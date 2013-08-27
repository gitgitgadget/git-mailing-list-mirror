From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v2] Set core.precomposeunicode to true on e.g. HFS+
Date: Tue, 27 Aug 2013 15:50:40 +0200
Message-ID: <201308271550.41448.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 15:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEJfb-0003NO-8u
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 15:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab3H0Nuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 09:50:51 -0400
Received: from mout.web.de ([212.227.15.3]:59801 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab3H0Nuv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 09:50:51 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0Mb6EN-1VUbEQ1VaV-00Khry for <git@vger.kernel.org>;
 Tue, 27 Aug 2013 15:50:49 +0200
X-Provags-ID: V03:K0:s5nj0WpHz9I+m1ykjmyuhylNFxskBiq1aSSxdrTuugJPWKp3U6G
 fbmIwScSGWL4vqrSwD1ZOxCs5LYhssPlyyQQzSWybG1EyrBEbCvIYE1QwdUWdnqgUmtnDVB
 19jAAGrnamA2PnwXss3zanKjjv8aVU0SFMre5Es7X71OMfgxiPchpZBbnmOWFNBq6cohhjU
 L42karaspGpXelcvjd79w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233088>

When core.precomposeunicode was introduced in 76759c7d,
it was set to false on a unicode decomposing file system like HFS+
to be compatible with older versions of Git.

The Mac OS users need to find out that this configuration exist
and change it manually from false to true.

A smoother workflow can be achieved,
so set core.precomposeunicode to true on a decomposing file system.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 compat/precompose_utf8.c     | 7 ++-----
 t/t0050-filesystem.sh        | 1 +
 t/t3910-mac-os-precompose.sh | 2 +-
 t/t7400-submodule-basic.sh   | 1 -
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 7980abd..95fe849 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -48,11 +48,8 @@ void probe_utf8_pathname_composition(char *path, int=
 len)
 	if (output_fd >=3D 0) {
 		close(output_fd);
 		strcpy(path + len, auml_nfd);
-		/* Indicate to the user, that we can configure it to true */
-		if (!access(path, R_OK))
-			git_config_set("core.precomposeunicode", "false");
-		/* To be backward compatible, set precomposed_unicode to 0 */
-		precomposed_unicode =3D 0;
+		precomposed_unicode =3D access(path, R_OK) ? 0 : 1;
+		git_config_set("core.precomposeunicode", precomposed_unicode ? "true=
" : "false");
 		strcpy(path + len, auml_nfc);
 		if (unlink(path))
 			die_errno(_("failed to unlink '%s'"), path);
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 05d78d2..6b3cedc 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -91,6 +91,7 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with di=
fferent case)' '
 test_expect_success "setup unicode normalization tests" '
 	test_create_repo unicode &&
 	cd unicode &&
+	git config core.precomposeunicode false &&
 	touch "$aumlcdiar" &&
 	git add "$aumlcdiar" &&
 	git commit -m initial &&
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
index 5fe57c5..e4ba601 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -36,7 +36,7 @@ Alongc=3D$Alongc$AEligatu$AEligatu                   =
  #254 Byte
=20
 test_expect_success "detect if nfd needed" '
 	precomposeunicode=3D`git config core.precomposeunicode` &&
-	test "$precomposeunicode" =3D false &&
+	test "$precomposeunicode" =3D true &&
 	git config core.precomposeunicode true
 '
 test_expect_success "setup" '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5ee97b0..f0f8cde 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -958,7 +958,6 @@ test_expect_success 'submodule with UTF-8 name' '
 		git add sub &&
 		git commit -m "init sub"
 	) &&
-	test_config core.precomposeunicode true &&
 	git submodule add ./"$svname" &&
 	git submodule >&2 &&
 	test -n "$(git submodule | grep "$svname")"
--=20
1.8.4.rc0.177.gceb3200
