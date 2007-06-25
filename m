From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 5/7] Changed sync not to use -b which has other
	semantics.
Date: Mon, 25 Jun 2007 23:24:46 +0200
Message-ID: <20070625212446.17189.45201.stgit@gandelf.nowhere.earth>
References: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2w3Q-0004qc-MF
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbXFYVY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbXFYVY6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:24:58 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51299 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287AbXFYVY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:24:57 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B24D15A210;
	Mon, 25 Jun 2007 23:24:56 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A54731F150;
	Mon, 25 Jun 2007 23:24:46 +0200 (CEST)
In-Reply-To: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50925>

Using --branch here is confusing from a UI point of view, and
unnecessarily complicates implementation, making it more delicate to
get rid of the crt-series global.  We now use --ref-branch (-B)
instead.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/sync.py |   13 ++++++-------
 t/t2000-sync.sh        |    8 ++++----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index e769602..2ec7427 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -38,7 +38,7 @@ The sync operation can be reverted for individual patches with --undo."""
 options = [make_option('-a', '--all',
                        help = 'synchronise all the patches',
                        action = 'store_true'),
-           make_option('-b', '--branch',
+           make_option('-B', '--ref-branch',
                        help = 'syncronise patches with BRANCH'),
            make_option('-s', '--series',
                        help = 'syncronise patches with SERIES'),
@@ -69,9 +69,9 @@ def func(parser, options, args):
     global crt_series
 
     if options.undo:
-        if options.branch or options.series:
+        if options.ref_branch or options.series:
             raise CmdException, \
-                  '--undo cannot be specified with --branch or --series'
+                  '--undo cannot be specified with --ref-branch or --series'
         __check_all()
 
         out.start('Undoing the sync of "%s"' % crt_series.get_current())
@@ -80,12 +80,11 @@ def func(parser, options, args):
         out.done()
         return
 
-    if options.branch:
+    if options.ref_branch:
         # the main function already made crt_series to be the remote
         # branch
-        remote_series = crt_series
-        stgit.commands.common.crt_series = crt_series = stack.Series()
-        if options.branch == crt_series.get_name():
+        remote_series = stack.Series(options.ref_branch)
+        if options.ref_branch == crt_series.get_name():
             raise CmdException, 'Cannot synchronise with the current branch'
         remote_patches = remote_series.get_applied()
 
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index 69ab1ac..f831df7 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -48,7 +48,7 @@ test_expect_success \
 test_expect_success \
     'Synchronise second patch with the master branch' \
     '
-    stg sync -b master p2 &&
+    stg sync -B master p2 &&
     [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
     [ "$(echo $(stg unapplied))" = "" ] &&
     test $(cat foo2.txt) = "foo2"
@@ -57,7 +57,7 @@ test_expect_success \
 test_expect_success \
     'Synchronise the first two patches with the master branch' \
     '
-    stg sync -b master -a &&
+    stg sync -B master -a &&
     [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
     [ "$(echo $(stg unapplied))" = "" ] &&
     test $(cat foo1.txt) = "foo1" &&
@@ -100,7 +100,7 @@ test_expect_success \
 test_expect_success \
     'Synchronise second patch with the master branch' \
     '
-    stg sync -b master p2 &&
+    stg sync -B master p2 &&
     [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
     [ "$(echo $(stg unapplied))" = "" ] &&
     test $(cat bar2.txt) = "bar2"
@@ -109,7 +109,7 @@ test_expect_success \
 test_expect_failure \
     'Synchronise the first two patches with the master branch (to fail)' \
     '
-    stg sync -b master -a
+    stg sync -B master -a
     '
 
 test_expect_success \
