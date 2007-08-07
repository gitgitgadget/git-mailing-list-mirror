From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/2] New test: make sure that popping doesn't change
	patch order
Date: Tue, 07 Aug 2007 04:43:51 +0200
Message-ID: <20070807024351.11174.22203.stgit@yoghurt>
References: <20070807024147.11174.87229.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:43:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF38-0004Wz-R8
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765776AbXHGCny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765769AbXHGCny
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:43:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2225 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765752AbXHGCnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:43:53 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF31-0002Sx-00; Tue, 07 Aug 2007 03:43:51 +0100
In-Reply-To: <20070807024147.11174.87229.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55203>

This is mostly useful in conjunction with the DAG appliedness patches,
since getting this right with a plain series file _ought_ to be
trivial. Nevertheless ...

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1203-pop.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t1203-pop.sh b/t/t1203-pop.sh
new file mode 100755
index 0000000..0a311d4
--- /dev/null
+++ b/t/t1203-pop.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# Copyright (c) 2007 Karl Hasselstr=C3=B6m
+test_description=3D'Test the pop command'
+. ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    'stg init'
+
+test_expect_success \
+    'Create ten patches' '
+    for i in 0 1 2 3 4 5 6 7 8 9; do
+        stg new p$i -m p$i;
+    done &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3 p4 p5 p6 p7 p8 p9" ] &=
&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_expect_success \
+    'Pop half the patches' '
+    stg pop -n 5 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p5 p6 p7 p8 p9" ]
+'
+
+test_expect_success \
+    'Pop the remaining patches' '
+    stg pop -a &&
+    [ "$(echo $(stg applied))" =3D "" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p0 p1 p2 p3 p4 p5 p6 p7 p8 p9" ]
+'
+
+test_done
