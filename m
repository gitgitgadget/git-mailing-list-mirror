From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH Cogito] Improve option parsing for cg-log
Date: Fri, 13 May 2005 13:32:51 +0200
Message-ID: <42849063.1040003@gmail.com>
References: <1115931114.18499.66.camel@pegasus> <20050512211315.GP324@pasky.ji.cz> <1115934586.18499.70.camel@pegasus> <20050513054140.GF16464@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010200060601020707070809"
X-From: git-owner@vger.kernel.org Fri May 13 13:28:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWYKs-0003zy-Lg
	for gcvg-git@gmane.org; Fri, 13 May 2005 13:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVEMLfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 07:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVEMLfq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 07:35:46 -0400
Received: from main.gmane.org ([80.91.229.2]:61151 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262234AbVEMLeE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 07:34:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DWYI3-0003hh-2t
	for git@vger.kernel.org; Fri, 13 May 2005 13:25:11 +0200
Received: from 217-211-177-12-o871.telia.com ([217.211.177.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 May 2005 13:25:11 +0200
Received: from holmsand by 217-211-177-12-o871.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 May 2005 13:25:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217-211-177-12-o871.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050513054140.GF16464@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------010200060601020707070809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
> The -r option still must be after all the other options.
> 

I've been thinking about option parsing as well, and I think cogito 
could use a more "getopt-like" handling of options. "cg-log -cf"
or "cg-diff -rorigin" is just so much easier to type...

The attached patch implements that for cg-log and cg-diff, by means of 
two new helper functions in cg-Xlib. It also improves error-handling a bit.

How about it?

/dan

--------------010200060601020707070809
Content-Type: text/x-patch;
 name="optparse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="optparse.patch"

Better option parsing in cg-diff and cg-log. Uses a new function, optparse,
in cg-Xlib, that allows for getopt-style option parsing.

This means that "cg-log -cf" is equivalent to "cg-log -c -f", as is
"cg-log -fc" and "cg-log -fc -rHEAD --" and even
"cg-log --file-list --color --revision=HEAD".

---

 cg-Xlib |   33 ++++++++++++++++++++++++++++++
 cg-diff |   53 ++++++++++++++++++++++---------------------------
 cg-log  |   69 ++++++++++++++++++++++++----------------------------------------
 3 files changed, 83 insertions(+), 72 deletions(-)

Index: cg-Xlib
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-Xlib  (mode:100755)
+++ 048128149b56f55427713c78a8a3ca9da811e589/cg-Xlib  (mode:100755)
@@ -62,6 +62,39 @@
 	fi
 done
 
+# option parsing
+
+opts=($@)
+
+optshift() {
+	unset opts[0]
+	opts=("${opts[@]}")
+	[ -z "$1" -o -n "$opts" ] || die "option \`$1' requires an argument"
+}
+
+optparse() {
+	[ -z "$1" ] && case $opts in
+		--) optshift; return 1 ;;
+		-*) return 0 ;;
+		*)  return 1 ;;
+	esac
+
+	local match=${1%=} minmatch=${2:-1} o=$opts val
+	[[ $1 == *= ]] && val=$match
+	case $match in
+	--*)	[ "$val" ] && o=${opts%%=*}
+		[ ${#o} -ge $((2 + $minmatch)) -a \
+			"${match:0:${#o}}" = "$o" ] || return 1
+		[[ -n "$val" && "$opts" == *=* ]] && opts[0]=${opts#*=} \
+			|| optshift $val ;;
+	-?)	[[ $o == $match* ]] || return 1
+		[[ $o != -?-* || -n "$val" ]] || die "unrecognized option \`$o'"
+		opts[0]=${o#$match}
+		[ "$opts" ] && { [ "$val" ] || opts[0]=-${opts}; } \
+			|| optshift $val ;;
+	*)	die "optparse cannot handle $1" ;;
+	esac
+}
 
 # Compatibility hacks:
 # 2005-04-26
Index: cg-diff
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-diff  (mode:100755)
+++ 048128149b56f55427713c78a8a3ca9da811e589/cg-diff  (mode:100755)
@@ -19,34 +19,33 @@
 . ${COGITO_LIB}cg-Xlib
 
 
-id1=" "
-id2=" "
-parent=
+unset id1 id2 parent
 
+while optparse; do
+	if optparse -p || optparse --parent; then
+		parent=1
+	elif optparse -r= || optparse --revision=; then
+		if [ set != "${id1+set}" ]; then
+			id1=$opts
+			if [[ "$id1" == *:* ]]; then
+				id2=${id1#*:}
+				id1=${id1%:*}
+			fi
+		else
+			[ set != "${id2+set}" ] || die "too many versions"
+			id2=$opts
+		fi
+		optshift
+	else
+		die "unrecognized option \`$opts'"
+	fi
+done
+shift $(( $# - ${#opts[*]} ))
 
-# FIXME: The commandline parsing is awful.
-
-if [ "$1" = "-p" ]; then
-	shift
-	parent=1
-fi
-
-if [ "$1" = "-r" ]; then
-	shift
-	id1=$(echo "$1": | cut -d : -f 1)
-	[ "$id1" != "$1" ] && id2=$(echo "$1": | cut -d : -f 2)
-	shift
-fi
-
-if [ "$1" = "-r" ]; then
-	shift
-	id2="$1"
-	shift
-fi
 
 if [ "$parent" ]; then
 	id2="$id1"
-	id1=$(parent-id "$id2" | head -n 1)
+	id1=$(parent-id "$id2" | head -n 1) || exit 1
 fi
 
 
@@ -58,12 +57,8 @@
 	done
 fi
 
-if [ "$id2" = " " ]; then
-	if [ "$id1" != " " ]; then
-		tree=$(tree-id "$id1")
-	else
-		tree=$(tree-id)
-	fi
+if [ set != "${id2+set}" ]; then
+	tree=$(tree-id "${id1:-HEAD}") || exit 1
 
 	# Ensure to only diff modified files
 	git-update-cache --refresh
Index: cg-log
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-log  (mode:100755)
+++ 048128149b56f55427713c78a8a3ca9da811e589/cg-log  (mode:100755)
@@ -30,18 +30,11 @@
 # at least somewhere it does. Bash is broken.
 trap exit SIGPIPE
 
-colheader=
-colauthor=
-colcommitter=
-colfiles=
-colsignoff=
-coldefault=
-list_files=
-user=
-while [ "$1" ]; do
-	# TODO: Parse -r here too.
-	case "$1" in
-	-c)
+unset colheader colauthor colcommitter colfiles colsignoff coldefault
+unset list_files log_start log_end files user
+
+while optparse; do
+	if optparse -c || optparse --color; then
 		# See terminfo(5), "Color Handling"
 		colheader="$(tput setaf 2)"    # Green
 		colauthor="$(tput setaf 6)"    # Cyan
@@ -49,21 +42,28 @@
 		colfiles="$(tput setaf 4)"     # Blue
 		colsignoff="$(tput setaf 3)"   # Yellow
 		coldefault="$(tput op)"        # Restore default
-		shift
-		;;
-	-f)
+	elif optparse -f || optparse --file-list; then
 		list_files=1
-		shift
-		;;
-	-u*)
-		user="${1#-u}"
-		shift
-		;;
-	*)
-		break
-		;;
-	esac
+	elif optparse -u= || optparse --user=; then
+		user=$opts
+		optshift
+	elif optparse -r= || optparse --revision=; then
+		if [ set != "${log_start+set}" ]; then
+			log_start=$opts
+			if [[ "$log_start" == *:* ]]; then
+				log_end=${log_start#*:}
+				log_start=${log_start%:*}
+			fi
+		else
+			[ set != "${log_end+set}" ] || die "too many revisions"
+			log_end=$opts
+		fi
+		optshift
+	else
+		die "unrecognized option \`$opts'"
+	fi
 done
+shift $(( $# - ${#opts[*]} ))
 
 list_commit_files()
 {
@@ -92,24 +92,7 @@
 	echo "$coldefault:"
 }
 
-log_start=
-log_end=
-if [ "$1" = "-r" ]; then
-	shift
-	log_start="$1"
-	shift
-	if echo "$log_start" | grep -q ':'; then
-		log_end=$(echo "$log_start" | cut -d : -f 2)
-		log_start=$(echo "$log_start" | cut -d : -f 1)
-	fi
-fi
-if [ "$1" = "-r" ]; then
-	shift
-	log_end="$1"
-	shift
-fi
-
-if [ "$log_end" ]; then
+if [ set = "${log_end+set}" ]; then
 	id1="$(commit-id $log_start)" || exit 1
 	id2="$(commit-id $log_end)" || exit 1
 	revls="git-rev-tree $id2 ^$id1"

--------------010200060601020707070809--

