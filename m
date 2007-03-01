From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Updated version, was Re: RFC: Patch editing
Date: Fri, 2 Mar 2007 00:30:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703020020470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 00:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuj5-0007Tt-QM
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbXCAXaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbXCAXaH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:30:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:40265 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161186AbXCAXaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:30:04 -0500
Received: (qmail invoked by alias); 01 Mar 2007 23:30:03 -0000
X-Provags-ID: V01U2FsdGVkX18fKx5oVsIfVzIIs5EHdnUreFGmzcm7RExGy9zzf9
	AUXRSRocGdclAR
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-ID: <Pine.LNX.4.63.0703020021511.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41151>

Hi,

this is an updated version, which got even less testing than the first 
version :-( However, the changes were small:

- added an attribution to Eric Biederman for the idea,
- if you mark a commit as "edit", it will _not_ be committed, so that
  you do not need --amend _both_ in case of conflicts and no conflicts 
  (noticed by Shawn Pearce),
- a "merge" is refused when it is the _first_ in the list (the first 
  version erroneously checked the opposite...)
- for a failed "merge", like for an "edit", you do not need --amend both 
  in case of conflicts and no conflicts, and
- the wrong usage of the "--reedit-message" flag was replaced by the 
  appropriate "-F .msg -e".

My plans are _not_ to turn this into git-rebase--interactive.sh, as I 
originally planned. Instead, I will try to make git-rebase a builtin, and 
add a "-i" flag which does the equivalent of this script.

BTW would people be mad at me if I did _not_ imitate git-rebase.sh (call 
format-patch and feed that into apply), but rather used cherry-pick 
throughout?

Ciao,
Dscho

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
# The original idea comes from Eric W. Biederman, in
# http://article.gmane.org/gmane.comp.version-control.git/22407
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
		git cherry-pick -n "$sha1" || \
			die "Could not apply $sha1... $rest"
		warn
		warn "After you edited the files, commit the result with"
		warn
		warn "	git commit -F .msg -e"
		warn
		exit 0
	;;
	merge)
		comment_for_reflog merge

		test -s "$DONE" ||
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
		git reset --soft HEAD^
		case $failed in
		f)
			# Usually, I would use --amend here, but -F forbids it
			git commit -F "$MSG" -e
		;;
		t)
			cp "$MSG" .msg
			warn
			warn "Could not apply $sha1... $rest"
			warn "After you fixed that, commit the result with"
			warn
			warn "	git commit -F .msg -e"
			warn
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
