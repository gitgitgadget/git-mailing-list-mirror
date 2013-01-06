From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive-zip: write uncompressed size into header even with
 streaming
Date: Sun, 06 Jan 2013 16:20:57 +0100
Message-ID: <50E99659.5090702@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 16:21:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trs2O-00074N-So
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 16:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab3AFPVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 10:21:04 -0500
Received: from india601.server4you.de ([85.25.151.105]:37097 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3AFPVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 10:21:03 -0500
Received: from [192.168.2.105] (p579BE462.dip.t-dialin.net [87.155.228.98])
	by india601.server4you.de (Postfix) with ESMTPSA id 7478616B;
	Sun,  6 Jan 2013 16:21:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212808>

We record the uncompressed and compressed sizes and the CRC of streamed
files as zero in the local header of the file.  The actual values are
recorded in an extra data descriptor after the file content, and in the
usual ZIP directory entry at the end of the archive.

While we know the compressed size and the CRC only after we processed
the contents, we actually know the uncompressed size right from the
start.  And for files that we store uncompressed we also already know
their final size.

Do it like InfoZIP's zip and recored the known values, even though they
can be reconstructed using the ZIP directory and the data descriptors
alone.  InfoZIP's unzip worked fine before, but NetBSD's version
actually depends on these fields.

The uncompressed size is already set by sha1_object_info().  We just
need to initialize the compressed size to zero or the uncompressed size
depending on the compression method (0 means storing).  The CRC was
propertly initialized already.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 55f66b4..d3aef53 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -240,7 +240,7 @@ static int write_zip_entry(struct archiver_args *args,
 			(mode & 0111) ? ((mode) << 16) : 0;
 		if (S_ISREG(mode) && args->compression_level != 0 && size > 0)
 			method = 8;
-		compressed_size = size;
+		compressed_size = (method == 0) ? size : 0;
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
 		    size > big_file_threshold) {
@@ -313,10 +313,7 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(header.compression_method, method);
 	copy_le16(header.mtime, zip_time);
 	copy_le16(header.mdate, zip_date);
-	if (flags & ZIP_STREAM)
-		set_zip_header_data_desc(&header, 0, 0, 0);
-	else
-		set_zip_header_data_desc(&header, size, compressed_size, crc);
+	set_zip_header_data_desc(&header, size, compressed_size, crc);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
-- 
1.7.12
