From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH 5/6] Make cg-diff use optparse, and add features
Date: Thu, 09 Jun 2005 13:24:07 +0200
Message-ID: <42A826D7.1060507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020509080305040408000004"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgMIF-00005j-H4
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 14:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVFIMlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVFIMlk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:41:40 -0400
Received: from main.gmane.org ([80.91.229.2]:10447 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262378AbVFIMik (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:38:40 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DgLrY-0003yV-4w
	for git@vger.kernel.org; Thu, 09 Jun 2005 14:10:20 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 14:10:20 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 14:10:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020509080305040408000004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This adds some new features to cg-diff:

  - diffstat (or rather git-apply --stat) support. The
    "-d" option outputs (optionally colorized) diff stats
    before the diff.

  - support for more git-diff-[tree/cache] options:
    -B, -R, -M, -C are now all passed on.

  - The COGITO_AUTO_COLOR environment variable makes output
    automatically colorized, if set and if we're on a color
    capable terminal.

We also use the new optparse function from cg-Xlib, to allow
for e.g. "cg-diff -drorigin" and stuff.

Reuse colorization logic from cg-Xlib.

And use LESS to make "less" search for chunks and diff --git
markers. This allows you to "n" your way through a series
of diffs, and gives a nice visual separation of patches.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>
---


--------------020509080305040408000004
Content-Type: text/plain;
 name="5-cg-diff.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="5-cg-diff.patch.txt"

 cg-diff |  222 +++++++++++++++++++++++++++++----------------------------------
 1 files changed, 102 insertions(+), 120 deletions(-)

diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -5,13 +5,16 @@
 #
 # Outputs a diff for converting the first tree to the second one.
 # By default compares the current working tree to the state at the
-# last commit. The output will automatically be displayed in a pager
-# unless it is piped to a program.
+# last commit.
 #
 # OPTIONS
 # -------
-# -c::
-#	Colorize the diff output
+# -c, --color::
+#	Colorize the diff output and use a pager for output (less by 
+#	default).
+#
+# -d, --diffstat::
+#	Show `diffstat' before diff.
 #
 # -p::
 #	Instead of one ID denotes a parent commit to the specified ID
@@ -24,153 +27,132 @@
 #	empty revision which means '-r rev:' compares between 'rev' and
 #	'HEAD', while '-r rev' compares between 'rev' and working tree.
 #
+# -R::
+#	Output diff in reverse.
+#
+# -M::
+#	Detect renames.
+#
+# -C::
+#	Detect copies (as well as renames).
+#
+# -B::
+#	Detect rewrites.
+#
 # -m::
 #	Base the diff at the merge base of the -r arguments (defaulting
-#	to master and origin).
+#	to HEAD and origin).
 #
 # ENVIRONMENT VARIABLES
 # ---------------------
 # PAGER::
 #	The pager to display log information in, defaults to `less`.
 #
-# PAGER_FLAGS::
-#	Flags to pass to the pager. By default `R` is added to the `LESS`
-#	environment variable to allow displaying of colorized output.
+# COGITO_AUTO_COLOR::
+#	If set, colorized output is used automatically on color-capable
+#	terminals.
 
 USAGE="cg-diff [-c] [-m] [-p] [-r FROM_ID[:TO_ID]] [FILE]..."
 
 . ${COGITO_LIB}cg-Xlib
 
 
-id1=" "
-id2=" "
-parent=
-opt_color=
-mergebase=
-
-# TODO: Make cg-log use this too.
-setup_colors()
-{
-	local C="diffhdr=1;36:diffhdradd=1;32:diffadd=32:diffhdrmod=1;35:diffmod=35:diffhdrrem=1;31:diffrem=31:diffhunk=36:diffctx=34:diffcctx=33:default=0"
-	[ -n "$COGITO_COLORS" ] && C="$C:$COGITO_COLORS"
-
-	C=${C//=/=\'$'\e'[}
-	C=col${C//:/m\'; col}m\'
-	#coldefault=$(tput op)
-	eval $C
+unset id1 id2 parent diffprog sedprog diffstat difftmp opt_color renames
+dtargs=()
+
+show_diffstat() {
+	[ -s "$difftmp" ] || return
+	git-apply --stat "$difftmp"
+	echo
+	cat "$difftmp"
 }
 
-while [ "$1" ]; do
-	case "$1" in
-	-c)
-		opt_color=1
-		setup_colors
-		;;
-	-p)
+while optparse; do
+	if optparse -p; then
 		parent=1
-		;;
-	-r)
-		shift
-		if echo "$1" | grep -q ':'; then
-			id2=$(echo "$1" | cut -d : -f 2)
-			[ "$id2" ] || log_end="HEAD"
-			id1=$(echo "$1" | cut -d : -f 1)
-		elif [ "$id1" = " " ]; then
-			id1="$1"
+	elif optparse -m; then
+		incoming=1
+	elif optparse -r=; then
+		if [ -z "${id1+set}" ]; then
+			id1=$OPTARG
+			if [[ "$id1" == *:* ]]; then
+				id2=${id1#*:}
+				id1=${id1%:*}
+			fi
 		else
-			id2="$1"
+			[ -z "${id2+set}" ] || die "too many revisions"
+			id2=$OPTARG
 		fi
-		;;
-	-m)
-		mergebase=1
-		;;
-	*)
-		break
-		;;
-	esac
-	shift
-done
-
-colorize() {
-	if [ "$opt_color" ]; then
-		gawk '
-		{ if (/^(Index:|diff --git) /)
-		    print "'$coldiffhdr'" $0 "'$coldefault'"
-		  else if (/^======*$/)
-		    print "'$coldiffhdr'" $0 "'$coldefault'"
-		  else if (/^\+\+\+/)
-		    print "'$coldiffhdradd'" $0 "'$coldefault'"
-		  else if (/^\*\*\*/)
-		    print "'$coldiffhdrmod'" $0 "'$coldefault'"
-		  else if (/^---/)
-		    print "'$coldiffhdrrem'" $0 "'$coldefault'"
-		  else if (/^(\+|new( file)? mode )/)
-		    print "'$coldiffadd'" $0 "'$coldefault'"
-		  else if (/^(-|(deleted file|old) mode )/)
-		    print "'$coldiffrem'" $0 "'$coldefault'"
-		  else if (/^!/)
-		    print "'$coldiffmod'" $0 "'$coldefault'"
-		  else if (/^@@ \-[0-9]+(,[0-9]+)? \+[0-9]+(,[0-9]+)? @@/)
-		    print gensub(/^(@@[^@]*@@)([ \t]*)(.*)/,
-		         "'$coldiffhunk'" "\\1" "'$coldefault'" \
-			 "\\2" \
-			 "'$coldiffctx'" "\\3" "'$coldefault'", "")
-		  else if (/^\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/)
-		    print "'$coldiffcctx'" $0 "'$coldefault'"
-		  else
-		    print
-		}'
+	elif optparse -c; then
+		opt_color=1
+	elif optparse -d || optparse --diffstat; then
+		diffstat=1
+	elif optparse -R; then
+		dtargs[${#dtargs[@]}]="-R"
+	elif optparse -M; then
+		[ "$renames" ] && optconflict
+		renames=1
+		dtargs[${#dtargs[@]}]="-M"
+	elif optparse -C; then
+		[ "$renames" ] && optconflict
+		renames=1
+		dtargs[${#dtargs[@]}]="-C"
+	elif optparse -B; then
+		dtargs[${#dtargs[@]}]="-B"
 	else
-		cat
+		optfail
 	fi
-}
+done
 
-if [ "$parent" ]; then
-	id2="$id1"
-	id="$id2"; [ "$id" = " " ] && id=""
-	id1=$(parent-id "$id" | head -n 1) || exit 1
-fi
+[ -n "$COGITO_AUTO_COLOR" -a -t 1 ] && [ "$(tput setaf 1 2>/dev/null)" ] && 
+opt_color=1
 
-if [ "$mergebase" ]; then
-	[ "$id1" != " " ] || id1="master"
-	[ "$id2" != " " ] || id2="origin"
-	id1=$(git-merge-base $(commit-id "$id1") $(commit-id "$id2"))
-fi
+LESS=$'+/\013^@@.*@@|^diff.--git..*$'" $LESS"
 
+diffprog=git-diff-tree
 
-filter=$(mktemp -t gitdiff.XXXXXX)
-for file in "$@"; do
-	echo "$file" >>$filter
-done
+if [ "$parent" ]; then
+	[ -z "${id2+set}" ] || die "too many revisions"
+	id2="$id1"
+	id1=$(parent-id "$id2" | head -n 1) || exit 1
+elif [ "$incoming" ]; then
+	tmp=$id1
+	id1="$(commit-id "${id2:-HEAD}")" || exit 1
+	id2="$(commit-id "${tmp:-origin}")" || exit 1
+	id1="$(git-merge-base "$id1" "$id2")" || exit 1
+fi
 
-if [ "$id2" = " " ]; then
-	if [ "$id1" != " " ]; then
-		tree=$(tree-id "$id1") || exit 1
-	else
-		tree=$(tree-id) || exit 1
-	fi
+id1=$(tree-id "$id1") || exit 1
 
+if [ -z "${id2+set}" ]; then
 	# Ensure to only diff modified files
 	git-update-cache --refresh >/dev/null
-
-	# FIXME: Update ret based on what did we match. And take "$@"
-	# to account after all.
-	ret=
-	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
-
-	rm $filter
-
-	[ "$ret" ] && die "no files matched"
-	exit $ret
+	diffprog=git-diff-cache
+else
+	id2=$(tree-id "$id2") || exit 1
 fi
 
-
-id1=$(tree-id "$id1") || exit 1
-id2=$(tree-id "$id2") || exit 1
-
 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
+diffopts=(-r -p "${dtargs[@]}" $id1 $id2 "${ARGS[@]}")
+
+if [ "$diffstat" ]; then
+	difftmp=$(mktemp -t cgdiff.XXXXXX) || exit 1
+	trap "rm '$difftmp'" SIGTERM EXIT
+	$diffprog "${diffopts[@]}" > $difftmp
 
-cat $filter | xargs git-diff-tree -r -p $id1 $id2 | colorize | pager
+	diffprog=show_diffstat
+	diffopts=
+fi
 
-rm $filter
-exit 0
+if [ "$opt_color" ]; then
+	setup_colors
+	sedprog="$color_rules"
+
+	[ "$diffstat" ] && sedprog="$sedprog
+s,^\\( [^ ].*\\)\\( |  *[0-9][0-9]* \\),$colfiles\\1$coldefault\\2,"
+
+	$diffprog "${diffopts[@]}" | sed -e "$sedprog" | pager
+	exit $PIPESTATUS
+else
+	$diffprog "${diffopts[@]}"
+fi

--------------020509080305040408000004--

