From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 11:09:29 +0100
Message-ID: <49C8B159.2040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 11:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm3bB-0001Pv-C7
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 11:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050AbZCXKJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 06:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755518AbZCXKJh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 06:09:37 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:58619 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbZCXKJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 06:09:35 -0400
Received: by ewy9 with SMTP id 9so1994982ewy.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Y6lzpLcwJnMHPcwwze/9QKGKc/GdfgEvPz1xGj49Gok=;
        b=piXiJd6XZFwTxryPiQiJjmVnMectP8n522cu2ZHiUGbThfRMhYHpaiPDeQgDXWawpv
         Z5jdE4//ZIbF/MP9mQ9wKyOMw7PitEk1Q4zw7Zll2Suynb1c/4riod+FENAmXYwp+jtQ
         UuI48zyItY2CT+VjEpwEv8hLaXBymsCmnPp94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=TywR7IdEB+q0aJs2gH9UQwsBkZKeSLQbpTprQCbotSaOCJj93YRQOLf+R2Y8p4nPsM
         0PRWGoVhfeg1rjQFXDJgTa3DRbyft4YDOA1aOc6bFCnJZy2ZhD1EhXNvKDEQvPhQCcDT
         8JMVpoOAAPSESiz8D3v4KaTeBExUX9zkn4Lcg=
Received: by 10.216.1.77 with SMTP id 55mr2995489wec.111.1237889371196;
        Tue, 24 Mar 2009 03:09:31 -0700 (PDT)
Received: from ?192.168.1.115? (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 28sm2389702eye.44.2009.03.24.03.09.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 03:09:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114445>

Maybe something like this is useful?
------------------------------>8-------------8<---------------------------------
Add git-cget.sh: prints elements of C code in the git repository.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/Makefile b/Makefile
index 1087884..c21ba91 100644
--- a/Makefile
+++ b/Makefile
@@ -260,6 +260,7 @@ BASIC_LDFLAGS =
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-filter-branch.sh
+SCRIPT_SH += git-cget.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
diff --git a/git-cget.sh b/git-cget.sh
new file mode 100755
index 0000000..08ea65f
--- /dev/null
+++ b/git-cget.sh
@@ -0,0 +1,409 @@
+#!/bin/bash
+# FIXME: make C++ style members
+
+int="[0-9]"
+hex="[a-f0-9]"
+hEx="[A-Fa-f0-9]"
+HEX="[A-F0-9]"
+upp="[A-Z]"
+up_="[A-Z_]"
+low="[a-z0-9]"
+lo_="[a-z0-9_]"
+alp="[A-Za-z]"
+al_="[A-Za-z_]"
+ALN="[A-Z0-9]"
+AN_="[A-Z0-9_]"
+aln="[A-Za-z0-9]"
+an_="[A-Za-z0-9_]"
+
+em='!'			# because of bash banging
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
+comm1="\/\*([^*]+|\**[^*/])*\*+\/"				# 1 backref
+comm2="\/\/([^\n]+|[n\\]+)*"				# 1 backref
+
+# match the end of the line, including comments:
+cendl="$s($comm1|$comm2|$s)*($|\n)"			 # 4 backrefs
+
+# strings and characters can contain things we want to match
+str="\"([^\\\"]+|\\\\.)*\""						 # 1 backref
+ch1="'[^\\']'"
+ch2="'\\\\.[^']*'"
+ch="$ch1|$ch2"
+
+# when using grep [^\/] also cases excludes '\', so we correct for that
+# match something that is not comment, string or character (c-code): 3 backrefs
+ccode="([^\"'/]+|\/[^*\"'/]|\/?$comm1|\/?$ch1|\/?$ch2|\/?$str|\/?\\\\|\/?$comm2)*"
+
+# TODO: use backref cheaper versions
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
+# unmatch: match anything except the given.
+#
+# If given is a string, then it also matches longer
+# or shorter strings.
+#
+# otherwise it delimits characters and then creates a match
+#
+unmatch()
+{
+	local sedstr=
+	# TODO: unmatch numbers
+	# if [ -n "`echo "$1" | grep -E "^$SD$"`" ]; then
+	if [ -n "`echo "$1" | grep -E "^$V$"`" ]; then
+		sedstr=":loop
+			s/^($an_+)?($an_)(\|.*)?$/\1\|\1[^\2]\3/
+			t loop
+			s/^[|](.*)$/($al_$an_{${#1}}|\1)$an_*/"
+	fi
+	# FIXME: unmatch non alnum characters:
+	# with the below "\*" results in ([^\\]|\\[^*])*,
+	# but it should be ([^\\]|\\+[^*\\])*
+	#else
+	#	local a="[^][{}(|)+*?\\/.^]"
+	#	local b="[][{}(|)+*?\\/.^]"
+	#	sedstr="$delimitstr
+	#		:loop
+	#		s/^(($a|[\\]$b)+)?(($a)|[\\]($b))(\|.*)?$/\1\|\1[^\4\5]\6/
+	#		t loop
+	#		s/^[|](.*)$/(\1)*/"
+	#fi
+	echo $1 | sed -r "$sedstr"
+}
+
+# excludes testing in strings, chars and comment
+excl_code()
+{
+	echo "([^$1\"'/$2]*|\/[^$1\"*'/$2]*|\/?$comm1|\/?$ch1|\/?$ch2|\/?$str|\/?$comm2)*"
+}
+
+# usage: nestc "(" ")" [number]
+# only works for nesting single chars. (TODO: multiple)
+nestc()
+{
+	local i;
+	[ $# -eq 1 ] && i=5 || i=$3;
+	# first and 2nd are flipped to enable matching
+	# square brackets "]["
+	local p="$(excl_code "$2$1" "$4")"
+	local ret="$p"
+	while [ $i -gt 0 ]; do
+		ret="${p}([$1]${ret}[$2]${p})*"
+		i=$(($i-1));
+	done
+	echo "$ret"
+}
+
+blank_it()
+{
+	echo "$1" | sed -r "
+		:a
+		s/([[:alnum:]])[[:space:]]+([[:alnum:]])/\1[[:space:]]+\2/g
+		s/[[:space:]]+/[[:space:]]*/g
+		$!{
+			N; ba
+		}"
+}
+
+# usage: grep_12 "struct list_head {" "include/linux/slub_def.h"
+# greps included as well, when not found
+grep_12()
+{
+	flist=
+	_grep_12 "$1" "$2"
+}
+
+_grep_12()
+{
+	grep -qE "$1" "$2";
+	if [ $? -eq 0 ]; then
+		echo "$2";
+	else
+		[ -n "$flist" ] && flist="$flist|"
+		flist="$flist$2"
+		local b="${2%\/*}"
+		for f in `sed -rn "/^$s#${s}include${s}[\"<]/{
+				$delimitstr
+				s/^$s#${s}include$s<([^>]+)>$cendl/include\/\1/p
+				s/^$s#${s}include$s\"([^\"]+)\"$cendl/${b//\//\/}\/\1/p
+				}" "$2" | grep -vE "($flist)" `; do
+			[ -f "$f" ] && _grep_12 "$1" "$f" && return 0;
+			b="${f%\/*}"
+		done
+	fi
+}
+
+get_matching_files()
+{
+	local files="${@:2}"
+	if [ -z "$files" ]; then
+		grep -lE "$1" $(git-ls-files "*.[ch]");
+		return;
+	fi
+	for f in $files; do
+		[ -f "$f" ] && echo -n "$(grep_12 "$1" "$f") "
+		[ -d "$f" ] && grep -lE "$1" $(git-ls-files "*.[ch]")
+	done
+}
+
+
+_sedit()
+{
+	sed -r -n "
+		:a
+		/$1/${em}b
+		/$2/${em}{
+			H; N; ba
+		}
+		$4
+		:b
+		/$3/${em}{
+			H; N; bb
+		}
+		$5
+	" "${@:6}"
+}
+
+sedit()
+{
+	local print2="p"
+	[ $(($1 & 4 )) -eq 4 ] && print2="="
+
+	local stages="` blank_it "$2@$3@$4" | tr "@" " "`"
+	local sed2str="/ \+@$/{N; s/@\n//}";
+	if [ $(($1 & 1 )) -eq 1 ]; then
+		_sedit $stages "#" "$print2" "${@:5}" | sed -r "$sed2str";
+	else
+		local print1=
+		[ $(($1 & 2 )) -eq 0 ] && print1="`echo -e "+@\n="`"
+		[ $1 -eq 4 ] && sed2str="/ \+@$/{N; N; s/\/\/ vi ([^+]*) \+@\n([0-9]*)\n([0-9]*)/\1:\2-\3/}"
+
+		for f in "${@:5}"; do
+			_sedit $stages "i// vi $f $print1" "$print2" "$f"
+		done | sed -r "$sed2str";
+	fi
+}
+
+get_func()
+{
+	# TODO: C++ member stuff
+	local fret="( $V( |\*|$comm1)*$S( |\*|$comm1)*)+"
+	local func_args="$(nestc "(" ")" 10 "+%/?#&|<>.^-")"
+	local func_body="$(nestc "{" "}" 10)"
+
+	local fl="${@:3}"
+	if [ -z "$fl" ]; then
+		local match="^($fret)? $2 ((\($func_args)+(\) ($comm1 )*((\{$func_body)+\}?)?)?)?$";
+		match="`blank_it "$match"`";
+		fl="`git-ls-files "*.[ch]"`"
+		fl="`grep -lE "$match" $fl`";
+		[ -z "$fl" ] && return;
+	fi
+
+	local stage1="^$fret ($2 ((\($func_args)+(\) ($comm1 )*((\{$func_body)+\}?)?)?)?)?$";
+	local stage2="^$fret $2 \($func_args\) \{";
+	local stage3="^$fret $2 \($func_args\) \{$func_body\}";
+	sedit $1 "$stage1" "$stage2" "$stage3" $fl
+}
+
+
+# get struct/enum/union
+get_elem()
+{
+	local sA="($S|$comm1)"
+	local sB="($V$S|$V \(\([^()]+\)\) |$comm1 )*"
+	local struct_body="$(nestc "{" "}" 10)"
+	local stage1=;
+	local stage2=;
+	local stage3=;
+
+	local match="^ (($sB$2)?$sA$sB)?$3($sA$sB)?((\{$struct_body)+\}?)?$cendl"
+	match="`blank_it "$match"`"
+	local fl="`get_matching_files "$match" ${@:4}`"
+	if [ -n "$fl" ]; then
+		stage1="^ ($V|$V \(\([^()]*\)\)|$sB$2($sA$sB($3($sA$sB)?((\{$struct_body)+\}?)?)?)?)$cendl"
+		stage2="^ $sB$2$sA$sB$3($sA$sB)? \{"
+		stage3="^ $sB$2$sA$sB$3($sA$sB)? \{$struct_body\}"
+		sedit $1 "$stage1" "$stage2" "$stage3" $fl
+	fi
+
+	match="^( (($sB$2)?($sA$sB| )\{)?($struct_body\})+)? $sB$3($sA$sB| );$cendl"
+	match="`blank_it "$match"`"
+	fl="`get_matching_files "$match" ${@:4}`"
+	if [ -n "$fl" ]; then
+		stage1="^ ($V|$V \(\([^()]*\)\)|$sB$2(($sA$sB| )((\{$struct_body)+(\} $sB($3($sA$sB| );)?)?)?)?)$cendl"
+		stage2="^ $sB$2($sA$sB| )\{"
+		stage3="^ $sB$2($sA$sB| )\{$struct_body\} $sB$3($sA$sB| );$cendl"
+		# there can be false positives due to stage1.
+		# here we remove them
+		sedit $1 "$stage1" "$stage2" "$stage3" $fl |
+			sed -r "/^\/\/ vi .* \+[0-9]*$/{
+				:a
+				$!{
+					d; b
+				}
+				N
+				/\/\/ vi .* \+[0-9]*\n\/\/ vi /${em}b
+				D; ba
+			}";
+
+	fi
+}
+
+get_def()
+{
+	local stage1="^ # define$S$2$Q"
+	local match="`blank_it "$stage1"`";
+	local stage2="^"
+	local stage3="[^\\]$"
+	sedit $1 "$stage1" "$stage2" "$stage3" `get_matching_files "$match" ${@:3}`
+}
+
+get_any()
+{
+	local defm=" # define$S$2$Q"
+	local sA="($S|$comm1)"
+	local sB="($V$S|$V \(\([^()]+\)\) |$comm1 )*"
+	local body="$(nestc "{" "}" 10)"
+
+	local elemsl="(($sB(struct|enum|union))?$sA$sB)?"
+	local elemsr1="$2($sA$sB)?((\{$body)+\}?)?"
+
+	local fret="( $V( |\*|$comm1)*$S( |\*|$comm1)*)+"
+	local func_args="$(nestc "(" ")" 10 "+%/?#^&|<>.-")"
+	local funcm="($fret)? $2 ((\($func_args)+(\) ($comm1 )*((\{$body)+\}?)?)?)?";
+
+	local match="`blank_it "^($defm| $elemsl$elemsr1$| (($elemsl\{)?($body\})+)? $sB$2$sA$sB;$|$funcm$)"`";
+	defm="`blank_it "^$defm"`"
+	funcm="`blank_it "^$funcm$"`"
+	git-grep -E "$match" | while read l; do
+		f="${l%:*}"
+		l="${l#*:}"
+		if [ "`echo "$l" | grep -E "^$defm"`" ]; then
+			get_def $1 "$2" $f
+		elif [ "`echo "$l" | grep -E "^$funcm$"`" ]; then
+			get_func $1 "$2" $f
+		else
+			for e in struct enum union; do
+				z="(($sB$e)?$sA$sB)?"
+				echo "$l" | grep -Eq "`blank_it "^ ( $z$elemsr1| (($z\{)?($body\})+)? $sB$2$sA$sB;)$cendl"`"
+				[ $? -eq 0 ] && get_elem $1 "$e" "$2" $f
+			done
+		fi
+	done
+}
+
+usage()
+{
+cat << EOF
+USAGE: git-get.sh [OPTION]... PATTERN [FILE]...
+print elements of C code with name PATTERN in the git repository,
+where PATTERN is a extended regular expression
+
+Options to specify which element(s) should be printed:
+	-f	function
+	-s	struct
+	-d	definition
+	-m	macro
+	-e	enum
+	-u	union
+
+Options to alter the output:
+	-b	only print body
+	-n	only print file and lineranges
+	-?	print this help
+
+EOF
+}
+
+parseopts()
+{
+	local fl=			# file list
+	local getflag=0
+	local printflag=0
+
+	while [ $# -ne 0 ]; do
+		while getopts "fdmseubn" optname; do
+			case "$optname" in
+				"f") getflag=$((getflag|1)) ;;
+				"d") getflag=$((getflag|2)) ;;
+				"m") getflag=$((getflag|4)) ;;
+				"s") getflag=$((getflag|8)) ;;
+				"e") getflag=$((getflag|16)) ;;
+				"u") getflag=$((getflag|32)) ;;
+				"b") printflag=3 ;;
+				"n") printflag=4 ;;
+				"?") usage; exit 0; ;;
+			esac
+		done
+		shift $((OPTIND-1))
+		[ $# -eq 0 ] && break;
+		OPTIND=0
+		if [ -f "$1" ]; then
+			fl="$fl $1";
+		else
+			name="$1";
+		fi
+		shift
+	done
+	[ -z "$name" ] && usage;
+	if [ $getflag -eq 0 ]; then
+		get_any $printflag "$name" $fl
+		return;
+	fi
+	[ $((getflag&1)) -eq 1 ] && get_func $printflag "$name" $fl
+	if [ $((getflag&6)) -ne 0 ]; then
+		if [ $((getflag&6)) -eq 2 ]; then
+					dom="($S.*)?";		# print only definitions
+		elif [ $((getflag&6)) -eq 4 ]; then
+					dom="\(.*";		# print only macros
+		else
+			dom="(\(.*|$S.*)?";	# catch definition or macro
+		fi
+		get_def $printflag "$name$dom" $fl
+	fi
+	if [ $((getflag&8)) -eq 8 ]; then
+		get_elem $printflag "struct" "$name" $fl
+	fi
+	if [ $((getflag&16)) -eq 16 ]; then
+		get_elem $printflag "enum" "$name" $fl
+	fi
+	if [ $((getflag&32)) -eq 32 ]; then
+		get_elem $printflag "union" "$name" $fl
+	fi
+}
+
+#main
+parseopts "$@"
