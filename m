From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC v2 2/4] cache: Added ce_norm_sha1() and related cache_entry fields.
Date: Sun, 25 Apr 2010 18:29:06 +0200
Message-ID: <871d5dbed4353d86854ef2705bb14bc352ea57c2.1272210580.git.grubba@grubba.org>
References: <cover.1272210580.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 18:29:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O64i9-0005ro-Ig
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 18:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab0DYQ3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 12:29:23 -0400
Received: from mail.roxen.com ([212.247.29.220]:38513 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab0DYQ3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 12:29:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 48EA0628235
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:29:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CGveQm3tyn+V for <git@vger.kernel.org>;
	Sun, 25 Apr 2010 18:29:21 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 231C06282D8
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:29:21 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3PGTKen012719;
	Sun, 25 Apr 2010 18:29:20 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3PGTKK9012718;
	Sun, 25 Apr 2010 18:29:20 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1272210580.git.grubba@grubba.org>
In-Reply-To: <cover.1272210580.git.grubba@grubba.org>
References: <cover.1272210580.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145752>

The index now keeps track of the conversion mode that was active
when the entry was created. This can be used to detect the most
common cases of when the conversion mode has changed.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
git_norm_flags has been extended with one flag (NORM_CONV_CRLF_WT)
to be able to keep track of the working tree state as well as the
repository state.

git_norm_flags() now takes account of the auto_crlf state.

ce_match_stat_basic() now knows that a normalization change may
affect the working tree file size.

Updating of the normalization state is now done in ce_compare_data().

 cache.h      |   14 ++++++++++++++
 convert.c    |   31 +++++++++++++++++++++++++++++++
 read-cache.c |   17 +++++++++++++++--
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 1fe2d7d..3e70bef 100644
--- a/cache.h
+++ b/cache.h
@@ -151,10 +151,18 @@ struct cache_entry {
 	unsigned int ce_size;
 	unsigned int ce_flags;
 	unsigned char sha1[20];
+	unsigned int norm_flags;
+	unsigned char norm_sha1[20];
 	struct cache_entry *next;
 	char name[FLEX_ARRAY]; /* more */
 };
=20
+#define NORM_CONV_CRLF_GIT	0x0001
+#define NORM_CONV_CRLF_WT	0x0002
+#define NORM_CONV_CRLF_GUESS	0x0004
+#define NORM_CONV_IDENT		0x0008
+#define NORM_CONV_FILT		0x0010
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_EXTENDED  (0x4000)
@@ -278,6 +286,11 @@ static inline int ce_to_dtype(const struct cache_e=
ntry *ce)
 	else
 		return DT_UNKNOWN;
 }
+static inline unsigned char *ce_norm_sha1(struct cache_entry *ce)
+{
+	return ce->norm_flags?ce->norm_sha1:ce->sha1;
+}
+
 #define canon_mode(mode) \
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
@@ -1014,6 +1027,7 @@ extern void trace_argv_printf(const char **argv, =
const char *format, ...);
=20
 /* convert.c */
 /* returns 1 if *dst was used */
+extern unsigned int git_norm_flags(const char *path);
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
                           struct strbuf *dst, enum safe_crlf checksafe=
);
 extern int convert_to_working_tree(const char *path, const char *src, =
size_t len, struct strbuf *dst);
diff --git a/convert.c b/convert.c
index 4f8fcb7..5f36669 100644
--- a/convert.c
+++ b/convert.c
@@ -568,6 +568,37 @@ static int git_path_check_ident(const char *path, =
struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
=20
+unsigned int git_norm_flags(const char *path)
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
+		ret |=3D NORM_CONV_CRLF_GIT;
+		if (crlf !=3D CRLF_INPUT && auto_crlf > 0)
+			ret |=3D NORM_CONV_CRLF_WT;
+		if (crlf =3D=3D CRLF_GUESS)
+			ret |=3D NORM_CONV_CRLF_GUESS;
+	}
+	if (ident) {
+		ret |=3D NORM_CONV_IDENT;
+	}
+	if (drv) {
+		ret |=3D NORM_CONV_FILT;
+	}
+	return ret;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
diff --git a/read-cache.c b/read-cache.c
index f1f789b..1a698bf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -88,12 +88,20 @@ void fill_stat_cache_info(struct cache_entry *ce, s=
truct stat *st)
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
 {
 	int match =3D -1;
-	int fd =3D open(ce->name, O_RDONLY);
+	int fd;
+	unsigned int norm_flags =3D git_norm_flags(ce->name);
=20
+	if (norm_flags !=3D ce->norm_flags) {
+		ce->norm_flags =3D norm_flags;
+		if (norm_flags)
+			index_blob(ce->norm_sha1, ce->sha1, 0, ce->name);
+	}
+
+	fd =3D open(ce->name, O_RDONLY);
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name))
-			match =3D hashcmp(sha1, ce->sha1);
+			match =3D hashcmp(sha1, ce_norm_sha1(ce));
 		/* index_fd() closed the file descriptor already */
 	}
 	return match;
@@ -227,6 +235,11 @@ static int ce_match_stat_basic(struct cache_entry =
*ce, struct stat *st)
 		changed |=3D INODE_CHANGED;
 #endif
=20
+	/* ce_size can not be trusted if the conversion mode has changed. */
+	if ((ce->ce_mode & S_IFMT) =3D=3D S_IFREG &&
+	    ce->norm_flags !=3D git_norm_flags(ce->name))
+		return changed;
+
 	if (ce->ce_size !=3D (unsigned int) st->st_size)
 		changed |=3D DATA_CHANGED;
=20
--=20
1.7.0.4.369.g81e89
