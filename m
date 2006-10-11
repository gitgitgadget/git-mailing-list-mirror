From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] Documentation/git-svn: document some of the newer features
Date: Wed, 11 Oct 2006 14:53:35 -0700
Message-ID: <1160603616126-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 11 23:54:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXm1F-00028j-IN
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161530AbWJKVxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161538AbWJKVxi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:53:38 -0400
Received: from hand.yhbt.net ([66.150.188.102]:12940 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1161530AbWJKVxf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 17:53:35 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 93AAA7DC08E;
	Wed, 11 Oct 2006 14:53:32 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 14:53:36 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.rc2.gbe730
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28754>

I've forgotten to document many of the features added along the
way in the manpages.  This fills in some holes in the
documentation and adds updates some outdated information.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |  139 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 123 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1cfa3e3..450ff1f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -37,7 +37,9 @@ COMMANDS
 'init'::
 	Creates an empty git repository with additional metadata
 	directories for git-svn.  The Subversion URL must be specified
-	as a command-line argument.
+	as a command-line argument.  Optionally, the target directory
+	to operate on can be specified as a second argument.  Normally
+	this command initializes the current directory.
 
 'fetch'::
 
@@ -63,7 +65,30 @@ manually joining branches on commit.
 	This is advantageous over 'commit' (below) because it produces
 	cleaner, more linear history.
 
+'log'::
+	This should make it easy to look up svn log messages when svn
+	users refer to -r/--revision numbers.
+
+	The following features from `svn log' are supported:
+
+	--revision=<n>[:<n>] - is supported, non-numeric args are not:
+	                       HEAD, NEXT, BASE, PREV, etc ...
+	-v/--verbose         - it's not completely compatible with
+	                       the --verbose output in svn log, but
+			       reasonably close.
+	--limit=<n>          - is NOT the same as --max-count,
+	                       doesn't count merged/excluded commits
+	--incremental        - supported
+
+	New features:
+
+	--show-commit        - shows the git commit sha1, as well
+	--oneline            - our version of --pretty=oneline
+
+	Any other arguments are passed directly to `git log'
+
 'commit'::
+	You should consider using 'dcommit' instead of this command.
 	Commit specified commit or tree objects to SVN.  This relies on
 	your imported fetch data being up-to-date.  This makes
 	absolutely no attempts to do patching when committing to SVN, it
@@ -86,12 +111,49 @@ manually joining branches on commit.
 	directories.  The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
+'commit-diff'::
+	Commits the diff of two tree-ish arguments from the
+	command-line.  This command is intended for interopability with
+	git-svnimport and does not rely on being inside an git-svn
+	init-ed repository.  This command takes three arguments, (a) the
+	original tree to diff against, (b) the new tree result, (c) the
+	URL of the target Subversion repository.  The final argument
+	(URL) may be omitted if you are working from a git-svn-aware
+	repository (that has been init-ed with git-svn).
+
+'graft-branches'::
+	This command attempts to detect merges/branches from already
+	imported history.  Techniques used currently include regexes,
+	file copies, and tree-matches).  This command generates (or
+	modifies) the $GIT_DIR/info/grafts file.  This command is
+	considered experimental, and inherently flawed because
+	merge-tracking in SVN is inherently flawed and inconsistent
+	across different repositories.
+
+'multi-init'::
+	This command supports git-svnimport-like command-line syntax for
+	importing repositories that are layed out as recommended by the
+	SVN folks.  This is a bit more tolerant than the git-svnimport
+	command-line syntax and doesn't require the user to figure out
+	where the repository URL ends and where the repository path
+	begins.
+
+'multi-fetch'::
+	This runs fetch on all known SVN branches we're tracking.  This
+	will NOT discover new branches (unlike git-svnimport), so
+	multi-init will need to be re-run (it's idempotent).
+
 --
 
 OPTIONS
 -------
 --
 
+--shared::
+--template=<template_directory>::
+	Only used with the 'init' command.
+	These are passed directly to gitlink:git-init-db[1].
+
 -r <ARG>::
 --revision <ARG>::
 
@@ -115,7 +177,7 @@ git-rev-list --pretty=oneline output can
 
 --rmdir::
 
-Only used with the 'commit' command.
+Only used with the 'dcommit', 'commit' and 'commit-diff' commands.
 
 Remove directories from the SVN tree if there are no files left
 behind.  SVN can version empty directories, and they are not
@@ -128,7 +190,7 @@ repo-config key: svn.rmdir
 -e::
 --edit::
 
-Only used with the 'commit' command.
+Only used with the 'dcommit', 'commit' and 'commit-diff' commands.
 
 Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
@@ -139,7 +201,7 @@ repo-config key: svn.edit
 -l<num>::
 --find-copies-harder::
 
-Both of these are only used with the 'commit' command.
+Only used with the 'dcommit', 'commit' and 'commit-diff' commands.
 
 They are both passed directly to git-diff-tree see
 gitlink:git-diff-tree[1] for more information.
@@ -164,7 +226,26 @@ will abort operation. The user will then
 appropriate entry.  Re-running the previous git-svn command
 after the authors-file is modified should continue operation.
 
-repo-config key: svn.authors-file
+repo-config key: svn.authorsfile
+
+-q::
+--quiet::
+	Make git-svn less verbose.  This only affects git-svn if you
+	have the SVN::* libraries installed and are using them.
+
+--repack[=<n>]::
+--repack-flags=<flags>
+	These should help keep disk usage sane for large fetches
+	with many revisions.
+
+	--repack takes an optional argument for the number of revisions
+	to fetch before repacking.  This defaults to repacking every
+	1000 commits fetched if no argument is specified.
+
+	--repack-flags are passed directly to gitlink:git-repack[1].
+
+repo-config key: svn.repack
+repo-config key: svn.repackflags
 
 -m::
 --merge::
@@ -215,6 +296,28 @@ section on
 '<<tracking-multiple-repos,Tracking Multiple Repositories or Branches>>'
 for more information on using GIT_SVN_ID.
 
+--follow-parent::
+	This is especially helpful when we're tracking a directory
+	that has been moved around within the repository, or if we
+	started tracking a branch and never tracked the trunk it was
+	descended from.
+
+	This relies on the SVN::* libraries to work.
+
+repo-config key: svn.followparent
+
+--no-metadata::
+	This gets rid of the git-svn-id: lines at the end of every commit.
+
+	With this, you lose the ability to use the rebuild command.  If
+	you ever lose your .git/svn/git-svn/.rev_db file, you won't be
+	able to fetch again, either.  This is fine for one-shot imports.
+
+	The 'git-svn log' command will not work on repositories using this,
+	either.
+
+repo-config key: svn.nometadata
+
 --
 
 COMPATIBILITY OPTIONS
@@ -231,6 +334,9 @@ for tracking the remote.
 --no-ignore-externals::
 Only used with the 'fetch' and 'rebuild' command.
 
+This command has no effect when you are using the SVN::*
+libraries with git, svn:externals are always avoided.
+
 By default, git-svn passes --ignore-externals to svn to avoid
 fetching svn:external trees into git.  Pass this flag to enable
 externals tracking directly via git.
@@ -264,7 +370,7 @@ Basic Examples
 Tracking and contributing to an Subversion managed-project:
 
 ------------------------------------------------------------------------
-# Initialize a tree (like git init-db):
+# Initialize a repo (like git init-db):
 	git-svn init http://svn.foo.org/project/trunk
 # Fetch remote revisions:
 	git-svn fetch
@@ -312,8 +418,8 @@ branches or directories in a Subversion 
 hack to allow it to track an arbitrary number of related _or_ unrelated
 SVN repositories via one git repository.  Simply set the GIT_SVN_ID
 environment variable to a name other other than "git-svn" (the default)
-and git-svn will ignore the contents of the $GIT_DIR/git-svn directory
-and instead do all of its work in $GIT_DIR/$GIT_SVN_ID for that
+and git-svn will ignore the contents of the $GIT_DIR/svn/git-svn directory
+and instead do all of its work in $GIT_DIR/svn/$GIT_SVN_ID for that
 invocation.  The interface branch will be remotes/$GIT_SVN_ID, instead of
 remotes/git-svn.  Any remotes/$GIT_SVN_ID branch should never be modified
 by the user outside of git-svn commands.
@@ -341,6 +447,9 @@ This allows you to tie unfetched SVN rev
 
 Advanced Example: Tracking a Reorganized Repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Note: this example is now obsolete if you have SVN::* libraries
+installed.  Simply use --follow-parent when fetching.
+
 If you're tracking a directory that has moved, or otherwise been
 branched or tagged off of another directory in the repository and you
 care about the full history of the project, then you can read this
@@ -371,20 +480,18 @@ he needed to continue tracking /ufoai/tr
 
 BUGS
 ----
-If somebody commits a conflicting changeset to SVN at a bad moment
-(right before you commit) causing a conflict and your commit to fail,
-your svn working tree ($GIT_DIR/git-svn/tree) may be dirtied.  The
-easiest thing to do is probably just to rm -rf $GIT_DIR/git-svn/tree and
-run 'rebuild'.
+
+If you are not using the SVN::* Perl libraries and somebody commits a
+conflicting changeset to SVN at a bad moment (right before you commit)
+causing a conflict and your commit to fail, your svn working tree
+($GIT_DIR/git-svn/tree) may be dirtied.  The easiest thing to do is
+probably just to rm -rf $GIT_DIR/git-svn/tree and run 'rebuild'.
 
 We ignore all SVN properties except svn:executable.  Too difficult to
 map them since we rely heavily on git write-tree being _exactly_ the
 same on both the SVN and git working trees and I prefer not to clutter
 working trees with metadata files.
 
-svn:keywords can't be ignored in Subversion (at least I don't know of
-a way to ignore them).
-
 Renamed and copied directories are not detected by git and hence not
 tracked when committing to SVN.  I do not plan on adding support for
 this as it's quite difficult and time-consuming to get working for all
-- 
1.4.3.rc2.gbe730
