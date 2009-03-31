From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] Convert "pop" to the lib infrastructure
Date: Tue, 31 Mar 2009 12:30:27 +0100
Message-ID: <20090331113027.2524.60993.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 13:33:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LocDW-0006ky-V0
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 13:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbZCaLbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 07:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbZCaLbI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 07:31:08 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:39919 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220AbZCaLbG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 07:31:06 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2VBSYZm000436;
	Tue, 31 Mar 2009 12:28:34 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 31 Mar 2009 12:30:59 +0100
User-Agent: StGit/0.14.3.356.g5010
X-OriginalArrivalTime: 31 Mar 2009 11:30:59.0867 (UTC) FILETIME=[2A6CA6B0:01C9B1F4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115253>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/pop.py |   67 ++++++++++++++++++++-----------------------------
 t/t3101-reset-hard.sh |    4 +--
 t/t3103-undo-hard.sh  |    4 +--
 3 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index 2c78ac2..eace090 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -16,11 +16,10 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
+from stgit.commands import common
+from stgit.lib import transaction
+from stgit import argparse
 from stgit.argparse import opt
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import argparse, stack, git
 
 help = 'Pop one or more patches from the stack'
 kind = 'stack'
@@ -40,50 +39,40 @@ options = [
     opt('-a', '--all', action = 'store_true',
         short = 'Pop all the applied patches'),
     opt('-n', '--number', type = 'int',
-        short = 'Pop the specified number of patches'),
-    opt('-k', '--keep', action = 'store_true',
-        short = 'Keep the local changes')]
+        short = 'Pop the specified number of patches')
+    ] + argparse.keep_option()
 
-directory = DirectoryGotoToplevel(log = True)
+directory = common.DirectoryHasRepositoryLib()
 
 def func(parser, options, args):
-    """Pop the topmost patch from the stack
-    """
-    check_conflicts()
-    check_head_top_equal(crt_series)
+    """Pop the given patches or the topmost one from the stack."""
+    stack = directory.repository.current_stack
+    iw = stack.repository.default_iw
+    clean_iw = (not options.keep and iw) or None
+    trans = transaction.StackTransaction(stack, 'pop',
+                                         check_clean_iw = clean_iw)
 
-    if not options.keep:
-        check_local_changes()
-
-    applied = crt_series.get_applied()
-    if not applied:
-        raise CmdException, 'No patches applied'
+    if not trans.applied:
+        raise common.CmdException('No patches applied')
 
     if options.all:
-        patches = applied
+        patches = trans.applied
     elif options.number:
         # reverse it twice to also work with negative or bigger than
         # the length numbers
-        patches = applied[::-1][:options.number][::-1]
-    elif len(args) == 0:
-        patches = [applied[-1]]
+        patches = trans.applied[::-1][:options.number][::-1]
+    elif not args:
+        patches = [trans.applied[-1]]
     else:
-        patches = parse_patches(args, applied, ordered = True)
+        patches = common.parse_patches(args, trans.applied, ordered = True)
 
     if not patches:
-        raise CmdException, 'No patches to pop'
-
-    # pop to the most distant popped patch
-    topop = applied[applied.index(patches[0]):]
-    # push those not in the popped range
-    topush = [p for p in topop if p not in patches]
-
-    if options.keep and topush:
-        raise CmdException, 'Cannot pop arbitrary patches with --keep'
-
-    topop.reverse()
-    pop_patches(crt_series, topop, options.keep)
-    if topush:
-        push_patches(crt_series, topush)
-
-    print_crt_patch(crt_series)
+        raise common.CmdException('No patches to pop')
+
+    applied = [p for p in trans.applied if not p in set(patches)]
+    unapplied = patches + trans.unapplied
+    try:
+        trans.reorder_patches(applied, unapplied, iw = iw)
+    except transaction.TransactionException:
+        pass
+    return trans.run(iw)
diff --git a/t/t3101-reset-hard.sh b/t/t3101-reset-hard.sh
index 2807ba3..bd97b3a 100755
--- a/t/t3101-reset-hard.sh
+++ b/t/t3101-reset-hard.sh
@@ -28,7 +28,7 @@ cat > expected.txt <<EOF
 C a
 EOF
 test_expect_success 'Pop middle patch, creating a conflict' '
-    conflict_old stg pop p2 &&
+    conflict stg pop p2 &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
     test "$(echo $(stg series))" = "+ p1 > p3 - p2"
@@ -47,7 +47,7 @@ test_expect_success 'Try to reset with --hard' '
     stg reset --hard master.stgit^~1 &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
-    test "$(echo $(stg series))" = "> p1 - p3 - p2"
+    test "$(echo $(stg series))" = "> p1 - p2 - p3"
 '
 
 test_done
diff --git a/t/t3103-undo-hard.sh b/t/t3103-undo-hard.sh
index 599aa43..ce71668 100755
--- a/t/t3103-undo-hard.sh
+++ b/t/t3103-undo-hard.sh
@@ -28,7 +28,7 @@ cat > expected.txt <<EOF
 C a
 EOF
 test_expect_success 'Pop middle patch, creating a conflict' '
-    conflict_old stg pop p2 &&
+    conflict stg pop p2 &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
     test "$(echo $(stg series))" = "+ p1 > p3 - p2"
@@ -47,7 +47,7 @@ test_expect_success 'Try to undo with --hard' '
     stg undo --hard &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
-    test "$(echo $(stg series))" = "> p1 - p3 - p2"
+    test "$(echo $(stg series))" = "> p1 - p2 - p3"
 '
 
 test_done
