From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/9] archive: delegate blob reading to backend
Date: Thu,  3 May 2012 08:51:03 +0700
Message-ID: <1336009868-7411-5-git-send-email-pclouds@gmail.com>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 03:53:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlEC-0007Ha-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 03:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab2ECBw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 21:52:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834Ab2ECBwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 21:52:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1813971pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ml/lvZhlHHKloDHv/Vhz07YubJWj76No2lSxvsyEz5I=;
        b=UGkY4x3TKmXslPl8UMGdXlpQqlTrLVRxWOAW0BOQEQqs44ZfDCMO/Tqk2jdvcRFmI/
         irD/DyZn/XujwGIdaus6HyH5h7uSslrOH42DyoFItg5hA0/dFjiJc6zh4kLgByszKBYt
         10IWA9dyLiVXU0r/MZRZo9rMvdH+TV5IsCSyVqqq/3UVTCD63RIndulAMO6QrEwSFjw6
         qoWpvw1/MTLCRsyyIVDQV9j2+U6UJEUJCZY//N7hMvwLt+QmLyyB4uGm1AK7vsYlV4/F
         7iPdKCiITL2ogxB0/APDWpo3dBF9JLMPZ9mKn+vAJDmY5+y9aFejNV4uIk7pLae68XDD
         23NQ==
Received: by 10.68.204.227 with SMTP id lb3mr502162pbc.92.1336009967405;
        Wed, 02 May 2012 18:52:47 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id uu3sm3616834pbc.70.2012.05.02.18.52.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:52:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:51:50 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196875>

archive-tar.c and archive-zip.c now perform conversion check, with
help of sha1_file_to_archive() from archive.c

This gives backends more freedom in dealing with (streaming) large
blobs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c |   25 +++++++++++++++++++++----
 archive-zip.c |   15 +++++++++++++--
 archive.c     |   28 +++++++++++-----------------
 archive.h     |   10 +++++++++-
 4 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 6c8a0bd..3be0cdf 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -161,11 +161,15 @@ static int write_extended_header(struct archiver_=
args *args,
 }
=20
 static int write_tar_entry(struct archiver_args *args,
-		const unsigned char *sha1, const char *path, size_t pathlen,
-		unsigned int mode, void *buffer, unsigned long size)
+			   const unsigned char *sha1,
+			   const char *path, size_t pathlen,
+			   unsigned int mode)
 {
 	struct ustar_header header;
 	struct strbuf ext_header =3D STRBUF_INIT;
+	unsigned int old_mode =3D mode;
+	unsigned long size;
+	void *buffer;
 	int err =3D 0;
=20
 	memset(&header, 0, sizeof(header));
@@ -199,7 +203,17 @@ static int write_tar_entry(struct archiver_args *a=
rgs,
 	} else
 		memcpy(header.name, path, pathlen);
=20
-	if (S_ISLNK(mode) && buffer) {
+	if (S_ISLNK(mode) || S_ISREG(mode)) {
+		enum object_type type;
+		buffer =3D sha1_file_to_archive(args, path, sha1, old_mode, &type, &=
size);
+		if (!buffer)
+			return error("cannot read %s", sha1_to_hex(sha1));
+	} else {
+		buffer =3D NULL;
+		size =3D 0;
+	}
+
+	if (S_ISLNK(mode)) {
 		if (size > sizeof(header.linkname)) {
 			sprintf(header.linkname, "see %s.paxheader",
 			        sha1_to_hex(sha1));
@@ -214,13 +228,16 @@ static int write_tar_entry(struct archiver_args *=
args,
 	if (ext_header.len > 0) {
 		err =3D write_extended_header(args, sha1, ext_header.buf,
 					    ext_header.len);
-		if (err)
+		if (err) {
+			free(buffer);
 			return err;
+		}
 	}
 	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header));
 	if (S_ISREG(mode) && buffer && size > 0)
 		write_blocked(buffer, size);
+	free(buffer);
 	return err;
 }
=20
diff --git a/archive-zip.c b/archive-zip.c
index 02d1f37..716cc42 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -121,8 +121,9 @@ static void *zlib_deflate(void *data, unsigned long=
 size,
 }
=20
 static int write_zip_entry(struct archiver_args *args,
-		const unsigned char *sha1, const char *path, size_t pathlen,
-		unsigned int mode, void *buffer, unsigned long size)
+			   const unsigned char *sha1,
+			   const char *path, size_t pathlen,
+			   unsigned int mode)
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
@@ -134,6 +135,8 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	int method;
 	unsigned char *out;
 	void *deflated =3D NULL;
+	void *buffer;
+	unsigned long size;
=20
 	crc =3D crc32(0, NULL, 0);
=20
@@ -148,7 +151,14 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
 		out =3D NULL;
 		uncompressed_size =3D 0;
 		compressed_size =3D 0;
+		buffer =3D NULL;
+		size =3D 0;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
+		enum object_type type;
+		buffer =3D sha1_file_to_archive(args, path, sha1, mode, &type, &size=
);
+		if (!buffer)
+			return error("cannot read %s", sha1_to_hex(sha1));
+
 		method =3D 0;
 		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
@@ -229,6 +239,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	}
=20
 	free(deflated);
+	free(buffer);
=20
 	return 0;
 }
diff --git a/archive.c b/archive.c
index 1ee837d..cd083ea 100644
--- a/archive.c
+++ b/archive.c
@@ -59,12 +59,15 @@ static void format_subst(const struct commit *commi=
t,
 	free(to_free);
 }
=20
-static void *sha1_file_to_archive(const char *path, const unsigned cha=
r *sha1,
-		unsigned int mode, enum object_type *type,
-		unsigned long *sizep, const struct commit *commit)
+void *sha1_file_to_archive(const struct archiver_args *args,
+			   const char *path, const unsigned char *sha1,
+			   unsigned int mode, enum object_type *type,
+			   unsigned long *sizep)
 {
 	void *buffer;
+	const struct commit *commit =3D args->convert ? args->commit : NULL;
=20
+	path +=3D args->baselen;
 	buffer =3D read_sha1_file(sha1, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf =3D STRBUF_INIT;
@@ -109,12 +112,9 @@ static int write_archive_entry(const unsigned char=
 *sha1, const char *base,
 	write_archive_entry_fn_t write_entry =3D c->write_entry;
 	struct git_attr_check check[2];
 	const char *path_without_prefix;
-	int convert =3D 0;
 	int err;
-	enum object_type type;
-	unsigned long size;
-	void *buffer;
=20
+	args->convert =3D 0;
 	strbuf_reset(&path);
 	strbuf_grow(&path, PATH_MAX);
 	strbuf_add(&path, args->base, args->baselen);
@@ -126,28 +126,22 @@ static int write_archive_entry(const unsigned cha=
r *sha1, const char *base,
 	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
-		convert =3D ATTR_TRUE(check[1].value);
+		args->convert =3D ATTR_TRUE(check[1].value);
 	}
=20
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		strbuf_addch(&path, '/');
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err =3D write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
+		err =3D write_entry(args, sha1, path.buf, path.len, mode);
 		if (err)
 			return err;
 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 	}
=20
-	buffer =3D sha1_file_to_archive(path_without_prefix, sha1, mode,
-			&type, &size, convert ? args->commit : NULL);
-	if (!buffer)
-		return error("cannot read %s", sha1_to_hex(sha1));
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-	err =3D write_entry(args, sha1, path.buf, path.len, mode, buffer, siz=
e);
-	free(buffer);
-	return err;
+	return write_entry(args, sha1, path.buf, path.len, mode);
 }
=20
 int write_archive_entries(struct archiver_args *args,
@@ -167,7 +161,7 @@ int write_archive_entries(struct archiver_args *arg=
s,
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
 		err =3D write_entry(args, args->tree->object.sha1, args->base,
-				len, 040777, NULL, 0);
+				  len, 040777);
 		if (err)
 			return err;
 	}
diff --git a/archive.h b/archive.h
index 2b0884f..895afcd 100644
--- a/archive.h
+++ b/archive.h
@@ -11,6 +11,7 @@ struct archiver_args {
 	const char **pathspec;
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
+	unsigned int convert : 1;
 	int compression_level;
 };
=20
@@ -27,11 +28,18 @@ extern void register_archiver(struct archiver *);
 extern void init_tar_archiver(void);
 extern void init_zip_archiver(void);
=20
-typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, co=
nst unsigned char *sha1, const char *path, size_t pathlen, unsigned int=
 mode, void *buffer, unsigned long size);
+typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
+					const unsigned char *sha1,
+					const char *path, size_t pathlen,
+					unsigned int mode);
=20
 extern int write_archive_entries(struct archiver_args *args, write_arc=
hive_entry_fn_t write_entry);
 extern int write_archive(int argc, const char **argv, const char *pref=
ix, int setup_prefix, const char *name_hint, int remote);
=20
 const char *archive_format_from_filename(const char *filename);
+extern void *sha1_file_to_archive(const struct archiver_args *args,
+				  const char *path, const unsigned char *sha1,
+				  unsigned int mode, enum object_type *type,
+				  unsigned long *sizep);
=20
 #endif	/* ARCHIVE_H */
--=20
1.7.3.1.256.g2539c.dirty
