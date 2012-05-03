From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 7/9] archive-zip: factor out helpers for writing sizes and CRC
Date: Thu,  3 May 2012 08:51:06 +0700
Message-ID: <1336009868-7411-8-git-send-email-pclouds@gmail.com>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 03:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlEd-0007c1-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 03:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab2ECBxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 21:53:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab2ECBxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 21:53:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1813971pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8FzZbdTdyG8hn24nx6HhFxNpBBSU8S+jCe9gKCUnB8w=;
        b=EuW+XpuitOgFjm1+XIApQ4iT9qmqu0WzYXT2Pvaa8RNakgBPFmyhKLnr5MUF8DWPq+
         fROmMGygejaM6X5i8S78luv26PCoAMyVOhA252UKXhFgs0iV9xOsQeWQTc2taR72knOT
         RiH4rrCztfJCb7pi3rt9EAc20rGVX4LVVOtlQL8mLlFwBeY/UVuH2dQ1rfJB2Pyv0ur2
         I50pitEXzbRHlkfbh1JpHUsFqTlCV+VNfttORQwsixz1IiHCzJxGIZb7R6fBHQIaFpqL
         /WP2yDIX4mTzlVLHlG++3TpfQCJAZUJKALKNAPnVVsRwON0hUkvOaoesBDj3CYBzVkDE
         QQSA==
Received: by 10.68.218.72 with SMTP id pe8mr2602482pbc.45.1336009989383;
        Wed, 02 May 2012 18:53:09 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id y3sm3619142pbh.59.2012.05.02.18.53.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:53:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:52:12 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196880>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

We're going to reuse them soon for streaming.  Also, update the ZIP
directory only at the very end, which will also make streaming easier.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-zip.c |   39 ++++++++++++++++++++++++++++-----------
 1 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 400ba38..678569a 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -120,6 +120,26 @@ static void *zlib_deflate(void *data, unsigned lon=
g size,
 	return buffer;
 }
=20
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
@@ -200,9 +220,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
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
@@ -210,11 +228,6 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
 	copy_le16(dirent.attr1, 0);
 	copy_le32(dirent.attr2, attr2);
 	copy_le32(dirent.offset, zip_offset);
-	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
-	zip_dir_offset +=3D ZIP_DIR_HEADER_SIZE;
-	memcpy(zip_dir + zip_dir_offset, path, pathlen);
-	zip_dir_offset +=3D pathlen;
-	zip_dir_entries++;
=20
 	copy_le32(header.magic, 0x04034b50);
 	copy_le16(header.version, 10);
@@ -222,9 +235,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
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
@@ -239,6 +250,12 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
 	free(deflated);
 	free(buffer);
=20
+	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
+	zip_dir_offset +=3D ZIP_DIR_HEADER_SIZE;
+	memcpy(zip_dir + zip_dir_offset, path, pathlen);
+	zip_dir_offset +=3D pathlen;
+	zip_dir_entries++;
+
 	return 0;
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
