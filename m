From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Use FETCH_HEAD to know where to rebase to after pull.
Date: Sat, 03 Feb 2007 22:29:30 +0100
Message-ID: <20070203212838.17474.42584.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSSr-0004TM-Ge
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXBCVa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbXBCVa1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:30:27 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:58899 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbXBCVa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:30:26 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id B186D277D0;
	Sat,  3 Feb 2007 22:30:25 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id CC3831F07F;
	Sat,  3 Feb 2007 22:29:30 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38606>


Since 'git fetch' already takes care of the branch.*.merge parameters,
resolves the new tip of the parent branch and puts it in FETCH_HEAD,
we're better just taking it from there.

This fixes the regression on t1200-push-modified.sh.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |    4 ++--
 stgit/git.py           |   23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 330cc25..e1aca87 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -73,8 +73,8 @@ def func(parser, options, args):
     print 'Pulling from "%s"...' % repository
     git.fetch(repository)
     if (config.get('stgit.pull-does-rebase') == 'yes'):
-        print "rebasing to '%s'..." % crt_series.get_parent_branch()
-        git.reset(tree_id = git.rev_parse(crt_series.get_parent_branch()))
+        print "rebasing to '%s'..." % git.fetch_head()
+        git.reset(tree_id = git.fetch_head())
     print 'done'
 
     # push the patches back
diff --git a/stgit/git.py b/stgit/git.py
index 3d84e97..6769a9f 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -931,7 +931,8 @@ def remotes_local_branches(remote):
         for line in stream:
             # Only consider Pull lines
             m = re.match('^Pull: (.*)\n$', line)
-            branches.append(refspec_localpart(m.group(1)))
+            if m:
+                branches.append(refspec_localpart(m.group(1)))
         stream.close()
     elif remote in __remotes_from_dir('branches'):
         # old-style branches only declare one branch
@@ -955,3 +956,23 @@ def identify_remote(branchname):
 
     # if we get here we've found nothing
     return None
+
+def fetch_head():
+    """Return the git id for the tip of the parent branch as left by
+    'git fetch'.
+    """
+
+    fetch_head=None
+    stream = open(os.path.join(basedir.get(), 'FETCH_HEAD'), "r")
+    for line in stream:
+        # Only consider lines not tagged not-for-merge
+        m = re.match('^([^\t]*)\t\t', line)
+        if m:
+            if fetch_head:
+                raise GitException, "StGit does not support multiple FETCH_HEAD"
+            else:
+                fetch_head=m.group(1)
+    stream.close()
+
+    # here we are sure to have a single fetch_head
+    return fetch_head
