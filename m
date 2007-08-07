From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/2] Verify patch status during the test
Date: Tue, 07 Aug 2007 04:43:56 +0200
Message-ID: <20070807024356.11174.47706.stgit@yoghurt>
References: <20070807024147.11174.87229.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF3G-0004Xo-4V
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765787AbXHGCn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765794AbXHGCn7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:43:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2228 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765781AbXHGCn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:43:58 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF37-0002T5-00; Tue, 07 Aug 2007 03:43:57 +0100
In-Reply-To: <20070807024147.11174.87229.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55204>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1200-push-modified.sh |   55 +++++++++++++++++++++++++++-----------=
--------
 1 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index 324b3b0..0e408d0 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -19,23 +19,26 @@ specify --merged, then rollback and retry with the =
correct flag.'
 test_create_repo foo
=20
 test_expect_success \
-    'Clone tree and setup changes' \
-    "stg clone foo bar &&
-     (cd bar && stg new p1 -m p1 &&
-      printf 'a\nc\n' > file && stg add file && stg refresh &&
-      stg new p2 -m p2 &&
-      printf 'a\nb\nc\n' > file && stg refresh
-     )
-"
+    'Clone tree and setup changes' '
+    stg clone foo bar &&
+    (
+        cd bar && stg new p1 -m p1 &&
+        printf "a\nc\n" > file && stg add file && stg refresh &&
+        stg new p2 -m p2 &&
+        printf "a\nb\nc\n" > file && stg refresh &&
+        [ "$(echo $(stg applied))" =3D "p1 p2" ] &&
+        [ "$(echo $(stg unapplied))" =3D "" ]
+    )
+'
=20
 test_expect_success \
-    'Port those patches to orig tree' \
-    '(cd foo &&
-      GIT_DIR=3D../bar/.git git-format-patch --stdout \
-          $(cd ../bar && stg id base@master)..HEAD |
-      git-am -3 -k
-     )
-    '
+    'Port those patches to orig tree' '
+    (
+        cd foo &&
+        GIT_DIR=3D../bar/.git git-format-patch --stdout \
+          $(cd ../bar && stg id base@master)..HEAD | git-am -3 -k
+    )
+'
=20
 test_expect_success \
     'Pull to sync with parent, preparing for the problem' \
@@ -51,15 +54,21 @@ test_expect_failure \
 "
=20
 test_expect_success \
-    'Rollback the push' \
-    "(cd bar && stg push --undo
-     )
-"
+    'Rollback the push' '
+    (
+        cd bar && stg push --undo &&
+        [ "$(echo $(stg applied))" =3D "" ] &&
+        [ "$(echo $(stg unapplied))" =3D "p1 p2" ]
+    )
+'
=20
 test_expect_success \
-    'Push those patches while checking they were merged upstream' \
-    "(cd bar && stg push --merged --all
-     )
-"
+    'Push those patches while checking they were merged upstream' '
+    (
+        cd bar && stg push --merged --all
+        [ "$(echo $(stg applied))" =3D "p1 p2" ] &&
+        [ "$(echo $(stg unapplied))" =3D "" ]
+    )
+'
=20
 test_done
