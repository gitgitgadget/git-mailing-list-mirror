From: Stepan Koltsov <Stepan.Koltsov@jetbrains.com>
Subject: [PATCH] stg delete --empty
Date: Wed, 11 Apr 2012 18:12:36 +0400
Message-ID: <B940726E-2CFA-45CB-8B81-A8F4268D51A6@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: catalin.marinas@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 16:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHyOL-0003p7-JK
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 16:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760314Ab2DKOTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 10:19:21 -0400
Received: from mail1.intellij.net ([46.137.178.215]:44134 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760288Ab2DKOTU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 10:19:20 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Apr 2012 10:19:20 EDT
Received: (qmail 31915 invoked by uid 89); 11 Apr 2012 14:12:37 -0000
Received: by simscan 1.1.0 ppid: 31835, pid: 31901, t: 0.1116s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO ?192.168.15.182?) (stepan.koltsov@jetbrains.com@81.211.18.86)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 11 Apr 2012 14:12:36 -0000
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195183>

`stg delete --empty` deletes all empty patches in series. Command
does nothing and exits with zero code if all patches are not empty.

--empty option can be useful in this workflow:

* you work on the patches
* you send patches to upstream (using stg export or stg mail)
* patches are committed to upstream after a while
* you do `git fetch && stg rebase origin`
* `stg rebase origin` makes applied to upstrem local patches empty
* now you can use stg delete --empty to cleanup

Signed-off-by: Stepan Koltsov <stepan.koltsov@jetbrains.com>
---
stgit/commands/delete.py |   30 ++++++++++++++++++++++++--
t/t1603-delete-empty.sh  |   51 ++++++++++++++++++++++++++++++++++++++++++++++
2 files changed, 78 insertions(+), 3 deletions(-)
create mode 100755 t/t1603-delete-empty.sh

diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 84a057e..414f456 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -1,3 +1,4 @@
+from stgit.out import MessagePrinter

__copyright__ = """
Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
@@ -40,7 +41,9 @@ options = [
    opt('-b', '--branch', args = [argparse.stg_branches],
        short = 'Use BRANCH instead of the default branch'),
    opt('-t', '--top', action = 'store_true',
-        short = 'Delete top patch'),]
+        short = 'Delete top patch'),
+    opt('-e', '--empty', action = 'store_true',
+        short = 'Delete empty patches')]

directory = common.DirectoryHasRepositoryLib()

@@ -51,8 +54,17 @@ def func(parser, options, args):
        iw = None # can't use index/workdir to manipulate another branch
    else:
        iw = stack.repository.default_iw
-    if args and options.top:
-        parser.error('Either --top or patches must be specified')
+        
+    mode_count = 0
+    if args:
+        mode_count += 1
+    if options.top:
+        mode_count += 1
+    if options.empty:
+        mode_count += 1
+        
+    if mode_count > 1:
+        parser.error('Either --top or --empty or patches must be specified')
    elif args:
        patches = set(common.parse_patches(args, list(stack.patchorder.all),
                                           len(stack.patchorder.applied)))
@@ -62,6 +74,16 @@ def func(parser, options, args):
            patches = set([applied[-1]])
        else:
            raise common.CmdException, 'No patches applied'
+
+    elif options.empty:
+        patches_list = []
+        for p in stack.patchorder.all:
+            if stack.patches.get(p).is_empty():
+                patches_list.append(p)
+        if not patches_list:
+            out.info('No empty patches')
+            return 0
+        patches = set(patches_list)
    else:
        parser.error('No patches specified')

@@ -86,3 +108,5 @@ def func(parser, options, args):
    except transaction.TransactionHalted:
        pass
    return trans.run(iw)
+
+out = MessagePrinter()
diff --git a/t/t1603-delete-empty.sh b/t/t1603-delete-empty.sh
new file mode 100755
index 0000000..8a5630a
--- /dev/null
+++ b/t/t1603-delete-empty.sh
@@ -0,0 +1,51 @@
+#!/bin/sh -e
+# Copyright (c) 2012 Stepan Koltsov
+test_description='Test the delete --empty command.'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    'stg init'
+
+test_expect_success \
+    'Create first real patch' \
+    '
+    stg new foo -m foo &&
+    echo foo > foo.txt &&
+    stg add foo.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Create second empty patch' \
+    'stg new bar -m bar'
+
+test_expect_success \
+    'Create third real patch' \
+    '
+    stg new baz -m foo &&
+    echo baz > baz.txt &&
+    stg add baz.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Create forth empty patch' \
+    'stg new qux -m qux'
+
+test_expect_success \
+    'Delete empty patches' \
+    '
+    stg delete --empty &&
+    [ "$(echo $(stg series --noprefix))" = "foo baz" ]
+    '
+
+test_expect_success \
+    'Delete empty patches again (i. e. delete nothing)' \
+    '
+    stg delete --empty &&
+    [ "$(echo $(stg series --noprefix))" = "foo baz" ]
+    '
+
+test_done
-- 
1.7.9.1
