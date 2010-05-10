From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v3 3/5] cache: Keep track of conversion mode changes.
Date: Mon, 10 May 2010 11:51:48 +0200
Message-ID: <864c8c0ba90b462b72071b5afff7e639391f7fe4.1273482409.git.grubba@grubba.org>
References: <cover.1273482409.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 11:52:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPer-00032f-22
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab0EJJwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 05:52:11 -0400
Received: from mail.roxen.com ([212.247.29.220]:32878 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756078Ab0EJJwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:52:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 7A729628103
	for <git@vger.kernel.org>; Mon, 10 May 2010 11:52:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ABjWTG2Toym7 for <git@vger.kernel.org>;
	Mon, 10 May 2010 11:52:06 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 547476280F5
	for <git@vger.kernel.org>; Mon, 10 May 2010 11:52:06 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o4A9pttK016659;
	Mon, 10 May 2010 11:51:55 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o4A9ptRC016658;
	Mon, 10 May 2010 11:51:55 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1273482409.git.grubba@grubba.org>
In-Reply-To: <cover.1273482409.git.grubba@grubba.org>
References: <cover.1273482409.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146785>

The index now keeps track of the conversion mode that was active
when the entry was created. This can be used to detect the most
common cases of when the conversion mode has changed.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
No longer keeps track of the normalized sha1. Instead
CONV_NORM_NEEDED is set when the conversion mode affects
the normalized sha1, and the normalized sha1 (re-)generated
on demand.

The cache_entry is now smudged when CONV_NORM_NEEDED is set
or reset, since we don't know the size of the corresponding
working tree file in such cases.

Removed the prefix NORM_ from the conversion mode flags.

 cache.h      |   10 ++++++++++
 convert.c    |   31 +++++++++++++++++++++++++++++++
 read-cache.c |   37 ++++++++++++++++++++++++++++++++++---
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 1fe2d7d..e5f54f2 100644
--- a/cache.h
+++ b/cache.h
@@ -151,10 +151,19 @@ struct cache_entry {
 	unsigned int ce_size;
 	unsigned int ce_flags;
 	unsigned char sha1[20];
+	unsigned int ce_conv_flags;
 	struct cache_entry *next;
 	char name[FLEX_ARRAY]; /* more */
 };
=20
+#define CONV_CRLF_GIT		0x0001
+#define CONV_CRLF_WT		0x0002
+#define CONV_CRLF_GUESS		0x0004
+#define CONV_IDENT		0x0008
+#define CONV_FILT		0x0010
+#define CONV_MASK		0x001f
+#define CONV_NORM_NEEDED	0x010000
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_EXTENDED  (0x4000)
@@ -1014,6 +1023,7 @@ extern void trace_argv_printf(const char **argv, =
const char *format, ...);
=20
 /* convert.c */
 /* returns 1 if *dst was used */
+extern unsigned int git_conv_flags(const char *path);
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
                           struct strbuf *dst, enum safe_crlf checksafe=
);
 extern int convert_to_working_tree(const char *path, const char *src, =
size_t len, struct strbuf *dst);
diff --git a/convert.c b/convert.c
index 4f8fcb7..9c063c8 100644
--- a/convert.c
+++ b/convert.c
@@ -568,6 +568,37 @@ static int git_path_check_ident(const char *path, =
struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
=20
+unsigned int git_conv_flags(const char *path)
+{
+	struct git_attr_check check[3];
+	int crlf =3D CRLF_GUESS;
+	int ident =3D 0;
+	unsigned ret =3D 0;
+	struct convert_driver *drv =3D NULL;
+
+	setup_convert_check(check);
+	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+		crlf =3D git_path_check_crlf(path, check + 0);
+		ident =3D git_path_check_ident(path, check + 1);
+		drv =3D git_path_check_convert(path, check + 2);
+	}
+
+	if (auto_crlf && (crlf !=3D CRLF_BINARY)) {
+		ret |=3D CONV_CRLF_GIT;
+		if (crlf !=3D CRLF_INPUT && auto_crlf > 0)
+			ret |=3D CONV_CRLF_WT;
+		if (crlf =3D=3D CRLF_GUESS)
+			ret |=3D CONV_CRLF_GUESS;
+	}
+	if (ident) {
+		ret |=3D CONV_IDENT;
+	}
+	if (drv) {
+		ret |=3D CONV_FILT;
+	}
+	return ret;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
diff --git a/read-cache.c b/read-cache.c
index f1f789b..eeda928 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -88,12 +88,38 @@ void fill_stat_cache_info(struct cache_entry *ce, s=
truct stat *st)
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
 {
 	int match =3D -1;
-	int fd =3D open(ce->name, O_RDONLY);
-
+	int fd;
+	unsigned char norm_sha1[20];
+	unsigned int conv_flags =3D git_conv_flags(ce->name);
+	const unsigned char *cmp_sha1 =3D ce->sha1;
+
+	if ((conv_flags ^ ce->ce_conv_flags) & CONV_MASK) {
+		if (ce->ce_conv_flags & CONV_NORM_NEEDED) {
+			/* Smudge the entry since it was only correct
+			 * for the old conversion mode. */
+			ce->ce_size =3D 0;
+		}
+		ce->ce_conv_flags =3D conv_flags;
+	} else
+		conv_flags =3D ce->ce_conv_flags & CONV_NORM_NEEDED;
+
+	if (conv_flags) {
+		index_blob(norm_sha1, ce->sha1, 0, ce->name);
+		if (!(conv_flags & CONV_NORM_NEEDED) &&
+		    hashcmp(norm_sha1, ce->sha1)) {
+			ce->ce_conv_flags =3D conv_flags | CONV_NORM_NEEDED;
+			/* Smudge the entry since we don't know
+			 * the correct value. */
+			ce->ce_size =3D 0;
+		}
+		cmp_sha1 =3D norm_sha1;
+	}
+=09
+	fd =3D open(ce->name, O_RDONLY);
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name))
-			match =3D hashcmp(sha1, ce->sha1);
+			match =3D hashcmp(sha1, cmp_sha1);
 		/* index_fd() closed the file descriptor already */
 	}
 	return match;
@@ -227,6 +253,11 @@ static int ce_match_stat_basic(struct cache_entry =
*ce, struct stat *st)
 		changed |=3D INODE_CHANGED;
 #endif
=20
+	/* ce_size can not be trusted if the conversion mode has changed. */
+	if ((ce->ce_mode & S_IFMT) =3D=3D S_IFREG &&
+	    ((ce->ce_conv_flags ^ git_conv_flags(ce->name)) & CONV_MASK))
+		return changed;
+
 	if (ce->ce_size !=3D (unsigned int) st->st_size)
 		changed |=3D DATA_CHANGED;
=20
--=20
1.7.0.4.369.g81e89
