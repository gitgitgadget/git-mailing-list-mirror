From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Allow deletion of several patches at once
Date: Sun, 22 Oct 2006 14:58:16 +0200
Message-ID: <20061022125816.15194.3341.stgit@localhost>
References: <20061022125337.15194.64831.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:58:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbcuG-0000Tu-5A
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWJVM6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWJVM6T
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:58:19 -0400
Received: from mxfep04.bredband.com ([195.54.107.79]:5315 "EHLO
	mxfep04.bredband.com") by vger.kernel.org with ESMTP
	id S1751786AbWJVM6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:58:18 -0400
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep04.bredband.com with ESMTP
          id <20061022125817.QUUH8360.mxfep04.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:58:17 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport.bredband.com with ESMTP; 22 Oct 2006 14:58:16 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id BA87B4C010;
	Sun, 22 Oct 2006 14:58:16 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022125337.15194.64831.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29731>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/delete.py |   50 ++++++++++++++++-----
 t/t1600-delete-one.sh    |  109 ++++++++++++++++++++++++++++++++++++++++++=
++++
 t/t1600-delete.sh        |  109 ------------------------------------------=
----
 t/t1601-delete-many.sh   |   45 +++++++++++++++++++
 4 files changed, 193 insertions(+), 120 deletions(-)

diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index c97d8ed..5617ca1 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -24,13 +24,16 @@ from stgit.utils import *
 from stgit import stack, git
=20
=20
-help =3D 'remove the topmost or any unapplied patch'
-usage =3D """%prog [options] <patch>
+help =3D 'delete patches'
+usage =3D """%prog [options] <patch> [ <patch> [...] ]
=20
-Delete the patch passed as argument. The patch to be deleted can only
-be part of the unapplied list or be the topmost one, in the latter
-case the command also popping it from the stack. Note that the
-'delete' operation is irreversible."""
+Delete the patches passed as arguments. If an applied patch is to be
+deleted, all other patches applied on top of it must be deleted too;
+and they must be explicitly specified, since this command will not try
+to delete a patch unless you explicitly ask it to. If any applied
+patches are deleted, they are popped from the stack.
+
+Note that the 'delete' operation is irreversible."""
=20
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one')]
@@ -38,16 +41,41 @@ options =3D [make_option('-b', '--branch',
 def func(parser, options, args):
     """Deletes a patch
     """
-    if len(args) !=3D 1:
-        parser.error('incorrect number of arguments')
+    if not args:
+        parser.error('no patches to delete')
+
+    applied =3D {}
+    unapplied =3D {}
+    dontexist =3D {}
+    for patch in args:
+        if patch in crt_series.get_unapplied():
+            unapplied[patch] =3D None
+        elif patch in crt_series.get_applied():
+            applied[patch] =3D None
+        else:
+            dontexist[patch] =3D None
=20
-    if args[0] =3D=3D crt_series.get_current():
+    while crt_series.get_current() in applied:
+        patch =3D crt_series.get_current()
         check_local_changes()
         check_conflicts()
         check_head_top_equal()
+        crt_series.delete_patch(patch)
+        del applied[patch]
+        print 'Patch "%s" successfully deleted' % patch
+
+    for patch in unapplied.iterkeys():
+        crt_series.delete_patch(patch)
+        print 'Patch "%s" successfully deleted' % patch
+
+    if dontexist:
+        print 'Error: no such patch: %s' % ', '.join(dontexist.iterkeys())
+    if applied:
+        print 'Error: failed to delete %s' % ', '.join(applied.iterkeys())
=20
-    crt_series.delete_patch(args[0])
-    print 'Patch "%s" successfully deleted' % args[0]
+    failed =3D len(dontexist) + len(applied)
+    if failed:
+        raise CmdException, 'Failed to delete %d patches' % failed
=20
     if not options.branch:
         print_crt_patch()
diff --git a/t/t1600-delete-one.sh b/t/t1600-delete-one.sh
new file mode 100644
index 0000000..df03d79
--- /dev/null
+++ b/t/t1600-delete-one.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+# Copyright (c) 2006 Karl Hasselstr=C3=B6m
+test_description=3D'Test the delete command (deleting one patch at a time)=
.'
+=2E ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    'stg init'
+
+test_expect_success \
+    'Create a patch' \
+    '
+    stg new foo -m foo &&
+    echo foo > foo.txt &&
+    stg add foo.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Try to delete a non-existing patch' \
+    '
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    ! stg delete bar &&
+    [ $(stg applied | wc -l) -eq 1 ]
+    '
+
+test_expect_success \
+    'Try to delete the topmost patch while dirty' \
+    '
+    echo dirty >> foo.txt &&
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    ! stg delete foo &&
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    git reset --hard
+    '
+
+test_expect_success \
+    'Delete the topmost patch' \
+    '
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    stg delete foo &&
+    [ $(stg applied | wc -l) -eq 0 ]
+    '
+
+test_expect_success \
+    'Create an unapplied patch' \
+    '
+    stg new foo -m foo &&
+    echo foo > foo.txt &&
+    stg add foo.txt &&
+    stg refresh &&
+    stg pop
+    '
+
+test_expect_success \
+    'Delete an unapplied patch' \
+    '
+    [ $(stg unapplied | wc -l) -eq 1 ] &&
+    stg delete foo &&
+    [ $(stg unapplied | wc -l) -eq 0 ]
+    '
+
+test_expect_success \
+    'Create two patches' \
+    '
+    stg new foo -m foo &&
+    echo foo > foo.txt &&
+    stg add foo.txt &&
+    stg refresh &&
+    stg new bar -m bar &&
+    echo bar > bar.txt &&
+    stg add bar.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Try to delete a non-topmost applied patch' \
+    '
+    [ $(stg applied | wc -l) -eq 2 ] &&
+    ! stg delete foo &&
+    [ $(stg applied | wc -l) -eq 2 ]
+    '
+
+test_expect_success \
+    'Create another branch, and put one patch in each branch' \
+    '
+    stg branch --create br &&
+    stg new baz -m baz &&
+    echo baz > baz.txt &&
+    stg add baz.txt &&
+    stg refresh &&
+    stg branch master &&
+    stg new baz -m baz &&
+    echo baz > baz.txt &&
+    stg add baz.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Delete a patch in another branch' \
+    '
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied -b br | wc -l) -eq 1 ] &&
+    stg delete -b br baz &&
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied -b br | wc -l) -eq 0 ]
+    '
+
+test_done
diff --git a/t/t1600-delete.sh b/t/t1600-delete.sh
deleted file mode 100644
index e22e624..0000000
--- a/t/t1600-delete.sh
+++ /dev/null
@@ -1,109 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2006 Karl Hasselstr=C3=B6m
-test_description=3D'Test the delete command.'
-=2E ./test-lib.sh
-
-test_expect_success \
-    'Initialize the StGIT repository' \
-    'stg init'
-
-test_expect_success \
-    'Create a patch' \
-    '
-    stg new foo -m foo &&
-    echo foo > foo.txt &&
-    stg add foo.txt &&
-    stg refresh
-    '
-
-test_expect_success \
-    'Try to delete a non-existing patch' \
-    '
-    [ $(stg applied | wc -l) -eq 1 ] &&
-    ! stg delete bar &&
-    [ $(stg applied | wc -l) -eq 1 ]
-    '
-
-test_expect_success \
-    'Try to delete the topmost patch while dirty' \
-    '
-    echo dirty >> foo.txt &&
-    [ $(stg applied | wc -l) -eq 1 ] &&
-    ! stg delete foo &&
-    [ $(stg applied | wc -l) -eq 1 ] &&
-    git reset --hard
-    '
-
-test_expect_success \
-    'Delete the topmost patch' \
-    '
-    [ $(stg applied | wc -l) -eq 1 ] &&
-    stg delete foo &&
-    [ $(stg applied | wc -l) -eq 0 ]
-    '
-
-test_expect_success \
-    'Create an unapplied patch' \
-    '
-    stg new foo -m foo &&
-    echo foo > foo.txt &&
-    stg add foo.txt &&
-    stg refresh &&
-    stg pop
-    '
-
-test_expect_success \
-    'Delete an unapplied patch' \
-    '
-    [ $(stg unapplied | wc -l) -eq 1 ] &&
-    stg delete foo &&
-    [ $(stg unapplied | wc -l) -eq 0 ]
-    '
-
-test_expect_success \
-    'Create two patches' \
-    '
-    stg new foo -m foo &&
-    echo foo > foo.txt &&
-    stg add foo.txt &&
-    stg refresh &&
-    stg new bar -m bar &&
-    echo bar > bar.txt &&
-    stg add bar.txt &&
-    stg refresh
-    '
-
-test_expect_success \
-    'Try to delete a non-topmost applied patch' \
-    '
-    [ $(stg applied | wc -l) -eq 2 ] &&
-    ! stg delete foo &&
-    [ $(stg applied | wc -l) -eq 2 ]
-    '
-
-test_expect_success \
-    'Create another branch, and put one patch in each branch' \
-    '
-    stg branch --create br &&
-    stg new baz -m baz &&
-    echo baz > baz.txt &&
-    stg add baz.txt &&
-    stg refresh &&
-    stg branch master &&
-    stg new baz -m baz &&
-    echo baz > baz.txt &&
-    stg add baz.txt &&
-    stg refresh
-    '
-
-test_expect_success \
-    'Delete a patch in another branch' \
-    '
-    [ $(stg applied | wc -l) -eq 3 ] &&
-    [ $(stg applied -b br | wc -l) -eq 1 ] &&
-    stg delete -b br baz &&
-    [ $(stg applied | wc -l) -eq 3 ] &&
-    [ $(stg applied -b br | wc -l) -eq 0 ]
-    '
-
-test_done
diff --git a/t/t1601-delete-many.sh b/t/t1601-delete-many.sh
new file mode 100644
index 0000000..f217804
--- /dev/null
+++ b/t/t1601-delete-many.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# Copyright (c) 2006 Karl Hasselstr=C3=B6m
+test_description=3D'Test the delete command (deleting many patches at once=
)=2E'
+=2E ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    'stg init'
+
+test_expect_success \
+    'Create five applied and five unapplied patches' \
+    '
+    stg new foo0 -m foo0 &&
+    echo foo0 > foo.txt &&
+    stg add foo.txt &&
+    stg refresh &&
+    for i in 1 2 3 4 5 6 7 8 9; do
+        stg new foo$i -m foo$i &&
+        echo foo$i >> foo.txt &&
+        stg refresh;
+    done &&
+    stg pop -n 5
+    '
+
+test_expect_success \
+    'Delete some patches' \
+    '
+    [ $(stg applied | wc -l) -eq 5 ] &&
+    [ $(stg unapplied | wc -l) -eq 5 ] &&
+    stg delete foo7 foo6 foo3 foo4 &&
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg unapplied | wc -l) -eq 3 ]
+    '
+
+test_expect_success \
+    'Delete some more patches, some of which fail' \
+    '
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg unapplied | wc -l) -eq 3 ] &&
+    ! stg delete foo7 foo8 foo2 foo0 &&
+    [ $(stg applied | wc -l) -eq 2 ] &&
+    [ $(stg unapplied | wc -l) -eq 2 ]
+    '
+
+test_done
