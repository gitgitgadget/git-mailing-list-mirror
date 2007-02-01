From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Fri, 02 Feb 2007 00:48:05 +0100
Message-ID: <20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClfw-0001mp-Hn
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422919AbXBAXtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422948AbXBAXtE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:49:04 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:38827 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422919AbXBAXtB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:49:01 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D93D04353D;
	Fri,  2 Feb 2007 00:48:59 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 2EE571F07F;
	Fri,  2 Feb 2007 00:48:05 +0100 (CET)
In-Reply-To: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38436>


Previously we were just assuming that the remote from which we
just failed defined a local branch whose name was the same as the
remote def, and that this branch was the parent.  While this is true
for the most common case (branch "origin" from remote "origin"), it is
quite an unflexible assumption.

Also move the rebasing from git.pull to commands.pull.func since that
is clearly stgit-level stuff, and rename git.pull() to git.fetch() to
match default behaviour.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |   20 +++++++++++---------
 stgit/git.py           |   10 +++-------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index f837fd4..15bbed6 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -26,15 +26,15 @@ from stgit import stack, git
 help = 'pull the changes from the remote repository'
 usage = """%prog [options] [<repository>]
 
-Pull the latest changes from the given repository (defaulting to
-'origin'). This command works by popping all the patches from the
-stack, pulling the changes in the parent repository, setting the base
-of the stack to the latest parent HEAD and pushing the patches back
-(unless '--nopush' is specified). The 'push' operation can fail if
-there are conflicts. They need to be resolved and the patch pushed
-again.
+Pull the latest changes from the given remote repository (defaulting
+to branch.<name>.remote, or 'origin' if not set). This command works
+by popping all the patches from the stack, pulling the changes in the
+parent repository, setting the base of the stack to the latest parent
+HEAD and pushing the patches back (unless '--nopush' is specified).
+The 'push' operation can fail if there are conflicts. They need to be
+resolved and the patch pushed again.
 
-Check the 'git pull' documentation for the <repository> format."""
+Check the 'git fetch' documentation for the <repository> format."""
 
 options = [make_option('-n', '--nopush',
                        help = 'do not push the patches back after pulling',
@@ -71,7 +71,9 @@ def func(parser, options, args):
 
     # pull the remote changes
     print 'Pulling from "%s"...' % repository
-    git.pull(repository)
+    git.fetch(repository)
+    if (config.get('stgit.pull-does-rebase')):
+        git.reset(tree_id = git.rev_parse(crt_series.get_parent_branch()))
     print 'done'
 
     # push the patches back
diff --git a/stgit/git.py b/stgit/git.py
index e30b959..49ebae1 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -807,9 +807,9 @@ def reset(files = None, tree_id = None, check_out = True):
     if not files:
         __set_head(tree_id)
 
-def pull(repository = 'origin', refspec = None):
-    """Pull changes from the remote repository. Uses 'git-fetch'
-    and moves the stack base.
+def fetch(repository = 'origin', refspec = None):
+    """Fetches changes from the remote repository, using 'git-fetch'
+    by default.
     """
     # we update the HEAD
     __clear_head_cache()
@@ -822,10 +822,6 @@ def pull(repository = 'origin', refspec = None):
     if __run(command, args) != 0:
         raise GitException, 'Failed "%s %s"' % (command, repository)
 
-    if (config.get('stgit.pull-does-rebase')):
-        # FIXME!
-        reset(tree_id = rev_parse(repository))
-
 def repack():
     """Repack all objects into a single pack
     """
