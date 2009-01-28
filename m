From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Check for local changes with "goto"
Date: Wed, 28 Jan 2009 23:13:05 +0000
Message-ID: <20090128231305.16133.29214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 00:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJhQ-0000cW-5p
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZA1XSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbZA1XSc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:18:32 -0500
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:27426 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756AbZA1XSc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 18:18:32 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jan 2009 18:18:31 EST
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090128231308.PMCV2989.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Wed, 28 Jan 2009 23:13:08 +0000
Received: from localhost.localdomain ([86.9.126.106])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20090128231307.FKCP19264.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 28 Jan 2009 23:13:07 +0000
User-Agent: StGit/0.14.3.340.ge799
X-Cloudmark-Analysis: v=1.0 c=1 a=ikxhZRSC73EA:10 a=SNtqtAhqVTYA:10 a=NTzMELdCTpYKUnya89MA:9 a=xJ2rC1bGx1L6RxToeIoA:7 a=Aw4rKOOSb5P5Dqz8nksV3N0FFggA:4 a=XF7b4UCPwd8A:10 a=ZCfqrk5O2kgA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107594>

This is done by default, unless the --keep option is passed, for
consistency with the "pop" command. The index is checked in the
Transaction.run() function so that other commands could benefit from
this feature (off by default).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/goto.py    |    8 ++++++--
 stgit/lib/transaction.py  |    7 ++++++-
 t/t2300-refresh-subdir.sh |    2 +-
 t/t2800-goto-subdir.sh    |    4 ++--
 t/t3000-dirty-merge.sh    |    2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 60a917e..7c5ad39 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -18,6 +18,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit import argparse
+from stgit.argparse import opt
 
 help = 'Push or pop patches to the given one'
 kind = 'stack'
@@ -27,7 +28,10 @@ Push/pop patches to/from the stack until the one given on the command
 line becomes current."""
 
 args = [argparse.other_applied_patches, argparse.unapplied_patches]
-options = []
+options = [
+    opt('-k', '--keep', action = 'store_true',
+        short = 'Keep the local changes')
+]
 
 directory = common.DirectoryHasRepositoryLib()
 
@@ -52,4 +56,4 @@ def func(parser, options, args):
         raise common.CmdException('Cannot goto a hidden patch')
     else:
         raise common.CmdException('Patch "%s" does not exist' % patch)
-    return trans.run(iw)
+    return trans.run(iw, check_clean = not options.keep)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 54de127..2b8f2de 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -183,13 +183,18 @@ class StackTransaction(object):
             self.__checkout(self.__stack.head.data.tree, iw,
                             allow_bad_head = True)
     def run(self, iw = None, set_head = True, allow_bad_head = False,
-            print_current_patch = True):
+            print_current_patch = True, check_clean = False):
         """Execute the transaction. Will either succeed, or fail (with an
         exception) and do nothing."""
         self.__check_consistency()
         log.log_external_mods(self.__stack)
         new_head = self.head
 
+        # Check for not clean index
+        if check_clean and iw and not iw.index.is_clean():
+            self.__halt('Repository not clean. Use "refresh" or '
+                        '"status --reset"')
+
         # Set branch head.
         if set_head:
             if iw:
diff --git a/t/t2300-refresh-subdir.sh b/t/t2300-refresh-subdir.sh
index d731a11..89c95db 100755
--- a/t/t2300-refresh-subdir.sh
+++ b/t/t2300-refresh-subdir.sh
@@ -65,7 +65,7 @@ test_expect_success 'refresh -u -p <subdir>' '
 
 test_expect_success 'refresh an unapplied patch' '
     stg refresh -u &&
-    stg goto p0 &&
+    stg goto --keep p0 &&
     test "$(stg status)" = "M foo.txt" &&
     stg refresh -p p1 &&
     test "$(stg status)" = "" &&
diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
index 28b8292..855972b 100755
--- a/t/t2800-goto-subdir.sh
+++ b/t/t2800-goto-subdir.sh
@@ -25,7 +25,7 @@ cat > expected2.txt <<EOF
 bar
 EOF
 test_expect_success 'Goto in subdirectory (just pop)' '
-    (cd foo && stg goto p1) &&
+    (cd foo && stg goto --keep p1) &&
     cat foo/bar > actual.txt &&
     test_cmp expected1.txt actual.txt &&
     ls foo > actual.txt &&
@@ -48,7 +48,7 @@ cat > expected2.txt <<EOF
 bar
 EOF
 test_expect_success 'Goto in subdirectory (conflicting push)' '
-    (cd foo && stg goto p3) ;
+    (cd foo && stg goto --keep p3) ;
     [ $? -eq 3 ] &&
     cat foo/bar > actual.txt &&
     test_cmp expected1.txt actual.txt &&
diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
index f0f79d5..419d86e 100755
--- a/t/t3000-dirty-merge.sh
+++ b/t/t3000-dirty-merge.sh
@@ -26,7 +26,7 @@ test_expect_success 'Push with dirty worktree' '
     echo 4 > a &&
     [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
-    conflict stg goto p2 &&
+    conflict stg goto --keep p2 &&
     [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
     [ "$(echo $(cat a))" = "4" ]
