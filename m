From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 6/9] Changed sync not to use -b which has other
	semantics.
Date: Sun, 17 Jun 2007 00:01:00 +0200
Message-ID: <20070616220100.14941.3131.stgit@gandelf.nowhere.earth>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgKu-0000H7-Ij
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226AbXFPWA6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbXFPWA5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:00:57 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45557 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105AbXFPWAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:00:52 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0009B5A121;
	Sun, 17 Jun 2007 00:00:50 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 5D3F21F08A;
	Sun, 17 Jun 2007 00:01:00 +0200 (CEST)
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50315>

Using --branch here is confusing from a UI point of view, and
unnecessarily complicates implementation, making in more delicate to
get rid of the crt-series global.  We now use --ref-branch (-B)
instead.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/sync.py |   15 ++++++---------
 t/t2000-sync.sh        |    8 ++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 9c95b99..2882391 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -51,7 +51,7 @@ class concreteCommand(Command):
     options = [make_option('-a', '--all',
                            help = 'synchronise all the patches',
                            action = 'store_true'),
-               make_option('-b', '--branch',
+               make_option('-B', '--ref-branch',
                            help = 'syncronise patches with BRANCH'),
                make_option('-s', '--series',
                            help = 'syncronise patches with SERIES'),
@@ -70,9 +70,9 @@ class concreteCommand(Command):
         global crt_series
 
         if self.flags.undo:
-            if self.flags.branch or self.flags.series:
+            if self.flags.ref_branch or self.flags.series:
                 raise CmdException, \
-                      '--undo cannot be specified with --branch or --series'
+                      '--undo cannot be specified with --ref-branch or --series'
             self.__check_all()
 
             out.start('Undoing the sync of "%s"' % crt_series.get_current())
@@ -81,12 +81,9 @@ class concreteCommand(Command):
             out.done()
             return
 
-        if self.flags.branch:
-            # the main function already made crt_series to be the remote
-            # branch
-            remote_series = crt_series
-            stgit.commands.common.crt_series = crt_series = stack.Series()
-            if self.flags.branch == crt_series.get_name():
+        if self.flags.ref_branch:
+            remote_series = stack.Series(self.flags.ref_branch)
+            if self.flags.ref_branch == crt_series.get_name():
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
