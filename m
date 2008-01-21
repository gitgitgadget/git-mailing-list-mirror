From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Document the hairy gfi_unpack_entry part of fast-import
Date: Sun, 20 Jan 2008 23:37:01 -0500
Message-ID: <20080121043701.GB27521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 05:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGoPi-0000aF-Du
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 05:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940AbYAUEhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 23:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbYAUEhG
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 23:37:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56737 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756899AbYAUEhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 23:37:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JGoOw-0006qK-7Y; Sun, 20 Jan 2008 23:36:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6986F20FBAE; Sun, 20 Jan 2008 23:37:01 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71216>

Junio pointed out this part of fast-import wasn't very clear on
initial read, and it took some time for someone who was new to
fast-import's "dirty little tricks" to understand how this was
even working.  So a little bit of commentary in the proper place
may help future readers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f6872fe..a523b17 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1125,6 +1125,24 @@ static int store_object(
 	return 0;
 }
 
+/* All calls must be guarded by find_object() or find_mark() to
+ * ensure the 'struct object_entry' passed was written by this
+ * process instance.  We unpack the entry by the offset, avoiding
+ * the need for the corresponding .idx file.  This unpacking rule
+ * works because we only use OBJ_REF_DELTA within the packfiles
+ * created by fast-import.
+ *
+ * oe must not be NULL.  Such an oe usually comes from giving
+ * an unknown SHA-1 to find_object() or an undefined mark to
+ * find_mark().  Callers must test for this condition and use
+ * the standard read_sha1_file() when it happens.
+ *
+ * oe->pack_id must not be MAX_PACK_ID.  Such an oe is usually from
+ * find_mark(), where the mark was reloaded from an existing marks
+ * file and is referencing an object that this fast-import process
+ * instance did not write out to a packfile.  Callers must test for
+ * this condition and use read_sha1_file() instead.
+ */
 static void *gfi_unpack_entry(
 	struct object_entry *oe,
 	unsigned long *sizep)
@@ -1132,7 +1150,22 @@ static void *gfi_unpack_entry(
 	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
 	if (p == pack_data && p->pack_size < (pack_size + 20)) {
+		/* The object is stored in the packfile we are writing to
+		 * and we have modified it since the last time we scanned
+		 * back to read a previously written object.  If an old
+		 * window covered [p->pack_size, p->pack_size + 20) its
+		 * data is stale and is not valid.  Closing all windows
+		 * and updating the packfile length ensures we can read
+		 * the newly written data.
+		 */
 		close_pack_windows(p);
+
+		/* We have to offer 20 bytes additional on the end of
+		 * the packfile as the core unpacker code assumes the
+		 * footer is present at the file end and must promise
+		 * at least 20 bytes within any window it maps.  But
+		 * we don't actually create the footer here.
+		 */
 		p->pack_size = pack_size + 20;
 	}
 	return unpack_entry(p, oe->offset, &type, sizep);
-- 
1.5.4.rc4.1109.g30426
