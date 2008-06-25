From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] New refresh tests
Date: Wed, 25 Jun 2008 06:30:33 +0200
Message-ID: <20080625043026.6044.72652.stgit@yoghurt>
References: <20080625042337.6044.53357.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMfU-0000Hd-D4
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbYFYEag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 00:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYFYEag
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:30:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3571 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYFYEaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:30:35 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KBMeO-0006KA-00; Wed, 25 Jun 2008 05:30:32 +0100
In-Reply-To: <20080625042337.6044.53357.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86220>

Test stg refresh more extensively -- including some things it only
recently learned to do.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t2300-refresh-subdir.sh |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)


diff --git a/t/t2300-refresh-subdir.sh b/t/t2300-refresh-subdir.sh
index 92c1cc8..d731a11 100755
--- a/t/t2300-refresh-subdir.sh
+++ b/t/t2300-refresh-subdir.sh
@@ -4,7 +4,7 @@ test_description=3D'Test the refresh command from a sub=
directory'
 stg init
=20
 test_expect_success 'Refresh from a subdirectory' '
-    stg new foo -m foo &&
+    stg new p0 -m p0 &&
     echo foo >> foo.txt &&
     mkdir bar &&
     echo bar >> bar/bar.txt &&
@@ -45,4 +45,31 @@ test_expect_success 'Refresh subdirectories recursiv=
ely' '
     [ "$(stg status)" =3D "" ]
 '
=20
+test_expect_success 'refresh -u' '
+    echo baz >> bar/baz.txt &&
+    stg new p1 -m p1 &&
+    git add bar/baz.txt &&
+    stg refresh --index &&
+    echo xyzzy >> foo.txt &&
+    echo xyzzy >> bar/bar.txt &&
+    echo xyzzy >> bar/baz.txt &&
+    stg refresh -u &&
+    test "$(echo $(stg status))" =3D "M bar/bar.txt M foo.txt"
+'
+
+test_expect_success 'refresh -u -p <subdir>' '
+    echo xyzzy >> bar/baz.txt &&
+    stg refresh -p p0 -u bar &&
+    test "$(echo $(stg status))" =3D "M bar/baz.txt M foo.txt"
+'
+
+test_expect_success 'refresh an unapplied patch' '
+    stg refresh -u &&
+    stg goto p0 &&
+    test "$(stg status)" =3D "M foo.txt" &&
+    stg refresh -p p1 &&
+    test "$(stg status)" =3D "" &&
+    test "$(echo $(stg files p1))" =3D "A bar/baz.txt M foo.txt"
+'
+
 test_done
