From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/46] clean: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:37 +0700
Message-ID: <1373790969-13000-15-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHoR-0001sY-Bq
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab3GNIhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:43 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32863 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:41 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so10189506pac.40
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eNviGZBN4zJu73Cwmpu1ALI+YZB5MP8Q9zPq6BVSh9Y=;
        b=t43rr8WJL3ZNrX9JB8xNGtAsN57Hb8e1zLAqPZS2x5ZO0W/gztDLbGRWORrmDtl2dD
         EYwcRz1M73VhPhJ6vjtEtzT2Ftqp6/D46tc5VngRrMCPQrMiLbGMg98N8bWhhulfTR78
         TefyRA5flvqXDzPQ9l4tkZKckw4pFpNKj/+b08LfE15StC8Gdq9HCxGIk2H6/1CbhzF0
         wHzCjJ2QxtLN/O1SLoe30Kck+Qk72YKUn7d5p4MeqRtiS6iRprNrAZCs6/xd5nJdAuSH
         xQSrESNSKPHc84aLXcOMysahun+vxSNPGic9KuMEi9jkLeYPupmRazGr2B7YIK2RwAyK
         1iAA==
X-Received: by 10.68.103.228 with SMTP id fz4mr49038153pbb.101.1373791061540;
        Sun, 14 Jul 2013 01:37:41 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id qu10sm54566958pbb.12.2013.07.14.01.37.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:53 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230326>


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
