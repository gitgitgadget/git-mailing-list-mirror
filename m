From: Stephan Beyer <s-beyer@gmx.net>
Subject: [RFC] git-sequencer.txt
Date: Sun, 8 Jun 2008 00:01:01 +0200
Message-ID: <20080607220101.GM31040@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 00:02:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K56UO-0003B0-GH
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 00:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765700AbYFGWB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 18:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765702AbYFGWB1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 18:01:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:46422 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765691AbYFGWBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 18:01:24 -0400
Received: (qmail invoked by alias); 07 Jun 2008 22:01:21 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp059) with SMTP; 08 Jun 2008 00:01:21 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/LCMsGhM/L5MPTMyxhhU2v4S44tCmLlVCMkCTzni
	GxSo6hSJ2psE8G
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K56T7-0002cx-9v; Sun, 08 Jun 2008 00:01:01 +0200
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84230>

Hi,

I inline-attached the documentation (and somehow specification)
for git-sequencer (my GSoC'08 project) for you to comment on.

git-sequencer wants to become the common backend for git-am and 
git-rebase(--interactive) and perhaps some other git commands.
But, if git-sequencer.txt is good enough, you should be able to figure
out yourself, what it can actually be used for :-)

Some background on the project status:
There is already a working (shell) implementation of the following 
specification (90% finished), but we thought that it is useful to 
first give you only a spec without implementation details to comment on.

Note, that there is also a git-am and git-rebase--interactive that use
git-sequencer directly and ... all test cases of the test suite (in "next")
are passed.  So imho a first reality-check is passed, too.

But the second (and perhaps much harder) stage to pass is your 
point of view.
So I hope you will have some good ideas and strong opinions ;-)

Regards,
  Stephan

------------------------------ git-sequencer.txt ------------------------------
git-sequencer(1)
================

NAME
----
git-sequencer - Execute a sequence of git instructions

SYNOPSIS
--------
[verse]
'git-sequencer' [-v | --verbose] <file> [<branch>]
'git-sequencer' --continue | --skip | --abort | --edit


DESCRIPTION
-----------
Executes a sequence of git instructions to HEAD or `<branch>`.
The sequence is given by `<file>` or standard input.
Also see 'TODO FILE FORMAT' below.

Before doing anything, the TODO file is checked for correct syntax 
and sanity.

In case of a conflict or request in the TODO file, git-sequencer will
pause. On conflict you can use git-diff to locate the markers (`<<<<<<`) 
and make edits to resolve the conflict.

For each file you edit, you need to tell git the changes by doing

    git add <file>

After resolving the conflict manually and updating the index with the
desired resolution, you can continue the sequencing process with

    git sequencer --continue

Alternatively, you can undo the git-sequencer progress with

    git sequencer --abort

or skip the current instruction with

    git sequencer --skip

or correct the TODO file with

    git sequencer --edit

During pauses or when finished with the sequencing task, the current
HEAD will always be the result of the last processed instruction.


OPTIONS
-------
<file>::
	Filename of the TODO file.  Use `-` to read from standard input.
	See 'TODO FILE FORMAT' below.

<branch>::
	Working branch; defaults to HEAD.

--continue::
	Restart the sequencing process after having resolved a merge conflict.

--abort::
	Restore the original branch and abort the sequence operation.

--skip::
	Restart the sequencing process by skipping the current patch.

--edit::
	Invoke editor to edit the undone rest of the TODO file.
+
The file is syntax- and sanity-checked afterwards, so that you can 
safely run `git sequencer --skip` or `--continue` after editing.
If you nonetheless noticed that you made a mistake, you can 
overwrite `.git/sequencer/todo` with `.git/sequencer/todo.old` and
rerun `git sequencer --edit`.
+
If the check fails you are prompted if you want to correct your 
changes, edit again, cancel editing or really want to save.

-v, \--verbose::
	Be more verbose. [XXX: to be defined more accurately, i.e. print diffstat]


NOTES
-----

When sequencing, it is possible, that you are changing the history of
a branch in a way that can cause problems for anyone who already has 
a copy of the branch in their repository and tries to pull updates from
you.  You should understand the implications of using git-sequencer on
a repository that you share.

git-sequencer will usually be called by another git porcelain, like
linkgit:git-am[1] or linkgit:git-rebase[1].


TODO FILE FORMAT
----------------

The TODO file contains basically one instruction per line.

Blank lines will be ignored. 
All characters after a `#` character will be ignored until the end of a line.

The following instructions can be used:


edit <commit>::
	Picks a commit and pauses the sequencer process to let you
	make changes.
+
After you have finished your changes, invoke `git-sequencer --continue`.
If you only want to edit the commit message with an editor,
run `git-commit --amend` (see linkgit:git-commit[1]) before.
+
Note, that `edit <commit>` is a short form for `pick --edit <commit>`.


file [<options>] <file>::
	If file `<file>` is a pure (diff) patch, then apply the patch.
	If no `--message` option is given, an editor will
	be invoked to enter a commit message.
+
If `<file>` is a linkgit:git-format-patch[1]-formatted patch,
then the patch will be commited.
+
See the following list and 'GENERAL OPTIONS' for values of `<option>`:

	-3, --3way;;
		When the patch does not apply cleanly, fall back on
		3-way merge, if the patch records the identity of blobs
		it is supposed to apply to, and we have those blobs
		available locally.

	-k;;
		Pass `-k` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).

	-n;;
		Pass `-n` flag to `git-mailinfo` (see
		linkgit:git-mailinfo[1]).

	-u;;
		Pass `-u` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
		The proposed commit log message taken from the e-mail
		is re-coded into UTF-8 encoding (configuration variable
		`i18n.commitencoding` can be used to specify project's
		preferred encoding if it is not UTF-8).
+
This was optional in prior versions of git, but now it is the
default. You could use `-n` to override this.

	-*;;
		Any other dash-prefixed option is passed to
		linkgit:git-apply[1].
		This is especially useful for flags like
		`--reverse`, `-C<n>`, `-p<n>` or `--whitespace=<action>`.


mark <mark>::
	Set a symbolic mark for the last commit.
	`<mark>` is an unsigned integer starting at 1 and
	prefixed with a colon, e.g. `:1`.
+
The marks can help if you want to refer to commits that you
created during the sequencer process, e.g. if you want to
merge such a commit.
+
The set marks are removed after the sequencer has completed.


merge [<options>] <commit-ish1> <commit-ish2> ... <commit-ishN>::
	Merge commits into HEAD.
+
A commit can also be given by a mark, if prefixed with a colon.
+
If you do not provide a commit message (using `-F`, `-m`, `--reference` 
or `--standard`), an editor will be invoked.
+
See the following list and 'GENERAL OPTIONS' for values of `<option>`:

	--reference=<commit-ish>;;
		Take author and commit message of <commit-ish>.
	
	--standard;;
		Generates a commit message like 'Merge ... into HEAD'.
		See also linkgit:git-fmt-merge-msg[1].
	
	-s <strategy>;;
	--strategy=<strategy>;;
		Use the given merge strategy.
		See also linkgit:git-merge[1].


pick [<options>] <commit>::
	Pick (see linkgit:git-cherry-pick[1]) a commit.
	Sequencer will pause on conflicts.
+
See 'GENERAL OPTIONS' for values of `<option>`.


reset <commit-ish>::
	Go back (see linkgit:git-reset[1] `--hard`) to commit `<commit-ish>`.
	`<commit-ish>` can also be given by a mark, if prefixed with a colon.


squash [<options>] <commit>::
	Add the changes introduced by `<commit>` to the last commit.
+
See 'GENERAL OPTIONS' for values of `<option>`.


tag <tag>::
	Set tag `<tag>` to the current HEAD,
	see also linkgit:git-tag[1].
	If another commit is tagged `<tag>`, it will lose this tag,
	i.e. the tag will be reset to HEAD.



GENERAL OPTIONS
---------------

Besides some special options, the instructions
`file`, `merge`, `pick`, `squash` take the following general options:

--edit::
	Allows you to re-edit the done commit. For example, you can change
	the commit message in an editor, or fix even bugs or typos.
	Lets you also manually make further commits on top of the
	current commit before continuing.
+
You will have to invoke `git-sequencer --continue` (or `--edit` or `--abort`),
when finished.

--author=<author>::
	Override the author name and e-mail address used in the commit.
	Use `A U Thor <author@example.com>` format.

-F <file>::
--file=<file>::
	Take the commit message from the given file.

-m <msg>::
--message=<msg>::
	Use the given `<msg>` as the commit message.

-s::
--signoff::
	Add `Signed-off-by:` line to the commit message (if not yet there),
	using the committer identity of yourself.


RETURN VALUES
-------------

git-sequencer returns:

* `0`, if git-sequencer successfully completed all the instructions
       in the TODO file or successfully aborted after
       `git-sequencer --abort`,
* `2`, on user-requested pausing, e.g.
       when using the `edit` instruction.
* `3`, on pauses that are not requested, e.g.
       when there are conflicts to resolve.
* any other value on error, e.g.
  syntax errors in the TODO file or
  running git-sequencer on a bare repository.


EXAMPLES
--------

XXX [Here the usage of all commands should become clear,
but it's braindamaged to write this section as long as the file format
is in discussion.]


SEE ALSO
--------
linkgit:git-add[1],
linkgit:git-am[1],
linkgit:git-cherry-pick[1],
linkgit:git-commit[1],
linkgit:git-format-patch[1],
linkgit:git-rebase[1],
linkgit:git-reset[1],
linkgit:git-tag[1]


Authors
-------
XXX

Documentation
-------------
Documentation by Stephan Beyer and the git-list <git@vger.kernel.org>.

GIT
---
Part of the linkgit:git[1] suite

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
