From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Fri, 12 Sep 2008 23:01:27 +0100
Message-ID: <20080912215613.10270.20599.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 00:02:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGiz-0001Mz-NT
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbYILWBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbYILWBh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:01:37 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:9409 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753274AbYILWBg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 18:01:36 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2008 18:01:35 EDT
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080912220134.BKJM21103.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Fri, 12 Sep 2008 23:01:34 +0100
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080912220134.DEV19289.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 12 Sep 2008 23:01:34 +0100
User-Agent: StGIT/0.14.3.225.g09cf8
X-Cloudmark-Analysis: v=1.0 c=1 a=K-Y7jj1EZy4A:10 a=CNudOPTRJqQA:10 a=m5T61OQctvbTDrPBk70A:9 a=GI7OzE65f2_vEBMK8wUA:7 a=nGed-yLrzGFuBdGiO0vPqLZV5y0A:4 a=MSl-tDqOz04A:10 a=XF7b4UCPwd8A:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95777>

This patch converts the sink command to use stgit.lib. The behaviour
is also changed slightly so that it only allows to sink a set of
patches if there are applied once, otherwise it is equivalent to a
push. The new implementation also allows to bring a patch forward
towards the top based on the --to argument.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

Before the final patch, I need to write a better test script.

I'm not sure about the conflict resolution. In this implementation, if
a conflict happens, the transaction is aborted. In case we allow
conflicts, I have to dig further on how to implement it with the new
transaction mechanism (I think "delete" does this).

An additional point - the transaction object supports functions like
pop_patches and push_patch. Should we change them for consistency and
simplicity? I.e., apart from current pop_patches with predicate add
functions that support popping a list or a single patch. The same goes
for push_patch.


stgit/commands/sink.py |   79 ++++++++++++++++++++++++++++++------------------
 1 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index d8f79b4..cb94f99 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -16,13 +16,10 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import stack, git
+from optparse import make_option
 
+from stgit.commands import common
+from stgit.lib import transaction
 
 help = 'send patches deeper down the stack'
 usage = """%prog [-t <target patch>] [-n] [<patches>]
@@ -32,7 +29,7 @@ push the specified <patches> (the current patch by default), and
 then push back into place the formerly-applied patches (unless -n
 is also given)."""
 
-directory = DirectoryGotoToplevel()
+directory = common.DirectoryHasRepositoryLib()
 options = [make_option('-n', '--nopush',
                        help = 'do not push the patches back after sinking',
                        action = 'store_true'),
@@ -42,33 +39,55 @@ options = [make_option('-n', '--nopush',
 def func(parser, options, args):
     """Sink patches down the stack.
     """
+    stack = directory.repository.current_stack
 
-    check_local_changes()
-    check_conflicts()
-    check_head_top_equal(crt_series)
-
-    oldapplied = crt_series.get_applied()
-    unapplied = crt_series.get_unapplied()
-    all = unapplied + oldapplied
-
-    if options.to and not options.to in oldapplied:
-        raise CmdException('Cannot sink below %s, since it is not applied'
-                           % options.to)
+    if not stack.patchorder.applied:
+        raise common.CmdException('No patches applied')
+    if options.to and not options.to in stack.patchorder.applied:
+        raise common.CmdException('Cannot sink below %s since it is not applied'
+                                  % options.to)
 
     if len(args) > 0:
-        patches = parse_patches(args, all)
+        patches = common.parse_patches(args, stack.patchorder.all)
     else:
-        current = crt_series.get_current()
-        if not current:
-            raise CmdException('No patch applied')
-        patches = [current]
+        # current patch
+        patches = stack.patchorder.applied[-1:]
+
+    if not patches:
+        raise common.CmdException('No patches to sink')
+    if options.to and options.to in patches:
+        raise common.CmdException('Cannot have a sinked patch as target')
+
+    trans = transaction.StackTransaction(stack, 'sink')
+
+    # pop any patches to be sinked in case they are applied
+    to_push = trans.pop_patches(lambda pn: pn in patches)
+
+    if options.to:
+        if options.to in to_push:
+            # this is the case where sinking actually brings some
+            # patches forward
+            for p in to_push:
+                if p == options.to:
+                    del to_push[:to_push.index(p)]
+                    break
+                trans.push_patch(p)
+        else:
+            # target patch below patches to be sinked
+            to_pop = trans.applied[trans.applied.index(options.to):]
+            to_push = to_pop + to_push
+            trans.pop_patches(lambda pn: pn in to_pop)
+    else:
+        # pop all the remaining patches
+        to_push = trans.applied + to_push
+        trans.pop_patches(lambda pn: True)
 
-    if oldapplied:
-        crt_series.pop_patch(options.to or oldapplied[0])
-    push_patches(crt_series, patches)
+    # push the sinked patches
+    for p in patches:
+        trans.push_patch(p)
 
     if not options.nopush:
-        newapplied = crt_series.get_applied()
-        def not_reapplied_yet(p):
-            return not p in newapplied
-        push_patches(crt_series, filter(not_reapplied_yet, oldapplied))
+        for p in to_push:
+            trans.push_patch(p)
+
+    trans.run()
