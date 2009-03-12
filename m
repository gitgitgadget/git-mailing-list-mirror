From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 5/5] Convert "float" to the lib infrastructure
Date: Thu, 12 Mar 2009 12:09:18 +0000
Message-ID: <20090312120918.2992.82713.stgit@pc1117.cambridge.arm.com>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhjks-0003cT-IJ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706AbZCLMJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756555AbZCLMJu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:09:50 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49959 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756683AbZCLMJr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:09:47 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2CC8CZm017573;
	Thu, 12 Mar 2009 12:08:12 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Mar 2009 12:09:41 +0000
In-Reply-To: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.348.gf982
X-OriginalArrivalTime: 12 Mar 2009 12:09:41.0989 (UTC) FILETIME=[6CAB1950:01C9A30B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113054>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/float.py |   75 ++++++++++++++++++-----------------------------
 1 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 7c3dcdf..f94de88 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -16,11 +16,11 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
+import sys
 from stgit.argparse import opt
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import argparse, stack, git
+from stgit.commands import common
+from stgit.lib import transaction
+from stgit import argparse
 
 help = 'Push patches to the top, even if applied'
 kind = 'stack'
@@ -36,25 +36,20 @@ args = [argparse.patch_range(argparse.applied_patches,
                              argparse.unapplied_patches)]
 options = [
     opt('-s', '--series', action = 'store_true',
-        short = 'Rearrange according to a series file')]
+        short = 'Rearrange according to a series file')
+    ] + argparse.keep_option()
 
-directory = DirectoryGotoToplevel(log = True)
+directory = common.DirectoryHasRepositoryLib()
 
 def func(parser, options, args):
-    """Pops and pushed to make the named patch the topmost patch
+    """Reorder patches to make the named patch the topmost one.
     """
     args_nr = len(args)
     if (options.series and args_nr > 1) \
            or (not options.series and args_nr == 0):
         parser.error('incorrect number of arguments')
 
-    check_local_changes()
-    check_conflicts()
-    check_head_top_equal(crt_series)
-
-    unapplied = crt_series.get_unapplied()
-    applied = crt_series.get_applied()
-    all = unapplied + applied
+    stack = directory.repository.current_stack
 
     if options.series:
         if args_nr:
@@ -68,35 +63,23 @@ def func(parser, options, args):
             if patch:
                 patches.append(patch)
     else:
-        patches = parse_patches(args, all)
-
-    # working with "topush" patches in reverse order might be a bit
-    # more efficient for large series but the main reason is for the
-    # "topop != topush" comparison to work
-    patches.reverse()
-
-    topush = []
-    topop = []
-
-    for p in patches:
-        while p in applied:
-            top = applied.pop()
-            if not top in patches:
-                topush.append(top)
-            topop.append(top)
-    topush = patches + topush
-
-    # remove common patches to avoid unnecessary pop/push
-    while topush and topop:
-        if topush[-1] != topop[-1]:
-            break
-        topush.pop()
-        topop.pop()
-
-    # check whether the operation is really needed
-    if topop != topush:
-        if topop:
-            pop_patches(crt_series, topop)
-        if topush:
-            topush.reverse()
-            push_patches(crt_series, topush)
+        patches = common.parse_patches(args, stack.patchorder.all)
+
+    if not patches:
+        raise common.CmdException('No patches to float')
+
+    applied = [p for p in stack.patchorder.applied if p not in patches] + \
+            patches
+    unapplied = [p for p in stack.patchorder.unapplied if p not in patches]
+    hidden = list(stack.patchorder.hidden)
+
+    iw = stack.repository.default_iw
+    clean_iw = not options.keep and iw or None
+    trans = transaction.StackTransaction(stack, 'sink',
+                                         check_clean_iw = clean_iw)
+
+    try:
+        trans.reorder_patches(applied, unapplied, hidden, iw)
+    except transaction.TransactionHalted:
+        pass
+    return trans.run(iw)
