From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/45] clean: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:47 +0700
Message-ID: <1370759178-1709-15-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ59-0000H8-QX
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab3FIG0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:24 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:40957 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab3FIG0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:23 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so1416756pbc.3
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eNviGZBN4zJu73Cwmpu1ALI+YZB5MP8Q9zPq6BVSh9Y=;
        b=sny54roBrlP+rg7iI+bM7ac7I06g2n6Nly7y6fs+xQOaFaP40ysiZQv9ZYv9d8qW+c
         JA9JyJXhiII+p67vivGaiIkJZ3AhQLF6+HheuKXD0obZFB10eRYIALtDO/ok0Nmij3x7
         tCwW5gRBctfR2+AZ5ZPKuiPaiNurzVy0FmS081mkzHZDxyPsZJqJna1jyXTAz7Jg7eYX
         Gd35oT47E4lQRmwWCtacYmVNl8msFYqt4KvjxRIlzCVFakyegn8Jw5ye30IKRqBUgCQQ
         Oa46rxji8HAJS0LxI/+oIEPf60DUrruxiDcA6k99D44GMFHqc0GqKJpMlKr5D6kcn6pG
         7XFw==
X-Received: by 10.68.52.10 with SMTP id p10mr5188241pbo.92.1370759182878;
        Sat, 08 Jun 2013 23:26:22 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id dc3sm5549108pbc.9.2013.06.08.23.26.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:53 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226906>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index f955a40..fdd4980 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,6 +13,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "quote.h"
+#include "pathspec.h"
=20
 static int force =3D -1; /* unset */
=20
@@ -150,7 +151,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory =3D STRBUF_INIT;
 	struct dir_struct dir;
-	static const char **pathspec;
+	struct pathspec pathspec;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
 	struct exclude_list *el;
@@ -209,9 +210,11 @@ int cmd_clean(int argc, const char **argv, const c=
har *prefix)
 	for (i =3D 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD,
+		       prefix, argv);
=20
-	fill_directory(&dir, pathspec);
+	fill_directory(&dir, pathspec.raw);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
@@ -246,9 +249,9 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		if (lstat(ent->name, &st))
 			continue;
=20
-		if (pathspec)
-			matches =3D match_pathspec(pathspec, ent->name, len,
-						 0, NULL);
+		if (pathspec.nr)
+			matches =3D match_pathspec_depth(&pathspec, ent->name,
+						       len, 0, NULL);
=20
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
@@ -262,7 +265,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			}
 			strbuf_reset(&directory);
 		} else {
-			if (pathspec && !matches)
+			if (pathspec.nr && !matches)
 				continue;
 			res =3D dry_run ? 0 : unlink(ent->name);
 			if (res) {
--=20
1.8.2.83.gc99314b
