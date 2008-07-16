From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/3] Add git-sequencer documentation
Date: Wed, 16 Jul 2008 22:45:17 +0200
Message-ID: <14224c96008f30754acb021bc0af6b6641897a1e.1216233915.git.s-beyer@gmx.net>
References: <cfa3b96d13488d57caf8b758367cdf0679126462.1216233914.git.s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:47:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDtz-0004gx-Ej
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031AbYGPUpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbYGPUpt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:45:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:45938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756201AbYGPUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:45:32 -0400
Received: (qmail invoked by alias); 16 Jul 2008 20:45:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp008) with SMTP; 16 Jul 2008 22:45:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WDHk2UWaWkOTGtPsdKHADoIvf0opaqx0EAHC5yq
	BnPmTe/B6PUJHc
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJDsI-0005nq-DA; Wed, 16 Jul 2008 22:45:22 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <cfa3b96d13488d57caf8b758367cdf0679126462.1216233914.git.s-beyer@gmx.net> 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88755>

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/git-sequencer.txt |  673 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 673 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sequencer.txt

diff --git a/Documentation/git-sequencer.txt b/Documentation/git-sequencer.txt
new file mode 100644
index 0000000..8a701c4
--- /dev/null
+++ b/Documentation/git-sequencer.txt
@@ -0,0 +1,673 @@
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
+'git sequencer' [--batch] [--onto=<base>]
+		[--verbose | --no-advice | --quiet]
+		[--] [<file>]
+'git sequencer' --continue | --skip | --abort | --edit | --status
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
+In case of a conflict or request in the TODO file, 'git-sequencer' will
+pause. On conflict you can use 'git-diff' to locate the markers (`<<<<<<<`)
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
+Alternatively, you can undo the 'git-sequencer' progress with
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
+	(e.g. a conflict or the need to run an editor), 'git-sequencer' fails.
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
+	Show the current status of 'git-sequencer' and what
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
+--no-advice::
+	Suppress advice on intentional and unintentional pauses.
+
+-q::
+--quiet::
+	Suppress output. Implies `--no-advice`.
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
+you.  You should understand the implications of using 'git-sequencer' on
+a repository that you share.
+
+'git-sequencer' will usually be called by another git porcelain, like
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
+	Pick a commit and pause the sequencer process to let you
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
+		Generate a commit message like 'Merge ... into HEAD'.
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
+		Allow you to pick merge commits by specifying the
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
+		Pass `-k` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
+
+	-n;;
+		Pass `-n` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
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
+		two files by first running 'diff' on them and applying
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
+		Under certain circumstances, some versions of 'diff' do not
+		correctly detect a missing new-line at the end of the file.
+		As a result, patches created by such 'diff' programs do not
+		record incomplete lines correctly.
+		This option adds support for applying such patches by
+		working around this bug.
+
+	-p<n>;;
+		Remove <n> leading slashes from traditional diff paths.
+		The default is 1.
+
+	--unidiff-zero;;
+		By default, 'git-apply' expects that the patch being
+		applied is a unified diff with at least one line of context.
+		This provides good safety measures, but breaks down when
+		applying a diff generated with --unified=0. To bypass these
+		checks use this option.
+
+
+pause::
+	Pause the sequencer process to let you manually make changes.
+	For example, you can re-edit the done commit, split a commit,
+	fix bugs or typos, or make further commits on top of HEAD before
+	continuing.
++
+After you have finished your changes and added them to the index,
+invoke `git sequencer --continue`.
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
+run [--dir=<path>] [--] <cmd> <args>...::
+	Run command `<cmd>` with arguments `<args>`.
+	Pause (conflict-like) if exit status is non-zero.
++
+If `<path>` is set, sequencer will change directory to `<path>`
+before running the command and change back after exit.
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
+'git-sequencer' returns:
+
+* `0`, if 'git-sequencer' successfully completed all the instructions
+       in the TODO file or successfully aborted after
+       `git sequencer --abort`,
+* `2`, on user-requested pausing, e.g.
+       when using the `edit` instruction.
+* `3`, on pauses that are not requested, e.g.
+       when there are conflicts to resolve
+       or errors in the TODO file.
+* any other value on error, e.g.
+  running 'git-sequencer' on a bare repository.
+
+
+EXAMPLES
+--------
+
+Here are some examples that shall ease the start with the TODO
+file format.
+Make sure you have understood the `pick` and perhaps the `patch` command.
+Those will not be explained further.
+
+Manually editing and adding commits
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Sequencer allows manual intervention in between.
+This can be useful to
+
+* check if everything has gone right so far,
+
+* split commits,
+
+* edit changes and/or commit messages, or
+
+* add further manual commits on top of the current one.
+
+If you want to do one of this, either change `pick` to `edit`, or
+add a `pause` line after the specific instruction.
+
+Note that if you only want to edit the commit message in an
+editor, just use the `--edit` option of your `pick` or `patch`
+instruction.
+
+`HEAD` refers to the last commit being done by sequencer.
+So if you want to split a commit, repeat something like
+
+------------
+$ git reset HEAD^   # Reset index to HEAD^, but keep working tree
+		    # HEAD is the last commit being done by sequencer
+$ git add -p        # Add changes interactively to the index, and/or
+$ git add file1     # Add changes from file1 to the index
+$ git commit        # Commit staged changes
+------------
+
+until you have no changes to commit, and then run
+
+------------
+$ git sequencer --continue   # Continue sequencer process
+------------
+
+Be aware that if there are still staged changes,
+'git-sequencer' will add those changes to the last commit being done.
+
+
+Squashing commits
+~~~~~~~~~~~~~~~~~
+
+Squashing commits means putting the changes of many commits into one.
+If you have two commits `abcdef1` and `fa1afe1` and you want to squash them,
+feed 'git-sequencer' with a TODO file like:
+
+------------
+pick abcdef1
+squash fa1afe1
+------------
+
+Squash will concatenate the commit messages of `abcdef1` and `fa1afe1` and
+invoke an editor so that you can edit them.
+Perhaps you just want to reuse the commit message of `abcdef1` and
+add a signoff.  Then use:
+
+------------
+pick abcdef1
+squash -C abcdef1 --signoff fa1afe1
+------------
+
+You can also squash more than two commits.
+Basically you can do:
+
+------------
+pick A
+squash B
+squash C
+squash D
+squash --message "Make indentation consistent" --signoff E
+------------
+
+If somebody sent you a patch that you have not yet applied and you want
+to apply it and squash it, or if you have a `pick <commit>` list generated
+with something like
+
+------------
+$ git rev-list --no-merges --reverse A^..E | sed -e 's/^/pick /'`
+------------
+
+you can use the `mark` and `squash --from` instructions to
+squash all commits between them into one:
+
+------------
+mark :0
+pick A
+pick B
+pick C
+pick D
+pick E
+squash --message "Make indentation consistent" --signoff --from :0
+------------
+
+
+Branching and Merging
+~~~~~~~~~~~~~~~~~~~~~
+
+Merging branches can easily be done using the `merge` instruction.
+For an example, it is more interesting to branch, pick some commits
+and merge.  Imagine you want to 'copy' this onto the current branch:
+
+------------
+ ...--A1--A2--A3--A4--A5---MA-A6  refs/heads/old
+       |       \          /
+       |        C1--MC--C2  refs/heads/topic
+	\          /
+	 B1--B2--B3
+------------
+
+You want the copy to look exactly like this, except that you
+are not on branch `old`, and you want to call the copy of `topic`
+simply `topic2`.
+Here is a way to achieve this:
+
+------------
+pick A1
+mark :0    # remember this to pick further commits on trunk A
+
+pick B1    # pick commits for trunk B
+pick B2
+pick B3
+mark :1    # remember this for merge
+# Why not just merge B3 later?
+# Then you would merge the original B3 and not the copy.
+# But in this example you want to merge the copy of B3.
+
+reset :0   # go back to the copy of A1
+pick A2    # go on picking the commits of trunk A
+pick A3
+mark :2    # remember this to pick further commits on trunk A
+
+pick C1    # pick commits for trunk C
+merge -C MC :1    # merge trunk B
+pick C2
+ref refs/heads/topic2    # create branch for the C trunk
+
+reset :2   # go back to last commit of trunk A (copy of A3)
+pick A4    # go on picking the commits of trunk A
+pick A5
+merge --standard topic2   # merge trunk C
+pick A6
+------------
+
+
+Proper handling of conflicts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+First of all, you are encouraged to use linkgit:git-rerere[1]:
+
+------------
+$ git config rerere.enabled true    # enable rerere
+------------
+
+Sequencer invokes 'git-rerere' automatically on conflict.
+
+If you experience conflicts, try
+
+------------
+$ git diff     # Show conflicting code
+$ git status   # Show conflicting files
+------------
+
+Then fix these conflicts using your editor and run
+
+------------
+$ git add file1 file2 file3   # Add modified files to the index
+$ git status                  # Make sure working tree is clean
+$ git sequencer --continue    # Continue sequencer process
+------------
+
+Now assume a conflict happens because you have unproperly edited
+the TODO file.
+
+Imagine your initial TODO file was:
+
+------------
+pick A
+pick C
+pick D
+------------
+
+But you wanted to pick B before C, and now you have this conflict on
+picking C.  You may first have a look at:
+
+------------
+$ git sequencer --status
+------------
+
+This will show you, what has been done, in what step the conflict
+happened and what is still to do, like this:
+
+------------
+Already done (or tried):
+  pick A
+  pick C
+
+Interrupted by conflict at
+  pick C
+
+Still to do:
+  pick D
+
+To abort & restore, invoke:
+    git sequencer --abort
+To continue, invoke:
+    git sequencer --continue
+To skip the current instruction, invoke:
+    git sequencer --skip
+------------
+
+A good way to solve that situation is running
+
+------------
+$ git sequencer --edit
+------------
+
+and change the file to:
+
+------------
+pick B
+pick C
+pick D
+------------
+
+Save the file, and invoke:
+
+------------
+$ git sequencer --skip
+------------
+
+Then the conflict-ridden `pick C` will be skipped and B is picked,
+before C will again be picked.
+
+
+Running tests
+~~~~~~~~~~~~~
+
+Imagine you have test programs within a `tests/` directory in your working
+tree.  But before running your test programs, you have to invoke `make` in
+the root directory of the working tree to compile your project.
+
+If the commit policy of your project says that after every commit the
+software must be able to compile and the test suite must pass, you
+are required to check this after every pick.
+
+This example shows how 'git-sequencer' can assist you:
+
+------------
+pick A      # Fix foo
+run make
+run --dir=tests ./test-foo
+pick B      # Extend bar
+run make
+run --dir tests -- ./test-bar --expensive-tests
+pick C
+run make
+run --dir tests make tests
+------------
+
+Sequencer will be paused, when a run fails (i.e. on non-zero exit status).
+Then it is your turn to fix the problem and make the tests pass.
+
+Note, that on `git sequencer --continue`, 'git-sequencer' will not
+repeat the failed `run` instruction.
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
+linkgit:git-rerere[1],
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
1.5.6.3.391.ge45b
