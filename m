From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 01/11] git-p4: introduce asciidoc documentation
Date: Sat, 17 Dec 2011 13:52:12 -0500
Message-ID: <1324147942-21558-2-git-send-email-pw@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
Cc: Frans Klaver <fransklaver@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:54:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzOT-0002e8-Sa
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab1LQSxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:53:47 -0500
Received: from honk.padd.com ([74.3.171.149]:48976 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab1LQSxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:53:42 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 321191C89;
	Sat, 17 Dec 2011 10:53:36 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0DD22314A9; Sat, 17 Dec 2011 13:52:43 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
In-Reply-To: <1324147942-21558-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187390>

Add proper documentation for git-p4.  Delete the old .txt
documentation from contrib/fast-import.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Cc: Frans Klaver <fransklaver@gmail.com>
Cc: Luke Diamand <luke@diamand.org>
---
Changes from v1:
    - review comments from Frans
    - review comments from Luke
    - spellcheck

 Documentation/git-p4.txt       |  456 ++++++++++++++++++++++++++++++++++++++++
 contrib/fast-import/git-p4.txt |  302 --------------------------
 2 files changed, 456 insertions(+), 302 deletions(-)
 create mode 100644 Documentation/git-p4.txt
 delete mode 100644 contrib/fast-import/git-p4.txt

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
new file mode 100644
index 0000000..c981407
--- /dev/null
+++ b/Documentation/git-p4.txt
@@ -0,0 +1,456 @@
+git-p4(1)
+=========
+
+NAME
+----
+git-p4 - Import from and submit to Perforce repositories
+
+
+SYNOPSIS
+--------
+[verse]
+'git p4 clone' [<sync options>] [<clone options>] <p4 depot path>...
+'git p4 sync' [<sync options>] [<p4 depot path>...]
+'git p4 rebase'
+'git p4 submit' [<submit options>] [<master branch name>]
+
+
+DESCRIPTION
+-----------
+This command provides a way to interact with p4 repositories
+using git.
+
+Create a new git repository from an existing p4 repository using
+'git p4 clone', giving it one or more p4 depot paths.  Incorporate
+new commits from p4 changes with 'git p4 sync'.  The 'sync' command
+is also used to include new branches from other p4 depot paths.
+Submit git changes back to p4 using 'git p4 submit'.  The command
+'git p4 rebase' does a sync plus rebases the current branch onto
+the updated p4 remote branch.
+
+
+EXAMPLE
+-------
+* Create an alias for 'git p4', using the full path to the 'git-p4'
+  script if needed:
++
+------------
+$ git config --global alias.p4 '!git-p4'
+------------
+
+* Clone a repository:
++
+------------
+$ git p4 clone //depot/path/project
+------------
+
+* Do some work in the newly created git repository:
++
+------------
+$ cd project
+$ vi foo.h
+$ git commit -a -m "edited foo.h"
+------------
+
+* Update the git repository with recent changes from p4, rebasing your
+  work on top:
++
+------------
+$ git p4 rebase
+------------
+
+* Submit your commits back to p4:
++
+------------
+$ git p4 submit
+------------
+
+
+COMMANDS
+--------
+
+Clone
+~~~~~
+Generally, 'git p4 clone' is used to create a new git directory
+from an existing p4 repository:
+------------
+$ git p4 clone //depot/path/project
+------------
+This:
+
+1.   Creates an empty git repository in a subdirectory called 'project'.
++
+2.   Imports the full contents of the head revision from the given p4
+depot path into a single commit in the git branch 'refs/remotes/p4/master'.
++
+3.   Creates a local branch, 'master' from this remote and checks it out.
+
+To reproduce the entire p4 history in git, use the '@all' modifier on
+the depot path:
+------------
+$ git p4 clone //depot/path/project@all
+------------
+
+
+Sync
+~~~~
+As development continues in the p4 repository, those changes can
+be included in the git repository using:
+------------
+$ git p4 sync
+------------
+This command finds new changes in p4 and imports them as git commits.
+
+P4 repositories can be added to an existing git repository using
+'git p4 sync' too:
+------------
+$ mkdir repo-git
+$ cd repo-git
+$ git init
+$ git p4 sync //path/in/your/perforce/depot
+------------
+This imports the specified depot into
+'refs/remotes/p4/master' in an existing git repository.  The
+'--branch' option can be used to specify a different branch to
+be used for the p4 content.
+
+If a git repository includes branches 'refs/remotes/origin/p4', these
+will be fetched and consulted first during a 'git p4 sync'.  Since
+importing directly from p4 is considerably slower than pulling changes
+from a git remote, this can be useful in a multi-developer environment.
+
+
+Rebase
+~~~~~~
+A common working pattern is to fetch the latest changes from the p4 depot
+and merge them with local uncommitted changes.  Often, the p4 repository
+is the ultimate location for all code, thus a rebase workflow makes
+sense.  This command does 'git p4 sync' followed by 'git rebase' to move
+local commits on top of updated p4 changes.
+------------
+$ git p4 rebase
+------------
+
+
+Submit
+~~~~~~
+Submitting changes from a git repository back to the p4 repository
+requires a separate p4 client workspace.  This should be specified
+using the 'P4CLIENT' environment variable or the git configuration
+variable 'git-p4.client'.  The p4 client must exist, but the client root
+will be created and populated if it does not already exist.
+
+To submit all changes that are in the current git branch but not in
+the 'p4/master' branch, use:
+------------
+$ git p4 submit
+------------
+
+To specify a branch other than the current one, use:
+------------
+$ git p4 submit topicbranch
+------------
+
+The upstream reference is generally 'refs/remotes/p4/master', but can
+be overridden using the '--origin=' command-line option.
+
+The p4 changes will be created as the user invoking 'git p4 submit'. The
+'--preserve-user' option will cause ownership to be modified
+according to the author of the git commit.  This option requires admin
+privileges in p4, which can be granted using 'p4 protect'.
+
+
+OPTIONS
+-------
+
+General options
+~~~~~~~~~~~~~~~
+All commands except clone accept this option.
+
+--git-dir <dir>::
+	Set the 'GIT_DIR' environment variable.  See linkgit:git[1].
+
+Sync options
+~~~~~~~~~~~~
+These options can be used in the initial 'clone' as well as in
+subsequent 'sync' operations.
+
+--branch <branch>::
+	Import changes into given branch.  If the branch starts with
+	'refs/', it will be used as is, otherwise the path 'refs/heads/'
+	will be prepended.  The default branch is 'master'.
+
+--detect-branches::
+	Use the branch detection algorithm to find new paths in p4.  It is
+	documented below in "BRANCH DETECTION".
+
+--changesfile <file>::
+	Import exactly the p4 change numbers listed in 'file', one per
+	line.  Normally, 'git p4' inspects the current p4 repository
+	state and detects the changes it should import.
+
+--silent::
+	Do not print any progress information.
+
+--verbose::
+	Provide more progress information.
+
+--detect-labels::
+	Query p4 for labels associated with the depot paths, and add
+	them as tags in git.
+
+--import-local::
+	By default, p4 branches are stored in 'refs/remotes/p4/',
+	where they will be treated as remote-tracking branches by
+	linkgit:git-branch[1] and other commands.  This option instead
+	puts p4 branches in 'refs/heads/p4/'.
+
+--max-changes <n>::
+	Limit the number of imported changes to 'n'.  Useful to
+	limit the amount of history when using the '@all' p4 revision
+	specifier.
+
+--keep-path::
+	The mapping of file names from the p4 depot path to git, by
+	default, involves removing the entire depot path.  With this
+	option, the full p4 depot path is retained in git.  For example,
+	path '//depot/main/foo/bar.c', when imported from
+	'//depot/main/', becomes 'foo/bar.c'.  With '--keep-path', the
+	git path is instead 'depot/main/foo/bar.c'.
+
+--use-client-spec::
+	Use a client spec to find the list of interesting files in p4.
+	The client spec is discovered using 'p4 client -o' which checks
+	the 'P4CLIENT' environment variable and returns a mapping of
+	depot files to workspace files.
+
+Clone options
+~~~~~~~~~~~~~
+These options can be used in an initial 'clone', along with the 'sync'
+options described above.
+
+--destination <directory>::
+	Where to create the git repository.  If not provided, the last
+	component in the p4 depot path is used to create a new
+	directory.
+
+--bare::
+	Perform a bare clone.  See linkgit:git-clone[1].
+
+-/ <path>::
+	Exclude selected depot paths when cloning.
+
+Submit options
+~~~~~~~~~~~~~~
+These options can be used to modify 'git p4 submit' behavior.
+
+--verbose::
+	Provide more progress information.
+
+--origin <commit>::
+	Upstream location from which commits are identified to submit to
+	p4.  By default, this is the most recent p4 commit reachable
+	from 'HEAD'.
+
+-M[<n>]::
+	Detect renames.  See linkgit:git-diff[1].  Renames will be
+	represented in p4 using explicit 'move' operations.
+
+--preserve-user::
+	Re-author p4 changes before submitting to p4.  This option
+	requires p4 admin privileges.
+
+
+DEPOT PATH SYNTAX
+-----------------
+The p4 depot path argument to 'git p4 sync' and 'git p4 clone' can
+be one or more space-separated p4 depot paths, with an optional
+p4 revision specifier on the end:
+
+"//depot/my/project"::
+    Import one commit with all files in the '#head' change under that tree.
+
+"//depot/my/project@all"::
+    Import one commit for each change in the history of that depot path.
+
+"//depot/my/project@1,6"::
+    Import only changes 1 through 6.
+
+"//depot/proj1 //depot/proj2@all"::
+    Import all changes from both named depot paths.
+
+See 'p4 help revisions' for the full syntax of p4 revision specifiers.
+
+
+BRANCH DETECTION
+----------------
+P4 does not have the same concept of a branch as git.  Instead,
+p4 organizes its content as a directory tree, where by convention
+different logical branches are in different locations in the tree.
+The 'p4 branch' command is used to maintain mappings between
+different areas in the tree, and indicate related content.  'git p4'
+can use these mappings to determine branch relationships.
+
+If you have a repository where all the branches of interest exist as
+subdirectories of a single depot path, you can use '--detect-branches'
+when cloning or syncing to have 'git p4' automatically find
+subdirectories in p4, and to generate these as branches in git.
+
+For example, if the P4 repository structure is:
+----
+//depot/main/...
+//depot/branch1/...
+----
+
+And "p4 branch -o branch1" shows a View line that looks like:
+----
+//depot/main/... //depot/branch1/...
+----
+
+Then this 'git p4 clone' command:
+----
+git p4 clone --detect-branches //depot@all
+----
+produces a separate branch in 'refs/remotes/p4/' for //depot/main,
+called 'master', and one for //depot/branch1 called 'depot/branch1'.
+
+However, it is not necessary to create branches in p4 to be able to use
+them like branches.  Because it is difficult to infer branch
+relationships automatically, a git configuration setting
+'git-p4.branchList' can be used to explicitly identify branch
+relationships.  It is a list of "source:destination" pairs, like a
+simple p4 branch specification, where the "source" and "destination" are
+the path elements in the p4 repository.  The example above relied on the
+presence of the p4 branch.  Without p4 branches, the same result will
+occur with:
+----
+git config git-p4.branchList main:branch1
+git p4 clone --detect-branches //depot@all
+----
+
+
+PERFORMANCE
+-----------
+The fast-import mechanism used by 'git p4' creates one pack file for
+each invocation of 'git p4 sync'.  Normally, git garbage compression
+(linkgit:git-gc[1]) automatically compresses these to fewer pack files,
+but explicit invocation of 'git repack -adf' may improve performance.
+
+
+CONFIGURATION VARIABLES
+-----------------------
+The following config settings can be used to modify 'git p4' behavior.
+They all are in the 'git-p4' section.
+
+General variables
+~~~~~~~~~~~~~~~~~
+git-p4.user::
+	User specified as an option to all p4 commands, with '-u <user>'.
+	The environment variable 'P4USER' can be used instead.
+
+git-p4.password::
+	Password specified as an option to all p4 commands, with
+	'-P <password>'.
+	The environment variable 'P4PASS' can be used instead.
+
+git-p4.port::
+	Port specified as an option to all p4 commands, with
+	'-p <port>'.
+	The environment variable 'P4PORT' can be used instead.
+
+git-p4.host::
+	Host specified as an option to all p4 commands, with
+	'-h <host>'.
+	The environment variable 'P4HOST' can be used instead.
+
+git-p4.client::
+	Client specified as an option to all p4 commands, with
+	'-c <client>'.  This can also be used as a way to find
+	the client spec for the 'useClientSpec' option.
+	The environment variable 'P4CLIENT' can be used instead.
+
+Clone and sync variables
+~~~~~~~~~~~~~~~~~~~~~~~~
+git-p4.syncFromOrigin::
+	Because importing commits from other git repositories is much faster
+	than importing them from p4, a mechanism exists to find p4 changes
+	first in git remotes.  If branches exist under 'refs/remote/origin/p4',
+	those will be fetched and used when syncing from p4.  This
+	variable can be set to 'false' to disable this behavior.
+
+git-p4.branchUser::
+	One phase in branch detection involves looking at p4 branches
+	to find new ones to import.  By default, all branches are
+	inspected.  This option limits the search to just those owned
+	by the single user named in the variable.
+
+git-p4.branchList::
+	List of branches to be imported when branch detection is
+	enabled.  Each entry should be a pair of branch names separated
+	by a colon (:).  This example declares that both branchA and
+	branchB were created from main:
+-------------
+git config       git-p4.branchList main:branchA
+git config --add git-p4.branchList main:branchB
+-------------
+
+git-p4.useClientSpec::
+	Specify that the p4 client spec to be used to identify p4 depot
+	paths of interest.  This is equivalent to specifying the option
+	'--use-client-spec'.  The variable 'git-p4.client' can be used
+	to specify the name of the client.
+
+Submit variables
+~~~~~~~~~~~~~~~~
+git-p4.detectRenames::
+	Detect renames.  See linkgit:git-diff[1].
+
+git-p4.detectCopies::
+	Detect copies.  See linkgit:git-diff[1].
+
+git-p4.detectCopiesHarder::
+	Detect copies harder.  See linkgit:git-diff[1].
+
+git-p4.preserveUser::
+	On submit, re-author changes to reflect the git author,
+	regardless of who invokes 'git p4 submit'.
+
+git-p4.allowMissingP4Users::
+	When 'preserveUser' is true, 'git p4' normally dies if it
+	cannot find an author in the p4 user map.  This setting
+	submits the change regardless.
+
+git-p4.skipSubmitEdit::
+	The submit process invokes the editor before each p4 change
+	is submitted.  If this setting is true, though, the editing
+	step is skipped.
+
+git-p4.skipSubmitEditCheck::
+	After editing the p4 change message, 'git p4' makes sure that
+	the description really was changed by looking at the file
+	modification time.  This option disables that test.
+
+git-p4.allowSubmit::
+	By default, any branch can be used as the source for a 'git p4
+	submit' operation.  This configuration variable, if set, permits only
+	the named branches to be used as submit sources.
+
+git-p4.skipUserNameCheck::
+	If the user running 'git p4 submit' does not exist in the p4
+	user map, 'git p4' exits.  This option can be used to force
+	submission regardless.
+
+
+IMPLEMENTATION DETAILS
+----------------------
+* Changesets from p4 are imported using git fast-import.
+* Cloning or syncing does not require a p4 client; file contents are
+  collected using 'p4 print'.
+* Submitting requires a p4 client, which is not in the same location
+  as the git repository.  Patches are applied, one at a time, to
+  this p4 client and submitted from there.
+* Each commit imported by 'git p4' has a line at the end of the log
+  message indicating the p4 depot location and change number.  This
+  line is used by later 'git p4 sync' operations to know which p4
+  changes are new.
+
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
deleted file mode 100644
index 5044a12..0000000
--- a/contrib/fast-import/git-p4.txt
+++ /dev/null
@@ -1,302 +0,0 @@
-git-p4 - Perforce <-> Git converter using git-fast-import
-
-Usage
-=====
-
-git-p4 can be used in two different ways:
-
-1) To import changes from Perforce to a Git repository, using "git-p4 sync".
-
-2) To submit changes from Git back to Perforce, using "git-p4 submit".
-
-Importing
-=========
-
-Simply start with
-
-  git-p4 clone //depot/path/project
-
-or
-
-  git-p4 clone //depot/path/project myproject
-
-This will:
-
-1) Create an empty git repository in a subdirectory called "project" (or
-"myproject" with the second command)
-
-2) Import the head revision from the given Perforce path into a git branch
-called "p4" (remotes/p4 actually)
-
-3) Create a master branch based on it and check it out.
-
-If you want the entire history (not just the head revision) then you can simply
-append a "@all" to the depot path:
-
-  git-p4 clone //depot/project/main@all myproject
-
-
-
-If you want more control you can also use the git-p4 sync command directly:
-
-  mkdir repo-git
-  cd repo-git
-  git init
-  git-p4 sync //path/in/your/perforce/depot
-
-This will import the current head revision of the specified depot path into a
-"remotes/p4/master" branch of your git repository. You can use the
---branch=mybranch option to import into a different branch.
-
-If you want to import the entire history of a given depot path simply use:
-
-  git-p4 sync //path/in/depot@all
-
-
-Note:
-
-To achieve optimal compression you may want to run 'git repack -a -d -f' after
-a big import. This may take a while.
-
-Incremental Imports
-===================
-
-After an initial import you can continue to synchronize your git repository
-with newer changes from the Perforce depot by just calling
-
-  git-p4 sync
-
-in your git repository. By default the "remotes/p4/master" branch is updated.
-
-Advanced Setup
-==============
-
-Suppose you have a periodically updated git repository somewhere, containing a
-complete import of a Perforce project. This repository can be cloned and used
-with git-p4. When updating the cloned repository with the "sync" command,
-git-p4 will try to fetch changes from the original repository first. The git
-protocol used with this is usually faster than importing from Perforce
-directly.
-
-This behaviour can be disabled by setting the "git-p4.syncFromOrigin" git
-configuration variable to "false".
-
-Updating
-========
-
-A common working pattern is to fetch the latest changes from the Perforce depot
-and merge them with local uncommitted changes. The recommended way is to use
-git's rebase mechanism to preserve linear history. git-p4 provides a convenient
-
-  git-p4 rebase
-
-command that calls git-p4 sync followed by git rebase to rebase the current
-working branch.
-
-Submitting
-==========
-
-git-p4 has support for submitting changes from a git repository back to the
-Perforce depot. This requires a Perforce checkout separate from your git
-repository. To submit all changes that are in the current git branch but not in
-the "p4" branch (or "origin" if "p4" doesn't exist) simply call
-
-    git-p4 submit
-
-in your git repository. If you want to submit changes in a specific branch that
-is not your current git branch you can also pass that as an argument:
-
-    git-p4 submit mytopicbranch
-
-You can override the reference branch with the --origin=mysourcebranch option.
-
-The Perforce changelists will be created with the user who ran git-p4. If you
-use --preserve-user then git-p4 will attempt to create Perforce changelists
-with the Perforce user corresponding to the git commit author. You need to
-have sufficient permissions within Perforce, and the git users need to have
-Perforce accounts. Permissions can be granted using 'p4 protect'.
-
-If a submit fails you may have to "p4 resolve" and submit manually. You can
-continue importing the remaining changes with
-
-  git-p4 submit --continue
-
-Example
-=======
-
-# Clone a repository
-  git-p4 clone //depot/path/project
-# Enter the newly cloned directory
-  cd project
-# Do some work...
-  vi foo.h
-# ... and commit locally to gi
-  git commit foo.h
-# In the meantime somebody submitted changes to the Perforce depot. Rebase your latest
-# changes against the latest changes in Perforce:
-  git-p4 rebase
-# Submit your locally committed changes back to Perforce
-  git-p4 submit
-# ... and synchronize with Perforce
-  git-p4 rebase
-
-
-Configuration parameters
-========================
-
-git-p4.user ($P4USER)
-
-Allows you to specify the username to use to connect to the Perforce repository.
-
-  git config [--global] git-p4.user public
-
-git-p4.password ($P4PASS)
-
-Allows you to specify the password to use to connect to the Perforce repository.
-Warning this password will be visible on the command-line invocation of the p4 binary.
-
-  git config [--global] git-p4.password public1234
-
-git-p4.port ($P4PORT)
-
-Specify the port to be used to contact the Perforce server. As this will be passed
-directly to the p4 binary, it may be in the format host:port as well.
-
-  git config [--global] git-p4.port codes.zimbra.com:2666
-
-git-p4.host ($P4HOST)
-
-Specify the host to contact for a Perforce repository.
-
-  git config [--global] git-p4.host perforce.example.com
-
-git-p4.client ($P4CLIENT)
-
-Specify the client name to use
-
-  git config [--global] git-p4.client public-view
-
-git-p4.allowSubmit
-
-  git config [--global] git-p4.allowSubmit false
-
-git-p4.syncFromOrigin
-
-A useful setup may be that you have a periodically updated git repository
-somewhere that contains a complete import of a Perforce project. That git
-repository can be used to clone the working repository from and one would
-import from Perforce directly after cloning using git-p4. If the connection to
-the Perforce server is slow and the working repository hasn't been synced for a
-while it may be desirable to fetch changes from the origin git repository using
-the efficient git protocol. git-p4 supports this setup by calling "git fetch origin"
-by default if there is an origin branch. You can disable this using:
-
-  git config [--global] git-p4.syncFromOrigin false
-
-git-p4.useclientspec
-
-  git config [--global] git-p4.useclientspec false
-
-The P4CLIENT environment variable should be correctly set for p4 to be
-able to find the relevant client.  This client spec will be used to
-both filter the files cloned by git and set the directory layout as
-specified in the client (this implies --keep-path style semantics).
-
-git-p4.skipSubmitEdit
-
-  git config [--global] git-p4.skipSubmitEdit false
-
-Normally, git-p4 invokes an editor after each commit is applied so
-that you can make changes to the submit message.  Setting this
-variable to true will skip the editing step, submitting the change as is.
-
-git-p4.skipSubmitEditCheck
-
-  git config [--global] git-p4.skipSubmitEditCheck false
-
-After the editor is invoked, git-p4 normally makes sure you saved the
-change description, as an indication that you did indeed read it over
-and edit it.  You can quit without saving to abort the submit (or skip
-this change and continue).  Setting this variable to true will cause
-git-p4 not to check if you saved the change description.  This variable
-only matters if git-p4.skipSubmitEdit has not been set to true.
-
-git-p4.preserveUser
-
-  git config [--global] git-p4.preserveUser false
-
-If true, attempt to preserve user names by modifying the p4 changelists. See
-the "--preserve-user" submit option.
-
-git-p4.allowMissingPerforceUsers
-
-  git config [--global] git-p4.allowMissingP4Users false
-
-If git-p4 is setting the perforce user for a commit (--preserve-user) then
-if there is no perforce user corresponding to the git author, git-p4 will
-stop. With allowMissingPerforceUsers set to true, git-p4 will use the
-current user (i.e. the behavior without --preserve-user) and carry on with
-the perforce commit.
-
-git-p4.skipUserNameCheck
-
-  git config [--global] git-p4.skipUserNameCheck false
-
-When submitting, git-p4 checks that the git commits are authored by the current
-p4 user, and warns if they are not. This disables the check.
-
-git-p4.detectRenames
-
-Detect renames when submitting changes to Perforce server. Will enable -M git
-argument. Can be optionally set to a number representing the threshold
-percentage value of the rename detection.
-
-  git config [--global] git-p4.detectRenames true
-  git config [--global] git-p4.detectRenames 50
-
-git-p4.detectCopies
-
-Detect copies when submitting changes to Perforce server. Will enable -C git
-argument. Can be optionally set to a number representing the threshold
-percentage value of the copy detection.
-
-  git config [--global] git-p4.detectCopies true
-  git config [--global] git-p4.detectCopies 80
-
-git-p4.detectCopiesHarder
-
-Detect copies even between files that did not change when submitting changes to
-Perforce server. Will enable --find-copies-harder git argument.
-
-  git config [--global] git-p4.detectCopies true
-
-git-p4.branchUser
-
-Only use branch specifications defined by the selected username.
-
-  git config [--global] git-p4.branchUser username
-
-git-p4.branchList
-
-List of branches to be imported when branch detection is enabled.
-
-  git config [--global] git-p4.branchList main:branchA
-  git config [--global] --add git-p4.branchList main:branchB
-
-Implementation Details...
-=========================
-
-* Changesets from Perforce are imported using git fast-import.
-* The import does not require anything from the Perforce client view as it just uses
-  "p4 print //depot/path/file#revision" to get the actual file contents.
-* Every imported changeset has a special [git-p4...] line at the
-  end of the log message that gives information about the corresponding
-  Perforce change number and is also used by git-p4 itself to find out
-  where to continue importing when doing incremental imports.
-  Basically when syncing it extracts the perforce change number of the
-  latest commit in the "p4" branch and uses "p4 changes //depot/path/...@changenum,#head"
-  to find out which changes need to be imported.
-* git-p4 submit uses "git rev-list" to pick the commits between the "p4" branch
-  and the current branch.
-  The commits themselves are applied using git diff/format-patch ... | git apply
-
-- 
1.7.8.258.g45cc3c
