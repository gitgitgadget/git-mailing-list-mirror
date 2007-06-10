From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/6] Test the new DAG appliedness machinery
Date: Sun, 10 Jun 2007 02:55:16 -0700
Message-ID: <20070610095516.12000.1553.stgit@bill>
References: <20070610094322.12000.56284.stgit@bill>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxK8z-0006fp-NP
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbXFJJzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 05:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbXFJJzV
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:55:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1833 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbXFJJzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:55:19 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1HxK8k-0008Rw-00; Sun, 10 Jun 2007 10:55:18 +0100
In-Reply-To: <20070610094322.12000.56284.stgit@bill>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49703>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t3000-git-interop.sh |   60 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/t/t3000-git-interop.sh b/t/t3000-git-interop.sh
new file mode 100755
index 0000000..44414b9
--- /dev/null
+++ b/t/t3000-git-interop.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+# Copyright (c) 2007 Karl Hasselstr=C3=B6m
+test_description=3D'Test git/StGIT interoperability'
+. ./test-lib.sh
+
+test_expect_success \
+    'Create some git-only history' '
+    echo foo > foo.txt &&
+    git add foo.txt &&
+    git commit -a -m foo &&
+    git tag foo-tag &&
+    for i in 0 1 2 3 4; do
+        echo foo$i >> foo.txt &&
+        git commit -a -m foo$i;
+    done
+'
+
+test_expect_success \
+    'Initialize the StGIT repository' '
+    stg init
+'
+
+test_expect_success \
+    'Create five patches' '
+    for i in 0 1 2 3 4; do
+        stg new p$i -m p$i;
+    done &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_expect_success \
+    'Pop two patches with git-reset' '
+    git reset --hard HEAD~2 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
+'
+
+test_expect_success \
+    'Create a new patch' '
+    stg new q0 -m q0 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 q0" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
+'
+
+test_expect_success \
+    'Go to an unapplied patch with with git-reset' '
+    git reset --hard $(stg id p3) &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "q0 p4" ]
+'
+
+test_expect_success \
+    'Go back to below the stack base with git-reset' '
+    git reset --hard foo-tag &&
+    [ "$(echo $(stg applied))" =3D "" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p0 p1 p2 q0 p3 p4" ]
+'
+
+test_done
