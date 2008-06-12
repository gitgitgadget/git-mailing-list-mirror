From: Stephan Beyer <s-beyer@gmx.net>
Subject: [RFCv2/FYI] git-sequencer.txt
Date: Thu, 12 Jun 2008 02:22:58 +0200
Message-ID: <20080612002258.GC7200@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 02:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6abl-00070V-U3
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 02:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbYFLAXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 20:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYFLAXI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 20:23:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:42775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751907AbYFLAXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 20:23:05 -0400
Received: (qmail invoked by alias); 12 Jun 2008 00:23:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp015) with SMTP; 12 Jun 2008 02:23:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/L3D9mSPfLRHbdjW/JT522a9DQhoJ4S6Hlk9psxr
	COYmVd4tSAcMer
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K6aag-0008Nc-LB; Thu, 12 Jun 2008 02:22:58 +0200
Content-Disposition: inline
In-Reply-To: <20080607220101.GM31040@leksak.fem-net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84688>

Hi,

> I inline-attached the documentation (and somehow specification)
> for git-sequencer (my GSoC'08 project) for you to comment on.

Here's the second and - if there are no big protests - last attempt
before I send the prototype RFC/PATCH patchset to the list.

Note that I didn't add the "comment" (or "amend") insn[1] proposed by
Pierre Habouzit currently, but this is no problem.

 1. http://thread.gmane.org/gmane.comp.version-control.git/84616

There's also an undocumented --caller option.
I mean, it is as undocumented as "git-am --rebasing",
because it should only be used by sequencer user scripts.

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
'git-sequencer' [--batch] [--onto=<base>] [--verbose] [<file>]
'git-sequencer' --continue | --skip | --abort | --edit | --status


DESCRIPTION
-----------
Executes a sequence of git instructions to HEAD or `<base>`.
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
	Filename of the TODO file.  If omitted, standard input is used.
	See 'TODO FILE FORMAT' below.

-B::
--batch::
	Run in batch mode. If unexpected user intervention is needed
	(e.g. a conflict or the need to run an editor), git-sequencer fails.
+
Note that the sanity check fails, if you use this option
and an instruction like `edit` or `pause`.

--onto=<base>::
	Checkout given commit or branch before sequencing.
	If you provide a branch, sequencer will make the provided
	changes on the branch, i.e. the branch will be changed.

--continue::
	Restart the sequencing process after having resolved a merge conflict.

--abort::
	Restore the original branch and abort the sequence operation.

--skip::
	Restart the sequencing process by skipping the current patch.

--status::
	Show the current status of git-sequencer and what
	operations can be done to change that status.

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

-v::
--verbose::
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
This is a short form for `pick <commit> and `pause` on separate lines.


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
See the following list and 'GENERAL OPTIONS' for values of `<option>`:

	-R;;
	--revert;;
		Revert the changes introduced by pick <commit>.
	
	--mainline=<n>;;
	--pick-parent=<n>;;
		Allows you to pick merge commits by specifying the
		parent number (beginning from 1) to let sequencer
		replay the changes relative to the specified parent.


patch [<options>] <file>::
	If file `<file>` is a pure (diff) patch, then apply the patch.
	If no `--message` option is given, an editor will
	be invoked to enter a commit message.
+
If `<file>` is a linkgit:git-format-patch[1]-formatted patch,
then the patch will be commited.
+
See the following list and 'GENERAL OPTIONS' for values of `<option>`:

	-3;;
	--3way;;
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


pause::
	Pauses the sequencer process to let you manually make changes.
	For example, you can re-edit the done commit, fix bugs or typos,
	or you can make further commits on top of HEAD before continuing.
+
After you have finished your changes and added them to the index,
invoke `git-sequencer --continue`.
If you only want to edit the last commit message with an editor,
run `git commit --amend` (see linkgit:git-commit[1]) before.


reset <commit-ish>::
	Go back (see linkgit:git-reset[1] `--hard`) to commit `<commit-ish>`.
	`<commit-ish>` can also be given by a mark, if prefixed with a colon.


squash [<options>] <commit>::
	Add the changes introduced by `<commit>` to the last commit.
+
See 'GENERAL OPTIONS' for values of `<option>`.

squash [<options>] --up-to <mark>::
	Squash all commits up to the given mark into one commit.
	There must not be any merge commits in between.
+
See the following list and 'GENERAL OPTIONS' for values of `<option>`:

	--collect-signoffs;;
		Collect the Signed-by-off: lines of each commit and
		add them to the squashed commit message.
	
	--include-merges;;
		Sanity check does not fail if you have merges
		between HEAD and <mark>.


tag <tag>::
	Set tag `<tag>` to the current HEAD,
	see also linkgit:git-tag[1].
	If another commit is tagged `<tag>`, it will lose this tag,
	i.e. the tag will be reset to HEAD.



GENERAL OPTIONS
---------------

Besides some special options, the instructions
`patch`, `merge`, `pick`, `squash` take the following general options:

--author=<author>::
	Override the author name and e-mail address used in the commit.
	Use `A U Thor <author@example.com>` format.

-C <commit-ish>::
--reuse-commit=<commit-ish>::
--reference=<commit-ish>::
	Reuse message and authorship data from specified commit.

-M <commit-ish>
--reuse-message=<commit-ish>::
	Reuse message from specified commit.
	Note, that only the commit message is reused
	and not the authorship information.

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
linkgit:git-fmt-merge-msg[1],
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
