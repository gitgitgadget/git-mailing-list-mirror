From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/46] rerere: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:40 +0700
Message-ID: <1373790969-13000-18-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:38:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHoi-00025s-W2
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab3GNIiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:38:00 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51109 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:59 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so9787531pdj.36
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9ibp2uICczNG2ZW+GB+y3Or/oPltsskOYsX34dZTMFY=;
        b=ICVM5NOZ2AptPPVWJeIPKclAI7wPZvEND2NbLaHr665leJTYAiPedQMqoQc63S/oh8
         Tv9ljcTJZ5/YkpCOzqC340yv0K7bfEN+NJjBPGAeS8jZQWrKZg08nCSllIsm7QPN3JSU
         5Y9LWH8FxdCPYUjZ2TMn04iga3HEEjLvaReFe904wHnf6Ytci/1eRlLleAIeA2LVApSi
         WXVtz2IIwcUE3mh1ffwRAg09VBX57CgWSWFkWioqhGmTg5GBYrnZualwNFdgTaY27+Bo
         9M7ag9x1f9Ib/YF1Z1+VQocEOo+jSx3UIav9lQZD+RYqFGX8lJ1vRmchyglv/k5dQb/Q
         ZeJA==
X-Received: by 10.68.60.132 with SMTP id h4mr4138377pbr.177.1373791078939;
        Sun, 14 Jul 2013 01:37:58 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id z19sm57818538paf.12.2013.07.14.01.37.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:38:10 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230329>


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
index 98e3e29..27afbfe 100644
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
@@ -656,7 +657,7 @@ static int rerere_forget_one_path(const char *path,=
 struct string_list *rr)
 	return 0;
 }
=20
-int rerere_forget(const char **pathspec)
+int rerere_forget(struct pathspec *pathspec)
 {
 	int i, fd;
 	struct string_list conflict =3D STRING_LIST_INIT_DUP;
@@ -667,12 +668,12 @@ int rerere_forget(const char **pathspec)
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
1.8.2.83.gc99314b
