From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 8a/5] archive-zip: streaming for stored files
Date: Tue, 01 May 2012 00:12:21 +0200
Message-ID: <4F9F0E45.6070108@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOypa-0006M0-H7
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab2D3WMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:12:24 -0400
Received: from india601.server4you.de ([85.25.151.105]:57806 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab2D3WMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:12:22 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id F03B22F805D;
	Tue,  1 May 2012 00:12:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196620>

Write a data descriptor containing the CRC of the entry and its sizes
after streaming it out.  For simplicity, do that only if we're storing
files (option -0) for now.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c    |   90 ++++++++++++++++++++++++++++++++++++++++++++++--------
 t/t1050-large.sh |    4 +++
 2 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 678569a..1c6c39d 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "archive.h"
+#include "streaming.h"
 
 static int zip_date;
 static int zip_time;
@@ -15,6 +16,7 @@ static unsigned int zip_dir_offset;
 static unsigned int zip_dir_entries;
 
 #define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
+#define ZIP_STREAM (8)
 
 struct zip_local_header {
 	unsigned char magic[4];
@@ -31,6 +33,14 @@ struct zip_local_header {
 	unsigned char _end[1];
 };
 
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
 
@@ -120,6 +131,19 @@ static void *zlib_deflate(void *data, unsigned long size,
 	return buffer;
 }
 
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
@@ -140,6 +164,8 @@ static void set_zip_header_data_desc(struct zip_local_header *header,
 	copy_le32(header->size, size);
 }
 
+#define STREAM_BUFFER_SIZE (1024 * 16)
+
 static int write_zip_entry(struct archiver_args *args,
 			   const unsigned char *sha1,
 			   const char *path, size_t pathlen,
@@ -155,6 +181,8 @@ static int write_zip_entry(struct archiver_args *args,
 	unsigned char *out;
 	void *deflated = NULL;
 	void *buffer;
+	struct git_istream *stream = NULL;
+	unsigned long flags = 0;
 	unsigned long size;
 
 	crc = crc32(0, NULL, 0);
@@ -173,25 +201,38 @@ static int write_zip_entry(struct archiver_args *args,
 		buffer = NULL;
 		size = 0;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type;
-		buffer = sha1_file_to_archive(args, path, sha1, mode, &type, &size);
-		if (!buffer)
-			return error("cannot read %s", sha1_to_hex(sha1));
+		enum object_type type = sha1_object_info(sha1, &size);
 
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
-		if (S_ISREG(mode) && args->compression_level != 0)
+		if (S_ISREG(mode) && args->compression_level != 0 && size > 0)
 			method = 8;
-		crc = crc32(crc, buffer, size);
-		out = buffer;
 		compressed_size = size;
+
+		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
+		    size > big_file_threshold && method == 0) {
+			stream = open_istream(sha1, &type, &size, NULL);
+			if (!stream)
+				return error("cannot stream blob %s",
+					     sha1_to_hex(sha1));
+			flags |= ZIP_STREAM;
+			out = buffer = NULL;
+		} else {
+			buffer = sha1_file_to_archive(args, path, sha1, mode,
+						      &type, &size);
+			if (!buffer)
+				return error("cannot read %s",
+					     sha1_to_hex(sha1));
+			crc = crc32(crc, buffer, size);
+			out = buffer;
+		}
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
 				sha1_to_hex(sha1));
 	}
 
-	if (method == 8) {
+	if (buffer && method == 8) {
 		deflated = zlib_deflate(buffer, size, args->compression_level,
 				&compressed_size);
 		if (deflated && compressed_size - 6 < size) {
@@ -216,7 +257,7 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(dirent.creator_version,
 		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
 	copy_le16(dirent.version, 10);
-	copy_le16(dirent.flags, 0);
+	copy_le16(dirent.flags, flags);
 	copy_le16(dirent.compression_method, method);
 	copy_le16(dirent.mtime, zip_time);
 	copy_le16(dirent.mdate, zip_date);
@@ -231,18 +272,43 @@ static int write_zip_entry(struct archiver_args *args,
 
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
 	zip_offset += ZIP_LOCAL_HEADER_SIZE;
 	write_or_die(1, path, pathlen);
 	zip_offset += pathlen;
-	if (compressed_size > 0) {
+	if (stream && method == 0) {
+		unsigned char buf[STREAM_BUFFER_SIZE];
+		ssize_t readlen;
+
+		for (;;) {
+			readlen = read_istream(stream, buf, sizeof(buf));
+			if (readlen <= 0)
+				break;
+			crc = crc32(crc, buf, readlen);
+			write_or_die(1, buf, readlen);
+		}
+		close_istream(stream);
+		if (readlen)
+			return readlen;
+
+		compressed_size = size;
+		zip_offset += compressed_size;
+
+		write_zip_data_desc(size, compressed_size, crc);
+		zip_offset += ZIP_DATA_DESC_SIZE;
+
+		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
+	} else if (compressed_size > 0) {
 		write_or_die(1, out, compressed_size);
 		zip_offset += compressed_size;
 	}
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index fe47554..9db54b5 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -138,4 +138,8 @@ test_expect_success 'tar achiving' '
 	git archive --format=tar HEAD >/dev/null
 '
 
+test_expect_success 'zip achiving, store only' '
+	git archive --format=zip -0 HEAD >/dev/null
+'
+
 test_done
-- 
1.7.10
