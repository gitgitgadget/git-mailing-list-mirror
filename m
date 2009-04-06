From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH v2] prints elements of C code in the git repository
Date: Tue, 07 Apr 2009 00:09:09 +0200
Message-ID: <49DA7D85.5080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, peff@peff.net,
	mike.ralphson@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 07 00:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqx1s-0000dK-D2
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 00:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbZDFWJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 18:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbZDFWJP
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 18:09:15 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:44111 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZDFWJN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 18:09:13 -0400
Received: by ey-out-2122.google.com with SMTP id 4so569206eyf.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=gGvZXdZxRXPNzvaCm0+zOsM7rMP9wu20H8Ft5tptgmI=;
        b=w/pHwmUqO3BOoTDDZnudv5X7J3nWhzciK5mD7H+At2ZSWUVf/vL7OHmAE8/TJQ3E4f
         F28H0v5rgq+aTb073aAL0WIG0lhvdTRx9j+OEGjw4KeT89cWm6/sARCs59iLNMbqZ7ea
         4eq8V9I3ZAMAGUE90v7skR8gDgU6ajKD8Ywdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=G5arovlxIn5KqqvG7+9FHrzA7nhWJfao7x63w6kQVd2l3ZDUcNhBFcNUNTZqFI7WjY
         mG4RxU20YBLsjzukdsso7BGS+zsCS5lu2aYPTcqsph7tuCECtrV0NdMo5R4+9vVk7dKe
         gZAeWHrII+G3ii6/ezVFvyzvC8CQUtAcc565w=
Received: by 10.210.34.5 with SMTP id h5mr1890009ebh.68.1239055748267;
        Mon, 06 Apr 2009 15:09:08 -0700 (PDT)
Received: from ?192.168.1.115? (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 7sm7558501eyb.40.2009.04.06.15.09.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 15:09:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115887>

This script searches the definition of elements of C and dumps them to
stdout. It now uses the ctags tags file. Thanks for previous comments,
Is this better?

Usage examples:

In your kernel source directory run to create your tags file:
scripts/tags.sh tags

Say the get-def.sh script lives in `../git/contrib/'.
To print the function definitions of kmalloc, do:
../git/contrib/get-def.sh -f kmalloc

You can search for a function with a specific multiline pattern:
../git/contrib/get-def.sh -f kmalloc "/size.*SLUB_DMA/p"

Maybe you want to search for any function within a directory
with a pattern. You may want to use definitions in get-def.sh:
source ../git/contrib/get-def.sh

bad_unsigned="`simple_sed \
	"unsigned ([^;{}()]*, )*($V)[#...#]\2 (<|>=) 0[^x]"`"
bad_unsigned_test="/$bad_unsigned/{
p
s/^.*$bad_unsigned.*$/Due to variable \2/p
}"

../git/contrib/get-def.sh -f "$V" kernel/ "$bad_unsigned_test" |
less

Since frequently searching for functions is slow you may want
to convert all functions to single lines and pipe that to a file
that can subsequently be parsed more quickly.

warning: this command may take a long time (once):
../git/contrib/get-def.sh -f "$V" -- git-ls-files "*.[ch]" \
"s/($S|$comm1|$comm2)*([\\]?\n|$comm1|$S$S)($S|$comm1)*/ /g;
p;" > ../allfuncs

And then for instance do:
sed -n -r "/$bad_unsigned_test/{
p
s/^.*$bad_unsigned_test.*$/Due to variable \2/p
}" ../allfuncs | less
------------------------------>8-------------8<---------------------------------
commit e61ffb20dffa95025e61e2706603a7c72fcad37f
Author: Roel Kluin <roel.kluin@gmail.com>
Date:   Mon Apr 6 23:58:28 2009 +0200

    This script searches the definition of elements of C and dumps them to
    stdout. It requires ctags and bash.
    
    As invoking it with -? will tell:
    
    USAGE: git get-def [OPTION]... PATTERN [FILE|DIRECTORY]... [SEDSCRIPT]
    print elements of C code with name PATTERN, an extended regular expression. If
    SEDSCRIPT is provided, it puts the entire element in the hold space before the
    execution of SEDSCRIPT.
    
    
    Options to specify which element(s) should be printed:
            -c      class name
            -d      define
            -f      function or method name
            -g      enumeration
            -m      member (of structure or class data)
            -s      structure
            -t      typedef
            -u      union
            -v      variable
            -D      only non-macro defines
            -M      only macro defines
    
    Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/contrib/get-def.sh b/contrib/get-def.sh
new file mode 100755
index 0000000..9428003
--- /dev/null
+++ b/contrib/get-def.sh
@@ -0,0 +1,254 @@
+#!/bin/bash
+# FIXME: make C++ style members
+
+int="[0-9]"
+hex="[a-f0-9]"
+hEx="[A-Fa-f0-9]"
+HEX="[A-F0-9]"
+upp="[A-Z]"
+up_="[A-Z_]"
+low="[a-z]"
+lo_="[a-z_]"
+alp="[A-Za-z]"
+al_="[A-Za-z_]"
+ALN="[A-Z0-9]"
+AN_="[A-Z0-9_]"
+aln="[A-Za-z0-9]"
+an_="[A-Za-z0-9_]"
+
+em='!'			# because of bash bang
+
+D="$int*\.?$int+x?$hex*[uUlL]{0,3}[fF]?"		# a number, float or hex
+# more strict and catches it (costs one backreference for (git )grep)
+SD="($int+[uUlLfF]?|$int+[uU]?[lL][lL]?|0x$hex+|0x$HEX+|$int+[lL][lL][uU]|$int*\.$int+[fF]?)"
+
+V="$al_+$an_*"		# variable/function name (or definition)
+K="$up_+$AN_*"		# definition (in capitals)
+
+# to catch variables that are members or arrays:
+W="[a-zA-Z0-9_>.-]*"
+SW="$V(\[[^][]*\]|\[[^][]*\[[^][]*\][^][]*\]|\.$V|->$V)*"	 # more strict, 1 backref
+
+s="[[:space:]]*"
+S="[[:space:]]+"
+
+# useful to ensure the end of a variable name:
+Q="[^[:alnum:]_]"
+Q2="[^[:alnum:]_>.]" # the '>' is tricky, it's an operator as well
+
+# match comments
+comm1="\/\*([^*]+|\**[^*/])*\*+\/"			# 1 backref
+comm2="\/\/([^\n]+|[n\\]+)*"				# 1 backref
+
+# match the end of the line, including comments:
+cendl="$s($comm1|$comm2|$s)*$"			 	# 3 backrefs
+cendln="$s($comm1|$comm2|$s)*($|\n)"			# 4 backrefs
+
+# strings and characters can contain things we want to match
+str="\"([^\\\"]+|\\\\.)*\""				# 1 backref
+ch1="'[^\\']'"
+ch2="'\\\\.[^']*'"
+ch="$ch1|$ch2"
+
+# match something that is not comment, string or character (c-code):
+ccode="([^\"'/]+|\/[^*\"'/]|\/?$comm1|\/?$ch1|\/?$ch2|\/?$str)*"		# 3 backrefs
+ccoden="([^\"'/]+|\/[^*\"'/]|\/?$comm1|\/?$ch1|\/?$ch2|\/?$str|\/?$comm2)*"	# 4 backrefs
+
+nps="[^()]*"
+nstdps="(\($nps(\($nps(\($nps(\($nps(\($nps\)$nps)*\)$nps)*\)$nps)*\)$nps)*\)$nps)*"
+npz="$nps$nstdps"
+nnps="\($npz\)"
+
+ncs="[^}{]*"
+nstdcs="(\{$ncs(\{$ncs(\{$ncs(\{$ncs(\{$ncs\}$ncs)*\}$ncs)*\}$ncs)*\}$ncs)*\}$ncs)*"
+ncz="$ncs$nstdcs"
+nncs="\{$ncz\}"
+
+delimitstr="s/([][{}(|)+*?\\/.^])/\\\\\1/g"
+delimit()
+{
+	sed -r "$delimitstr"
+}
+
+# excludes testing in strings, chars and comment
+excl_code()
+{
+	local incl=""
+	for f in "${@:3}"; do
+		incl="$incl|\/?$f";
+	done
+	echo "([^$1\"'/$2]*$incl|\/[^$1\"*'/$2]*|\/?$comm1|\/?$ch1|\/?$ch2|\/?$str|\/?$comm2)*"
+}
+
+# usage: nestc "(" ")" [number]
+nestc()
+{
+	local i;
+	[ $# -eq 1 ] && i=5 || i=$3;
+	# first and 2nd are flipped to enable matching
+	# square brackets "]["
+	local p="$(excl_code "$2$1" "${@:4}")"
+	local ret="$p"
+	while [ $i -gt 0 ]; do
+		ret="${p}([$1]${ret}[$2]${p})*"
+		i=$(($i-1));
+	done
+	echo "$ret"
+}
+
+simple_sed()
+{
+	l="${1//\(...\)/\($(nestc "(" ")" 8 | delimit)\)}"
+	l="${1//\{...\}/\($(nestc "{" "}" 12 | delimit)\)}"
+	l="${l//[[]#...#[]]/$Q$ccode$Q2}"
+	l="${l//[[]...[&|][&|][]]/$s($(nestc "(" ")" 5 | delimit)[&|][&|])?$s}"
+	l="${l//[[][&|][&|]...[]]/$s([&|][&|]$(nestc "(" ")" 5 | delimit))?$s}"
+	l="${l//[[]...[]]/$ccode}"
+	l="${l//[[](\{...)\*[]]/(\{$(nestc "{" "}" 12))*}"
+	l="${l//[[](...\})\*[]]/($(nestc "{" "}" 12)\})*}"
+	echo "$l" | sed -r "
+		:a
+		s/([[:alnum:]])[[:space:]]+([[:alnum:]])/\1[[:space:]]+\2/g
+		s/[[:space:]]+/[[:space:]]*/g
+		$!{
+			N; ba
+		}"
+}
+
+usage()
+{
+cat << EOF
+USAGE: git get-def [OPTION]... PATTERN [FILE|DIRECTORY]... [SEDSCRIPT]
+
+print elements of C code with name PATTERN, an extended regular expression. If
+SEDSCRIPT is provided, it puts the entire element in the hold space before the
+execution of SEDSCRIPT.
+
+Options to specify which element(s) should be printed:
+	-c	class name
+	-d	define
+	-f	function or method name
+	-g	enumeration
+	-m	member (of structure or class data)
+	-s	structure
+	-t	typedef
+	-u	union
+	-v	variable
+	-D	only non-macro defines
+	-M	only macro defines
+	-?	print this help
+
+EOF
+}
+
+sedstr_matches()
+{
+	# TODO: distinction between simple defines and macros
+	local shead="$(nestc "(" ")" 5)"
+	local head="$(nestc "(" ")" 10)"
+	local body="$(nestc "{" "}" 10)"
+	local SP="$S|$comm1|[\\]"
+
+	local wrd="$V(($SP)?\($shead\))?"
+	local fret="($SP)*($wrd($SP|\*)+)+"
+	local A="($SP)*($wrd($SP)+)*"
+	local B="($SP)+($wrd($SP))*"
+	local C="(($SP)+$wrd)*($SP)*"
+	local t=
+	local match=
+	local pr=":__print;${3}"
+	for t in ${1//|/ }; do
+		case "$t" in
+			"c") match="^${A}class($B$2($C)?\{$body\}|($C)?\{$body\}$A$2)($C)?;";;
+			"d") match="^$s#(${SP})*define(${SP})+$2(($S|\().*[^\\])?$" ;;
+			"D") match="^$s#(${SP})*define(${SP})+$2($S.*[^\\])?$" ;;
+			"M") match="^$s#(${SP})*define(${SP})+$2\(.*[^\\]$" ;;
+			"f") match="^$fret$2($SP)*\($shead\)($SP)*\{$body\}" ;;
+			"g") match="^${A}enum($B$2($C)?\{$body\}|($C)?\{$body\}$A$2)($C)?;";;
+			"m") match="^$fret$2($SP)*[;=]";;
+			"s") match="^${A}struct($B$2($C)?\{$body\}|($C)?\{$body\}$A$2)($C)?;";;
+			"t") match="^($SP)*typedef(($B)?\{$body\}|($SP)+)$A$2($C)?;$cendl" ;;
+			"u") match="^${A}union($B$2($C)?\{$body\}|($C)?\{$body\}$A$2)($C)?;";;
+			"v") match="^$fret$2($SP)*[;=]";;
+		esac
+		t="${t//[DM]/d}"
+		pr=":__$t;/$match/${em}{H;N;b__$t};b__print;
+$pr"
+	done
+	echo "$pr"
+}
+
+parse_tags()
+{
+	# TODO: other limits, e.g. limit="\tfile:" for local functions
+	local limit="(	.*)?"
+	local l=
+	#		  name	file	query		type
+	for l in $(grep -E "^$1	($2)	[^	]+	(${3//[DM]/d})$limit$" "tags" |
+			sort -k2 | tr "\t " "@\`"); do
+		local n="${l%%@*}"
+		l="${l#*@}"
+		local f="${l%%@*}"
+		local t="${l#*;\"@}"
+		if [ "$f" != "$oldf" ]; then
+			if [ -n "$oldf" ]; then
+				sed -r -n "${sedstr}b;$4" "$oldf"
+				[ $? -ne 0 ] && echo "Error in $oldf"
+			fi
+			local sedstr=
+			local oldf="$f"
+		fi
+		l="${l%;\"*}"
+		l="${l#*@}"
+		[ "${l:0:2}" = "/^" ] && l="/^`echo "${l:2:$((${#l}-3))}" | delimit`/"
+		sedstr="${l//\`/ }b__${t:0:1};$sedstr"
+	done
+	[ -n "$sedstr" ] && sed -r -n "${sedstr}b;$4" "$oldf"
+}
+
+parse_opts()
+{
+	local fl=			# file list
+	local name=
+	local getstr=
+	local script=
+
+	while [ $# -ne 0 ]; do
+		while getopts "cdDMfgmstuv" optname; do
+			case "$optname" in
+				c|d|D|M|f|g|m|s|t|u|v) getstr="${getstr:+$getstr|}$optname" ;;
+				"?") usage; exit 0; ;;
+			esac
+		done
+		shift $((OPTIND-1))
+		[ $# -eq 0 ] && break;
+		OPTIND=0
+		if [ -f "$1" ]; then
+			fl="${fl:+$fl|}$1";
+		elif [ -d "$1" ]; then
+			fl="${fl:+$fl|}${1}[^	]+";
+		else
+			if [ -z "$name" ]; then
+				name="$1";
+			else
+				script="$1"
+			fi
+		fi
+		shift
+	done
+	[ -z "$name" ] && usage;
+	getstr="${getstr:=c|d|f|g|m|s|t|u|v}"
+	local pr="`sedstr_matches "$getstr" "$name" "${script:=p;}"`"
+	fl="${fl:=[^	]+}"
+	parse_tags "$name" "${fl//\//\\/}" "$getstr" "$pr"
+}
+
+
+#main
+if [ "$0" != "-bash" ]; then
+	if [ -f "tags" ]; then
+		parse_opts "$@"
+	else
+		echo "No tags file found";
+	fi
+fi
