From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/6] Verify patch status during the test
Date: Sun, 10 Jun 2007 02:54:55 -0700
Message-ID: <20070610095455.12000.43959.stgit@bill>
References: <20070610094322.12000.56284.stgit@bill>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxK8T-0006Yr-UO
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbXFJJy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbXFJJy7
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:54:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1824 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXFJJy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:54:58 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1HxK8P-0008R8-00; Sun, 10 Jun 2007 10:54:57 +0100
In-Reply-To: <20070610094322.12000.56284.stgit@bill>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49700>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1200-push-modified.sh |   55 +++++++++++++++++++++++++++-----------=
--------
 1 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index 6769667..aa4ffd0 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -19,23 +19,26 @@ specify --merged, then rollback and retry with the =
correct flag.'
 test_create_repo foo
=20
 test_expect_success \
-    'Clone tree and setup changes' \
-    "stg clone foo bar &&
-     (cd bar && stg new p1 -m p1
-      printf 'a\nc\n' > file && stg add file && stg refresh &&
-      stg new p2 -m p2
-      printf 'a\nb\nc\n' > file && stg refresh
-     )
-"
+    'Clone tree and setup changes' '
+    stg clone foo bar &&
+    (
+        cd bar && stg new p1 -m p1
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
