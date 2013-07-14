From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 29/46] checkout: convert read_tree_some to take struct pathspec
Date: Sun, 14 Jul 2013 15:35:52 +0700
Message-ID: <1373790969-13000-30-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHpr-0002q1-6l
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab3GNIjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:39:10 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:52997 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3GNIjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:39:09 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so10290154pbc.31
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=t78HA8r9+x39nIVwhWBYm9n9PojyMVccvmZpWgRUUU0=;
        b=Q5OWGz60CZO3Qq5antsj/RSH7BfWd5PovhJjMJJ9YinNQ1pFlkI1al9GkztyooKp8T
         Vc4zcYoHbZBKCoHiS76Wpt0TYkgO8sMK4fmgnv3+jgYqKy1vwDA+yPs2Dk/2Ppqwm7tP
         65merY203HusKhJdNRPXfPmWtRzxdGTQDTfAYUXg3JWwtFrGUT7xuOK52aw0iMPLbAzU
         cV+oVObKK/awzq6ijeMgcLCphBHLwrWJ6YzXF/Gm8HJod9ev1JBjqsuzKDZMhhokbm4C
         0vNzgAXl4KHaec/iPTj+4QQN+tfzt2Qfz0TL1UVsfVU1+cC+dLy7oq2+IqgR2IVJHVsE
         WBmg==
X-Received: by 10.68.239.66 with SMTP id vq2mr49222145pbc.182.1373791148415;
        Sun, 14 Jul 2013 01:39:08 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id zf3sm23166374pac.9.2013.07.14.01.39.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:39:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:39:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230341>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 9 +++------
 tree.c             | 4 ++--
 tree.h             | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5d31767..c2f3571 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -83,12 +83,9 @@ static int update_some(const unsigned char *sha1, co=
nst char *base, int baselen,
 	return 0;
 }
=20
-static int read_tree_some(struct tree *tree, const char **pathspec)
+static int read_tree_some(struct tree *tree, const struct pathspec *pa=
thspec)
 {
-	struct pathspec ps;
-	init_pathspec(&ps, pathspec);
-	read_tree_recursive(tree, "", 0, 0, &ps, update_some, NULL);
-	free_pathspec(&ps);
+	read_tree_recursive(tree, "", 0, 0, pathspec, update_some, NULL);
=20
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
@@ -266,7 +263,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		return error(_("corrupt index file"));
=20
 	if (opts->source_tree)
-		read_tree_some(opts->source_tree, opts->pathspec.raw);
+		read_tree_some(opts->source_tree, &opts->pathspec);
=20
 	ps_matched =3D xcalloc(1, opts->pathspec.nr);
=20
diff --git a/tree.c b/tree.c
index 62fed63..ff72f67 100644
--- a/tree.c
+++ b/tree.c
@@ -47,7 +47,7 @@ static int read_one_entry_quick(const unsigned char *=
sha1, const char *base, int
 }
=20
 static int read_tree_1(struct tree *tree, struct strbuf *base,
-		       int stage, struct pathspec *pathspec,
+		       int stage, const struct pathspec *pathspec,
 		       read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
@@ -116,7 +116,7 @@ static int read_tree_1(struct tree *tree, struct st=
rbuf *base,
=20
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
-			int stage, struct pathspec *pathspec,
+			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb =3D STRBUF_INIT;
diff --git a/tree.h b/tree.h
index 69bcb5e..9dc90ba 100644
--- a/tree.h
+++ b/tree.h
@@ -25,7 +25,7 @@ typedef int (*read_tree_fn_t)(const unsigned char *, =
const char *, int, const ch
=20
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
-			       int stage, struct pathspec *pathspec,
+			       int stage, const struct pathspec *pathspec,
 			       read_tree_fn_t fn, void *context);
=20
 extern int read_tree(struct tree *tree, int stage, struct pathspec *pa=
thspec);
--=20
1.8.2.83.gc99314b
