From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7a/5] archive-zip: factor out helpers for writing sizes and
 CRC
Date: Tue, 01 May 2012 00:12:16 +0200
Message-ID: <4F9F0E40.8010809@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:12:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOypU-0006JG-M5
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181Ab2D3WMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:12:18 -0400
Received: from india601.server4you.de ([85.25.151.105]:57802 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab2D3WMS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:12:18 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 194662F805D;
	Tue,  1 May 2012 00:12:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196619>

We're going to reuse them soon for streaming.  Also, update the ZIP
directory only at the very end, which will also make streaming easier.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c |   39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 400ba38..678569a 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -120,6 +120,26 @@ static void *zlib_deflate(void *data, unsigned long size,
 	return buffer;
 }
 
+static void set_zip_dir_data_desc(struct zip_dir_header *header,
+				  unsigned long size,
+				  unsigned long compressed_size,
+				  unsigned long crc)
+{
+	copy_le32(header->crc32, crc);
+	copy_le32(header->compressed_size, compressed_size);
+	copy_le32(header->size, size);
+}
+
+static void set_zip_header_data_desc(struct zip_local_header *header,
+				     unsigned long size,
+				     unsigned long compressed_size,
+				     unsigned long crc)
+{
+	copy_le32(header->crc32, crc);
+	copy_le32(header->compressed_size, compressed_size);
+	copy_le32(header->size, size);
+}
+
 static int write_zip_entry(struct archiver_args *args,
 			   const unsigned char *sha1,
 			   const char *path, size_t pathlen,
@@ -200,9 +220,7 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(dirent.compression_method, method);
 	copy_le16(dirent.mtime, zip_time);
 	copy_le16(dirent.mdate, zip_date);
-	copy_le32(dirent.crc32, crc);
-	copy_le32(dirent.compressed_size, compressed_size);
-	copy_le32(dirent.size, size);
+	set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
 	copy_le16(dirent.filename_length, pathlen);
 	copy_le16(dirent.extra_length, 0);
 	copy_le16(dirent.comment_length, 0);
@@ -210,11 +228,6 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(dirent.attr1, 0);
 	copy_le32(dirent.attr2, attr2);
 	copy_le32(dirent.offset, zip_offset);
-	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
-	zip_dir_offset += ZIP_DIR_HEADER_SIZE;
-	memcpy(zip_dir + zip_dir_offset, path, pathlen);
-	zip_dir_offset += pathlen;
-	zip_dir_entries++;
 
 	copy_le32(header.magic, 0x04034b50);
 	copy_le16(header.version, 10);
@@ -222,9 +235,7 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(header.compression_method, method);
 	copy_le16(header.mtime, zip_time);
 	copy_le16(header.mdate, zip_date);
-	copy_le32(header.crc32, crc);
-	copy_le32(header.compressed_size, compressed_size);
-	copy_le32(header.size, size);
+	set_zip_header_data_desc(&header, size, compressed_size, crc);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, 0);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
@@ -239,6 +250,12 @@ static int write_zip_entry(struct archiver_args *args,
 	free(deflated);
 	free(buffer);
 
+	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
+	zip_dir_offset += ZIP_DIR_HEADER_SIZE;
+	memcpy(zip_dir + zip_dir_offset, path, pathlen);
+	zip_dir_offset += pathlen;
+	zip_dir_entries++;
+
 	return 0;
 }
 
-- 
1.7.10
