From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RFC: Patch editing
Date: Sun, 25 Feb 2007 22:59:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 22:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRPF-0003zk-84
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 22:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbXBYV7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 16:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbXBYV7j
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 16:59:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:52612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965154AbXBYV7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 16:59:24 -0500
Received: (qmail invoked by alias); 25 Feb 2007 21:59:22 -0000
X-Provags-ID: V01U2FsdGVkX1+VQV1SYYGVVcjYwRQgfyvuyi9MYWhmwrghcOMnyR
	sBtg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40579>

Hi list,

while I was hacking on another issue, I realized just how often I would 
like to stash away a fix which is unrelated (but often triggered) by the 
theme of the current topic branch. Or I fix an earlier commit, which is 
not the tip of the branch, so I cannot --amend it.

My common practice is to commit it nevertheless, and sort the topic 
branches out later, by cherry-picking my way through the commits.

This is a tedious and error-prone procedure, and I often wished I knew how 
to use StGIT. But then, StGIT is overkill for me: on some machines I work 
on, there is no Python installed, I do not really need to have a history 
on the order and version of patches, and I do not need to preserve author 
and committer information *1*.

Therefore, I wrote this extremely simple script to sort out the order of 
commits, and possibly merging some. The script lets you edit the commit 
list upon start (reordering it, or removing commits), and then works on 
that list. It has three subcommands:

	start <base>
	continue
	reset [-f]

The subcommand "start" takes a base commit (actually, it will take the 
merge base of HEAD and that base commit) from which to start. It builds a 
commit list and opens it in an editor. The rows of the list have the form 
"<action> <sha1> <oneline>". The oneline description is purely for ease of 
use.

The three possible actions are "pick" (the default), "edit" and "merge". 
"pick" will just cherry-pick that commit, "edit" will stop after 
cherry-picking so that you can make a small fixup (in the code or in the 
commit message), and "merge" will try to apply the corresponding patch, 
amend the previous commit with the result, and let you edit the combined 
commit message.

If a patch fails, or "edit" was specified, the loop is interrupted for 
fixups. Use the subcommand "continue" to restart the loop (the working 
tree has to be clean, though).

Once there are no more commits to be picked, the original branch is 
updated to that new tip.

If you decide at some point that you do not want to rewrite the patches 
after all, you can use the subcommand "reset".

To see which commits were already applied, you can inspect .series/done, 
and likewise .series/todo for what is to be applied yet. You can even edit 
.series/todo if you decide on another course of action.

Anyway, it is a relatively short and stupid script.

Ciao,
Dscho

*1* My slight aversion against Python and Perl might be involved, too.

-- snipsnap --
#!/bin/sh
#
# Copyright (c) 2006 Johannes E. Schindelin

# SHORT DESCRIPTION
#
# This is a really stupid script to arrange a patch series for submission.
# It does not care for authorship or dates, all it does is make it easy
# to fix up commits in the middle of a series, and rearrange commits.
#
# MOTIVATION
#
# It is extremely useful for this type of workflow:
#
#	1. have a wonderful idea
#	2. hack on the code
#	3. prepare a series for submission
#	4. submit
#
# where the point (2) consists of several instances of
#
#	A.1. finish something worthy of a commit
#	A.2. commit
#
# and/or
#
#	B.1. realize that something does not work
#	B.2. fix that
#	B.3. commit it
#
# Sometimes the thing fixed in B.2. cannot be amended to the not-quite
# perfect commit it fixes, because that commit is buried deeply in a
# patch series.
#
# Use this script after plenty of "A"s and "B"s, by rearranging, and
# possibly editing and merging commits.
#
# USAGE:
#
# The subcommand "start" will make a list of the commits in the patch
# series <base>..HEAD, where <base> is the commit identiefied by the
# parameter.
#
# It will automatically start an editor, where you can rearrange the
# commits. The list looks more or less like this:
#
#	pick deadbee The oneline of this commit
#	pick fa1afe1 The oneline of the next commit
#	...
#
# By replacing the command "pick" with "edit" you can tell
# this script to stop the loop so you can fix up the commit by editing
# files and/or the commit message.
#
# When replacing the command "pick" with "merge, the script will merge
# this commit's changes into the previous commit, munge the commit
# messages of both, and open the commit message editor.
#
# In both cases, or when a "pick" does not succeed (because of merge
# errors), the loop will stop to let you fix things, and you can continue
# the loop with `git edit-patch-series continue`.

USAGE='(start <basecommit>| continue | reset [--force])'

. git-sh-setup
require_work_tree

SERIESDIR="$(pwd)/.series"
TODO="$SERIESDIR"/todo
DONE="$SERIESDIR"/done

warn () {
	echo "$@" >&2
}

require_clean_work_tree () {
	# test if working tree is dirty
	git rev-parse --verify HEAD > /dev/null &&
	git update-index --refresh &&
	test -z "`git diff-files --name-only`" &&
	test -z "`git diff-index --cached --name-only HEAD`" ||
	die "Working tree is dirty"
}

ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"

comment_for_reflog () {
	if test -z "$ORIG_REFLOG_ACTION"; then
		GIT_REFLOG_ACTION="edit-patch-series($1)"
		export GIT_REFLOG_ACTION
	fi
}

mark_action_done () {
	sed -n 1p < "$TODO" >> "$DONE"
	sed -n '2,$p' < "$TODO" >> "$TODO".new
	mv -f "$TODO".new "$TODO"
}

do_next () {
	read command sha1 rest < "$TODO"
	case "$command" in
	\#)
		mark_action_done
		continue
	;;
	pick)
		comment_for_reflog pick

		mark_action_done
		git cherry-pick "$sha1" || \
			die "Could not apply $sha1... $rest"
	;;
	edit)
		comment_for_reflog edit

		mark_action_done
		git cherry-pick "$sha1" || \
			die "Could not apply $sha1... $rest"
		exit 0
	;;
	merge)
		comment_for_reflog merge

		test -s "$DONE" &&
			die "Cannot 'merge' without a previous commit"

		mark_action_done
		failed=f
		git cherry-pick -n "$sha1" || failed=t
		MSG="$SERIESDIR"/message
		echo "# This is a combination of two commits." > "$MSG"
		echo "# The first commit's message is:" >> "$MSG"
		git cat-file commit HEAD | sed -n '/^$/,$p' >> "$MSG"
		echo >> "$MSG"
		echo "# And this is the 2nd commit message:" >> "$MSG"
		echo >> "$MSG"
		cat .msg >> "$MSG"
		case $failed in
		f)
			# Usually, I would use --amend here, but -F forbids it
			git reset --soft HEAD^
			git commit -F "$MSG" -e
		;;
		t)
			cp "$MSG" .msg
			warn "Could not apply $sha1... $rest"
			warn "After you fixed that, commit the result with"
			warn
			warn "	git commit --reedit-message .msg"
			exit 1
		esac
	;;
	*)
		warn "Unknown command: $command $sha1 $rest"
		warn "Please fix this in the file $TODO."
		exit 1
	esac
	test -s "$TODO" && continue

	HEAD=$(git rev-parse HEAD)
	HEADNAME=$(cat "$SERIESDIR"/head-name)
	git update-ref $HEADNAME $HEAD &&
	git symbolic-ref HEAD $HEADNAME &&
	rm -rf "$SERIESDIR" &&
	warn "Successfully edited patch series and updated $HEADNAME."

	exit $?
}

case "$1" in
start)
	comment_for_reflog start

	HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
	BASE=$(git rev-parse --verify "$2") || die "Invalid base"

	# DWIM: use the merge base
	MERGEBASE=$(git merge-base $HEAD $BASE)
	if test "$BASE" != "$MERGEBASE"
	then
		CANDIDATES="$(git merge-base --all $HEAD $BASE)"
		if test "$MERGEBASE" != "$CANDIDATES"
		then
			warn "Error: Multiple merge bases found:"
			warn "$CANDIDATES"
			rm -rf "$SERIESDIR"
			exit 1
		fi
		BASE=$MERGEBASE
	fi

	require_clean_work_tree

	git var GIT_COMMITTER_IDENT >/dev/null || exit

	test -d "$SERIESDIR" &&
		die "Edit-patch-series already started"

	test "z$(git rev-list --parents $BASE..$HEAD | grep " .* ")" != z &&
		die "Cannot edit a series including merges"

	mkdir "$SERIESDIR" || die "Could not create temporary $SERIESDIR"
	git symbolic-ref HEAD > "$SERIESDIR"/head-name || die "Could not get HEAD"

	echo $HEAD > "$SERIESDIR"/head
	echo $BASE > "$SERIESDIR"/base

	cat > "$TODO" << EOF
# Edit the patch series by exchanging lines.  The commits will be
# arranged in the given order.  If you want to edit a commit, replace
# the "pick" command with "edit".  If you want to merge the changes of
# a commit A into a commit B, place A directly after B, and replace the
# "pick" command with "merge".
EOF
	git rev-list --reverse --pretty=oneline --abbrev-commit --abbrev=7 \
		$BASE..$HEAD | sed "s/^/pick /" >> "$TODO"

	cp "$TODO" "$TODO".backup
	${VISUAL:-${EDITOR:-vi}} "$TODO" || warn "Could not execute editor"
	if git diff --no-index "$TODO" "$TODO".backup > /dev/null
	then
		rm -rf "$SERIESDIR"
		warn "No changes"
		exit 0
	fi

	git checkout $BASE || die "Could not checkout $BASE"

	while :
	do
		do_next
	done
;;
continue)
	comment_for_reflog continue

	test -d "$SERIESDIR" || die "No edit-patch-series running"

	require_clean_work_tree

	while :
	do
		do_next
	done
;;
reset)
	comment_for_reflog reset

	test -d "$SERIESDIR" || die "No edit-patch-series running"

	HEADNAME=$(cat "$SERIESDIR"/head-name)
	force=
	case "$2" in
	-f|--force)
		git symbolic-ref HEAD $HEADNAME &&
		git reset --hard
	;;
	*)
		git checkout $HEADNAME
	esac &&
	rm -rf "$SERIESDIR"
;;
*)
	usage
esac
