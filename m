From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/45] rerere: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:50 +0700
Message-ID: <1370759178-1709-18-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ5S-0000V2-9O
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab3FIG0m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:42 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49612 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3FIG0l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:41 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so5325719pdc.19
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9ibp2uICczNG2ZW+GB+y3Or/oPltsskOYsX34dZTMFY=;
        b=Ww+djpPEt5JRuNv3K2JF/Kl2fr/popmBJZBkVFbnRx79nMJpZGsc1teggENDCViWLx
         B/uoTz5TeyKJSWYbQ1/q1BBtql9q/9hteoeSWK24IA+hkJOU1jCL7L94hMtMVITXv5RY
         FjTE2hV9Ag/mvHSEsNNvAZITuF2vfU7F2SY04399R7LxD1tjpMWabX6KIkCjJ0anQp+k
         iiWyPclzDI9DQB7aejM3rlnhHCLaLhG5bMqlO+tqULg9aArvI39k/XfAOk+QUtZRzQjs
         H/3URHKi1Dk6H5VBR7mTqafN6JEOAYMwuKtD2YnZAHwkLKS0o4OAOeUOptqftmguInp9
         sBlQ==
X-Received: by 10.68.164.196 with SMTP id ys4mr5075990pbb.170.1370759200942;
        Sat, 08 Jun 2013 23:26:40 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id pm7sm5504192pbb.31.2013.06.08.23.26.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:12 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226909>


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
