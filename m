From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/5] Test the new DAG appliedness machinery
Date: Tue, 07 Aug 2007 04:47:56 +0200
Message-ID: <20070807024756.11373.28612.stgit@yoghurt>
References: <20070807024508.11373.62875.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF74-0005H0-24
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765980AbXHGCr7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765969AbXHGCr6
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:47:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2243 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765964AbXHGCr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:47:57 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF6y-0002UY-00; Tue, 07 Aug 2007 03:47:56 +0100
In-Reply-To: <20070807024508.11373.62875.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55208>

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
