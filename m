From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 15/45] clean: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:30 +0700
Message-ID: <1363327620-29017-16-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5j-00057a-7Q
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab3COGZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:44 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51307 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab3COGZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:43 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so3997693ieb.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CE+Lw5zTI1gCpw67fPGO0+PQ1NfVXsZBeKJ0YulY+Ok=;
        b=qyw6dbUWMNwH3FA22fMo89JjJ4KM28zBuijKIKOOIRgmfxWRYY7Q4ed5tN7QVNEjWR
         zScmxA8zwOR4rUEECDqqnYYRt5aBlfiNoTRaKoqPupJoTwjz+ewjKlzk4Wa1sBaznS1Z
         5h+n5eGRj7tDkcQrkGUXXEdGdWYyk/FxsqS6VZymiFxdVqWxwk6eQs9aiHyUD/VG6vTW
         Km3sAIs/n4C5U75oGmWHQiN2ci1yejibQpNcMJLdz/IeI+2ETkGyq1OQqDRB2240PQih
         ElTYM1ye9Dq8Whffiy3YdSSwqA2xmabZSygzhkYEF4r7sIvudTOEK32IIDz9SkU7Cz3V
         w2gw==
X-Received: by 10.50.16.138 with SMTP id g10mr341791igd.33.1363328743566;
        Thu, 14 Mar 2013 23:25:43 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id vb15sm733409igb.9.2013.03.14.23.25.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:42 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:46 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218202>


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
1.8.0.rc0.19.g7bbb31d
