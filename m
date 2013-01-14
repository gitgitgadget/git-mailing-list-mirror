From: Mark Lodato <lodatom@gmail.com>
Subject: Announcing git-reparent
Date: Mon, 14 Jan 2013 01:15:06 -0500
Message-ID: <CAHREChhnf44CprHnS=z9KO5aOkfDPSG6Xb2GU=Kvaz38eTgbUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TudKs-0002EZ-1M
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab3ANGP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:15:29 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:59612 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab3ANGP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:15:27 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1657532dak.5
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 22:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=gan+/w9/qDYEUShxaj1+YRopzugSRDq5ou0KgeExg8s=;
        b=Ii2k9FqIjW5gkF6kfrQ0BYe2lyUVjsURhwBGDzat9o78eYxfu8GnCAy/zNRaplqZDy
         DRLNXqHK6lVZx/iTZk6XYH5PXwGTr91ES5BnFcP183YR8rNDaQDrN5IJT0JneHDR6BV5
         kJf0rgAwnKKPdbfOk/V+zcE2QPmceuQfzH3pDrfn/ioDsHN/udyVK3BEUQt6nwxa6DGQ
         hUDMgHnf7gkoWXR/ZtA+e2ha/vsYhc2HyPgY0CnypD/D9L3BQ9vqjN1UQHm2/cGvN6N7
         KJULy9WnnJNNjCHQrUFx6XcfXt8hqpvAa+Xd5Kwz7Va/lm4wIAozQTSAFoNDsxSVnAjI
         y3RQ==
Received: by 10.68.218.97 with SMTP id pf1mr251292103pbc.96.1358144126575;
 Sun, 13 Jan 2013 22:15:26 -0800 (PST)
Received: by 10.68.222.132 with HTTP; Sun, 13 Jan 2013 22:15:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213450>

I threw together a small utility called "git-reparent", available on GitHub at:

    https://github.com/MarkLodato/git-reparent

I welcome any comments or suggestions.  To make discussion easier,
I've copied the README and code below.

--- 8< ---

NAME
====

git-reparent - Recommit HEAD with a new set of parents.


SYNOPSIS
========

``git reparent [OPTIONS] ((-p <parent>)... | --no-parent)``


DESCRIPTION
===========

Create a new commit object that has the same tree and commit message as HEAD
but with a different set of parents.  If ``--no-reset`` is given, the full
object id of this commit is printed and the program exits; otherwise, ``git
reset`` is used to update HEAD and the current branch to this new commit.

This command can be used to manually shape the history of a repository.
Whereas ``git rebase`` moves around *diffs*, ``git reparent`` moves around
*snapshots*.  See EXAMPLES for a reason why you might want to use this
command.


OPTIONS
=======

-h, --help                show the help
-e, --edit                edit the commit message in an editor first
-m, --message <message>   use the given message instead of that of HEAD
-p, --parent <commit>     new parent to use; may be given multiple times
--no-parent               create a parentless commit
-q, --quiet               be quiet; only report errors
--no-reset                print the new object id instead of updating HEAD


INSTALLATION
============

Make executable and place somewhere in your $PATH.


EXAMPLES
========

Reparenting the tip of a branch
-------------------------------

Suppose we create some commit *B* and then accidentally pass the ``--amend``
flag when creating new commit *C*, resulting in the following history::

                B
               /
        ...---A---C (HEAD)

What we really wanted was one linear history, ``...---A--B--C``.  If we
were to use ``git rebase`` or ``git cherry-pick`` to reconstruct the history,
this would try to apply the *diff* of *A..C* onto *B*, which might fail.
Instead, what we really want to do is use the exact message and tree from *C*
but with parent *B* instead of *A*.  To do this, we run ::

        $ git reparent -p B

where the name *B* can be found by running ``git reflog`` and looking for the
first "commit (amend)".  The resulting history is now just what we wanted::

                C
               /
        ...---A---B---C' (HEAD)


Reparenting an inner commit
---------------------------

We can also update the parents of a commit other than the most recent.
Suppose that we want to perform a rebase-like operation, moving *master* onto
*origin/master*, but we want to completely ignore any changes made in the
remote branch.  That is, our history currently looks like this::

                B---C (master, HEAD)
               /
        ...---A---D---E (origin/master)

and we want to make it look like this::

                B---C   (origin/master)
               /       /
        ...---A---D---E---B'---C' (master, HEAD)

We can accomplish this by using ``git rebase --interactive`` along with ``git
reparent``::

        $ git rebase -i A
        # select the "edit" command for commit B
        # git rebase will dump us out at commit B
        $ git reparent -p origin/master
        $ git rebase --continue

Now the history will look as desired, and the trees, commit messages, and
authors of *B'* and *C'* will be identical to those of *B* and *C*,
respectively.


SEE ALSO
========

git-filter-branch(1) combined with either git grafts or git-replace(1) can be
used to achieve the same effect

git-rebase(1) can be used to re-apply the *diffs* of the current branch to
another


AUTHOR
======

Mark Lodato <lodatom@gmail.com>

--- 8< ---

#!/bin/sh
# Copyright (c) Mark Lodato, 2013

OPTIONS_SPEC="\
git reparent [OPTIONS] ((-p <parent>)... | --no-parent)

Recommit HEAD with a new set of parents.
--
h,help          show the help
e,edit          edit the commit message in an editor first
m,message=      use the given message instead of that of HEAD
p,parent=!      new parent to use; may be given multiple times
no-parent!      create a parentless commit
q,quiet         be quiet; only report errors
reset*          default behavior
no-reset!       print the new object id instead of updating HEAD
"
SUBDIRECTORY_OK=Yes
. "$(git --exec-path)/git-sh-setup" || exit $?
require_clean_work_tree reparent "Please commit or stash them first."

# Location of the temporary message.
msg_file="$GIT_DIR/reparent-msg"

die_with_usage() {
	echo "error: $1" >&2
	usage
}

edit=
message=
no_parent=
no_reset=
parent_flags=
quiet=
while [ $# -gt 0 ]; do
	case "$1" in
	-p)
		[ $# -eq 0 ] && die_with_usage "-p requires an argument"
		shift
		parent_flags="$parent_flags$(git rev-parse --sq-quote -p "$1")"
		;;
	--no-parent) no_parent=1 ;;
	-e)          edit=1 ;;
	--no-edit)   edit= ;;
	-m)          message="$2"; shift ;;
	--no-message)message= ;;
	-q)          quiet=-q ;;
	--no-quiet)  quiet= ;;
	--reset)     no_reset= ;;
	--no-reset)  no_reset=1 ;;
	--)          shift; break ;;
	*)           die "internal error: unknown flag $1" ;;
	esac
	shift
done
[ $# -gt 0 ] && \
	die_with_usage "no positional arguments expected"
[ -z "$no_parent" -a -z "$parent_flags" ] && \
	die_with_usage "either -p or --no-parent is required"
[ -n "$no_parent" -a -n "$parent_flags" ] && \
	die_with_usage "-p and --no-parent are mutually exclusive"

# Create the commit.
if [ -n "$message" ]; then
	echo "$message" > "$msg_file"
else
	git cat-file commit HEAD | sed "1,/^$/d" > "$msg_file"
fi
if [ -n "$edit" ]; then
	# TODO: use the normal `git commit` comment stripping stuff
	git_editor "$msg_file" || die "no editor configured"
	[ -s "$msg_file" ] || die "aborting due to empty commit message"
fi
eval "$(get_author_ident_from_commit HEAD)"
old_head="$(git rev-parse --short HEAD)" || exit $?
new_head="$(eval "git commit-tree HEAD: $parent_flags" '< $msg_file')" || \
	exit $?
rm "$msg_file"

# Print out the commit if --no-reset; otherwise update HEAD.
if [ -n "$no_reset" ]; then
	echo "$new_head"
else
	set_reflog_action reparent
	git reset $quiet "$new_head" || exit $?
	new_abbrev="$(git rev-parse --short HEAD)" || exit $?
	[ -z "$quiet" ] && echo "Moved HEAD to $new_abbrev (was $old_head)"
fi
