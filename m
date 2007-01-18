From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Document pack .idx file format upgrade strategy.
Date: Wed, 17 Jan 2007 20:43:57 -0500
Message-ID: <20070118014356.GA23390@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 02:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7MK1-0003wr-7Z
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 02:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXARBoD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 20:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbXARBoC
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 20:44:02 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56906 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXARBoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 20:44:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7MJf-0005XF-SG; Wed, 17 Jan 2007 20:43:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 56E9020FBAE; Wed, 17 Jan 2007 20:43:57 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37056>

Way back when Junio developed the 64 bit index topic he came up
with a means of changing the .idx file format so that older Git
clients would recognize that they don't understand the file and
refuse to read it, while newer clients could tell the difference
between the old-style and new-style .idx files.  Unfortunately
this wasn't recorded anywhere.

This change documents how we might go about changing the .idx
file format by using a special signature in the first four bytes.
Credit (and possible blame) goes completely to Junio for thinking
up this technique.

The change also modifies the error message of the current Git code
so that users get a recommendation to upgrade their Git software
should this version or later encounter a new-style .idx which it
cannot process.  We already do this for the .pack files, but since
we usually process the .idx files first its important that these
files are recognized and encourage an upgrade.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 pack.h      |   28 ++++++++++++++++++++++++++++
 sha1_file.c |   17 ++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/pack.h b/pack.h
index 4814800..790ff4a 100644
--- a/pack.h
+++ b/pack.h
@@ -15,5 +15,33 @@ struct pack_header {
 	unsigned int hdr_entries;
 };
 
+/*
+ * Packed object index header
+ *
+ * struct pack_idx_header {
+ * 	uint32_t idx_signature;
+ *	uint32_t idx_version;
+ * };
+ *
+ * Note: this header isn't active yet.  In future versions of git
+ * we may change the index file format.  At that time we would start
+ * the first four bytes of the new index format with this signature,
+ * as all older git binaries would find this value illegal and abort
+ * reading the file.
+ *
+ * This is the case because the number of objects in a packfile
+ * cannot exceed 1,431,660,000 as every object would need at least
+ * 3 bytes of data and the overall packfile cannot exceed 4 GiB due
+ * to the 32 bit offsets used by the index.  Clearly the signature
+ * exceeds this maximum.
+ *
+ * Very old git binaries will also compare the first 4 bytes to the
+ * next 4 bytes in the index and abort with a "non-monotonic index"
+ * error if the second 4 byte word is smaller than the first 4
+ * byte word.  This would be true in the proposed future index
+ * format as idx_signature would be greater than idx_version.
+ */
+#define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
+
 extern int verify_pack(struct packed_git *, int);
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 1b1c0f7..0b70545 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -456,12 +456,23 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 
 	/* check index map */
 	if (idx_size < 4*256 + 20 + 20)
-		return error("index file too small");
+		return error("index file %s is too small", path);
+
+	/* a future index format would start with this, as older git
+	 * binaries would fail the non-monotonic index check below.
+	 * give a nicer warning to the user if we can.
+	 */
+	if (index[0] == htonl(PACK_IDX_SIGNATURE))
+		return error("index file %s is a newer version"
+			" and is not supported by this binary"
+			" (try upgrading GIT to a newer version)",
+			path);
+
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned int n = ntohl(index[i]);
 		if (n < nr)
-			return error("non-monotonic index");
+			return error("non-monotonic index %s", path);
 		nr = n;
 	}
 
@@ -473,7 +484,7 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	 *  - 20-byte SHA1 file checksum
 	 */
 	if (idx_size != 4*256 + nr * 24 + 20 + 20)
-		return error("wrong index file size");
+		return error("wrong index file size in %s", path);
 
 	return 0;
 }
-- 
1.5.0.rc1.g556b
