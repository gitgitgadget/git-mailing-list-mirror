From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/2] optimize adjust_shared_perm() in path.c:
Date: Sat, 30 Mar 2013 10:53:47 +0100
Message-ID: <201303301053.49140.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org, kusmabite@gmail.com,
	mlevedahl@gmail.com, ramsay@ramsay1.demon.co.uk, tboegi@web.de,
	sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 30 10:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsUX-0002yR-NY
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3C3JyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:54:00 -0400
Received: from mout.web.de ([212.227.15.3]:49270 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747Ab3C3Jx7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Mar 2013 05:53:59 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MBTEQ-1USzDQ2vgc-00Ay6v; Sat, 30 Mar 2013 10:53:55 +0100
X-Provags-ID: V02:K0:lRD69KNo6fgd1mQVSdEQPIUkYtQ7ZGc7MPsdDBKVu35
 KxGLb2AM32+sUNN08WlrVM2tmSei4/UVWdNVToOteamR2Hpszh
 Uu4zgbF4IfUu1Kyqyy77UmFZqJAs0bZI+Km6+3DFjZqrNOXl/f
 slWh9p60vE3TjULUvme1iW2Iw+wmlyp8hWQ7yuCSmpWhb3xByZ
 m22c4IHLii4T7JJ/Tbj+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219584>

sometimes the chown() function is called even when not needed.
(This can be provoced by running t1301, and adding some debug code)

Save a chmod from 400 to 400, or from 600->600 on these files:
 .git/info/refs+
 .git/objects/info/packs+

Save chmod on directories from 2770 to 2770:
 .git/refs
 .git/refs/heads
 .git/refs/tags

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 path.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/path.c b/path.c
index 427312e..33fa880 100644
--- a/path.c
+++ b/path.c
@@ -396,22 +396,14 @@ const char *enter_repo(const char *path, int stri=
ct)
 	return NULL;
 }
=20
-int adjust_shared_perm(const char *path)
+static int calc_shared_perm(int mode)
 {
-	int tweak, shared, orig_mode, mode;
+	int tweak;
=20
-	if (!shared_repository) {
-		return 0;
-	}
-	if (get_st_mode_bits(path, &mode) < 0)
-		return -1;
-
-	orig_mode =3D mode;
 	if (shared_repository < 0)
-		shared =3D -shared_repository;
+		tweak =3D -shared_repository;
 	else
-		shared =3D shared_repository;
-	tweak =3D shared;
+		tweak =3D shared_repository;
=20
 	if (!(mode & S_IWUSR))
 		tweak &=3D ~0222;
@@ -423,16 +415,28 @@ int adjust_shared_perm(const char *path)
 	else
 		mode |=3D tweak;
=20
-	if (S_ISDIR(mode)) {
+	return mode;
+}
+
+
+int adjust_shared_perm(const char *path)
+{
+	int old_mode, new_mode;
+
+	if (!shared_repository)
+		return 0;
+	if (get_st_mode_bits(path, &old_mode) < 0)
+		return -1;
+
+	new_mode =3D calc_shared_perm(old_mode);
+	if (S_ISDIR(old_mode)) {
 		/* Copy read bits to execute bits */
-		mode |=3D (shared & 0444) >> 2;
-		mode |=3D FORCE_DIR_SET_GID;
+		new_mode |=3D (new_mode & 0444) >> 2;
+		new_mode |=3D FORCE_DIR_SET_GID;
 	}
=20
-	if (((shared_repository < 0
-	      ? (orig_mode & (FORCE_DIR_SET_GID | 0777))
-	      : (orig_mode & mode)) !=3D mode) &&
-	    chmod(path, (mode & ~S_IFMT)) < 0)
+	if (((old_mode ^ new_mode) & ~S_IFMT) &&
+			chmod(path, (new_mode & ~S_IFMT)) < 0)
 		return -2;
 	return 0;
 }
--=20
1.8.2.341.g543621f
