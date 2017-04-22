Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5629A1FE90
	for <e@80x24.org>; Sat, 22 Apr 2017 19:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426678AbdDVTcQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 22 Apr 2017 15:32:16 -0400
Received: from lamora.getmail.no ([84.210.184.7]:34716 "EHLO lamora.getmail.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426632AbdDVTcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 15:32:15 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Apr 2017 15:32:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id 817DB12006A;
        Sat, 22 Apr 2017 21:22:37 +0200 (CEST)
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kEmwRfOrhNM8; Sat, 22 Apr 2017 21:22:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id C4C3D122A00;
        Sat, 22 Apr 2017 21:22:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lamora.get.c.bitbit.net
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Wm0JgIg-9SDA; Sat, 22 Apr 2017 21:22:36 +0200 (CEST)
Received: from perkele.intern.softwolves.pp.se (cm-84.209.33.229.getinternet.no [84.209.33.229])
        by lamora.getmail.no (Postfix) with ESMTPSA id 972C912006A;
        Sat, 22 Apr 2017 21:22:36 +0200 (CEST)
Received: from peter (helo=localhost)
        by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.84_2)
        (envelope-from <peter@softwolves.pp.se>)
        id 1d20c9-0003LM-8r; Sat, 22 Apr 2017 21:22:37 +0200
Date:   Sat, 22 Apr 2017 20:22:37 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     git@vger.kernel.org
cc:     Keith Goldfarb <keith@blackthorn-media.com>
Subject: [PATCH] archive-zip: Add zip64 headers when file size is too large
 for 32 bits
In-Reply-To: <3C736801-6BB8-41CC-88FF-C42FC853A736@blackthorn-media.com>
Message-ID: <alpine.DEB.2.11.1704222019420.12779@perkele.intern.softwolves.pp.se>
References: <3C736801-6BB8-41CC-88FF-C42FC853A736@blackthorn-media.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the size of the files in the archive cannot be expressed in 32 bits, or
the offset in the zip file itself, add zip64 local headers with the actual
size. If we do find such entries, we also set a flag to force the creation
of a zip64 end of central directory record.

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
  archive-zip.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
  1 file changed, 41 insertions(+), 9 deletions(-)

> git archive, when writing a zip file, has a silent 4GB file size 
> limit (on the inputs as well as the output), as it doesn¢t fully 
> support zip64.

Yeah, it seems that the zip64 support that was added was to support 
more than 65535 files, but it did not add support for 64-bit file 
sizes or ZIP archives.

Try the below patch, it seems to work for me with a repository with 
two files of 4 Gbyte plus a few bytes. Haven't tested the case where 
the archive itself is larger than 4 Gbyte, but that ought to work, too.

diff --git a/archive-zip.c b/archive-zip.c
index b429a8d..c76a9b4 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -10,6 +10,7 @@

  static int zip_date;
  static int zip_time;
+static int zip_zip64;

  static unsigned char *zip_dir;
  static unsigned int zip_dir_size;
@@ -88,6 +89,16 @@ struct zip_extra_mtime {
  	unsigned char _end[1];
  };

+struct zip_extra_zip64 {
+	unsigned char magic[2];
+	unsigned char extra_size[2];
+	unsigned char size[8];
+	unsigned char compressed_size[8];
+	unsigned char offset[8];
+	unsigned char disk[4];
+	unsigned char _end[1];
+};
+
  struct zip64_dir_trailer {
  	unsigned char magic[4];
  	unsigned char record_size[8];
@@ -122,6 +133,9 @@ struct zip64_dir_trailer_locator {
  #define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
  #define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
  	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
+#define ZIP_EXTRA_ZIP64_SIZE	offsetof(struct zip_extra_zip64, _end)
+#define ZIP_EXTRA_ZIP64_PAYLOAD_SIZE \
+	(ZIP_EXTRA_ZIP64_SIZE - offsetof(struct zip_extra_zip64, size))
  #define ZIP64_DIR_TRAILER_SIZE	offsetof(struct zip64_dir_trailer, _end)
  #define ZIP64_DIR_TRAILER_RECORD_SIZE \
  	(ZIP64_DIR_TRAILER_SIZE - \
@@ -219,19 +233,25 @@ static void set_zip_dir_data_desc(struct zip_dir_header *header,
  				  unsigned long compressed_size,
  				  unsigned long crc)
  {
+	int clamped = 0;
  	copy_le32(header->crc32, crc);
-	copy_le32(header->compressed_size, compressed_size);
-	copy_le32(header->size, size);
+	copy_le32(header->compressed_size, clamp_max(compressed_size, 0xFFFFFFFFU, &clamped));
+	copy_le32(header->size, clamp_max(size, 0xFFFFFFFFU, &clamped));
+	if (clamped)
+		zip_zip64 = 1;
  }

  static void set_zip_header_data_desc(struct zip_local_header *header,
  				     unsigned long size,
  				     unsigned long compressed_size,
-				     unsigned long crc)
+				     unsigned long crc,
+				     int *clamped)
  {
  	copy_le32(header->crc32, crc);
-	copy_le32(header->compressed_size, compressed_size);
-	copy_le32(header->size, size);
+	copy_le32(header->compressed_size, clamp_max(compressed_size, 0xFFFFFFFFU, clamped));
+	copy_le32(header->size, clamp_max(size, 0xFFFFFFFFU, clamped));
+	if (clamped)
+		zip_zip64 = 1;
  }

  static int has_only_ascii(const char *s)
@@ -279,6 +299,7 @@ static int write_zip_entry(struct archiver_args *args,
  	int is_binary = -1;
  	const char *path_without_prefix = path + args->baselen;
  	unsigned int creator_version = 0;
+	int clamped = 0;

  	crc = crc32(0, NULL, 0);

@@ -376,7 +397,7 @@ static int write_zip_entry(struct archiver_args *args,
  	copy_le16(dirent.comment_length, 0);
  	copy_le16(dirent.disk, 0);
  	copy_le32(dirent.attr2, attr2);
-	copy_le32(dirent.offset, zip_offset);
+	copy_le32(dirent.offset, clamp_max(zip_offset, 0xFFFFFFFFU, &clamped));

  	copy_le32(header.magic, 0x04034b50);
  	copy_le16(header.version, 10);
@@ -384,15 +405,26 @@ static int write_zip_entry(struct archiver_args *args,
  	copy_le16(header.compression_method, method);
  	copy_le16(header.mtime, zip_time);
  	copy_le16(header.mdate, zip_date);
-	set_zip_header_data_desc(&header, size, compressed_size, crc);
+	set_zip_header_data_desc(&header, size, compressed_size, crc, &clamped);
  	copy_le16(header.filename_length, pathlen);
-	copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE);
+	copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE + (clamped ? ZIP_EXTRA_ZIP64_SIZE : 0));
  	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
  	zip_offset += ZIP_LOCAL_HEADER_SIZE;
  	write_or_die(1, path, pathlen);
  	zip_offset += pathlen;
  	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
  	zip_offset += ZIP_EXTRA_MTIME_SIZE;
+	if (clamped) {
+		struct zip_extra_zip64 extra_zip64;
+		copy_le16(extra_zip64.magic, 0x0001);
+		copy_le16(extra_zip64.extra_size, ZIP_EXTRA_ZIP64_PAYLOAD_SIZE);
+		copy_le64(extra_zip64.size, size);
+		copy_le64(extra_zip64.compressed_size, compressed_size);
+		copy_le64(extra_zip64.offset, zip_offset);
+		copy_le32(extra_zip64.disk, 0);
+		write_or_die(1, &extra_zip64, ZIP_EXTRA_ZIP64_SIZE);
+		zip_offset += ZIP_EXTRA_ZIP64_SIZE;
+	}
  	if (stream && method == 0) {
  		unsigned char buf[STREAM_BUFFER_SIZE];
  		ssize_t readlen;
@@ -538,7 +570,7 @@ static void write_zip_trailer(const unsigned char *sha1)
  	copy_le16(trailer.comment_length, sha1 ? GIT_SHA1_HEXSZ : 0);

  	write_or_die(1, zip_dir, zip_dir_offset);
-	if (clamped)
+	if (clamped || zip_zip64)
  		write_zip64_trailer();
  	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
  	if (sha1)
-- 
2.1.4
