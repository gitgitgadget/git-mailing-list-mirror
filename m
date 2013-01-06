From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/21] rerere: convert to use parse_pathspec
Date: Sun,  6 Jan 2013 13:20:55 +0700
Message-ID: <1357453268-12543-9-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjca-00080e-AD
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab3AFGVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:21:53 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33113 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab3AFGVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:21:52 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so9985261pbc.23
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=MEpTJLlkvgzUqboJH8AflQtq6ruyzisG0yLSUH7otmU=;
        b=wqtn6cr5jLCENT61oE1GCPQe69Sp51IiKua9ij2NfGlB+KdhtUck1LH4MtvEJvrlrb
         RdfV1B0+gZ32L9+2ES8fTlK76RpEbrDqcvkIK4zndCw2y0KQ/9ufUKMuEO+sBP5dFbid
         1a2EqxYQNodiLv4jmzfUwl2fFk/U98KvPiyJo8VwOio6zJPOnjKDTxkiguAb3CJZB9GQ
         2THRDnmlmAe/qyPCzDK1GC/oX5rqQFxLeeFkVTRI97qvQrjQG4XU9EOKJMQNSn6DvYNI
         3A9pRrLsByh0HKbzaiaiEHezObT9PbEFjBJEfVUKGbmXmjt7qZ55v1MKfNxeLOlGH5VF
         3/3A==
X-Received: by 10.68.253.161 with SMTP id ab1mr156643473pbd.97.1357453310787;
        Sat, 05 Jan 2013 22:21:50 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id k4sm36318630paz.26.2013.01.05.22.21.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:21:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:21:59 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212762>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rerere.c | 6 +++---
 rerere.c         | 8 ++++----
 rerere.h         | 4 +++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index dc1708e..a573c4a 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -68,11 +68,11 @@ int cmd_rerere(int argc, const char **argv, const c=
har *prefix)
 		return rerere(flags);
=20
 	if (!strcmp(argv[0], "forget")) {
-		const char **pathspec;
+		struct pathspec pathspec;
 		if (argc < 2)
 			warning("'git rerere forget' without paths is deprecated");
-		pathspec =3D get_pathspec(prefix, argv + 1);
-		return rerere_forget(pathspec);
+		parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + 1);
+		return rerere_forget(&pathspec);
 	}
=20
 	fd =3D setup_rerere(&merge_rr, flags);
diff --git a/rerere.c b/rerere.c
index a6a5cd5..f8ddf85 100644
--- a/rerere.c
+++ b/rerere.c
@@ -655,7 +655,7 @@ static int rerere_forget_one_path(const char *path,=
 struct string_list *rr)
 	return 0;
 }
=20
-int rerere_forget(const char **pathspec)
+int rerere_forget(struct pathspec *pathspec)
 {
 	int i, fd;
 	struct string_list conflict =3D STRING_LIST_INIT_DUP;
@@ -666,12 +666,12 @@ int rerere_forget(const char **pathspec)
=20
 	fd =3D setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
=20
-	unmerge_cache(pathspec);
+	unmerge_cache(pathspec->raw);
 	find_conflict(&conflict);
 	for (i =3D 0; i < conflict.nr; i++) {
 		struct string_list_item *it =3D &conflict.items[i];
-		if (!match_pathspec(pathspec, it->string, strlen(it->string),
-				    0, NULL))
+		if (!match_pathspec_depth(pathspec, it->string, strlen(it->string),
+					  0, NULL))
 			continue;
 		rerere_forget_one_path(it->string, &merge_rr);
 	}
diff --git a/rerere.h b/rerere.h
index 156d2aa..4aa06c9 100644
--- a/rerere.h
+++ b/rerere.h
@@ -3,6 +3,8 @@
=20
 #include "string-list.h"
=20
+struct pathspec;
+
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
=20
@@ -16,7 +18,7 @@ extern void *RERERE_RESOLVED;
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
-extern int rerere_forget(const char **);
+extern int rerere_forget(struct pathspec *);
 extern int rerere_remaining(struct string_list *);
 extern void rerere_clear(struct string_list *);
 extern void rerere_gc(struct string_list *);
--=20
1.8.0.rc2.23.g1fb49df
