From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] Convert "push" to the lib infrastructure
Date: Tue, 31 Mar 2009 12:30:33 +0100
Message-ID: <20090331113033.2524.27502.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 13:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LocDX-0006ky-Me
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 13:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbZCaLbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755488AbZCaLbN
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 07:31:13 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:39925 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755812AbZCaLbK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 07:31:10 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2VBSeZm000439;
	Tue, 31 Mar 2009 12:28:40 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 31 Mar 2009 12:31:05 +0100
User-Agent: StGit/0.14.3.356.g5010
X-OriginalArrivalTime: 31 Mar 2009 11:31:05.0554 (UTC) FILETIME=[2DD06B20:01C9B1F4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115252>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/push.py   |   68 ++++++++++++++++++++++++----------------------
 t/t0002-status.sh        |    2 +
 t/t1200-push-modified.sh |    2 +
 t/t1202-push-undo.sh     |    4 +--
 t/t1203-push-conflict.sh |    2 +
 t/t1205-push-subdir.sh   |    2 +
 t/t2500-clean.sh         |    2 +
 7 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 818e02d..0d25a65 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -16,12 +16,10 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
+from stgit.commands import common
+from stgit.lib import transaction
+from stgit import argparse
 from stgit.argparse import opt
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit.out import *
-from stgit import argparse, stack, git
 
 help = 'Push one or more patches onto the stack'
 kind = 'stack'
@@ -45,39 +43,45 @@ options = [
     opt('-n', '--number', type = 'int',
         short = 'Push the specified number of patches'),
     opt('--reverse', action = 'store_true',
-        short = 'Push the patches in reverse order'),
-    opt('-m', '--merged', action = 'store_true',
-        short = 'Check for patches merged upstream')]
+        short = 'Push the patches in reverse order')
+    ] + argparse.keep_option() + argparse.merged_option()
 
-directory = DirectoryGotoToplevel(log = True)
+directory = common.DirectoryHasRepositoryLib()
 
 def func(parser, options, args):
-    """Pushes the given patch or all onto the series
-    """
-
-    check_local_changes()
-    check_conflicts()
-    check_head_top_equal(crt_series)
-
-    unapplied = crt_series.get_unapplied()
-    if not unapplied:
-        raise CmdException, 'No more patches to push'
-
-    if options.number:
-        patches = unapplied[:options.number]
-    elif options.all:
-        patches = unapplied
-    elif len(args) == 0:
-        patches = [unapplied[0]]
+    """Pushes the given patches or the first unapplied onto the stack."""
+    stack = directory.repository.current_stack
+    iw = stack.repository.default_iw
+    clean_iw = (not options.keep and iw) or None
+    trans = transaction.StackTransaction(stack, 'pop',
+                                         check_clean_iw = clean_iw)
+
+    if not trans.unapplied:
+        raise common.CmdException('No patches to push')
+
+    if options.all:
+        patches = list(trans.unapplied)
+    elif options.number:
+        patches = trans.unapplied[:options.number]
+    elif not args:
+        patches = [trans.unapplied[0]]
     else:
-        patches = parse_patches(args, unapplied)
+        patches = common.parse_patches(args, trans.unapplied)
 
-    if patches == []:
-        raise CmdException, 'No patches to push'
+    if not patches:
+        raise common.CmdException('No patches to push')
 
     if options.reverse:
         patches.reverse()
 
-    push_patches(crt_series, patches, options.merged)
-
-    print_crt_patch(crt_series)
+    try:
+        if options.merged:
+            merged = set(trans.check_merged(patches))
+        else:
+            merged = set()
+        for pn in patches:
+            trans.push_patch(pn, iw, allow_interactive = True,
+                             already_merged = pn in merged)
+    except transaction.TransactionHalted:
+        pass
+    return trans.run(iw)
diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index d95a83b..ffcad77 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -111,7 +111,7 @@ A fie
 C foo/bar
 EOF
 test_expect_success 'Status after conflicting push' '
-    conflict_old stg push &&
+    conflict stg push &&
     stg status > output.txt &&
     test_cmp expected.txt output.txt
 '
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index a591124..2077492 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -49,7 +49,7 @@ test_expect_success \
 
 test_expect_success \
     'Attempt to push the first of those patches without --merged' \
-    "(cd bar && conflict_old stg push
+    "(cd bar && conflict stg push
      )
 "
 
diff --git a/t/t1202-push-undo.sh b/t/t1202-push-undo.sh
index 79439de..14a3d6d 100755
--- a/t/t1202-push-undo.sh
+++ b/t/t1202-push-undo.sh
@@ -43,7 +43,7 @@ test_expect_success \
 test_expect_success \
 	'Push the second patch with conflict' \
 	'
-	conflict_old stg push bar
+	conflict stg push bar
 	'
 
 test_expect_success \
@@ -55,7 +55,7 @@ test_expect_success \
 test_expect_success \
 	'Check the push after undo fails as well' \
 	'
-	conflict_old stg push bar
+	conflict stg push bar
 	'
 
 test_expect_success \
diff --git a/t/t1203-push-conflict.sh b/t/t1203-push-conflict.sh
index 96fee15..8027e6c 100755
--- a/t/t1203-push-conflict.sh
+++ b/t/t1203-push-conflict.sh
@@ -38,7 +38,7 @@ test_expect_success \
 test_expect_success \
 	'Push the first patch with conflict' \
 	'
-	conflict_old stg push foo
+	conflict stg push foo
 	'
 
 test_expect_success \
diff --git a/t/t1205-push-subdir.sh b/t/t1205-push-subdir.sh
index f852762..2d5918b 100755
--- a/t/t1205-push-subdir.sh
+++ b/t/t1205-push-subdir.sh
@@ -47,7 +47,7 @@ test_expect_success 'Conflicting push from subdir' '
     [ "$(echo $(cat x.txt))" = "x0" ] &&
     [ "$(echo $(cat foo/y.txt))" = "y0" ] &&
     cd foo &&
-    conflict_old stg push p2 &&
+    conflict stg push p2 &&
     cd .. &&
     [ "$(echo $(stg status --conflict))" = "foo/y.txt x.txt" ]
 '
diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
index 99fd29f..7f821f5 100755
--- a/t/t2500-clean.sh
+++ b/t/t2500-clean.sh
@@ -32,7 +32,7 @@ test_expect_success 'Create a conflict' '
     stg new p2 -m p2
     echo quux > foo.txt &&
     stg refresh &&
-    conflict_old stg push
+    conflict stg push
 '
 
 test_expect_success 'Make sure conflicting patches are preserved' '
