From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/5] Factorize rebasing behaviour.
Date: Tue, 20 Feb 2007 01:14:03 +0100
Message-ID: <20070220001403.31139.19775.stgit@gandelf.nowhere.earth>
References: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJE2-0000P4-V5
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965820AbXBTAu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbXBTAu5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:50:57 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44263 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965820AbXBTAuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:50:51 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D3A7F5770A;
	Tue, 20 Feb 2007 01:25:54 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A9AAD1F087;
	Tue, 20 Feb 2007 01:14:03 +0100 (CET)
In-Reply-To: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40182>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py |   23 +++++++++++++++++++++++
 stgit/commands/pull.py   |   20 ++++----------------
 stgit/commands/rebase.py |   17 +++--------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 432edce..a352d89 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -346,3 +346,26 @@ def make_patch_name(msg, unacceptable, default_name = 'patch',
             suffix += 1
         patchname = '%s-%d' % (patchname, suffix)
     return patchname
+
+def prepare_rebase():
+    # pop all patches
+    applied = crt_series.get_applied()
+    if len(applied) > 0:
+        print 'Popping all applied patches...',
+        sys.stdout.flush()
+        crt_series.pop_patch(applied[0])
+        print 'done'
+    return applied
+
+def rebase(target):
+    if target == git.get_head():
+        print 'Already at "%s", no need for rebasing.' % target
+        return
+    
+    print 'Rebasing to "%s"...' % target
+    git.reset(tree_id = git_id(target))
+
+def post_rebase(applied, nopush, merged):
+    # push the patches back
+    if not nopush:
+        push_patches(applied, merged)
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 2d4a782..83a2725 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -61,27 +61,15 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    # pop all patches
-    applied = crt_series.get_applied()
-    if len(applied) > 0:
-        print 'Popping all applied patches...',
-        sys.stdout.flush()
-        crt_series.pop_patch(applied[0])
-        print 'done'
+    applied = prepare_rebase()
 
     # pull the remote changes
     print 'Pulling from "%s"...' % repository
     git.fetch(repository)
     if (config.get('stgit.pull-does-rebase') == 'yes'):
-        fetch_head = git.fetch_head()
-        if fetch_head != git.get_head():
-            print 'rebasing to "%s"...' % fetch_head
-            git.reset(tree_id = fetch_head)
-    print 'done'
-
-    # push the patches back
-    if not options.nopush:
-        push_patches(applied, options.merged)
+        rebase(git.fetch_head())
+
+    post_rebase(applied, options.nopush, options.merged)
 
     # maybe tidy up
     if config.get('stgit.keepoptimized') == 'yes':
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 2951421..63f18ec 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -49,19 +49,8 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    # pop all patches
-    applied = crt_series.get_applied()
-    if len(applied) > 0:
-        print 'Popping all applied patches...',
-        sys.stdout.flush()
-        crt_series.pop_patch(applied[0])
-        print 'done'
-
-    print 'Rebasing to "%s"...' % args[0]
-    git.reset(tree_id = git_id(args[0]))
-
-    # push the patches back
-    if not options.nopush:
-        push_patches(applied, options.merged)
+    applied = prepare_rebase()
+    rebase(args[0])
+    post_rebase(applied, options.nopush, options.merged)
 
     print_crt_patch()
