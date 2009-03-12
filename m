From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 4/5] Convert "sink" to the new infrastructure
Date: Thu, 12 Mar 2009 12:09:13 +0000
Message-ID: <20090312120913.2992.21403.stgit@pc1117.cambridge.arm.com>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhjkr-0003cT-Qj
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbZCLMJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbZCLMJn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:09:43 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49948 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756666AbZCLMJl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:09:41 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2CC86Zm017568;
	Thu, 12 Mar 2009 12:08:06 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Mar 2009 12:09:36 +0000
In-Reply-To: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.348.gf982
X-OriginalArrivalTime: 12 Mar 2009 12:09:36.0427 (UTC) FILETIME=[695A67B0:01C9A30B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113055>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/sink.py |   86 +++++++++++++++++++++---------------------------
 t/t1501-sink.sh        |    2 +
 2 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index d4561ed..8b17fd1 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -16,11 +16,10 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
 from stgit.argparse import opt
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import argparse, stack, git
+from stgit.commands import common
+from stgit.lib import transaction
+from stgit import argparse
 
 help = 'Send patches deeper down the stack'
 kind = 'stack'
@@ -51,57 +50,48 @@ options = [
     opt('-t', '--to', metavar = 'TARGET', args = [argparse.applied_patches],
         short = 'Sink patches below the TARGET patch', long = """
         Specify a target patch to place the patches below, instead of
-        sinking them to the bottom of the stack.""")]
+        sinking them to the bottom of the stack.""")
+    ] + argparse.keep_option()
 
-directory = DirectoryGotoToplevel(log = True)
+directory = common.DirectoryHasRepositoryLib()
 
 def func(parser, options, args):
     """Sink patches down the stack.
     """
+    stack = directory.repository.current_stack
 
-    check_local_changes()
-    check_conflicts()
-    check_head_top_equal(crt_series)
+    if options.to and not options.to in stack.patchorder.applied:
+        raise common.CmdException('Cannot sink below %s since it is not applied'
+                                  % options.to)
 
-    oldapplied = crt_series.get_applied()
-    unapplied = crt_series.get_unapplied()
-    all = oldapplied + unapplied
+    if len(args) > 0:
+        patches = common.parse_patches(args, stack.patchorder.all)
+    else:
+        # current patch
+        patches = list(stack.patchorder.applied[-1:])
 
-    if options.to and not options.to in oldapplied:
-        raise CmdException('Cannot sink below %s, since it is not applied'
-                           % options.to)
+    if not patches:
+        raise common.CmdException('No patches to sink')
+    if options.to and options.to in patches:
+        raise common.CmdException('Cannot have a sinked patch as target')
 
-    if len(args) > 0:
-        patches = parse_patches(args, all)
+    applied = [p for p in stack.patchorder.applied if p not in patches]
+    if options.to:
+        insert_idx = applied.index(options.to)
     else:
-        current = crt_series.get_current()
-        if not current:
-            raise CmdException('No patch applied')
-        patches = [current]
-
-    before_patches = after_patches = []
-
-    # pop necessary patches
-    if oldapplied:
-        if options.to:
-            pop_idx = oldapplied.index(options.to)
-        else:
-            pop_idx = 0
-        after_patches = [p for p in oldapplied[pop_idx:] if p not in patches]
-
-        # find the deepest patch to pop
-        sink_applied = [p for p in oldapplied if p in patches]
-        if sink_applied:
-            sinked_idx = oldapplied.index(sink_applied[0])
-            if sinked_idx < pop_idx:
-                # this is the case where sink brings patches forward
-                before_patches = [p for p in oldapplied[sinked_idx:pop_idx]
-                                  if p not in patches]
-                pop_idx = sinked_idx
-
-        crt_series.pop_patch(oldapplied[pop_idx])
-
-    push_patches(crt_series, before_patches)
-    push_patches(crt_series, patches)
-    if not options.nopush:
-        push_patches(crt_series, after_patches)
+        insert_idx = 0
+    applied = applied[:insert_idx] + patches + applied[insert_idx:]
+
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
diff --git a/t/t1501-sink.sh b/t/t1501-sink.sh
index 516aa44..a0769dd 100755
--- a/t/t1501-sink.sh
+++ b/t/t1501-sink.sh
@@ -58,7 +58,7 @@ test_expect_success 'sink specified patch below a target' '
 '
 
 test_expect_success 'sink with conflict' '
-    conflict_old stg sink --to=p2 p22 &&
+    conflict stg sink --to=p2 p22 &&
     test "$(echo $(stg series --applied --noprefix))" = "p1 p22" &&
     test "$(echo $(stg status -c))" = "f2"
 '
