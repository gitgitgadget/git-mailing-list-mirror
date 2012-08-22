From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] precompompose_utf8.c: iconv_open_or_die
Date: Wed, 22 Aug 2012 22:00:07 +0200
Message-ID: <201208222200.08803.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 22:00:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4H6K-0003Ol-S0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 22:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab2HVUAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 16:00:22 -0400
Received: from mout.web.de ([212.227.15.3]:56262 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab2HVUAU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 16:00:20 -0400
Received: from appes.localnet ([195.67.191.22]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MY6wu-1T8gvw3cvY-00VOdP; Wed, 22 Aug 2012 22:00:17 +0200
X-Provags-ID: V02:K0:RveFgpq9hYDhza49pqrGcPKyiTRbHaYqe9lW3Wnnjyj
 rr+oWzCAZ0RoajDGMQ6sV2LIkhOjYnAUiMtSEoLk7eUs+WbSe5
 Ui1vackmcdw9/S8rOwmFjb02GlstKsLM/HuSxC13tAjGUDJcWw
 EZ2mPbldNrxz65NGtu35Bu6C4xN84aZx2QSuniI7iUKUXZzF8b
 rVw7s9i6/zK/SVnECUSsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204089>

Add the function iconv_open_or_die(), which is used in both
readdir() and precompose_argv()

Optimized away one save/restore of errnor, which is no longer nedded

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 compat/precompose_utf8.c | 59 ++++++++++++++++++++++------------------=
--------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index e6c6bf2..d8b189d 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -13,6 +13,15 @@ typedef char *iconv_ibp;
 static const char *repo_encoding =3D "UTF-8";
 static const char *path_encoding =3D "UTF-8-MAC";
=20
+static iconv_t iconv_open_or_die(const char* tocode, const char* fromc=
ode)
+{
+	iconv_t my_iconv;
+	my_iconv =3D iconv_open(tocode, fromcode);
+	if (my_iconv =3D=3D (iconv_t) -1)
+		die_errno(_("iconv_open(%s,%s) failed"), repo_encoding, path_encodin=
g);
+	return my_iconv;
+}
+
 static size_t has_utf8(const char *s, size_t maxlen, size_t *strlen_c)
 {
 	const uint8_t *utf8p =3D (const uint8_t *)s;
@@ -78,9 +87,7 @@ void precompose_argv(int argc, const char **argv)
 	if (argc <=3D i)
 		return; /* no utf8 found */
=20
-	ic_precompose =3D iconv_open(repo_encoding, path_encoding);
-	if (ic_precompose =3D=3D (iconv_t) -1)
-		return;
+	ic_precompose =3D iconv_open_or_die(repo_encoding, path_encoding);
=20
 	for (i =3D 0; i < argc; i++) {
 		size_t namelen;
@@ -106,11 +113,8 @@ PREC_DIR *precompose_utf8_opendir(const char *dirn=
ame)
 		free(prec_dir->dirent_nfc);
 		free(prec_dir);
 		return NULL;
-	} else {
-		int ret_errno =3D errno;
+	} else
 		prec_dir->ic_precompose =3D (iconv_t)-1;
-		errno =3D ret_errno;
-	}
=20
 	return prec_dir;
 }
@@ -137,32 +141,23 @@ struct dirent_prec_psx *precompose_utf8_readdir(P=
REC_DIR *prec_dir)
 		prec_dir->dirent_nfc->d_type =3D res->d_type;
=20
 		if ((precomposed_unicode =3D=3D 1) && has_utf8(res->d_name, (size_t)=
-1, NULL)) {
+			iconv_ibp cp =3D (iconv_ibp)res->d_name;
+			size_t inleft =3D namelenz;
+			char *outpos =3D &prec_dir->dirent_nfc->d_name[0];
+			size_t outsz =3D prec_dir->dirent_nfc->max_name_len;
+			size_t cnt;
+			errno =3D 0;
 			if (prec_dir->ic_precompose =3D=3D (iconv_t)-1)
-				prec_dir->ic_precompose =3D
-					iconv_open(repo_encoding, path_encoding);
-			if (prec_dir->ic_precompose =3D=3D (iconv_t)-1) {
-				die("iconv_open(%s,%s) failed, but needed:\n"
-						"    precomposed unicode is not supported.\n"
-						"    If you wnat to use decomposed unicode, run\n"
-						"    \"git config core.precomposeunicode false\"\n",
-						repo_encoding, path_encoding);
-			} else {
-				iconv_ibp	cp =3D (iconv_ibp)res->d_name;
-				size_t inleft =3D namelenz;
-				char *outpos =3D &prec_dir->dirent_nfc->d_name[0];
-				size_t outsz =3D prec_dir->dirent_nfc->max_name_len;
-				size_t cnt;
-				errno =3D 0;
-				cnt =3D iconv(prec_dir->ic_precompose, &cp, &inleft, &outpos, &out=
sz);
-				if (errno || inleft) {
-					/*
-					 * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
-					 * MacOS X avoids illegal byte sequemces.
-					 * If they occur on a mounted drive (e.g. NFS) it is not worth to
-					 * die() for that, but rather let the user see the original name
-					*/
-					namelenz =3D 0; /* trigger strlcpy */
-				}
+				prec_dir->ic_precompose =3D	iconv_open_or_die(repo_encoding, path_=
encoding);
+			cnt =3D iconv(prec_dir->ic_precompose, &cp, &inleft, &outpos, &outs=
z);
+			if (errno || inleft) {
+				/*
+				 * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
+				 * MacOS X avoids illegal byte sequemces.
+				 * If they occur on a mounted drive (e.g. NFS) it is not worth to
+				 * die() for that, but rather let the user see the original name
+				 */
+				namelenz =3D 0; /* trigger strlcpy */
 			}
 		} else
 			namelenz =3D 0;
--=20
1.7.12
