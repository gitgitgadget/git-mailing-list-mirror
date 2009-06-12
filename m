From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] UploadPack: Only recompute okToGiveUp() if bases changed
Date: Fri, 12 Jun 2009 16:00:19 -0700
Message-ID: <1244847619-7364-6-git-send-email-spearce@spearce.org>
References: <1244847619-7364-1-git-send-email-spearce@spearce.org>
 <1244847619-7364-2-git-send-email-spearce@spearce.org>
 <1244847619-7364-3-git-send-email-spearce@spearce.org>
 <1244847619-7364-4-git-send-email-spearce@spearce.org>
 <1244847619-7364-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:00:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFjo-000336-9O
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbZFLXAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755820AbZFLXAf
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:00:35 -0400
Received: from george.spearce.org ([209.20.77.23]:40058 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbZFLXA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:00:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B48FC381FE; Fri, 12 Jun 2009 23:00:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9C14B38215;
	Fri, 12 Jun 2009 23:00:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244847619-7364-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121465>

If we get a commit we don't recognize, but we haven't added any new
common bases to the commonBase set since the last time we ran the
okToGiveUp() algorithm, then there is no point in running it again,
as the result will not change.  Instead we cache the result in a
Boolean and just return the cached result until another common base
can be found and added to the set.

This helps to fix a performance problem when the client is 50,000
commits ahead of the server, and keeps sending them in "have"
lines, but the server doesn't recognize them.  On every "have"
line we will not have updated the common base, but we also aren't
yet satisfied that it is OK to give up negotiation.

Between the changes introduced by the parent commit and this commit,
negotiation in this case of 50,000 ahead now completes instantly,
instead of taking hours.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/UploadPack.java |   27 ++++++++++++++------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 5127dad..5c8df62 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -112,6 +112,9 @@
 	/** Objects on both sides, these don't have to be sent. */
 	private final List<RevObject> commonBase = new ArrayList<RevObject>();
 
+	/** null if {@link #commonBase} should be examined again. */
+	private Boolean okToGiveUp;
+
 	/** Marked on objects we sent in our advertisement list. */
 	private final RevFlag ADVERTISED;
 
@@ -396,15 +399,26 @@ private boolean matchHave(final ObjectId id) {
 			o.add(PEER_HAS);
 			if (o instanceof RevCommit)
 				((RevCommit) o).carry(PEER_HAS);
-			if (!o.has(COMMON)) {
-				o.add(COMMON);
-				commonBase.add(o);
-			}
+			addCommonBase(o);
 		}
 		return true;
 	}
 
+	private void addCommonBase(final RevObject o) {
+		if (!o.has(COMMON)) {
+			o.add(COMMON);
+			commonBase.add(o);
+			okToGiveUp = null;
+		}
+	}
+
 	private boolean okToGiveUp() throws PackProtocolException {
+		if (okToGiveUp == null)
+			okToGiveUp = Boolean.valueOf(okToGiveUpImp());
+		return okToGiveUp.booleanValue();
+	}
+
+	private boolean okToGiveUpImp() throws PackProtocolException {
 		if (commonBase.isEmpty())
 			return false;
 
@@ -429,10 +443,7 @@ private boolean wantSatisfied(final RevCommit want) throws IOException {
 			if (c == null)
 				break;
 			if (c.has(PEER_HAS)) {
-				if (!c.has(COMMON)) {
-					c.add(COMMON);
-					commonBase.add(c);
-				}
+				addCommonBase(c);
 				return true;
 			}
 		}
-- 
1.6.3.2.367.gf0de
