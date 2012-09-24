From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/2] archive-zip: write extended timestamp
Date: Mon, 24 Sep 2012 17:56:23 +0200
Message-ID: <506082A7.4010108@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net> <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org> <5047A9C0.9020200@lsrfire.ath.cx> <5058CE49.3070108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Sep 24 17:57:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGB1m-00069H-CA
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 17:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496Ab2IXP4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 11:56:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:43291 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab2IXP4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 11:56:48 -0400
Received: from [192.168.2.105] (p4FFD913E.dip.t-dialin.net [79.253.145.62])
	by india601.server4you.de (Postfix) with ESMTPSA id C7164A6;
	Mon, 24 Sep 2012 17:56:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <5058CE49.3070108@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206288>

File modification times in ZIP files are encoded in DOS format: local
time with a granularity of two seconds.  Add an extra field to all
archive entries to also record the mtime in Unix' fashion, as UTC with
a granularity of one second.

This has the desirable side-effect of convincing Info-ZIP unzip 6.00
to respect general purpose flag 11, which is used to indicate that a
file name is encoded in UTF-8.  Any extra field would do, actually,
but the extended timestamp is a reasonably small one (22 bytes per
entry).  Archives created by Info-ZIP zip 3.0 contain it, too (but
with ctime and atime as well).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 0f763e8..55f66b4 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -76,6 +76,14 @@ struct zip_dir_trailer {
 	unsigned char _end[1];
 };
 
+struct zip_extra_mtime {
+	unsigned char magic[2];
+	unsigned char extra_size[2];
+	unsigned char flags[1];
+	unsigned char mtime[4];
+	unsigned char _end[1];
+};
+
 /*
  * On ARM, padding is added at the end of the struct, so a simple
  * sizeof(struct ...) reports two bytes more than the payload size
@@ -85,6 +93,9 @@ struct zip_dir_trailer {
 #define ZIP_DATA_DESC_SIZE	offsetof(struct zip_data_desc, _end)
 #define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
 #define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
+#define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
+#define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
+	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
 
 static void copy_le16(unsigned char *dest, unsigned int n)
 {
@@ -186,6 +197,7 @@ static int write_zip_entry(struct archiver_args *args,
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
+	struct zip_extra_mtime extra;
 	unsigned long attr2;
 	unsigned long compressed_size;
 	unsigned long crc;
@@ -266,8 +278,13 @@ static int write_zip_entry(struct archiver_args *args,
 		}
 	}
 
+	copy_le16(extra.magic, 0x5455);
+	copy_le16(extra.extra_size, ZIP_EXTRA_MTIME_PAYLOAD_SIZE);
+	extra.flags[0] = 1;	/* just mtime */
+	copy_le32(extra.mtime, args->time);
+
 	/* make sure we have enough free space in the dictionary */
-	direntsize = ZIP_DIR_HEADER_SIZE + pathlen;
+	direntsize = ZIP_DIR_HEADER_SIZE + pathlen + ZIP_EXTRA_MTIME_SIZE;
 	while (zip_dir_size < zip_dir_offset + direntsize) {
 		zip_dir_size += ZIP_DIRECTORY_MIN_SIZE;
 		zip_dir = xrealloc(zip_dir, zip_dir_size);
@@ -283,7 +300,7 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(dirent.mdate, zip_date);
 	set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
 	copy_le16(dirent.filename_length, pathlen);
-	copy_le16(dirent.extra_length, 0);
+	copy_le16(dirent.extra_length, ZIP_EXTRA_MTIME_SIZE);
 	copy_le16(dirent.comment_length, 0);
 	copy_le16(dirent.disk, 0);
 	copy_le16(dirent.attr1, 0);
@@ -301,11 +318,13 @@ static int write_zip_entry(struct archiver_args *args,
 	else
 		set_zip_header_data_desc(&header, size, compressed_size, crc);
 	copy_le16(header.filename_length, pathlen);
-	copy_le16(header.extra_length, 0);
+	copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
 	zip_offset += ZIP_LOCAL_HEADER_SIZE;
 	write_or_die(1, path, pathlen);
 	zip_offset += pathlen;
+	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
+	zip_offset += ZIP_EXTRA_MTIME_SIZE;
 	if (stream && method == 0) {
 		unsigned char buf[STREAM_BUFFER_SIZE];
 		ssize_t readlen;
@@ -402,6 +421,8 @@ static int write_zip_entry(struct archiver_args *args,
 	zip_dir_offset += ZIP_DIR_HEADER_SIZE;
 	memcpy(zip_dir + zip_dir_offset, path, pathlen);
 	zip_dir_offset += pathlen;
+	memcpy(zip_dir + zip_dir_offset, &extra, ZIP_EXTRA_MTIME_SIZE);
+	zip_dir_offset += ZIP_EXTRA_MTIME_SIZE;
 	zip_dir_entries++;
 
 	return 0;
-- 
1.7.12
