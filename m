From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/10] archive-zip: streaming for stored files
Date: Wed,  2 May 2012 20:25:21 +0700
Message-ID: <1335965122-17458-10-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZdW-0001KS-U0
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab2EBNaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:30:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab2EBNaY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:30:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1097342pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TkR3OvtYCvFuJ0VPTe8cIxDoj+JsLULoe5LxCYeBnpE=;
        b=F+nCe0eBj7QRzOIMNtbqZ/pSWoZakksc6GrNpcja3cWvZIO0JkDRgfK8TERGQevM2S
         sa7Z7dESzlBiWF52SqB9sd48nsoWd6FMwqm5tFE3bomYtgSnvOywAb6KQq6sMvGJuD/6
         +ZOxOX5iQikq/y4o2C59z6iCKdZ4p+J/HGdtS0k3XVERQt6PVl/z8tTCBRXnlggMKrQg
         oEEqMYsaV1zBmq2QQ1a1D41/Pd/qP79ZcEHAR41ayXUX5Lc3GAU4vEngADypLFVlDsai
         Ls2Y6JACgvzFcqjBQAUvaACzJYxydz+p/Uxx7sdu3IT/bHIXfOVbSxY+LV7cojaBPCPm
         oJ9g==
Received: by 10.68.227.227 with SMTP id sd3mr19357891pbc.64.1335965423798;
        Wed, 02 May 2012 06:30:23 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id qk5sm1991280pbc.45.2012.05.02.06.30.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:30:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:26:53 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196812>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

Write a data descriptor containing the CRC of the entry and its sizes
after streaming it out.  For simplicity, do that only if we're storing
files (option -0) for now.

t5000 verifies output. t1050 makes sure the command always respects
core.bigfilethreshold

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-zip.c       |   90 +++++++++++++++++++++++++++++++++++++++++++=
+-------
 t/t1050-large.sh    |    4 ++
 t/t5000-tar-tree.sh |    7 ++++
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 678569a..1c6c39d 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "archive.h"
+#include "streaming.h"
=20
 static int zip_date;
 static int zip_time;
@@ -15,6 +16,7 @@ static unsigned int zip_dir_offset;
 static unsigned int zip_dir_entries;
=20
 #define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
+#define ZIP_STREAM (8)
=20
 struct zip_local_header {
 	unsigned char magic[4];
@@ -31,6 +33,14 @@ struct zip_local_header {
 	unsigned char _end[1];
 };
=20
+struct zip_data_desc {
+	unsigned char magic[4];
+	unsigned char crc32[4];
+	unsigned char compressed_size[4];
+	unsigned char size[4];
+	unsigned char _end[1];
+};
+
 struct zip_dir_header {
 	unsigned char magic[4];
 	unsigned char creator_version[2];
@@ -70,6 +80,7 @@ struct zip_dir_trailer {
  * we're interested in.
  */
 #define ZIP_LOCAL_HEADER_SIZE	offsetof(struct zip_local_header, _end)
+#define ZIP_DATA_DESC_SIZE	offsetof(struct zip_data_desc, _end)
 #define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
 #define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
=20
@@ -120,6 +131,19 @@ static void *zlib_deflate(void *data, unsigned lon=
g size,
 	return buffer;
 }
=20
+static void write_zip_data_desc(unsigned long size,
+				unsigned long compressed_size,
+				unsigned long crc)
+{
+	struct zip_data_desc trailer;
+
+	copy_le32(trailer.magic, 0x08074b50);
+	copy_le32(trailer.crc32, crc);
+	copy_le32(trailer.compressed_size, compressed_size);
+	copy_le32(trailer.size, size);
+	write_or_die(1, &trailer, ZIP_DATA_DESC_SIZE);
+}
+
 static void set_zip_dir_data_desc(struct zip_dir_header *header,
 				  unsigned long size,
 				  unsigned long compressed_size,
@@ -140,6 +164,8 @@ static void set_zip_header_data_desc(struct zip_loc=
al_header *header,
 	copy_le32(header->size, size);
 }
=20
+#define STREAM_BUFFER_SIZE (1024 * 16)
+
 static int write_zip_entry(struct archiver_args *args,
 			   const unsigned char *sha1,
 			   const char *path, size_t pathlen,
@@ -155,6 +181,8 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	unsigned char *out;
 	void *deflated =3D NULL;
 	void *buffer;
+	struct git_istream *stream =3D NULL;
+	unsigned long flags =3D 0;
 	unsigned long size;
=20
 	crc =3D crc32(0, NULL, 0);
@@ -173,25 +201,38 @@ static int write_zip_entry(struct archiver_args *=
args,
 		buffer =3D NULL;
 		size =3D 0;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type;
-		buffer =3D sha1_file_to_archive(args, path, sha1, mode, &type, &size=
);
-		if (!buffer)
-			return error("cannot read %s", sha1_to_hex(sha1));
+		enum object_type type =3D sha1_object_info(sha1, &size);
=20
 		method =3D 0;
 		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
-		if (S_ISREG(mode) && args->compression_level !=3D 0)
+		if (S_ISREG(mode) && args->compression_level !=3D 0 && size > 0)
 			method =3D 8;
-		crc =3D crc32(crc, buffer, size);
-		out =3D buffer;
 		compressed_size =3D size;
+
+		if (S_ISREG(mode) && type =3D=3D OBJ_BLOB && !args->convert &&
+		    size > big_file_threshold && method =3D=3D 0) {
+			stream =3D open_istream(sha1, &type, &size, NULL);
+			if (!stream)
+				return error("cannot stream blob %s",
+					     sha1_to_hex(sha1));
+			flags |=3D ZIP_STREAM;
+			out =3D buffer =3D NULL;
+		} else {
+			buffer =3D sha1_file_to_archive(args, path, sha1, mode,
+						      &type, &size);
+			if (!buffer)
+				return error("cannot read %s",
+					     sha1_to_hex(sha1));
+			crc =3D crc32(crc, buffer, size);
+			out =3D buffer;
+		}
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
 				sha1_to_hex(sha1));
 	}
=20
-	if (method =3D=3D 8) {
+	if (buffer && method =3D=3D 8) {
 		deflated =3D zlib_deflate(buffer, size, args->compression_level,
 				&compressed_size);
 		if (deflated && compressed_size - 6 < size) {
@@ -216,7 +257,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	copy_le16(dirent.creator_version,
 		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
 	copy_le16(dirent.version, 10);
-	copy_le16(dirent.flags, 0);
+	copy_le16(dirent.flags, flags);
 	copy_le16(dirent.compression_method, method);
 	copy_le16(dirent.mtime, zip_time);
 	copy_le16(dirent.mdate, zip_date);
@@ -231,18 +272,43 @@ static int write_zip_entry(struct archiver_args *=
args,
=20
 	copy_le32(header.magic, 0x04034b50);
 	copy_le16(header.version, 10);
-	copy_le16(header.flags, 0);
+	copy_le16(header.flags, flags);
 	copy_le16(header.compression_method, method);
 	copy_le16(header.mtime, zip_time);
 	copy_le16(header.mdate, zip_date);
-	set_zip_header_data_desc(&header, size, compressed_size, crc);
+	if (flags & ZIP_STREAM)
+		set_zip_header_data_desc(&header, 0, 0, 0);
+	else
+		set_zip_header_data_desc(&header, size, compressed_size, crc);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, 0);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
 	zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
 	write_or_die(1, path, pathlen);
 	zip_offset +=3D pathlen;
-	if (compressed_size > 0) {
+	if (stream && method =3D=3D 0) {
+		unsigned char buf[STREAM_BUFFER_SIZE];
+		ssize_t readlen;
+
+		for (;;) {
+			readlen =3D read_istream(stream, buf, sizeof(buf));
+			if (readlen <=3D 0)
+				break;
+			crc =3D crc32(crc, buf, readlen);
+			write_or_die(1, buf, readlen);
+		}
+		close_istream(stream);
+		if (readlen)
+			return readlen;
+
+		compressed_size =3D size;
+		zip_offset +=3D compressed_size;
+
+		write_zip_data_desc(size, compressed_size, crc);
+		zip_offset +=3D ZIP_DATA_DESC_SIZE;
+
+		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
+	} else if (compressed_size > 0) {
 		write_or_die(1, out, compressed_size);
 		zip_offset +=3D compressed_size;
 	}
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index fe47554..9db54b5 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -138,4 +138,8 @@ test_expect_success 'tar achiving' '
 	git archive --format=3Dtar HEAD >/dev/null
 '
=20
+test_expect_success 'zip achiving, store only' '
+	git archive --format=3Dzip -0 HEAD >/dev/null
+'
+
 test_done
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 421c356..3cd2e51 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -245,6 +245,13 @@ test_expect_success UNZIP \
     'validate file contents with prefix' \
     'diff -r a e/prefix/a'
=20
+test_expect_success UNZIP 'git archive -0 --format=3Dzip on large file=
s' '
+    git config core.bigfilethreshold 1 &&
+    git archive -0 --format=3Dzip HEAD >large.zip &&
+    git config --unset core.bigfilethreshold &&
+    (mkdir large && cd large && $UNZIP ../large.zip)
+'
+
 test_expect_success \
     'git archive --list outside of a git repo' \
     'GIT_DIR=3Dsome/non-existing/directory git archive --list'
--=20
1.7.8.36.g69ee2
