From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] archive-zip: support UTF-8 paths
Date: Tue, 18 Sep 2012 21:46:56 +0200
Message-ID: <5058CFB0.6040506@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net> <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org> <5047A9C0.9020200@lsrfire.ath.cx> <5058CE49.3070108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Sep 18 21:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3lQ-0007lA-SM
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab2IRTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:47:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:42877 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab2IRTrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:47:10 -0400
Received: from [192.168.2.105] (p579BE98C.dip.t-dialin.net [87.155.233.140])
	by india601.server4you.de (Postfix) with ESMTPSA id 8C188B1;
	Tue, 18 Sep 2012 21:47:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <5058CE49.3070108@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205858>

Set general purpose flag 11 if we encounter a path that contains
non-ASCII characters.  We assume that all paths are given as UTF-8; no
conversion is done.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Changes from previous version: Stop using has_non_ascii(), which does
slightly too much for our purposes, and split off creator version
change into a separate patch.

 archive-zip.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index f5af81f..0f763e8 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "archive.h"
 #include "streaming.h"
+#include "utf8.h"
 
 static int zip_date;
 static int zip_time;
@@ -16,7 +17,8 @@ static unsigned int zip_dir_offset;
 static unsigned int zip_dir_entries;
 
 #define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
-#define ZIP_STREAM (8)
+#define ZIP_STREAM	(1 <<  3)
+#define ZIP_UTF8	(1 << 11)
 
 struct zip_local_header {
 	unsigned char magic[4];
@@ -164,6 +166,17 @@ static void set_zip_header_data_desc(struct zip_local_header *header,
 	copy_le32(header->size, size);
 }
 
+static int has_only_ascii(const char *s)
+{
+	for (;;) {
+		int c = *s++;
+		if (c == '\0')
+			return 1;
+		if (!isascii(c))
+			return 0;
+	}
+}
+
 #define STREAM_BUFFER_SIZE (1024 * 16)
 
 static int write_zip_entry(struct archiver_args *args,
@@ -187,6 +200,13 @@ static int write_zip_entry(struct archiver_args *args,
 
 	crc = crc32(0, NULL, 0);
 
+	if (!has_only_ascii(path)) {
+		if (is_utf8(path))
+			flags |= ZIP_UTF8;
+		else
+			warning("Path is not valid UTF-8: %s", path);
+	}
+
 	if (pathlen > 0xffff) {
 		return error("path too long (%d chars, SHA1: %s): %s",
 				(int)pathlen, sha1_to_hex(sha1), path);
-- 
1.7.12
