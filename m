From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/10] archive-zip: factor out helpers for writing sizes and CRC
Date: Wed,  2 May 2012 20:25:20 +0700
Message-ID: <1335965122-17458-9-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:30:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZdQ-0001HI-2f
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab2EBNaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:30:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58325 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab2EBNaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:30:15 -0400
Received: by yenm10 with SMTP id m10so147799yen.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PKuejTHBdNSeU3G+slx5c99AeLNks0CVWUv4mDRboOw=;
        b=NhTOllXUyBV0UcNW1Cgpd6/P1GPBfSGIwiF9FPhXf4LOs90jQNnqx+gvZc0XP9cfed
         XRDV8eMbHniXBVnGYddrzIqEu7y6eI4P9PstahP9r5ucdJA4gixuUTCQZ0wRva4wZAYe
         wQa5RQ6wK6UhrTxX7kImZQEoCym5EvgVoLdUK6abBNlkEC/HLpNI5Fs1RwDzaxMPNeAG
         Uu3hiYCtE9CeYRlGgrs7qZVDDYD5NLBc58PPqBcMSoXZUEuAzjxbbyrzoXHnC8Sy0f79
         eC0inhULOwKcD4YtPcgMlYxrezewBTdLk5PeXV4u5X31s/r0z8MZj5Wa84RCfiVA90mN
         SsKQ==
Received: by 10.68.236.165 with SMTP id uv5mr14835661pbc.37.1335965414108;
        Wed, 02 May 2012 06:30:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id k9sm1987007pbf.65.2012.05.02.06.30.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:30:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:26:42 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196811>

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
1.7.8.36.g69ee2
