From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Test the new powers of "stg assimilate"
Date: Wed, 26 Sep 2007 04:15:14 +0200
Message-ID: <20070926021514.1202.68589.stgit@yoghurt>
References: <20070926020911.1202.2580.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 04:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaMRC-00054R-9F
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 04:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbXIZCP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2007 22:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbXIZCP1
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 22:15:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2551 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbXIZCP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 22:15:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IaMQk-0006iw-00; Wed, 26 Sep 2007 03:15:14 +0100
In-Reply-To: <20070926020911.1202.2580.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59211>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1302-assimilate-interop.sh |   59 +++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 t/t1302-assimilate-interop.sh


diff --git a/t/t1302-assimilate-interop.sh b/t/t1302-assimilate-interop=
=2Esh
new file mode 100755
index 0000000..31f8b78
--- /dev/null
+++ b/t/t1302-assimilate-interop.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+test_description=3D'Test git/StGit interoperability with "stg assimila=
te"'
+. ./test-lib.sh
+
+test_expect_success 'Create some git-only history' '
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
+test_expect_success 'Initialize the StGit repository' '
+    stg init
+'
+
+test_expect_success 'Create five patches' '
+    for i in 0 1 2 3 4; do
+        stg new p$i -m p$i;
+    done &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_expect_success 'Pop two patches with git-reset' '
+    git reset --hard HEAD~2 &&
+    ! stg refresh &&
+    stg assimilate &&
+    stg refresh &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
+'
+
+test_expect_success 'Create a new patch' '
+    stg new q0 -m q0 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 q0" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
+'
+
+test_expect_success 'Go to an unapplied patch with with git-reset' '
+    git reset --hard $(stg id p3) &&
+    ! stg refresh &&
+    stg assimilate &&
+    stg refresh &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "q0 p4" ]
+'
+
+test_expect_success 'Go back to below the stack base with git-reset' '
+    git reset --hard foo-tag &&
+    stg assimilate &&
+    [ "$(echo $(stg applied))" =3D "" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p0 p1 p2 p3 q0 p4" ]
+'
+
+test_done
