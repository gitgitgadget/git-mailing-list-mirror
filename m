From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/3] Add methods to RawParseUtils for scanning backwards.
Date: Sun,  7 Jun 2009 22:19:10 +0200
Message-ID: <1244405951-21808-3-git-send-email-robin.rosenberg@dewire.com>
References: <y>
 <1244405951-21808-1-git-send-email-robin.rosenberg@dewire.com>
 <1244405951-21808-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 07 22:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDOqI-0003R9-3k
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbZFGUTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbZFGUTS
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:19:18 -0400
Received: from mail.dewire.com ([83.140.172.130]:18041 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbZFGUTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:19:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 27A9A146D038;
	Sun,  7 Jun 2009 22:19:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jMhTGPtrMaFC; Sun,  7 Jun 2009 22:19:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 2C8D1146D039;
	Sun,  7 Jun 2009 22:19:14 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1244405951-21808-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120997>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   84 +++++++++++++++++++-
 1 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 79ebe41..bdd6a11 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -321,6 +321,67 @@ public static final int nextLF(final byte[] b, int ptr, final char chrA) {
 	}
 
 	/**
+	 * Locate the first position before a given character.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position within buffer to start looking for chrA at.
+	 * @param chrA
+	 *            character to find.
+	 * @return new position just before chrA, -1 for not found
+	 */
+	public static final int prev(final byte[] b, int ptr, final char chrA) {
+		if (ptr == b.length)
+			--ptr;
+		while (ptr >= 0) {
+			if (b[ptr--] == chrA)
+				return ptr;
+		}
+		return ptr;
+	}
+
+	/**
+	 * Locate the first position before the previous LF.
+	 * <p>
+	 * This method stops on the first '\n' it finds.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position within buffer to start looking for LF at.
+	 * @return new position just before the first LF found, -1 for not found
+	 */
+	public static final int prevLF(final byte[] b, int ptr) {
+		return prev(b, ptr, '\n');
+	}
+
+	/**
+	 * Locate the previous position before either the given character or LF.
+	 * <p>
+	 * This method stops on the first match it finds from either chrA or '\n'.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position within buffer to start looking for chrA or LF at.
+	 * @param chrA
+	 *            character to find.
+	 * @return new position just before the first chrA or LF to be found, -1 for
+	 *         not found
+	 */
+	public static final int prevLF(final byte[] b, int ptr, final char chrA) {
+		if (ptr == b.length)
+			--ptr;
+		while (ptr >= 0) {
+			final byte c = b[ptr--];
+			if (c == chrA || c == '\n')
+				return ptr;
+		}
+		return ptr;
+	}
+
+	/**
 	 * Index the region between <code>[ptr, end)</code> to find line starts.
 	 * <p>
 	 * The returned list is 1 indexed. Index 0 contains
@@ -519,7 +580,28 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 	 *         after decoding the region through the specified character set.
 	 */
 	public static String decode(final byte[] buffer) {
-		return decode(Constants.CHARSET, buffer, 0, buffer.length);
+		return decode(buffer, 0, buffer.length);
+	}
+
+	/**
+	 * Decode a buffer under UTF-8, if possible.
+	 * 
+	 * If the byte stream cannot be decoded that way, the platform default is
+	 * tried and if that too fails, the fail-safe ISO-8859-1 encoding is tried.
+	 * 
+	 * @param buffer
+	 *            buffer to pull raw bytes from.
+	 * @param start
+	 *            start position in buffer
+	 * @param end
+	 *            one position past the last location within the buffer to take
+	 *            data from.
+	 * @return a string representation of the range <code>[start,end)</code>,
+	 *         after decoding the region through the specified character set.
+	 */
+	public static String decode(final byte[] buffer, final int start,
+			final int end) {
+		return decode(Constants.CHARSET, buffer, start, end);
 	}
 
 	/**
-- 
1.6.3.2.199.g7340d
