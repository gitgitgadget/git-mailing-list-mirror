From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] contrib/test-hg*.sh: Do not use PYTHON_PATH
Date: Wed, 17 Apr 2013 16:10:48 +0200
Message-ID: <201304171610.49384.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: felipe.contreras@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 17 16:11:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UST4i-0006sN-St
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 16:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966541Ab3DQOK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 10:10:58 -0400
Received: from mout.web.de ([212.227.17.11]:56328 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966455Ab3DQOK5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 10:10:57 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MAdrf-1UH9SX04XT-00BRBM; Wed, 17 Apr 2013 16:10:54 +0200
X-Provags-ID: V02:K0:ogEB0aBp/J9v125USRPU2FBEikg028Xwoj+fjZkVv0D
 vqVMdACXrFjcsYrWhwqoDeHj9Fr47NQFuC4wpJvtUwkHjXB/bx
 8lyInF/ap3xq67VleKdZcMsf++VKklgLXwjREMDpUbd4Wsc1H8
 zmgcXgv8SqlaK3+R2ua6SN0TGAr256/5oNYJLbaTntqfs9LfHK
 vySbQeCa2fEXYooIQ4dMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221541>

The test cases in contrib/remote-helpers use mercurial and python.
Before the tests are run, we check if python can import
"mercurial" and "hggit".
To run this check, python pointed out by PYTHON_PATH is used.
This may not work when different python binaries exist,
and PYTHON_PATH is not set:
 Makefile sets it to the default /usr/bin/python
 The PATH may point out e.g. /sw/bin/python.
When /sw/bin/python has the mercurial module installed,
but /usr/bin/python has not, the test will not be run.

Git respects PYTHON_PATH, hg does not.
Use python instead of $PYTHON_PATH to check for installed modules.

While at it, split exportX=3DY into 2 lines

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 contrib/remote-helpers/test-hg-bidi.sh   | 14 +++++++++-----
 contrib/remote-helpers/test-hg-hg-git.sh | 12 +++++++-----
 contrib/remote-helpers/test-hg.sh        |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
index f368953..9f4a430 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
+if ! python -c 'import mercurial'; then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
@@ -68,10 +68,13 @@ setup () {
 	) >> "$HOME"/.hgrc &&
 	git config --global remote-hg.hg-git-compat true
=20
-	export HGEDITOR=3D/usr/bin/true
+	HGEDITOR=3D/usr/bin/true
+	export HGEDITOR
=20
-	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE
 }
=20
 setup
@@ -88,7 +91,8 @@ test_expect_success 'encoding' '
 	git add alpha &&
 	git commit -m "add =C3=A4lph=C3=A0" &&
=20
-	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	export GIT_AUTHOR_NAME &&
 	echo beta > beta &&
 	git add beta &&
 	git commit -m "add beta" &&
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-=
helpers/test-hg-hg-git.sh
index 253e65a..5414f81 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -15,12 +15,12 @@ if ! test_have_prereq PYTHON; then
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
+if ! python -c 'import mercurial'; then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import hggit'; then
+if ! python -c 'import hggit'; then
 	skip_all=3D'skipping remote-hg tests; hg-git not available'
 	test_done
 fi
@@ -103,10 +103,12 @@ setup () {
 	git config --global receive.denycurrentbranch warn
 	git config --global remote-hg.hg-git-compat true
=20
-	export HGEDITOR=3D/usr/bin/true
+	HGEDITOR=3D/usr/bin/true
+	export HGEDITOR
=20
-	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+  GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+  GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+  export GIT_AUTHOR_DATE GIT_COMMITTER_DATE
 }
=20
 setup
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index d5b8730..8614fa1 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
+if ! python -c 'import mercurial'; then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
--=20
1.8.2.282.g4bc7171
