From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/2] Support extracting emails from Signed-off-by lines
Date: Wed, 24 Jun 2009 10:30:29 -0700
Message-ID: <20090624173029.GF11191@spearce.org>
References: <1245813109-29763-1-git-send-email-spearce@spearce.org> <1245813109-29763-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJWIw-0003Ld-F2
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 19:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbZFXRa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 13:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZFXRa1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 13:30:27 -0400
Received: from george.spearce.org ([209.20.77.23]:51834 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbZFXRa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 13:30:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5D60A381FD; Wed, 24 Jun 2009 17:30:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1245813109-29763-2-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122147>

A typical Signed-off-by footer line can be seen below in this
message, and it clearly contains an email address (or at least
a user@domain sort of reference to the identity).  This identity
may need to be parsed out of a footer line by application code,
to match the Signed-off-by line back to the author or the committer
of the commit, or to some external datastore.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/FooterLineTest.java   |   40 ++++++++++++++++++++
 .../src/org/spearce/jgit/revwalk/FooterLine.java   |   24 ++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java
index 342346f..431c170 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java
@@ -105,6 +105,7 @@ public void testSignedOffBy_OneUserNoLF() {
 		f = footers.get(0);
 		assertEquals("Signed-off-by", f.getKey());
 		assertEquals("A. U. Thor <a@example.com>", f.getValue());
+		assertEquals("a@example.com", f.getEmailAddress());
 	}
 
 	public void testSignedOffBy_OneUserWithLF() {
@@ -119,6 +120,7 @@ public void testSignedOffBy_OneUserWithLF() {
 		f = footers.get(0);
 		assertEquals("Signed-off-by", f.getKey());
 		assertEquals("A. U. Thor <a@example.com>", f.getValue());
+		assertEquals("a@example.com", f.getEmailAddress());
 	}
 
 	public void testSignedOffBy_IgnoreWhitespace() {
@@ -136,6 +138,7 @@ public void testSignedOffBy_IgnoreWhitespace() {
 		f = footers.get(0);
 		assertEquals("Signed-off-by", f.getKey());
 		assertEquals("A. U. Thor <a@example.com>  ", f.getValue());
+		assertEquals("a@example.com", f.getEmailAddress());
 	}
 
 	public void testEmptyValueNoLF() {
@@ -150,6 +153,7 @@ public void testEmptyValueNoLF() {
 		f = footers.get(0);
 		assertEquals("Signed-off-by", f.getKey());
 		assertEquals("", f.getValue());
+		assertNull(f.getEmailAddress());
 	}
 
 	public void testEmptyValueWithLF() {
@@ -164,6 +168,7 @@ public void testEmptyValueWithLF() {
 		f = footers.get(0);
 		assertEquals("Signed-off-by", f.getKey());
 		assertEquals("", f.getValue());
+		assertNull(f.getEmailAddress());
 	}
 
 	public void testShortKey() {
@@ -178,6 +183,37 @@ public void testShortKey() {
 		f = footers.get(0);
 		assertEquals("K", f.getKey());
 		assertEquals("V", f.getValue());
+		assertNull(f.getEmailAddress());
+	}
+
+	public void testNonDelimtedEmail() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "Acked-by: re@example.com\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Acked-by", f.getKey());
+		assertEquals("re@example.com", f.getValue());
+		assertEquals("re@example.com", f.getEmailAddress());
+	}
+
+	public void testNotEmail() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "Acked-by: Main Tain Er\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Acked-by", f.getKey());
+		assertEquals("Main Tain Er", f.getValue());
+		assertNull(f.getEmailAddress());
 	}
 
 	public void testSignedOffBy_ManyUsers() {
@@ -197,18 +233,22 @@ public void testSignedOffBy_ManyUsers() {
 		f = footers.get(0);
 		assertEquals("Signed-off-by", f.getKey());
 		assertEquals("A. U. Thor <a@example.com>", f.getValue());
+		assertEquals("a@example.com", f.getEmailAddress());
 
 		f = footers.get(1);
 		assertEquals("CC", f.getKey());
 		assertEquals("<some.mailing.list@example.com>", f.getValue());
+		assertEquals("some.mailing.list@example.com", f.getEmailAddress());
 
 		f = footers.get(2);
 		assertEquals("Acked-by", f.getKey());
 		assertEquals("Some Reviewer <sr@example.com>", f.getValue());
+		assertEquals("sr@example.com", f.getEmailAddress());
 
 		f = footers.get(3);
 		assertEquals("Signed-off-by", f.getKey());
 		assertEquals("Main Tain Er <mte@example.com>", f.getValue());
+		assertEquals("mte@example.com", f.getEmailAddress());
 	}
 
 	public void testSignedOffBy_SkipNonFooter() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java
index 1fef47d..b28f52d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java
@@ -114,6 +114,30 @@ public String getValue() {
 		return RawParseUtils.decode(enc, buffer, valStart, valEnd);
 	}
 
+	/**
+	 * Extract the email address (if present) from the footer.
+	 * <p>
+	 * If there is an email address looking string inside of angle brackets
+	 * (e.g. "<a@b>"), the return value is the part extracted from inside the
+	 * brackets. If no brackets are found, then {@link #getValue()} is returned
+	 * if the value contains an '@' sign. Otherwise, null.
+	 *
+	 * @return email address appearing in the value of this footer, or null.
+	 */
+	public String getEmailAddress() {
+		final int lt = RawParseUtils.nextLF(buffer, valStart, '<');
+		if (valEnd <= lt) {
+			final int at = RawParseUtils.nextLF(buffer, valStart, '@');
+			if (valStart < at && at < valEnd)
+				return getValue();
+			return null;
+		}
+		final int gt = RawParseUtils.nextLF(buffer, lt, '>');
+		if (valEnd < gt)
+			return null;
+		return RawParseUtils.decode(enc, buffer, lt, gt - 1);
+	}
+
 	@Override
 	public String toString() {
 		return getKey() + ": " + getValue();
-- 
1.6.3.3.420.gd4b46
