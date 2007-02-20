From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/5] Refuse to pull/rebase when rendered unsafe by (un)commits.
Date: Tue, 20 Feb 2007 01:14:24 +0100
Message-ID: <20070220001424.31139.33562.stgit@gandelf.nowhere.earth>
References: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJDz-0000P4-NM
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965810AbXBTAua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965815AbXBTAu3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:50:29 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:43062 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965810AbXBTAu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:50:28 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A72C550785;
	Tue, 20 Feb 2007 01:15:46 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 1ED631F092;
	Tue, 20 Feb 2007 01:14:24 +0100 (CET)
In-Reply-To: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40185>


This can be overriden by a new --force flag.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py |    9 ++++++++-
 stgit/commands/pull.py   |    8 ++++++--
 stgit/commands/rebase.py |    5 ++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 56cb517..398231a 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -347,7 +347,14 @@ def make_patch_name(msg, unacceptable, default_name = 'patch',
         patchname = '%s-%d' % (patchname, suffix)
     return patchname
 
-def prepare_rebase():
+def prepare_rebase(real_rebase, force=None):
+    if not force:
+        # Be sure we won't loose results of stg-(un)commit by error.
+        # Do not require an existing orig-base for compatibility with 0.12 and earlier.
+        origbase = crt_series._get_field('orig-base')
+        if origbase and crt_series.get_base() != origbase:
+            raise CmdException, 'Rebasing would possibly lose data'
+
     # pop all patches
     applied = crt_series.get_applied()
     if len(applied) > 0:
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 83a2725..990244e 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -41,6 +41,9 @@ options = [make_option('-n', '--nopush',
                        action = 'store_true'),
            make_option('-m', '--merged',
                        help = 'check for patches merged upstream',
+                       action = 'store_true'),
+           make_option('--force',
+                       help = 'force rebase even if the stack based was moved by (un)commits',
                        action = 'store_true')]
 
 def func(parser, options, args):
@@ -61,12 +64,13 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    applied = prepare_rebase()
+    must_rebase = (config.get('stgit.pull-does-rebase') == 'yes')
+    applied = prepare_rebase(real_rebase=must_rebase, force=options.force)
 
     # pull the remote changes
     print 'Pulling from "%s"...' % repository
     git.fetch(repository)
-    if (config.get('stgit.pull-does-rebase') == 'yes'):
+    if must_rebase:
         rebase(git.fetch_head())
 
     post_rebase(applied, options.nopush, options.merged)
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 63f18ec..d132b60 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -34,6 +34,9 @@ options = [make_option('-n', '--nopush',
                        action = 'store_true'),
            make_option('-m', '--merged',
                        help = 'check for patches merged upstream',
+                       action = 'store_true'),
+           make_option('--force',
+                       help = 'force rebase even if the stack based was moved by (un)commits',
                        action = 'store_true')]
 
 def func(parser, options, args):
@@ -49,7 +52,7 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    applied = prepare_rebase()
+    applied = prepare_rebase(real_rebase=True, force=options.force)
     rebase(args[0])
     post_rebase(applied, options.nopush, options.merged)
 
