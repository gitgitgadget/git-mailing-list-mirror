From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 2/5] Reuse compression code in unpack_compressed_entry.
Date: Sat, 26 Aug 2006 04:11:02 -0400
Message-ID: <20060826081102.GD22343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 10:11:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGtG3-0002uy-TV
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 10:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWHZILI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 04:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWHZILH
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 04:11:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:12737 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964920AbWHZILG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 04:11:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGtFu-00078C-Mw; Sat, 26 Aug 2006 04:11:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EAEE920FB7F; Sat, 26 Aug 2006 04:11:02 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26037>

[PATCH 2/5] Reuse compression code in unpack_compressed_entry.

This cleans up the code by reusing a perfectly good decompression
implementation at the expense of 1 extra byte of memory allocated in
temporary memory while the delta is being decompressed and applied
to the base.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   25 ++++---------------------
 1 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 024b605..fd3e01b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1092,10 +1092,8 @@ static void *unpack_delta_entry(unsigned
 				struct packed_git *p)
 {
 	struct pack_entry base_ent;
-	void *data, *delta_data, *result, *base;
-	unsigned long data_size, result_size, base_size;
-	z_stream stream;
-	int st;
+	void *delta_data, *result, *base;
+	unsigned long result_size, base_size;
 
 	if (left < 20)
 		die("truncated pack file");
@@ -1109,23 +1107,8 @@ static void *unpack_delta_entry(unsigned
 		die("failed to read delta-pack base object %s",
 		    sha1_to_hex(base_sha1));
 
-	data = base_sha1 + 20;
-	data_size = left - 20;
-	delta_data = xmalloc(delta_size);
-
-	memset(&stream, 0, sizeof(stream));
-
-	stream.next_in = data;
-	stream.avail_in = data_size;
-	stream.next_out = delta_data;
-	stream.avail_out = delta_size;
-
-	inflateInit(&stream);
-	st = inflate(&stream, Z_FINISH);
-	inflateEnd(&stream);
-	if ((st != Z_STREAM_END) || stream.total_out != delta_size)
-		die("delta data unpack failed");
-
+	delta_data = unpack_compressed_entry(base_sha1 + 20,
+			     delta_size, left - 20);
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
 			     &result_size);
-- 
1.4.2.g6580
