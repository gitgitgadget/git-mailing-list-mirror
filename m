From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/3] Test patch order, not just number of patches
Date: Sun, 13 May 2007 20:27:25 +0200
Message-ID: <20070513182725.18810.85322.stgit@yoghurt>
References: <20070513182720.18810.64330.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 20:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIxC-0000KD-Cy
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372AbXEMShy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757564AbXEMShy
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:37:54 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:35262 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757372AbXEMShx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 14:37:53 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:50795 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HnIx6-0000eS-3j; Sun, 13 May 2007 20:37:52 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HnImz-0004ty-Jv; Sun, 13 May 2007 20:27:25 +0200
In-Reply-To: <20070513182720.18810.64330.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HnIx6-0000eS-3j.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HnIx6-0000eS-3j 808828ac270ebe5c6cc9e8d3aab117ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47163>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

In addition to testing the number of applied patches, also test their
order. And test the order of unapplied patches too while we're at it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t2000-sync.sh |   37 +++++++++++++++++++++++++++----------
 1 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index 02345bb..69ab1ac 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -29,7 +29,9 @@ test_expect_success \
     stg add foo3.txt &&
     stg refresh &&
     stg export &&
-    stg pop
+    stg pop &&
+    [ "$(echo $(stg applied))" =3D "p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3" ]
     '
=20
 test_expect_success \
@@ -38,15 +40,17 @@ test_expect_success \
     stg branch -c foo base &&
     stg new p1 -m p1 &&
     stg new p2 -m p2 &&
-    stg new p3 -m p3
-    test $(stg applied -c) -eq 3
+    stg new p3 -m p3 &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
     '
=20
 test_expect_success \
     'Synchronise second patch with the master branch' \
     '
     stg sync -b master p2 &&
-    test $(stg applied -c) -eq 3 &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ] &&
     test $(cat foo2.txt) =3D "foo2"
     '
=20
@@ -54,7 +58,8 @@ test_expect_success \
     'Synchronise the first two patches with the master branch' \
     '
     stg sync -b master -a &&
-    test $(stg applied -c) -eq 3 &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ] &&
     test $(cat foo1.txt) =3D "foo1" &&
     test $(cat foo2.txt) =3D "foo2"
     '
@@ -63,7 +68,8 @@ test_expect_success \
     'Synchronise all the patches with the exported series' \
     '
     stg sync -s patches-master/series -a &&
-    test $(stg applied -c) -eq 3 &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ] &&
     test $(cat foo1.txt) =3D "foo1" &&
     test $(cat foo2.txt) =3D "foo2" &&
     test $(cat foo3.txt) =3D "foo3"
@@ -73,6 +79,8 @@ test_expect_success \
     'Modify the master patches' \
     '
     stg branch master &&
+    [ "$(echo $(stg applied))" =3D "p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3" ] &&
     stg goto p1 &&
     echo bar1 >> foo1.txt &&
     stg refresh &&
@@ -83,6 +91,8 @@ test_expect_success \
     stg goto p3 &&
     echo bar3 >> foo3.txt &&
     stg refresh &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ] &&
     stg export &&
     stg branch foo
     '
@@ -91,7 +101,8 @@ test_expect_success \
     'Synchronise second patch with the master branch' \
     '
     stg sync -b master p2 &&
-    test $(stg applied -c) -eq 3 &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ] &&
     test $(cat bar2.txt) =3D "bar2"
     '
=20
@@ -104,10 +115,13 @@ test_expect_failure \
 test_expect_success \
     'Restore the stack status after the failed sync' \
     '
-    test $(stg applied -c) -eq 1 &&
+    [ "$(echo $(stg applied))" =3D "p1" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p2 p3" ] &&
     stg resolved -a &&
     stg refresh &&
     stg goto p3
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
     '
=20
 test_expect_failure \
@@ -119,9 +133,12 @@ test_expect_failure \
 test_expect_success \
     'Restore the stack status after the failed sync' \
     '
-    test $(stg applied -c) -eq 3 &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ] &&
     stg resolved -a &&
-    stg refresh
+    stg refresh &&
+    [ "$(echo $(stg applied))" =3D "p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
     '
=20
 test_done
