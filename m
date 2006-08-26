From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 1/5] Reorganize/rename unpack_non_delta_entry to unpack_compressed_entry.
Date: Sat, 26 Aug 2006 04:10:43 -0400
Message-ID: <20060826081043.GC22343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 10:10:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGtFj-0002rL-J5
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 10:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbWHZIKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 04:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWHZIKs
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 04:10:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8641 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964920AbWHZIKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 04:10:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGtFb-000767-Ch; Sat, 26 Aug 2006 04:10:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A4D8320FB7F; Sat, 26 Aug 2006 04:10:43 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26036>

This function was moved above unpack_delta_entry so we can call it
from within unpack_delta_entry without a forward declaration.

This change looks worse than it is.  Its really just a relocation
of unpack_non_delta_entry to earlier in the file and renaming the
function to unpack_compressed_entry.  No other changes were made.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   56 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 066cff1..024b605 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1057,6 +1057,33 @@ static int packed_object_info(struct pac
 	return 0;
 }
 
+static void *unpack_compressed_entry(unsigned char *data,
+				    unsigned long size,
+				    unsigned long left)
+{
+	int st;
+	z_stream stream;
+	unsigned char *buffer;
+
+	buffer = xmalloc(size + 1);
+	buffer[size] = 0;
+	memset(&stream, 0, sizeof(stream));
+	stream.next_in = data;
+	stream.avail_in = left;
+	stream.next_out = buffer;
+	stream.avail_out = size;
+
+	inflateInit(&stream);
+	st = inflate(&stream, Z_FINISH);
+	inflateEnd(&stream);
+	if ((st != Z_STREAM_END) || stream.total_out != size) {
+		free(buffer);
+		return NULL;
+	}
+
+	return buffer;
+}
+
 static void *unpack_delta_entry(unsigned char *base_sha1,
 				unsigned long delta_size,
 				unsigned long left,
@@ -1110,33 +1137,6 @@ static void *unpack_delta_entry(unsigned
 	return result;
 }
 
-static void *unpack_non_delta_entry(unsigned char *data,
-				    unsigned long size,
-				    unsigned long left)
-{
-	int st;
-	z_stream stream;
-	unsigned char *buffer;
-
-	buffer = xmalloc(size + 1);
-	buffer[size] = 0;
-	memset(&stream, 0, sizeof(stream));
-	stream.next_in = data;
-	stream.avail_in = left;
-	stream.next_out = buffer;
-	stream.avail_out = size;
-
-	inflateInit(&stream);
-	st = inflate(&stream, Z_FINISH);
-	inflateEnd(&stream);
-	if ((st != Z_STREAM_END) || stream.total_out != size) {
-		free(buffer);
-		return NULL;
-	}
-
-	return buffer;
-}
-
 static void *unpack_entry(struct pack_entry *entry,
 			  char *type, unsigned long *sizep)
 {
@@ -1185,7 +1185,7 @@ void *unpack_entry_gently(struct pack_en
 		return NULL;
 	}
 	*sizep = size;
-	retval = unpack_non_delta_entry(pack, size, left);
+	retval = unpack_compressed_entry(pack, size, left);
 	return retval;
 }
 
-- 
1.4.2.g6580
