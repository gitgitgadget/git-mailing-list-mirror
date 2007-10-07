From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/8] New test: "stg pop --keep"
Date: Mon, 08 Oct 2007 01:17:24 +0200
Message-ID: <20071007231724.12626.57217.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefOT-0003Sh-1l
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609AbXJGXR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbXJGXR2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1363 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842AbXJGXR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:28 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefNE-0000Ks-00; Mon, 08 Oct 2007 00:17:24 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60241>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1204-pop-keep.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100755 t/t1204-pop-keep.sh


diff --git a/t/t1204-pop-keep.sh b/t/t1204-pop-keep.sh
new file mode 100755
index 0000000..40cd2a2
--- /dev/null
+++ b/t/t1204-pop-keep.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description=3D'Test "stg pop -keep"'
+. ./test-lib.sh
+stg init
+
+test_expect_success 'Create a few patches' '
+    for i in 0 1 2; do
+        stg new p$i -m p$i &&
+        echo "patch$i" >> patch$i.txt &&
+        stg add patch$i.txt &&
+        stg refresh
+    done &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_expect_success 'Make some non-conflicting local changes' '
+    echo "local" >> patch0.txt
+'
+
+test_expect_success 'Pop two patches, keeping local changes' '
+    stg pop -n 2 --keep &&
+    [ "$(echo $(stg applied))" =3D "p0" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p1 p2" ] &&
+    [ "$(echo $(ls patch?.txt))" =3D "patch0.txt" ] &&
+    [ "$(echo $(cat patch0.txt))" =3D "patch0 local" ]
+'
+
+test_expect_success 'Reset and push patches again' '
+    git reset --hard &&
+    stg push -a
+'
+
+test_expect_success 'Pop a patch without local changes' '
+    stg pop --keep &&
+    [ "$(echo $(stg applied))" =3D "p0 p1" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p2" ] &&
+    [ "$(echo $(ls patch?.txt))" =3D "patch0.txt patch1.txt" ]
+'
+
+test_done
