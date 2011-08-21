From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] clone: allow to clone from .git file
Date: Sun, 21 Aug 2011 18:58:09 +0700
Message-ID: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 13:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv6fj-0004ht-Hv
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 13:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab1HUL6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 07:58:30 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55437 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab1HUL63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 07:58:29 -0400
Received: by pzk37 with SMTP id 37so7255182pzk.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=V1qd1dznkHZySUvQM3ZDau2apcplYZ2L1Mdtuv9xRxo=;
        b=V7TZVkJp4ZqVTmV6SxO9J5SvOyWPx4F/VC4UKOSeAG71cQlF9NXiKFuCedZr9HeQ+o
         3JcvOstne52iHYSEqiCT0iWf7EC9B0vUyS+uIfdUdFM/wECT7XFNi5xjogiOw03Fm8Sq
         316VV8bWvX3gBL/RJx06FrjrqNk3dneNg/tRU=
Received: by 10.142.224.7 with SMTP id w7mr974537wfg.215.1313927908924;
        Sun, 21 Aug 2011 04:58:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id d4sm3636597pbe.68.2011.08.21.04.58.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Aug 2011 04:58:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Aug 2011 18:58:22 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179802>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c  |   23 ++++++++++++++++++++++-
 t/t5601-clone.sh |    4 ++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7663bc2..eff3b5e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -103,10 +103,31 @@ static char *get_repo_path(const char *repo, int =
*is_bundle)
 	for (i =3D 0; i < ARRAY_SIZE(suffix); i++) {
 		const char *path;
 		path =3D mkpath("%s%s", repo, suffix[i]);
-		if (is_directory(path)) {
+		if (stat(path, &st))
+			continue;
+		if (S_ISDIR(st.st_mode)) {
 			*is_bundle =3D 0;
 			return xstrdup(absolute_path(path));
 		}
+		else if (S_ISREG(st.st_mode) && st.st_size > 8) {
+			/* Despite the name read_gitfile_gently can be
+			   cruel on non .git file, check for signature
+			   ourselves */
+			char signature[8];
+			int len, fd =3D open(path, O_RDONLY);
+			if (fd < 0)
+				continue;
+			len =3D read_in_full(fd, signature, 8);
+			close(fd);
+			if (len !=3D 8 || strncmp(signature, "gitdir: ", 8))
+				continue;
+
+			path =3D read_gitfile_gently(path);
+			if (path) {
+				*is_bundle =3D 0;
+				return xstrdup(absolute_path(path));
+			}
+		}
 	}
=20
 	for (i =3D 0; i < ARRAY_SIZE(bundle_suffix); i++) {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 151ea53..501bd3f 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -202,6 +202,10 @@ test_expect_success 'clone separate gitdir: output=
' '
 	test_cmp expected dst/.git
 '
=20
+test_expect_success 'clone from .git file' '
+	git clone dst/.git dst2
+'
+
 test_expect_success 'clone separate gitdir where target already exists=
' '
 	rm -rf dst &&
 	test_must_fail git clone --separate-git-dir realgitdir src dst
--=20
1.7.4.74.g639db
