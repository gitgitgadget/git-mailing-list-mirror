From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] archive: make zip compression level independent from
 core git
Date: Fri, 18 Jul 2008 16:30:32 +0200
Message-ID: <4880A908.9010206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 16:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJr04-0006Z0-Ko
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 16:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbYGROak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 10:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbYGROak
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 10:30:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:48972 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbYGROaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 10:30:39 -0400
Received: from [10.0.1.200] (p57B7EF64.dip.t-dialin.net [87.183.239.100])
	by india601.server4you.de (Postfix) with ESMTPSA id 31A3E2F8064;
	Fri, 18 Jul 2008 16:30:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89044>

zlib_compression_level is the compression level used for git's object store.
It's 1 by default, which is the fastest setting.  This variable is also used
as the default compression level for ZIP archives created by git archive.

For archives, however, zlib's own default of 6 is more appropriate, as it's
favouring small size over speed -- archive creation is not that performance
critical most of the time.

This patch makes git archive independent from git's internal compression
level setting.  It affects invocations of git archive without explicitly
specified compression level option, only.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c     |    9 +++++----
 archive.h         |    1 +
 builtin-archive.c |    3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index d56e5cf..fb12398 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -93,7 +93,7 @@ static void copy_le32(unsigned char *dest, unsigned int n)
 }
 
 static void *zlib_deflate(void *data, unsigned long size,
-                          unsigned long *compressed_size)
+		int compression_level, unsigned long *compressed_size)
 {
 	z_stream stream;
 	unsigned long maxsize;
@@ -101,7 +101,7 @@ static void *zlib_deflate(void *data, unsigned long size,
 	int result;
 
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
+	deflateInit(&stream, compression_level);
 	maxsize = deflateBound(&stream, size);
 	buffer = xmalloc(maxsize);
 
@@ -157,7 +157,7 @@ static int write_zip_entry(struct archiver_args *args,
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
-		if (S_ISREG(mode) && zlib_compression_level != 0)
+		if (S_ISREG(mode) && args->compression_level != 0)
 			method = 8;
 		crc = crc32(crc, buffer, size);
 		out = buffer;
@@ -169,7 +169,8 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (method == 8) {
-		deflated = zlib_deflate(buffer, size, &compressed_size);
+		deflated = zlib_deflate(buffer, size, args->compression_level,
+				&compressed_size);
 		if (deflated && compressed_size - 6 < size) {
 			/* ZLIB --> raw compressed data (see RFC 1950) */
 			/* CMF and FLG ... */
diff --git a/archive.h b/archive.h
index 96bb1cd..4a02371 100644
--- a/archive.h
+++ b/archive.h
@@ -13,6 +13,7 @@ struct archiver_args {
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
+	int compression_level;
 };
 
 typedef int (*write_archive_fn_t)(struct archiver_args *);
diff --git a/builtin-archive.c b/builtin-archive.c
index d5e3af8..cff6ce7 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -185,9 +185,10 @@ int parse_archive_args(int argc, const char **argv, const struct archiver **ar,
 	if (!*ar)
 		die("Unknown archive format '%s'", format);
 
+	args->compression_level = Z_DEFAULT_COMPRESSION;
 	if (compression_level != -1) {
 		if ((*ar)->flags & USES_ZLIB_COMPRESSION)
-			zlib_compression_level = compression_level;
+			args->compression_level = compression_level;
 		else {
 			die("Argument not supported for format '%s': -%d",
 					format, compression_level);
-- 
1.5.6.2.212.g08b51
