From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 2/4] Add git-sequencer prototype documentation
Date: Sat,  5 Jul 2008 19:00:04 +0200
Message-ID: <1215277204-20926-1-git-send-email-s-beyer@gmx.net>
References: <1214879914-17866-3-git-send-email-s-beyer@gmx.net>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 19:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFB8Q-0002QU-US
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 19:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbYGERAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYGERAU
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 13:00:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:45585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752118AbYGERAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 13:00:19 -0400
Received: (qmail invoked by alias); 05 Jul 2008 17:00:17 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp019) with SMTP; 05 Jul 2008 19:00:17 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19p7CMntJ1ptNSZ7HRPG5+tf0f0h1kcb14m1C/EyP
	PNOhcoaIP2Bacv
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KFB7E-0005Rr-RE; Sat, 05 Jul 2008 19:00:04 +0200
X-Mailer: git-send-email 1.5.6.361.g18ea7
In-Reply-To: <1214879914-17866-3-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87452>

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
This contains some feedback of Jakub.

 Documentation/git-sequencer.txt |  387 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 387 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sequencer.txt

diff --git a/Documentation/git-sequencer.txt b/Documentation/git-sequencer.txt
new file mode 100644
index 0000000..1a9eda4
--- /dev/null
+++ b/Documentation/git-sequencer.txt
@@ -0,0 +1,387 @@
+git-sequencer(1)
+================
+
+NAME
+----
+git-sequencer - Execute a sequence of git instructions
+
+SYNOPSIS
+--------
+[verse]
+'git-sequencer' [--batch] [--onto=<base>] [--verbose|--quiet] [<file>]
+'git-sequencer' --continue | --skip | --abort | --edit | --status
+
+
+DESCRIPTION
+-----------
+Executes a sequence of git instructions to HEAD or `<base>`.
+The sequence is given by `<file>` or standard input.
+Also see 'TODO FILE FORMAT' below.
+
+Before doing anything, the TODO file is checked for correct syntax
+and sanity.
+
+In case of a conflict or request in the TODO file, git-sequencer will
+pause. On conflict you can use git-diff to locate the markers (`<<<<<<<`)
+and make edits to resolve the conflict.
+
+For each file you edit, you need to tell git the changes by doing
+
+    git add <file>
+
+After resolving the conflict manually and updating the index with the
+desired resolution, you can continue the sequencing process with
+
+    git sequencer --continue
+
+Alternatively, you can undo the git-sequencer progress with
+
+    git sequencer --abort
+
+or skip the current instruction with
+
+    git sequencer --skip
+
+or correct the TODO file with
+
+    git sequencer --edit
+
+During pauses or when finished with the sequencing task, the current
+HEAD will always be the result of the last processed instruction.
+
+
+OPTIONS
+-------
+<file>::
+	Filename of the TODO file.  If omitted, standard input is used.
+	See 'TODO FILE FORMAT' below.
+
+-B::
+--batch::
+	Run in batch mode. If unexpected user intervention is needed
+	(e.g. a conflict or the need to run an editor), git-sequencer fails.
++
+Note that the sanity check fails, if you use this option
+and an instruction like `edit` or `pause` is in the TODO file.
+
+--onto=<base>::
+	Checkout given commit or branch before sequencing.
+	If you provide a branch, sequencer will make the provided
+	changes on the branch, i.e. the branch will be changed.
+
+--continue::
+	Restart the sequencing process after having resolved a merge conflict.
+
+--abort::
+	Restore the original branch and abort the sequence operation.
+
+--skip::
+	Restart the sequencing process by skipping the current instruction.
+
+--status::
+	Show the current status of git-sequencer and what
+	operations can be done to change that status.
+
+--edit::
+	Invoke editor to edit the unprocessed part of the TODO file.
++
+The file is syntax- and sanity-checked afterwards, so that you can
+safely run `git sequencer --skip` or `--continue` after editing.
+If you nonetheless noticed that you made a mistake, you can
+overwrite `.git/sequencer/todo` with `.git/sequencer/todo.old` and
+rerun `git sequencer --edit`.
++
+If the check fails you are prompted if you want to correct your
+changes, edit again, cancel editing or really want to save.
+
+-q::
+--quiet::
+	Suppress output.
+	(Not yet implemented.)
+
+-v::
+--verbose::
+	Be more verbose.
+
+
+NOTES
+-----
+
+When sequencing, it is possible, that you are changing the history of
+a branch in a way that can cause problems for anyone who already has
+a copy of the branch in their repository and tries to pull updates from
+you.  You should understand the implications of using git-sequencer on
+a repository that you share.
+
+git-sequencer will usually be called by another git porcelain, like
+linkgit:git-am[1] or linkgit:git-rebase[1].
+
+
+TODO FILE FORMAT
+----------------
+
+The TODO file contains basically one instruction per line.
+
+Blank lines will be ignored.
+All characters after a `#` character will be ignored until the end of a line.
+
+The following instructions can be used:
+
+
+edit <commit>::
+	Picks a commit and pauses the sequencer process to let you
+	make changes.
++
+This is a short form for `pick <commit> and `pause` on separate lines.
+
+
+mark <mark>::
+	Set a symbolic mark for the last commit.
+	`<mark>` is an unsigned integer starting at 1 and
+	prefixed with a colon, e.g. `:1`.
++
+The marks can help if you want to refer to commits that you
+created during the sequencer process, e.g. if you want to
+merge such a commit.
++
+The set marks are removed after the sequencer has completed.
+
+
+merge [options] <commit-ish1> <commit-ish2> ... <commit-ishN>::
+	Merge commits into HEAD.
++
+You can refer to a commit by a mark.
++
+If you do not provide a commit message (using `-F`, `-m`, `-C`, `-M`,
+or `--standard`), an editor will be invoked.
++
+See the following list and 'GENERAL OPTIONS' for values of `options`:
+
+	--standard;;
+		Generates a commit message like 'Merge ... into HEAD'.
+		See also linkgit:git-fmt-merge-msg[1].
+
+	-s <strategy>;;
+	--strategy=<strategy>;;
+		Use the given merge strategy.
+		See also linkgit:git-merge[1].
+
+
+pick [options] <commit>::
+	Pick (see linkgit:git-cherry-pick[1]) a commit.
+	Sequencer will pause on conflicts.
++
+See the following list and 'GENERAL OPTIONS' for values of `options`:
+
+	-R;;
+	--reverse;;
+		Revert the changes introduced by pick <commit>.
+
+	--mainline=<n>;;
+		Allows you to pick merge commits by specifying the
+		parent number (beginning from 1) to let sequencer
+		replay the changes relative to the specified parent.
+		+
+This option does not work together with `-R`.
+
+
+patch [options] <file>::
+	If file `<file>` is a pure (diff) patch, then apply the patch.
+	If no `--message` option is given, an editor will
+	be invoked to enter a commit message.
++
+If `<file>` is a linkgit:git-format-patch[1]-formatted patch,
+then the patch will be commited.
++
+See the following list and 'GENERAL OPTIONS' for values of `options`:
+
+	-3;;
+	--3way;;
+		When the patch does not apply cleanly, fall back on
+		3-way merge, if the patch records the identity of blobs
+		it is supposed to apply to, and we have those blobs
+		available locally.
+
+	-k;;
+		Pass `-k` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
+
+	-n;;
+		Pass `-n` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
+
+	--exclude=<path-pattern>;;
+		Do not apply changes to files matching the given path pattern.
+		This can be useful when importing patchsets, where you want to
+		exclude certain files or directories.
+
+	-R;;
+	--reverse;;
+		Apply the patch in reverse.
+
+	--no-add;;
+		When applying a patch, ignore additions made by the
+		patch.  This can be used to extract the common part between
+		two files by first running `diff` on them and applying
+		the result with this option, which would apply the
+		deletion part but not addition part.
+
+	--whitespace=<action>;;
+		Specify behavior on whitespace errors.
+		See linkgit:git-apply[1] for a detailed description.
+
+	--context=<n>;;
+		Ensure at least <n> lines of surrounding context match before
+		and after each change.  When fewer lines of surrounding
+		context exist they all must match.  By default no context is
+		ever ignored.
+
+	--inaccurate-eof;;
+		Under certain circumstances, some versions of diff do not
+		correctly detect a missing new-line at the end of the file.
+		As a result, patches created by such diff programs do not
+		record incomplete lines correctly.
+		This option adds support for applying such patches by
+		working around this bug.
+
+	-p<n>;;
+		Remove <n> leading slashes from traditional diff paths.
+		The default is 1.
+
+	--unidiff-zero;;
+		By default, linkgit:git-apply[1] expects that the patch being
+		applied is a unified diff with at least one line of context.
+		This provides good safety measures, but breaks down when
+		applying a diff generated with --unified=0. To bypass these
+		checks use '--unidiff-zero'.
+
+
+pause::
+	Pauses the sequencer process to let you manually make changes.
+	For example, you can re-edit the done commit, fix bugs or typos,
+	or you can make further commits on top of HEAD before continuing.
++
+After you have finished your changes and added them to the index,
+invoke `git-sequencer --continue`.
+If you only want to edit the last commit message with an editor,
+run `git commit --amend` (see linkgit:git-commit[1]) before saying
+`--continue`.
+
+
+ref <ref>::
+	Set ref `<ref>` to the current HEAD, see also
+	linkgit:git-update-ref[1].
+
+
+reset <commit-ish>::
+	Go back (see linkgit:git-reset[1] `--hard`) to commit `<commit-ish>`.
+	`<commit-ish>` can also be given by a mark, if prefixed with a colon.
+
+
+squash [options] <commit>::
+	Add the changes introduced by `<commit>` to the last commit.
++
+See 'GENERAL OPTIONS' for values of `options`.
+
+squash [options] --from <mark>::
+	Squash all commits from the given mark into one commit.
+	There must not be any `merge` instructions between the
+	`mark` instruction and this `squash --from` instruction.
++
+See the following list and 'GENERAL OPTIONS' for values of `options`:
+
+	--collect-signoffs;;
+		Collect the Signed-off-by: lines of each commit and
+		add them to the squashed commit message.
+		(Not yet implemented.)
+
+	--include-merges;;
+		Sanity check does not fail if you have merges
+		between HEAD and <mark>.
+
+
+GENERAL OPTIONS
+---------------
+
+Besides some special options, the instructions
+`patch`, `merge`, `pick`, `squash` take the following general options:
+
+--author=<author>::
+	Override the author name and e-mail address used in the commit.
+	Use `A U Thor <author@example.com>` format.
+
+-C <commit-ish>::
+--reuse-commit=<commit-ish>::
+	Reuse message and authorship data from specified commit.
+
+-M <commit-ish>
+--reuse-message=<commit-ish>::
+	Reuse message from specified commit.
+	Note, that only the commit message is reused
+	and not the authorship information.
+
+-F <file>::
+--file=<file>::
+	Take the commit message from the given file.
+
+-m <msg>::
+--message=<msg>::
+	Use the given `<msg>` as the commit message.
+
+--signoff::
+	Add `Signed-off-by:` line to the commit message (if not yet there),
+	using the committer identity of yourself.
+
+-e::
+--edit::
+	Regardless what commit message options are given,
+	invoke the editor to allow editing of the commit message.
+
+
+RETURN VALUES
+-------------
+
+git-sequencer returns:
+
+* `0`, if git-sequencer successfully completed all the instructions
+       in the TODO file or successfully aborted after
+       `git sequencer --abort`,
+* `2`, on user-requested pausing, e.g.
+       when using the `edit` instruction.
+* `3`, on pauses that are not requested, e.g.
+       when there are conflicts to resolve
+       or errors in the TODO file.
+* any other value on error, e.g.
+  running git-sequencer on a bare repository.
+
+
+EXAMPLES
+--------
+
+TODO [Here the usage of all commands should become clear.]
+
+
+SEE ALSO
+--------
+
+linkgit:git-add[1],
+linkgit:git-am[1],
+linkgit:git-cherry-pick[1],
+linkgit:git-commit[1],
+linkgit:git-fmt-merge-msg[1],
+linkgit:git-format-patch[1],
+linkgit:git-rebase[1],
+linkgit:git-reset[1],
+linkgit:git-update-ref[1]
+
+
+Authors
+-------
+Written by Stephan Beyer <s-beyer@gmx.net>.
+
+
+Documentation
+-------------
+Documentation by Stephan Beyer and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.5.6.361.g18ea7
