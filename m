From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 01/11] Fix RawParseUtils.endOfParagraph to work on all corner cases
Date: Sun, 10 Aug 2008 01:46:16 -0700
Message-ID: <1218357986-19671-2-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aS-0001pt-SZ
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbYHJIqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbYHJIqb
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:31 -0400
Received: from george.spearce.org ([209.20.77.23]:51261 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbYHJIq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 95B6B38379; Sun, 10 Aug 2008 08:46:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 06B5F38375;
	Sun, 10 Aug 2008 08:46:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91814>

We rely on this method to find the end of the "oneline" part of a
commit message, which is then used in displays like the History
view in EGit or in some tooltips.  However a number of weird commit
formats were throwing its parsing off, causing us to split the text
in a way we didn't expect (or want) to split it.

This change resolves the splitting by making sure we don't throw an
IndexOutOfBoundsException from RevCommit.getShortMessage due to the
end of the paragraph coming out before the beginning of it.  This
happened sometimes when the commit message was empty.

We also now properly trim the trailing LFs which end the paragraph,
as these were showing up sometimes as spaces at the end of a short
message string (as we do LF->space conversion prior to returning).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index f268ffc..dbc2e83 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -422,20 +422,21 @@ public final class RawParseUtils {
 	 * 
 	 * @param b
 	 *            buffer to scan.
-	 * @param ptr
+	 * @param start
 	 *            position in buffer to start the scan at. Most callers will
 	 *            want to pass the first position of the commit message (as
 	 *            found by {@link #commitMessage(byte[], int)}.
 	 * @return position of the LF at the end of the paragraph;
 	 *         <code>b.length</code> if no paragraph end could be located.
 	 */
-	public static final int endOfParagraph(final byte[] b, int ptr) {
+	public static final int endOfParagraph(final byte[] b, final int start) {
+		int ptr = start;
 		final int sz = b.length;
 		while (ptr < sz && b[ptr] != '\n')
 			ptr = next(b, ptr, '\n');
-		if (ptr < sz && b[ptr] == '\n')
-			return ptr - 1;
-		return sz;
+		while (0 < ptr && start < ptr && b[ptr - 1] == '\n')
+			ptr--;
+		return ptr;
 	}
 
 	private RawParseUtils() {
-- 
1.6.0.rc2.219.g1250ab
