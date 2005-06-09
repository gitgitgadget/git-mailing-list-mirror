From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH 6/6] Make cg-log use optparse, and add features
Date: Thu, 09 Jun 2005 13:29:14 +0200
Message-ID: <42A8280A.3070607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050609080308080402090902"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 15:02:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgMOp-0001G8-71
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 14:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVFIMs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVFIMs0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:48:26 -0400
Received: from main.gmane.org ([80.91.229.2]:39634 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262126AbVFIMpF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:45:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DgM1C-0005ok-Od
	for git@vger.kernel.org; Thu, 09 Jun 2005 14:20:18 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 14:20:18 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 14:20:18 +0200
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
--------------050609080308080402090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is more or less a rewrite of cg-log, that adds a bunch
of new features and gives a substantial speedup.

cg-log now lets git-rev-list and git-diff-tree do as much
of the heavy lifting as possible. When possible, cg-log
pretty much reduces to a sed script, that does some fixup
and adds colorization. Otherwise, cg-log uses
--pretty=[raw|medium|short] output, that's augmented as
necessary.

New features:

  - New, human friendlier output format. cg-log now uses
    the same format as git-rev-list --pretty. It also
    doesn't show tree, committer and parents by default.
    These are all shown with "-v or --verbose", however.

  - Slightly more readable summary format. sha1s are hidden
    unless -v is given. Date format is condenced to HH:MM
    for the last day, and Month Day otherwise. (+year is
    shown for really old stuff).

    summary format can also be combined with other options,
    like "-f" and "-d" (diffstat).

  - "-u" (or --search=) now searches the entire commit
    message. This is more flexible, as you can still do e.g.
    "cg-log -u 'author Petr Baudis'". Search is now also
    a lot faster, done with a single grep invocation.

  - Output can be limited by date or count.

  - New format for "-f". This is pretty much the same
    output as cg-status gives, and allows for the
    rename/copy detection things to work. New and
    deleted files are optionally color coded.

    The old format is still available as -F.

  - Merge commits are hidden by default when displaying
    differences between commits, or when displaying disjoint
    sets of commits. "-a" makes them show again. So
    "cg-log -caF" gives you pretty much the same output
    as the old "cg-log -c -f" would.

  - Shows diffs between commits with the "-p" options.
    The diffs use the same colorization rules as cg-diff,
    and can be skipped through with "n" in less if "-c"
    is given.

  - "--stdin" reads sha1s from stdin instead of from
    git-rev-list, for some extra flexibility.

New features in common with cg-diff:

  - diffstat support (or rather git-apply --stat). The
    "-d" option outputs (optionally colorized) diff stats
    before the diff.

  - support for more git-diff-[tree/cache] options:
    -B, -R, -M, -C are now all passed on.

  - The COGITO_AUTO_COLOR environment variable makes output
    automatically colorized, if set and if we're on a color
    capable terminal.

We also use the new optparse function from cg-Xlib, to allow
for e.g. "cg-log -sfa" and stuff.

Reuse colorization logic from cg-Xlib. All the colors are
added in a single sed invocation.

And use LESS to make "less" search for chunks and diff --git
markers. This allows you to "n" your way through a series
of diffs, and gives a nice visual separation of patches.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>
---

--------------050609080308080402090902
Content-Type: text/plain;
 name="6-cg-log.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="6-cg-log.patch.txt"

 cg-log |  545 +++++++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 331 insertions(+), 214 deletions(-)

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
@@ -37,29 +45,61 @@
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
+#	Show merge commits as well.
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
@@ -75,228 +115,305 @@ USAGE="cg-log [-c] [-f] [-m] [-s] [-uUSE
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
 }
 
-process_commit_line()
-{
-	if [ "$key" = "%" ] || [ "$key" = "%$colsignoff" ]; then
-		# The fast common case
-		[ "$summary" ] || [ "$skip_commit" ] || echo "    $rest"
-		return
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
 	fi
-	case "$key" in
-	"commit")
-		[ "$summary" ] || [ "$skip_commit" ] || { [ "$commit" ] && echo; }
-		commit="$rest"
-		parents=()
-		skip_commit=
-		;;
-	"tree")
-		tree="$rest"
-		;;
-	"parent")
-		parents[${#parents[@]}]="$rest"
-		;;
-	"committer")
-		committer="$rest"
-		;;
-	"author")
-		author="$rest"
-		;;
-	"")
-		if [ ! "$commit" ]; then
-			# Next commit is coming
-			[ "$summary" ] || echo
-			return
-		fi
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
 
-		if [ "$user" ]; then
-			if ! echo -e "author $author\ncommitter $committer" \
-			     | grep -qi "$user"; then
-				skip_commit=1
-				return
-			fi
-		fi
-		if [ "$files" ]; then
-			parent="${parents[0]}"
-			diff_ops=
-			[ "$parent" ] || diff_ops=--root
-			if ! [ "$(git-diff-tree -r $diff_ops $commit $parent "${files[@]}")" ]; then
-				skip_commit=1
-				return
-			fi
-		fi
-		if [ "$summary" ]; then
-			# Print summary
-			commit="${commit%:*}"
-			author="${author% <*}"
-			date=(${committer#*> })
-			date="$(showdate $date '+%F %H:%M')"
-			read title
-			if [ "${#author}" -gt 15 ]; then
-				author="${author:0:14}$coltrim~"
-			fi
-			if [ "${COLUMNS:-0}" -le 90 ]; then
-				commit="${commit:0:12}$coltrim~"
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
 			fi
-
-			printf "$colcommit%s $colauthor%-15s $coldate%s $coldefault%s\n" \
-				"${commit%:*}" "$author" "$date" "${title:2}"
-			commit=
-			return
+		else
+			[ -z "${id2+set}" ] || die "too many revisions"
+			id2=$OPTARG
 		fi
+	else
+		optfail
+	fi
+done
 
-		echo ${colheader}commit ${commit%:*} $coldefault
-		echo ${colheader}tree $tree $coldefault
+[ -n "$COGITO_AUTO_COLOR" -a -t 1 ] && [ "$(tput setaf 1 2>/dev/null)" ] && 
+	opt_color=1
 
-		for parent in "${parents[@]}"; do
-			echo ${colheader}parent $parent $coldefault
-		done
+LESS="-S $LESS"
+[ "$COLUMNS" ] || COLUMNS="$(tput cols)"
 
-		date=(${author#*> })
-		pdate="$(showdate $date)"
-		[ "$pdate" ] && author="${author%> *}> $pdate"
-		echo ${colauthor}author $author $coldefault
-
-		date=(${committer#*> })
-		pdate="$(showdate $date)"
-		[ "$pdate" ] && committer="${committer%> *}> $pdate"
-		echo ${colcommitter}committer $committer $coldefault
+if [ "$incoming" ]; then
+	id1="$(commit-id "${id1:-origin}")" || exit 1
+	id2="$(commit-id "${id2:-HEAD}")" || exit 1
+	id2="$(git-merge-base "$id1" "$id2")" || exit 1
+fi
 
-		if [ -n "$list_files" ]; then
-			list_commit_files "$tree" "${parents[0]}"
-		fi
-		echo
-		commit=
-		;;
-	esac
-}
+id1=$(commit-id "$id1") || exit 1
+[ -z "${id2+set}" ] || id2=$(commit-id "$id2") || exit 1
+rlargs=( "${rlargs[@]}" $id1 ${id2+^}$id2 )
 
-print_commit_log()
-{
-	commit=
-	author=
-	committer=
-	tree=
-
-	sed -e '
-		s/^    \(.*\)/% \1/
-		/^% *[Ss]igned-[Oo]ff-[Bb]y:.*/ s/^% \(.*\)/% '$colsignoff'\1'$coldefault'/
-		/^% *[Aa]cked-[Bb]y:.*/ s/^% \(.*\)/% '$colsignoff'\1'$coldefault'/
-	' | while read key rest; do
-		trap exit SIGPIPE
-		process_commit_line
-	done
-}
+if [ -n "${dtargs[*]}${ARGS[*]}" -o "$filemode" != -s -o "$dtmode" ]; then
+	dtmode=diff-tree
+else
+	dtmode=commit
+	[ "$verbose" -a -z "$summary" ] && pretty=raw
+	[ "$quiet" ] && { pretty=short; quiet=; } 
+fi
 
-if [ "$mergebase" ]; then
-	[ "$log_start" ] || log_start="master"
-	[ "$log_end" ] || log_end="origin"
-	log_start=$(git-merge-base $(commit-id "$log_start") $(commit-id "$log_end"))
+if [ "$summary" ]; then
+	year=$(date +%Y)
+	month=$(LANG=C date +%b)
+	day=$(date +%d)
+	[ "$verbose" ] && { longsummary=1; verbose=; }
 fi
 
-id1="$(commit-id "$log_start")" || exit 1
-if [ "$log_end" ]; then
-	id2="$(commit-id "$log_end")" || exit 1
-	revls="git-rev-list --pretty=raw $id2 ^$id1"
+if [ "$filelist$diffstat$summary" -o "$pretty" = raw -o $dtmode = diff-tree ]
+then
+	needparse=1
 else
-	revls="git-rev-list --pretty=raw $id1"
+	[ "$maxn" ] && rlargs=(--max-count="$maxn" "${rlargs[@]}")
+fi
+
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
+	fi
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
 fi
 
-# LESS="S" will prevent less to wrap too long titles to multiple lines;
-# you can scroll horizontally.
-$revls | print_commit_log | LESS="S$LESS" pager
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
+			[ "$quiet" ] || printf "$f" "Date:   $(showdate $date)" 
+		elif [ "$summary" ]; then
+			date=$(showdate $date)
+		fi ;;
+
+		committer\ *)
+		if [ "$verbose" ]; then
+			line=${line#committer }
+			echo "Committer:  ${line% [0-9]*}"
+			echo "Commitdate: $(showdate ${line##*> })"
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
+	) | LANG=C sed -e "$sedprog" | pager
+else
+	# Fast version, using sed only.
+	sedprog="s,^$dtmode ,Commit: ,;$sedprog"
+	dolog | LANG=C sed -e "$sedprog" | pager
+fi 

--------------050609080308080402090902--

