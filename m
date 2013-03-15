From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 18/45] rerere: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:33 +0700
Message-ID: <1363327620-29017-19-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO65-0005Wz-CD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab3COG0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:26:06 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:41548 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3COG0E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:26:04 -0400
Received: by mail-ia0-f176.google.com with SMTP id i18so2842709iac.7
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Ktpqx23F8lqNlCogYFuF39gee4WzxuNgfnSaQDON3mQ=;
        b=hxvH5RFaArPJJwN6r7bQOCvrMUKhJqEO0FsJ7scvluDR1rt5yZ+wR1ng77yFq2gWhC
         DVLd9Nv36ZrbsDYWZCzSduI4JbG+mUz4iOZsUTbWEGrzsQ03X26U7gPef9eK5xkHyqbe
         ShhTN+48h5ND0VtRhsE9wHVUk4Ibh6VZ/QyFdnxmlHL3SyLmBgPGQt0ZscruMmFawO0K
         zZaxoV1Zj2WHx6yWmMbYI0sZSBv+J4QutffEVxLitDLLvV2kjFsikK82gwzK35eSwwbY
         XguUQI3486OqolrzIaEgStFHkkcY+7VmBpzA9Fpdwgg61lDrVE6Fjs3Xg/Wb0ogDZH5L
         ieGw==
X-Received: by 10.50.36.199 with SMTP id s7mr418105igj.56.1363328764084;
        Thu, 14 Mar 2013 23:26:04 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id g6sm622334ign.4.2013.03.14.23.26.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:26:03 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:06 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218205>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rerere.c | 8 +++++---
 rerere.c         | 9 +++++----
 rerere.h         | 4 +++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index dc1708e..4e51add 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -6,6 +6,7 @@
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "pathspec.h"
=20
 static const char * const rerere_usage[] =3D {
 	N_("git rerere [clear | forget path... | status | remaining | diff | =
gc]"),
@@ -68,11 +69,12 @@ int cmd_rerere(int argc, const char **argv, const c=
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
+		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
+			       prefix, argv + 1);
+		return rerere_forget(&pathspec);
 	}
=20
 	fd =3D setup_rerere(&merge_rr, flags);
diff --git a/rerere.c b/rerere.c
index a6a5cd5..c52c1f2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -6,6 +6,7 @@
 #include "resolve-undo.h"
 #include "ll-merge.h"
 #include "attr.h"
+#include "pathspec.h"
=20
 #define RESOLVED 0
 #define PUNTED 1
@@ -655,7 +656,7 @@ static int rerere_forget_one_path(const char *path,=
 struct string_list *rr)
 	return 0;
 }
=20
-int rerere_forget(const char **pathspec)
+int rerere_forget(struct pathspec *pathspec)
 {
 	int i, fd;
 	struct string_list conflict =3D STRING_LIST_INIT_DUP;
@@ -666,12 +667,12 @@ int rerere_forget(const char **pathspec)
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
1.8.0.rc0.19.g7bbb31d
