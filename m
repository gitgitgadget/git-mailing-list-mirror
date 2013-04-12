From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] test-bzr: portable shell and utf-8 strings for Mac OS
Date: Fri, 12 Apr 2013 23:18:20 +0200
Message-ID: <201304122318.20780.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de
To: felipe.contreras@gmail.com, christophe@kn.gl
X-From: git-owner@vger.kernel.org Fri Apr 12 23:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQlMk-0000Z9-Pi
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 23:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab3DLVSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 17:18:34 -0400
Received: from mout.web.de ([212.227.17.11]:57936 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab3DLVSe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 17:18:34 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0M4qWn-1UlzBL47vJ-00yfTb; Fri, 12 Apr 2013 23:18:31 +0200
X-Provags-ID: V02:K0:CcG+rXdwpOC9CjQSZMFmRkEx42qy1QeCC28PVuUMfxV
 i8VTfaB3sXnyRujbtIE0bmWU9BpthSjxfnNJ96dCybTf+0Hy1H
 yYg+bItyKG2KHNtUXeK93pHd78Ovgf97zd1BGYvqs/nyUr/6ve
 qtyquA/xY53sjaRPq2hIDICXld8oNP71p51NU0bUH7JJCnPPAU
 gKpAEy4+8RNa1CzQCEJaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221028>

Make the shell script more portable:
- Split export X=3DY into 2 lines
- Use printf instead of echo -e

Use UTF-8 code points which are not decomposed by the filesystem:
 Code points like "=C3=A1" will be decomposed by Mac OS X.
 bzr is unable to find the file "=C3=A1" on disk.
 Use code points from unicode which can not be decomposed.
 In other words, the precompsed form use the same bytes as decomposed.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 contrib/remote-helpers/test-bzr.sh | 38 +++++++++++++++++++-----------=
--------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index e800c97..34666e1 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -169,31 +169,30 @@ test_expect_success 'fetch utf-8 filenames' '
   mkdir -p tmp && cd tmp &&
   test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
=20
-  export LC_ALL=3Den_US.UTF-8
-
+  LC_ALL=3Den_US.UTF-8
+  export LC_ALL
   (
   bzr init bzrrepo &&
   cd bzrrepo &&
=20
-  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
-  bzr add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
-  echo test >> "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
-  bzr add "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
-  bzr commit -m utf-8 &&
-  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
-  bzr commit -m utf-8 &&
-  bzr rm "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
-  bzr mv "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" "=C3=A5=C3=9F=E2=88=82" &&
-  bzr commit -m utf-8
+  echo test >> "=C3=A6r=C3=B8" &&
+  bzr add "=C3=A6r=C3=B8" &&
+  echo test >> "=C3=B8~?" &&
+  bzr add "=C3=B8~?" &&
+  bzr commit -m add-utf-8 &&
+  echo test >> "=C3=A6r=C3=B8" &&
+  bzr commit -m test-utf-8 &&
+  bzr rm "=C3=B8~?" &&
+  bzr mv "=C3=A6r=C3=B8" "=C3=B8~?" &&
+  bzr commit -m bzr-mv-utf-8
   ) &&
=20
   (
   git clone "bzr::$PWD/bzrrepo" gitrepo &&
   cd gitrepo &&
-  git ls-files > ../actual
+  git -c core.quotepath=3Dfalse ls-files > ../actual
   ) &&
-
-  echo "\"\\303\\245\\303\\237\\342\\210\\202\"" > expected &&
+  echo "=C3=B8~?" > expected &&
   test_cmp expected actual
 '
=20
@@ -201,7 +200,8 @@ test_expect_success 'push utf-8 filenames' '
   mkdir -p tmp && cd tmp &&
   test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
=20
-  export LC_ALL=3Den_US.UTF-8
+  LC_ALL=3Den_US.UTF-8
+  export LC_ALL
=20
   (
   bzr init bzrrepo &&
@@ -216,15 +216,15 @@ test_expect_success 'push utf-8 filenames' '
   git clone "bzr::$PWD/bzrrepo" gitrepo &&
   cd gitrepo &&
=20
-  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
-  git add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  echo test >> "=C3=A6r=C3=B8" &&
+  git add "=C3=A6r=C3=B8" &&
   git commit -m utf-8 &&
=20
   git push
   ) &&
=20
   (cd bzrrepo && bzr ls > ../actual) &&
-  echo -e "content\n=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" > expected &&
+  printf "content\n=C3=A6r=C3=B8\n" > expected &&
   test_cmp expected actual
 '
=20
--=20
1.8.2.341.g543621f
