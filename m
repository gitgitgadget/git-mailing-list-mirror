From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v5 1/7] Add methods to RawParseUtils for scanning backwards.
Date: Wed, 10 Jun 2009 23:22:19 +0200
Message-ID: <1244668945-12622-2-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jun 10 23:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVFt-0007hX-HG
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 23:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbZFJVWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 17:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbZFJVWd
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 17:22:33 -0400
Received: from mail.dewire.com ([83.140.172.130]:3874 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbZFJVWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 17:22:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5A592147D5B1;
	Wed, 10 Jun 2009 23:22:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sbMtVFXIFMm; Wed, 10 Jun 2009 23:22:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id A1452147D5A0;
	Wed, 10 Jun 2009 23:22:27 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1244668945-12622-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121302>

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
