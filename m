From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC 2/5] cache: Added ce_norm_sha1() and related cache_entry fields.
Date: Fri, 16 Apr 2010 18:09:59 +0200
Message-ID: <46923d62c91524a5afd987088bb1a10de2a701cd.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 18:43:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2odt-0005I4-Md
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566Ab0DPQnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 12:43:20 -0400
Received: from mail.roxen.com ([212.247.29.220]:35380 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758128Ab0DPQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:43:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 9B0AD628159
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBBSoBdRTtVc for <git@vger.kernel.org>;
	Fri, 16 Apr 2010 18:10:06 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 27389628226
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:06 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3GGA5vp021796;
	Fri, 16 Apr 2010 18:10:05 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3GGA5BB021795;
	Fri, 16 Apr 2010 18:10:05 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145076>

Added function to retrieve the sha1 for a (re-)normalized cache_entry.
It makes a reasonable effort at detecting conversion mode changes.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
Note: This implementation will miss a changed custom filter.

 cache.h   |   21 +++++++++++++++++++++
 convert.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 1fe2d7d..536697d 100644
--- a/cache.h
+++ b/cache.h
@@ -151,10 +151,17 @@ struct cache_entry {
 	unsigned int ce_size;
 	unsigned int ce_flags;
 	unsigned char sha1[20];
+	unsigned int norm_flags;
+	unsigned char norm_sha1[20];
 	struct cache_entry *next;
 	char name[FLEX_ARRAY]; /* more */
 };
=20
+#define NORM_CONV_CRLF	0x0001
+#define NORM_CONV_GUESS	0x0002
+#define NORM_CONV_IDENT	0x0004
+#define NORM_CONV_FILT	0x0008
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_EXTENDED  (0x4000)
@@ -1014,6 +1021,7 @@ extern void trace_argv_printf(const char **argv, =
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
@@ -1062,4 +1070,17 @@ int split_cmdline(char *cmdline, const char ***a=
rgv);
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
=20
+static inline unsigned char *ce_norm_sha1(struct cache_entry *ce)
+{
+	unsigned int norm_flags =3D git_norm_flags(ce->name);
+
+	if (!norm_flags)
+		return ce->sha1;
+	if (norm_flags =3D=3D ce->norm_flags)
+		return ce->norm_sha1;
+	index_blob(ce->norm_sha1, ce->sha1, 1, ce->name);
+   	ce->norm_flags =3D norm_flags;
+	return ce->norm_sha1;
+}
+
 #endif /* CACHE_H */
diff --git a/convert.c b/convert.c
index 4f8fcb7..6378ef5 100644
--- a/convert.c
+++ b/convert.c
@@ -568,6 +568,41 @@ static int git_path_check_ident(const char *path, =
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
+	switch(crlf) {
+	case CRLF_INPUT:
+	case CRLF_TEXT:
+		ret |=3D NORM_CONV_CRLF;
+		break;
+	case CRLF_GUESS:
+		ret |=3D NORM_CONV_GUESS;
+		break;
+	case CRLF_BINARY:
+		break;
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
--=20
1.7.0.4.369.g81e89
