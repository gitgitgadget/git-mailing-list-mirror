From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH] Many new features for cg-diff and cg-log
Date: Wed, 08 Jun 2005 22:28:05 +0200
Message-ID: <42A754D5.10705@gmail.com>
References: <20050608144632.A28042@flint.arm.linux.org.uk> <tnxhdg8g6e1.fsf@arm.com> <20050608181747.GA982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040705060101000108040705"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:38:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg7Gf-0002oC-Hn
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 22:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVFHUjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 16:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFHUjE
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 16:39:04 -0400
Received: from main.gmane.org ([80.91.229.2]:17121 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261599AbVFHUdA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 16:33:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dg77o-0001J8-Nw
	for git@vger.kernel.org; Wed, 08 Jun 2005 22:26:10 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 22:26:08 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 22:26:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050608181747.GA982@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705060101000108040705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
> FYI, I plan to release 0.11.2 this evening. I'll try to go through some
> more queued patches before and update cg-log to fully use git-rev-list.

In that case, you might want to have a look at this patch. I've been 
tinkering with cg-log and cg-diff for some time, and just about got 
ready to send you a patch.

Sorry about the monster patch, but I wanted to get it to you quickly...

...

[PATCH] Many new features for cg-diff and cg-log

Both cg-diff and cg-log get:

- A common infrastructure for option parsing, that allows for 
combinations of options like all getopt-using programs. So you can say:

cg-log -cfm
cg-diff foo --color
cg-log -sfrlinus foobar

At the same time, you get decent error reporting on illegal options.

- A common infrastructure for colorization. cg-log and cg-diff share 
setup, and sed scripts for colorization.

- diffstat (or rather, git-apply --stat) support.

- Support for the new -M, -C and -B switches to the git-diff-* brothers.

- Automatic search in less, so you can jump to the next commit/diff 
chunk by "n".

- Automatic color if the COGITO_AUTO_COLOR environment variable is set.

- "Smart pager" support - less isn't invoked unless there's actually 
some output. This is useful is COGITO_AUTO_COLOR is set.

cg-log also gets:

- Vast speedup. It uses git-rev-list and git-diff-tree to do most of the 
heavy lifting.

- A new default "-f" format, that allows deletions, renames etc. to be 
shown (the old format is still available as -F). Deletions and new files 
are color-coded.

- Diff output. cg-log -p shows diff output between commits. Colorized as 
in cg-diff.

- New, more compact summary, that's readable on 80-column terminals. By
default, sha1's are hidden, and the date is more compact (and readable). 
It can also be combined with the other options: for example "cg-log -sf" 
gives a nice overview of commits and the files they touch.

- Slightly new behaviour, thanks to use of git-diff-tree: when you use 
any of the options that shows differences between revisions, or that 
gives a subset of revisions, merge commits are hidden by default. They 
are visible if the "-a/--all" option is given.

- The default log format is also shorter. The full version is available 
with "-v". An even shorter format is available with "-q".

- Selection of ranges by date or maximum number of commits to show.

--------------040705060101000108040705
Content-Type: text/plain;
 name="log-diff.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log-diff.patch.txt"

 cg-Xlib |   83 +++++++++
 cg-diff |  220 +++++++++++--------------
 cg-log  |  556 ++++++++++++++++++++++++++++++++++++++++-----------------------
 3 files changed, 534 insertions(+), 325 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -119,11 +119,94 @@ print_help () {
 }
 
 for option in "$@"; do
+	[ "$option" = -- ] && break
 	if [ "$option" = "-h" -o "$option" = "--help" ]; then
 		print_help ${_cg_cmd##cg-}
 	fi
 done
 
+# option parsing
+
+ARGS=("$@")
+ARGPOS=0
+
+optshift() {
+	unset ARGS[$ARGPOS]
+	ARGS=("${ARGS[@]}")
+	[ -z "$1" -o -n "${ARGS[$ARGPOS]}" ] || 
+	die "option \`$1' requires an argument"
+}
+
+optfail() {
+	die "unrecognized option \`${ARGS[$ARGPOS]}'"
+}
+
+optconflict() {
+	die "conflicting option \`$CUROPT'"
+}
+
+optparse() {
+	unset OPTARG
+	[ -z "$1" ] && case ${ARGS[$ARGPOS]} in
+	--)	optshift; return 1 ;;
+	-*)	return 0 ;;
+	*)	while (( ${#ARGS[@]} > ++ARGPOS )); do
+			[[ "${ARGS[$ARGPOS]}" == -- ]] && return 1
+			[[ "${ARGS[$ARGPOS]}" == -* ]] && return 0
+		done; return 1 ;;
+	esac
+
+	CUROPT=${ARGS[$ARGPOS]}
+	local match=${1%=} minmatch=${2:-1} opt=$CUROPT o=$CUROPT val
+	[[ $1 == *= ]] && val=$match
+	case $match in
+	--*)	[ "$val" ] && o=${o%%=*}
+		[ ${#o} -ge $((2 + $minmatch)) -a \
+			"${match:0:${#o}}" = "$o" ] || return 1
+		[[ -n "$val" && "$opt" == *=?* ]] && ARGS[$ARGPOS]=${opt#*=} ||
+		optshift $val ;;
+	-?)	[[ $o == $match* ]] || return 1
+		[[ $o != -?-* || -n "$val" ]] || optfail
+		ARGS[$ARGPOS]=${o#$match}
+		[ "${ARGS[$ARGPOS]}" ] && 
+		{ [ "$val" ] || ARGS[$ARGPOS]=-${ARGS[$ARGPOS]}; } || 
+		optshift $val ;;
+	*)	die "optparse cannot handle $1" ;;
+	esac
+	[ -z "$val" ] || { OPTARG=${ARGS[$ARGPOS]}; optshift; } 
+}
+
+maybe_less() {
+	# Invoke $PAGER if there is any output
+	local line
+	if read -r line; then
+		( echo "$line"; cat ) | LESS="-R $LESS" ${PAGER:-less}
+	fi
+}
+
+setup_colors()
+{
+	local C="header=32:author=36:signoff=33:committer=35:files=34"
+	C="$C:commit=34:date=32:trim=35"
+	C="$C:diffhdr=34:diffhdradd=32:diffadd=32:diffhdrmod=35"
+	C="$C:diffmod=35:diffhdrrem=31:diffrem=31:diffhunk=36"
+	C="$C:diffctx=34:diffcctx=33:default=0"
+	[ -n "$COGITO_COLORS" ] && C="$C:$COGITO_COLORS"
+
+	C=${C//=/=\'$'\e'[}
+	C=col${C//:/m\'; col}m\'
+	#coldefault=$(tput op)
+	eval $C
+
+	color_rules="
+s,^+++.*,$coldiffhdradd&$coldefault,
+s,^---.*,$coldiffhdrrem&$coldefault,
+s,^[+].*,$coldiffadd&$coldefault,
+s,^[-].*,$coldiffrem&$coldefault,
+s,^\\(@@.*@@\\)\\(.*\\),$coldiffhunk\\1$coldiffctx\\2$coldefault,
+s,^=*$',$coldiffhdr&$coldefault,
+s,^\\(Index:\\|===\\|diff\\) .*,$coldiffhdr&$coldefault,"
+}
 
 # Check if we have something to work on, unless the script can do w/o it.
 if [ ! "$_git_repo_unneeded" ]; then
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
@@ -24,152 +27,131 @@
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
 
-USAGE="cg-diff [-c] [-m] [-p] [-r FROM_ID[:TO_ID]] [FILE]..."
+USAGE="cg-diff [-c] [-m] [-p] [-r FROM_ID[:TO_ID] [FILE]..."
 
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
+
+[ -n "$COGITO_AUTO_COLOR" -a -t 1 ] && [ "$(tput setaf 1 2>/dev/null)" ] && 
+opt_color=1
+
+LESS=$'+/\013^@@.*@@|^diff.--git..*$'" $LESS"
+
+diffprog=git-diff-tree
 
 if [ "$parent" ]; then
+	[ -z "${id2+set}" ] || die "too many revisions"
 	id2="$id1"
 	id1=$(parent-id "$id2" | head -n 1) || exit 1
+elif [ "$incoming" ]; then
+	tmp=$id1
+	id1="$(commit-id "${id2:-HEAD}")" || exit 1
+	id2="$(commit-id "${tmp:-origin}")" || exit 1
+	id1="$(git-merge-base "$id1" "$id2")" || exit 1
 fi
 
-if [ "$mergebase" ]; then
-	[ "$id1" != " " ] || id1="master"
-	[ "$id2" != " " ] || id2="origin"
-	id1=$(git-merge-base $(commit-id "$id1") $(commit-id "$id2"))
-fi
-
-
-filter=$(mktemp -t gitdiff.XXXXXX)
-for file in "$@"; do
-	echo "$file" >>$filter
-done
-
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
+	$diffprog "${diffopts[@]}" | sed -e "$sedprog" | maybe_less
+else
+	$diffprog "${diffopts[@]}"
+fi
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -3,6 +3,7 @@
 # Make a log of changes in a GIT branch.
 # Copyright (c) Petr Baudis, 2005.
 # Copyright (c) David Woodhouse, 2005.
+# Copyright (c) Dan Holmsand, 2005.
 #
 # Display log information for files or a range of commits. The output
 # will automatically be displayed in a pager unless it is piped to
@@ -13,7 +14,7 @@
 # Arguments not interpreted as options will be interpreted as filenames;
 # cg-log then displays only changes in those files.
 #
-# -c::
+# -c, --color::
 #	Colorize to the output. The used colors are listed below together
 #	with information about which log output (summary, full or both)
 #	they apply to:
@@ -26,8 +27,15 @@
 #		- `date`:	'green'		(summary)
 #		- `trim_mark`:	'magenta'	(summary)
 #
+# -d, --diffstat::
+#	Show `diffstat' for every commit.
+#
 # -f::
-#	List affected files. (No effect when passed along `-s`.)
+#	Show list of files modified in each commit.
+#
+# -F::
+#	Show ChangeLog-style list of modified files, instead of the
+#	default listing.
 #
 # -r FROM_ID[:TO_ID]::
 #	Limit the log information to a set of revisions using either
@@ -37,29 +45,63 @@
 #	to the initial commit is shown. If no revisions is specified,
 #	the log information starting from 'HEAD' will be shown.
 #
-# -m::
-#	End the log listing at the merge base of the -r arguments
-#	(defaulting to master and origin).
-#
-# -s::
+# -s, --summary::
 #	Show a one line summary for each log entry. The summary contains
 #	information about the commit date, the author, the first line
 #	of the commit log and the commit ID. Long author names and commit
 #	IDs are trimmed and marked with an ending tilde (~).
 #
-# -uUSERNAME::
-#	List only commits where author or committer contains 'USERNAME'.
-#	The search for 'USERNAME' is case-insensitive.
+# -p, --patches::
+#	Show diffs for files modified by each commit.
+#
+# -v, --verbose::
+#	Show committer, tree and parents for each commit.
+#
+# -a, --all::
+#	Show merge commits as well. By default merge commits are not
+#	shown if you use any of the options that show differences between
+#	commits, or that select some disjoint commits. (-u, -f, -d, etc.)
+#
+# -m::
+#	End the log listing at the merge base of the -r arguments
+#	(defaulting to master and origin).
+#
+# -u, --search=TEXT::
+#	List only commits where author, committer or commit message
+#	contains 'TEXT'. The search for 'TEXT' is case-insensitive.
+#
+# -S, --match=TEXT::
+#	Look for commits that introduces TEXT in a file.
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
+# -y, --max-age=DATE::
+#	Limit output to commits younger than DATE.
+#
+# -o, --min-age=DATE::
+#	Limit output to commits older than DATE.
+#
+# --max-count=N::
+#	Show at most N commits.
+#
+# --stdin::
+#	Show commits for sha1s read from stdin.
 #
 # ENVIRONMENT VARIABLES
 # ---------------------
 # PAGER::
 #	The pager to display log information in, defaults to `less`.
 #
-# PAGER_FLAGS::
-#	Flags to pass to the pager. By default `R` and `S` is added to the
-#	`LESS` environment variable to allow displaying of colorized output
-#	and to avoid long lines from wrapping when using `-s`.
+# COGITO_AUTO_COLOR::
+#	If set, colorized output is used automatically on color-capable
+#	terminals.
 #
 # EXAMPLE USAGE
 # -------------
@@ -75,212 +117,314 @@ USAGE="cg-log [-c] [-f] [-m] [-s] [-uUSE
 # at least somewhere it does. Bash is broken.
 trap exit SIGPIPE
 
-[ "$COLUMNS" ] || COLUMNS="$(tput cols)"
+# speed bash up on utf-8 locales
+LANG=C
 
-colheader=
-colauthor=
-colcommitter=
-colfiles=
-colsignoff=
-colcommit=
-coldate=
-coltrim=
-coldefault=
-
-list_files=
-log_start=
-log_end=
-summary=
-user=
-mergebase=
-files=()
-
-while [ "$1" ]; do
-	case "$1" in
-	-c)
-		# See terminfo(5), "Color Handling"
-		colheader="$(tput setaf 2)"    # Green
-		colauthor="$(tput setaf 6)"    # Cyan
-		colcommitter="$(tput setaf 5)" # Magenta
-		colfiles="$(tput setaf 4)"     # Blue
-		colsignoff="$(tput setaf 3)"   # Yellow
-
-		colcommit="$(tput setaf 4)"
-		coldate="$(tput setaf 2)"
-		coltrim="$(tput setaf 5)"
-
-		coldefault="$(tput op)"        # Restore default
-		;;
-	-f)
-		list_files=1
-		;;
-	-u*)
-		user="${1#-u}"
-		;;
-	-r)
-		shift
-		if echo "$1" | grep -q ':'; then
-			log_end=$(echo "$1" | cut -d : -f 2)
-			[ "$log_end" ] || log_end="HEAD"
-			log_start=$(echo "$1" | cut -d : -f 1)
-		elif [ -z "$log_start" ]; then
-			log_start="$1"
-		else
-			log_end="$1"
-		fi
-		;;
-	-m)
-		mergebase=1
-		;;
-	-s)
-		summary=1
-		;;
-	*)
-		files=("$@")
-		break
-		;;
-	esac
-	shift
-done
+unset id1 id2 user verbose filelist patches sedprog incoming pretty maxn
+unset diffstat stdin opt_color renames dtmode quiet summary longsummary files
+unset needparse
+filemode=-s
+dtargs=() rlargs=()
+
+revlist() {
+	if [ "$stdin" ]; then
+		# read sha1s from stdin. remove leading stuff from
+		# git-rev-tree output.
+		sed 's/^[0-9]* \([a-f0-9]\{40\}\)/\1/'
+	elif [ "$user" ]; then
+		git-rev-list --header "${rlargs[@]}" |
+		LANG=C grep -iz "$user" | tr '\n\0' '\t\n' | cut -f1
+	else
+		git-rev-list "${rlargs[@]}" "$@"
+	fi 
+}
 
-list_commit_files()
-{
-	tree1="$1"
-	tree2="$2"
-	line=
-	sep="    * $colfiles"
-	# List all files for for the initial commit
-	if [ -z $tree2 ]; then
-		list_cmd="git-ls-tree $tree1"
+dolog() {
+	if [ "$dtmode" = diff-tree ]; then
+		revlist | 
+		git-diff-tree --stdin -v -r $filemode "${dtargs[@]}" \
+			-- "${ARGS[@]}"
 	else
-		list_cmd="git-diff-tree -r $tree1 $tree2"
+		revlist --pretty${pretty+=}$pretty
 	fi
+}
+
+showstat() {
+	git-diff-tree -r -p "${dtargs[@]}" $1 $2 -- "${ARGS[@]}" | 
+		git-apply --stat 2>/dev/null
 	echo
-	$list_cmd | cut -f 2- | while read file; do
-		echo -n "$sep"
-		sep=", "
-		line="$line$sep$file"
-		if [ ${#line} -le 74 ]; then
-			echo -n "$file"
+}
+
+showfiles() {
+	local p=6 sep="    * $colfiles" IFS=$'\n' file end=":$coldefault"
+	[ "$summary" ] && { end="$coldefault"$'\n'; }
+	for i in $(git-diff-tree -m -r $1 $2); do
+		[[ "$i" == :* ]] || continue
+		i=${i##*$'\t'}
+		if (( (p += 2 + ${#i}) < 75 )); then
+			echo -n "$sep$i"
 		else
-			line="      $file"
-			echo "$coldefault"
-			echo -n "      $colfiles$file"
+			(( p = 6 + ${#i} ))
+			echo ",$coldefault"
+			echo -n "      $colfiles$i"
 		fi
+		sep=", "
 	done
-	echo "$coldefault:"
+	echo "$end"
+}
+
+todate() {
+	local secs=$1 tzhours=${2:0:3} tzmins=${2:0:1}${2:3} 
+	local format="+%a %b %-d %H:%M:%S %Y $2"
+	# bash doesn't like leading zeros
+	[ "${tzhours:1:1}" = 0 ] && tzhours=${2:0:1}${2:2:1}
+	secs=$((secs + tzhours * 3600 + tzmins * 60))
+	LANG=C date -ud "1970-01-01 UTC + $secs sec" "$format"
 }
 
-if [ "$mergebase" ]; then
-	[ "$log_start" ] || log_start="master"
-	[ "$log_end" ] || log_end="origin"
-	log_start=$(git-merge-base $(commit-id "$log_start") $(commit-id "$log_end"))
+toepoch() {
+	expr "$1" : "[0-9]*$" >/dev/null && echo "$1" ||
+	date -ud "$1" +%s || die "invalid date $1"
+}
+
+showsummary() {
+	local commit=$1 author=$2 date=$3 text=$4 da
+	author=${author#Author: }
+	author=${author% <*}
+	[ ${#author} -gt 14 ] && author=${author:0:13}$coltrim~
+	if [ -z "$longsummary" ]; then
+		commit=
+	elif [ "${COLUMNS:-0}" -le 90 ]; then
+		commit="$colcommit${commit:0:12}$coltrim~ "
+	else
+		commit="$colcommit$commit "
+	fi
+	# find suitable short date format, assumes date in "std linus format"
+	da=(${date#Date:})
+	local dyear=${da[4]}
+	if [ "$year" -ne "$dyear" ]; then
+		# year month day
+		date="${da[1]} ${da[2]} $dyear"
+	elif [ "$month" != "${da[1]}" -o "$day" -ne "${da[2]}" ]; then
+		# month day
+		date="${da[1]} ${da[2]}"
+	else
+		# time
+		date=${da[3]%:*}
+	fi
+	line=${line#    }
+	printf "%s$colauthor%-14s $coldate%-6s $coldefault%s\n" \
+		"$commit" "$author" "$date" "$line"
+}
+
+while optparse; do
+	if optparse -c || optparse --color; then
+		opt_color=1
+	elif optparse -f; then
+		[ "$patches" ] && optconflict
+		files=1
+		filemode=
+	elif optparse -F; then
+		filelist=1
+		dtmode=diff-tree
+	elif optparse -p || optparse --patches; then
+		[ "$files" ] && optconflict
+		patches=1
+		filemode=-p
+	elif optparse -d || optparse --diffstat; then
+		diffstat=1
+		dtmode=diff-tree
+	elif optparse -u= || optparse --search= 2; then
+		user=$OPTARG
+		dtmode=diff-tree
+	elif optparse -q || optparse --short; then
+		[ "$verbose$summary" ] && optconflict
+		quiet=1
+	elif optparse -v || optparse --verbose; then
+		[ "$quiet" ] && optconflict
+		verbose=1
+	elif optparse -s || optparse --summary 2; then
+		[ "$quiet" ] && optconflict
+		summary=1
+	elif optparse --stdin 2; then
+		stdin=1
+		dtmode=diff-tree
+	elif optparse -y= || optparse --max-age= 5; then
+		rlargs[${#rlargs[@]}]=--max-age=$(toepoch "$OPTARG") || exit 1
+	elif optparse -o= || optparse --min-age= 2; then
+		rlargs[${#rlargs[@]}]=--min-age=$(toepoch "$OPTARG") || exit 1
+	elif optparse --max-count= 5; then
+		maxn=$OPTARG
+	elif optparse -a || optparse --all; then
+		dtargs[${#dtargs[@]}]="-m"
+		dtargs[${#dtargs[@]}]="--root"
+	elif optparse -m || optparse --mergebase 2; then
+		incoming=1
+	elif optparse -S= || optparse --match= 3; then
+		dtargs[${#dtargs[@]}]="-S$OPTARG"
+	elif optparse -M; then
+		[ "$renames" ] && optconflict
+		[ "$patches" ] || filemode=
+		dtargs[${#dtargs[@]}]="-M"
+		renames=1
+	elif optparse -C; then
+		[ "$renames" ] && optconflict
+		[ "$patches" ] || filemode=
+		dtargs[${#dtargs[@]}]="-C"
+		renames=1
+	elif optparse -B; then
+		[ "$patches" ] || filemode=
+		dtargs[${#dtargs[@]}]="-B"
+	elif optparse -r= || optparse --revision=; then
+		if [ -z "${id1+set}" ]; then
+			id1=$OPTARG
+			if [[ "$id1" == *:* ]]; then
+				id2=${id1#*:}
+				id1=${id1%:*}
+			fi
+		else
+			[ -z "${id2+set}" ] || die "too many revisions"
+			id2=$OPTARG
+		fi
+	else
+		optfail
+	fi
+done
+
+[ -n "$COGITO_AUTO_COLOR" -a -t 1 ] && [ "$(tput setaf 1 2>/dev/null)" ] && 
+	opt_color=1
+
+LESS="-S $LESS"
+[ "$COLUMNS" ] || COLUMNS="$(tput cols)"
+
+if [ "$incoming" ]; then
+	id1="$(commit-id "${id1:-origin}")" || exit 1
+	id2="$(commit-id "${id2:-HEAD}")" || exit 1
+	id2="$(git-merge-base "$id1" "$id2")" || exit 1
 fi
 
-if [ "$log_end" ]; then
-	id1="$(commit-id "$log_start")" || exit 1
-	id2="$(commit-id "$log_end")" || exit 1
-	revls="git-rev-tree $id2 ^$id1"
-	revsort="sort -rn"
-	revfmt="git-rev-tree"
+id1=$(commit-id "$id1") || exit 1
+[ -z "${id2+set}" ] || id2=$(commit-id "$id2") || exit 1
+rlargs=( "${rlargs[@]}" $id1 ${id2+^}$id2 )
+
+if [ -n "${dtargs[*]}${ARGS[*]}" -o "$filemode" != -s -o "$dtmode" ]; then
+	dtmode=diff-tree
 else
-	id1="$(commit-id "$log_start")" || exit 1
-	revls="git-rev-list $id1"
-	revsort="cat"
-	revfmt="git-rev-list"
+	dtmode=commit
+	[ "$verbose" -a -z "$summary" ] && pretty=raw
+	[ "$quiet" ] && { pretty=short; quiet=; } 
 fi
 
-print_commit_log() {
-	commit="$1"
-	author=
-	committer=
-	tree=
-	parents=()
-
-	git-cat-file commit $commit | \
-		while read key rest; do
-			trap exit SIGPIPE
-			case "$key" in
-			"author")
-				author="$rest"
-				;;
-			"committer")
-				committer="$rest"
-				;;
-			"tree")
-				tree="$rest"
-				;;
-			"parent")
-				parents[${#parents[@]}]="$rest"
-				;;
-			"")
-				if [ "$files" ]; then
-					parent="${parents[0]}"
-					diff_ops=
-					[ "$parent" ] || diff_ops=--root
-					[ "$(git-diff-tree -r $diff_ops $commit $parent "${files[@]}")" ] || return 1
-				fi
-				if [ "$user" ]; then
-					echo -e "author $author\ncommitter $committer" \
-						| grep -qi "$user" || return
-				fi
-				if [ "$summary" ]; then
-					# Print summary
-					commit="${commit%:*}"
-					author="${author% <*}"
-					date=(${committer#*> })
-					date="$(showdate $date '+%F %H:%M')"
-					read title
-					if [ "${#author}" -gt 15 ]; then
-						author="${author:0:14}$coltrim~"
-					fi
-					if [ "${COLUMNS:-0}" -le 90 ]; then
-						commit="${commit:0:12}$coltrim~"
-					fi
-
-					printf "$colcommit%s $colauthor%-15s $coldate%s $coldefault%s\n" \
-						"${commit%:*}" "$author" "$date" "$title"
-					return
-				fi
-
-				echo ${colheader}commit ${commit%:*} $coldefault
-				echo ${colheader}tree $tree $coldefault
-
-				for parent in "${parents[@]}"; do
-					echo ${colheader}parent $parent $coldefault
-				done
-
-				date=(${author#*> })
-				pdate="$(showdate $date)"
-				[ "$pdate" ] && author="${author%> *}> $pdate"
-				echo ${colauthor}author $author $coldefault
-
-				date=(${committer#*> })
-				pdate="$(showdate $date)"
-				[ "$pdate" ] && committer="${committer%> *}> $pdate"
-				echo ${colcommitter}committer $committer $coldefault
-
-				if [ -n "$list_files" ]; then
-					list_commit_files "$tree" "${parents[0]}"
-				fi
-				echo; sed -re '
-					/ *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
-					/ *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/
-					s/./    &/
-				'
-				;;
-			esac
-		done
-}
+if [ "$summary" ]; then
+	year=$(date +%Y)
+	month=$(LANG=C date +%b)
+	day=$(date +%d)
+	[ "$verbose" ] && { longsummary=1; verbose=; }
+fi
+
+if [ "$filelist$diffstat$summary" -o "$pretty" = raw -o $dtmode = diff-tree ]
+then
+	needparse=1
+else
+	[ "$maxn" ] && rlargs=(--max-count="$maxn" "${rlargs[@]}")
+fi
 
-$revls | $revsort | while read time commit parents; do
-	trap exit SIGPIPE
-	[ "$revfmt" = "git-rev-list" ] && commit="$time"
-	log="$(print_commit_log $commit)"
-	if [ "$log" ]; then
-		echo "$log"
-		[ "$summary" ] || echo
+if [ "$opt_color" ]; then
+	setup_colors
+
+	if [ ! "$summary" ]; then
+		LESS=$'+/\013^Commit:.[a-f0-9]*|^diff.--git..*$'" $LESS"
+		sedprog="
+s,^\\(Commit: [^ ]*\\)\\(.*\\),$colheader\\1$coldefault\\2,
+s,^Author:.*,$colauthor&$coldefault,
+s,^Date:.*,$colauthor&$coldefault,
+s,^Tree:.*,$colheader&$coldefault,
+s,^Parent:.*,$colheader&$coldefault,
+s,^Committer:.*,$colcommitter&$coldefault,
+s,^Commitdate:.*,$colcommitter&$coldefault,
+s,^    Signed-[Oo]ff[- ][Bb]y:.*,$colsignoff&$coldefault,
+s,^    Acked[- ][Bb]y:.*,$colsignoff&$coldefault,"
 	fi
-	# LESS="S" will prevent less to wrap too long titles to multiple lines;
-	# you can scroll horizontally.
-done | LESS="S$LESS" pager
+
+	[ "$patches" ] && sedprog="$sedprog;$color_rules"
+
+	[ "$diffstat" ] && sedprog="$sedprog
+s,^\\( [^ ].*\\)\\( |  *[0-9][0-9]* \\),$colfiles\\1$coldefault\\2,"
+fi
+
+if [ $dtmode = diff-tree -a -z "$filemode" ]; then
+	filediffstart=$'s,^:[0-9]* [^ ]* [^ ]* [^ ]* \('
+	filediffend=$'[^\t]*\)\t\(.*\)'
+	sedprog="$sedprog
+${filediffstart}[NCR]$filediffend,$coldiffadd\\1 \\2$coldefault,
+${filediffstart}D$filediffend,$coldiffrem\\1 \\2$coldefault,
+${filediffstart}.$filediffend,$colfiles\\1 \\2$coldefault,"
+fi
+
+if [ "$needparse" ]; then
+	# Slow version, parsing output from diff-tree or rev-list
+	unset commit showds from lineno line
+	n=0
+	dolog | ( trap exit SIGPIPE
+	while [ "$line" ] || IFS='' read -r line; do 
+	case $line in 
+		$dtmode\ *)
+		[ "$maxn" ] && (( ++n > maxn )) && exit
+		[ "$showds" ] && showstat $commit $from
+		line=${line#$dtmode } f="%s\n" showds=$diffstat lineno=0
+		commit=${line% (*} from=${line#*(from }; from=${from%)}
+		[ "$summary" ] && f= || echo "Commit: $line" ;;
+
+		Author:*) printf "$f" "$line"; author=$line ;;
+
+		Date:*) printf "$f" "$line"; date=$line ;;
+
+		author\ *)
+		line=${line#author }; author=${line% [0-9]*}; date=${line##*> }
+		if [ "$f" ]; then
+			printf "$f" "Author: $author"
+			[ "$quiet" ] || printf "$f" "Date:   $(todate $date)" 
+		elif [ "$summary" ]; then
+			date=$(todate $date)
+		fi ;;
+
+		committer\ *)
+		if [ "$verbose" ]; then
+			line=${line#committer }
+			echo "Committer:  ${line% [0-9]*}"
+			echo "Commitdate: $(todate ${line##*> })"
+		fi ;;
+
+		tree\ *) [ "$verbose" ] && echo "Tree: ${line#tree }" ;;
+
+		parent\ *) [ "$verbose" ] && echo "Parent: ${line#parent }" ;;
+
+		\ \ \ \ * | '')
+		if (( ++lineno == 2 )); then
+			[ "$summary" ] && 
+			showsummary $commit "$author" "$date" "$line"
+			[ "$filelist" ] && showfiles $commit $from
+			printf "$f" "$line"
+			[ "$quiet" ] && { f=; echo; }
+		else
+			printf "$f" "$line"
+		fi ;;
+
+		*)
+		[ "$showds" ] && { showstat $commit $from; showds=; }
+		printf "%s\n" "$line"
+		while IFS='' read -r line; do
+			case $line in $dtmode\ *) break ;; esac
+			printf "%s\n" "$line"
+		done
+		continue ;;
+	esac
+	line=
+	done
+	[ "$showds" ] && showstat $commit $from
+	) | LANG=C sed -e "$sedprog" | maybe_less
+else
+	# Fast version, using sed only.
+	sedprog="s,^$dtmode ,Commit: ,;$sedprog"
+	dolog | LANG=C sed -e "$sedprog" | maybe_less
+fi 

--------------040705060101000108040705--

