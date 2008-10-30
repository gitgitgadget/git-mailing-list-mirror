From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/3] Don't permit '.' or '..' in tree entries
Date: Thu, 30 Oct 2008 10:46:25 -0700
Message-ID: <1225388785-26818-4-git-send-email-spearce@spearce.org>
References: <1225388785-26818-1-git-send-email-spearce@spearce.org>
 <1225388785-26818-2-git-send-email-spearce@spearce.org>
 <1225388785-26818-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:48:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvbcu-0002Uc-EO
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbYJ3Rqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbYJ3Rqf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:46:35 -0400
Received: from george.spearce.org ([209.20.77.23]:50789 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbYJ3Rqa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:46:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0BC1638368; Thu, 30 Oct 2008 17:46:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BB52238260;
	Thu, 30 Oct 2008 17:46:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.3.756.gb776d
In-Reply-To: <1225388785-26818-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99510>

A Git tree must not have '.' or '..' within the structure as these
names are reserved in every directory by the client operating system.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/ObjectCheckerTest.java    |   31 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |    7 ++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java
index fa37fb5..7befde8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java
@@ -980,6 +980,13 @@ public void testValidTree5() throws CorruptObjectException {
 		checker.checkTree(data);
 	}
 
+	public void testValidTree6() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 .a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
 	public void testValidTreeSorting1() throws CorruptObjectException {
 		final StringBuilder b = new StringBuilder();
 		entry(b, "100644 fooaaa");
@@ -1166,6 +1173,30 @@ public void testInvalidTreeNameIsEmpty() {
 		}
 	}
 
+	public void testInvalidTreeNameIsDot() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 .");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid name '.'", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeNameIsDotDot() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 ..");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid name '..'", e.getMessage());
+		}
+	}
+
 	public void testInvalidTreeTruncatedInName() {
 		final StringBuilder b = new StringBuilder();
 		b.append("100644 b");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
index d403119..b303d6f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
@@ -318,6 +318,13 @@ public void checkTree(final byte[] raw) throws CorruptObjectException {
 			}
 			if (thisNameB + 1 == ptr)
 				throw new CorruptObjectException("zero length name");
+			if (raw[thisNameB] == '.') {
+				final int nameLen = (ptr - 1) - thisNameB;
+				if (nameLen == 1)
+					throw new CorruptObjectException("invalid name '.'");
+				if (nameLen == 2 && raw[thisNameB + 1] == '.')
+					throw new CorruptObjectException("invalid name '..'");
+			}
 			if (duplicateName(raw, thisNameB, ptr - 1))
 				throw new CorruptObjectException("duplicate entry names");
 
-- 
1.6.0.3.756.gb776d
