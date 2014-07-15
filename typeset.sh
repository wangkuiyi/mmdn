
if [ ! -d typeset ]; then
    mkdir typeset
fi

cd typeset

if [ ! -d /Applications/OmniGraffle\ Professional*.app ]; then
    echo "You need to install OmniGraffle in order to typeset this document"
    exit
fi

if [ ! -e graffle.sh ]; then
    if wget https://raw.githubusercontent.com/dcreager/graffle-export/master/graffle.sh && wget https://raw.githubusercontent.com/dcreager/graffle-export/master/graffle.scpt; then
        echo "Downloaded graffle.sh"
    else
        echo "Cannot download graffle.sh"
        exit
    fi
fi

chmod +x graffle.sh

for i in ../*.graffle; do
    ./graffle.sh $i $(echo $i | sed 's/\.graffle$/.pdf/' | sed 's/\.\.\///');
done

pdflatex ../mmdn.tex && pdflatex ../mmdn.tex && open -a Skim mmdn.pdf
