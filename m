From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Committer, author and tagger time should not be parsed as 32 bit signed int
Date: Wed, 17 Dec 2008 23:32:52 +0100
Message-ID: <1229553172-2038-1-git-send-email-robin.rosenberg@dewire.com>
References: <200812172328.07371.robin.rosenberg.lists@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 17 23:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4y6-000501-Du
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbYLQWcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYLQWcz
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:32:55 -0500
Received: from mail.dewire.com ([83.140.172.130]:14248 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYLQWcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:32:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3A9C3147E592;
	Wed, 17 Dec 2008 23:32:53 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A75derQs7p05; Wed, 17 Dec 2008 23:32:52 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 59CAA147B7F9;
	Wed, 17 Dec 2008 23:32:52 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <200812172328.07371.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103404>

If not dates past 2038 will be parsed the wrong way when
parsed into a RevCommit or RevTag object.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   58 +++++++++++++++++++-
 1 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 55a3001..74fe506 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -135,7 +135,7 @@ public static int formatBase10(final byte[] b, int o, int value) {
 	}
 
 	/**
-	 * Parse a base 10 numeric from a sequence of ASCII digits.
+	 * Parse a base 10 numeric from a sequence of ASCII digits into an int.
 	 * <p>
 	 * Digit sequences can begin with an optional run of spaces before the
 	 * sequence, and may start with a '+' or a '-' to indicate sign position.
@@ -189,6 +189,60 @@ public static final int parseBase10(final byte[] b, int ptr,
 	}
 
 	/**
+	 * Parse a base 10 numeric from a sequence of ASCII digits into a long.
+	 * <p>
+	 * Digit sequences can begin with an optional run of spaces before the
+	 * sequence, and may start with a '+' or a '-' to indicate sign position.
+	 * Any other characters will cause the method to stop and return the current
+	 * result to the caller.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position within buffer to start parsing digits at.
+	 * @param ptrResult
+	 *            optional location to return the new ptr value through. If null
+	 *            the ptr value will be discarded.
+	 * @return the value at this location; 0 if the location is not a valid
+	 *         numeric.
+	 */
+	public static final long parseLongBase10(final byte[] b, int ptr,
+			final MutableInteger ptrResult) {
+		long r = 0;
+		int sign = 0;
+		try {
+			final int sz = b.length;
+			while (ptr < sz && b[ptr] == ' ')
+				ptr++;
+			if (ptr >= sz)
+				return 0;
+
+			switch (b[ptr]) {
+			case '-':
+				sign = -1;
+				ptr++;
+				break;
+			case '+':
+				ptr++;
+				break;
+			}
+
+			while (ptr < sz) {
+				final byte v = digits[b[ptr]];
+				if (v < 0)
+					break;
+				r = (r * 10) + v;
+				ptr++;
+			}
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// Not a valid digit.
+		}
+		if (ptrResult != null)
+			ptrResult.value = ptr;
+		return sign < 0 ? -r : r;
+	}
+
+	/**
 	 * Parse a Git style timezone string.
 	 * <p>
 	 * The sequence "-0315" will be parsed as the numeric value -195, as the
@@ -414,7 +468,7 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 		final String email = decode(cs, raw, emailB, emailE - 1);
 
 		final MutableInteger ptrout = new MutableInteger();
-		final int when = parseBase10(raw, emailE + 1, ptrout);
+		final long when = parseLongBase10(raw, emailE + 1, ptrout);
 		final int tz = parseTimeZoneOffset(raw, ptrout.value);
 
 		return new PersonIdent(name, email, when * 1000L, tz);
-- 
1.6.0.3.640.g6331a
