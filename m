X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Allow deletion of several patches at once
Date: Wed, 01 Nov 2006 10:07:14 +0100
Message-ID: <20061101090714.2066.93948.stgit@localhost>
References: <20061023123714.GB10872@diana.vm.bytemark.co.uk>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
NNTP-Posting-Date: Wed, 1 Nov 2006 09:09:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061023123714.GB10872@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30626>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfC6I-0000C7-2W for gcvg-git@gmane.org; Wed, 01 Nov
 2006 10:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423974AbWKAJJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 04:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423973AbWKAJJ3
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 04:09:29 -0500
Received: from mxfep03.bredband.com ([195.54.107.76]:53711 "EHLO
 mxfep03.bredband.com") by vger.kernel.org with ESMTP id S1423974AbWKAJJ1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 04:09:27 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep03.bredband.com with ESMTP id
 <20061101090925.HPRP25623.mxfep03.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Wed, 1 Nov 2006 10:09:25 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 01 Nov 2006 10:09:25 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id B7DF54CB5A; Wed,  1 Nov
 2006 10:09:23 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

This is an updated patch, which uses parse_patches() to support patch
ranges. It replaces patch 2/2 in the series; patch 1/2 (original
delete regression test) is unaffected.

 stgit/commands/delete.py |   54 +++++++++++++++++------
 t/t1600-delete-one.sh    |  109 ++++++++++++++++++++++++++++++++++++++++++=
++++
 t/t1600-delete.sh        |  109 ------------------------------------------=
----
 t/t1601-delete-many.sh   |   55 +++++++++++++++++++++++
 4 files changed, 205 insertions(+), 122 deletions(-)

diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index c97d8ed..2f3aece 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -24,30 +24,58 @@ from stgit.utils import *
 from stgit import stack, git
=20
=20
-help =3D 'remove the topmost or any unapplied patch'
-usage =3D """%prog [options] <patch>
+help =3D 'delete patches'
+usage =3D """%prog [options] [<patch1>] [<patch2>] [<patch3>..<patch4>]
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
=20
 def func(parser, options, args):
-    """Deletes a patch
-    """
-    if len(args) !=3D 1:
-        parser.error('incorrect number of arguments')
+    """Deletes one or more patches."""
+    applied_patches =3D crt_series.get_applied()
+    unapplied_patches =3D crt_series.get_unapplied()
+    all_patches =3D applied_patches + unapplied_patches
+
+    if args:
+        patches =3D parse_patches(args, all_patches)
+    else:
+        parser.error('No patches specified')
+
+    applied =3D {}
+    unapplied =3D {}
+    for patch in patches:
+        if patch in unapplied_patches:
+            unapplied[patch] =3D None
+        else:
+            applied[patch] =3D None
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
+    if applied:
+        print 'Error: failed to delete %s' % ', '.join(applied.iterkeys())
=20
-    crt_series.delete_patch(args[0])
-    print 'Patch "%s" successfully deleted' % args[0]
+    failed =3D len(applied)
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
index 0000000..8648ed1
--- /dev/null
+++ b/t/t1601-delete-many.sh
@@ -0,0 +1,55 @@
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
+    'Delete some more patches, some of which do not exist' \
+    '
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg unapplied | wc -l) -eq 3 ] &&
+    ! stg delete foo7 foo8 foo2 foo0 &&
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg unapplied | wc -l) -eq 3 ]
+    '
+
+test_expect_success \
+    'Delete a range of patches' \
+    '
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg unapplied | wc -l) -eq 3 ] &&
+    stg delete foo1..foo8 &&
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    [ $(stg unapplied | wc -l) -eq 1 ]
+    '
+
