From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/31] Add copy_pathspec
Date: Sun, 13 Jan 2013 19:35:10 +0700
Message-ID: <1358080539-17436-3-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMnB-0005cj-C7
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab3AMMfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:35:41 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:60821 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab3AMMfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:35:40 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so1423753dak.30
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=LHrRYKuZuBHvvOOygpnpl3wR32Y5wLonXWFLrFDdxys=;
        b=ZCja4nUZvhHYMDaESTYh+FperoTQYrWF5KpsKKi1axj4yQHFQ/0jSL3A0MwsSyb59B
         u3KSyNdNZufSx7SIiZSLuDCumsCjk8hU8zocp0J7ML0ou0Cv0UmR5kogHn1SyLG1SRsc
         nA4ZOp7ZKX6PsURzf3IZS+fDKTG8xS8VqsDe5jG2nfQmLrnXmVcDYS/tqcOZVaIIHLY0
         Mr64+TRC3Mn0hJX1inXeIIwqmCXirmvnYpP0T8ApYfEKJPtS+19zpzFUufsxqXnxGvci
         B3wPuFN4lXiTOHAkaRw14jUfQ1NwT+j8inMRPuu73mZ4EMHAbJMVy5Tzny5/p5jHIlpq
         /Pjg==
X-Received: by 10.68.226.71 with SMTP id rq7mr245142577pbc.60.1358080540375;
        Sun, 13 Jan 2013 04:35:40 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id ti9sm6291676pbc.16.2013.01.13.04.35.36
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:35:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:35:54 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213342>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 13 +++++++------
 cache.h      |  1 +
 dir.c        |  8 ++++++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 034fec9..16ce99b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -15,8 +15,9 @@ static const char * const builtin_mv_usage[] =3D {
 	NULL
 };
=20
-static const char **copy_pathspec(const char *prefix, const char **pat=
hspec,
-				  int count, int base_name)
+static const char **internal_copy_pathspec(const char *prefix,
+					   const char **pathspec,
+					   int count, int base_name)
 {
 	int i;
 	const char **result =3D xmalloc((count + 1) * sizeof(const char *));
@@ -81,17 +82,17 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
=20
-	source =3D copy_pathspec(prefix, argv, argc, 0);
+	source =3D internal_copy_pathspec(prefix, argv, argc, 0);
 	modes =3D xcalloc(argc, sizeof(enum update_mode));
-	dest_path =3D copy_pathspec(prefix, argv + argc, 1, 0);
+	dest_path =3D internal_copy_pathspec(prefix, argv + argc, 1, 0);
=20
 	if (dest_path[0][0] =3D=3D '\0')
 		/* special case: "." was normalized to "" */
-		destination =3D copy_pathspec(dest_path[0], argv, argc, 1);
+		destination =3D internal_copy_pathspec(dest_path[0], argv, argc, 1);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] =3D add_slash(dest_path[0]);
-		destination =3D copy_pathspec(dest_path[0], argv, argc, 1);
+		destination =3D internal_copy_pathspec(dest_path[0], argv, argc, 1);
 	} else {
 		if (argc !=3D 1)
 			die("destination '%s' is not a directory", dest_path[0]);
diff --git a/cache.h b/cache.h
index c257953..72675a1 100644
--- a/cache.h
+++ b/cache.h
@@ -491,6 +491,7 @@ struct pathspec {
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
+extern void copy_pathspec(struct pathspec *dst, const struct pathspec =
*src);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
diff --git a/dir.c b/dir.c
index e883a91..12a76d7 100644
--- a/dir.c
+++ b/dir.c
@@ -1559,6 +1559,14 @@ int init_pathspec(struct pathspec *pathspec, con=
st char **paths)
 	return 0;
 }
=20
+void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
+{
+	*dst =3D *src;
+	dst->items =3D xmalloc(sizeof(struct pathspec_item) * dst->nr);
+	memcpy(dst->items, src->items,
+	       sizeof(struct pathspec_item) * dst->nr);
+}
+
 void free_pathspec(struct pathspec *pathspec)
 {
 	free(pathspec->items);
--=20
1.8.0.rc2.23.g1fb49df
