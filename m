From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/1] Honor repack.usedeltabaseoffset when fetching packs
Date: Fri,  1 May 2009 15:00:24 -0700
Message-ID: <1241215224-29374-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat May 02 00:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M00mx-0002nk-NX
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 00:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758160AbZEAWA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 18:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbZEAWA0
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 18:00:26 -0400
Received: from george.spearce.org ([209.20.77.23]:58617 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444AbZEAWAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 18:00:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3AB033807E; Fri,  1 May 2009 22:00:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 85D7E3807B;
	Fri,  1 May 2009 22:00:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118100>

If the local receiving repository has disabled the use of delta base
offset, for example to retain compatibility with older versions of
Git that predate OFS_DELTA, we shouldn't ask for ofs-delta support
when we obtain a pack from the remote server.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I just realized we don't honor this during fetch, and we should.

 .../jgit/transport/BasePackFetchConnection.java    |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index b75e0ef..b51ce23 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -49,6 +49,7 @@
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RepositoryConfig;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevCommitList;
 import org.spearce.jgit.revwalk.RevFlag;
@@ -126,10 +127,15 @@
 
 	private boolean includeTags;
 
+	private boolean allowOfsDelta;
+
 	BasePackFetchConnection(final PackTransport packTransport) {
 		super(packTransport);
+
+		final RepositoryConfig cfg = local.getConfig();
 		includeTags = transport.getTagOpt() != TagOpt.NO_TAGS;
 		thinPack = transport.isFetchThin();
+		allowOfsDelta = cfg.getBoolean("repack", "usedeltabaseoffset", true);
 
 		walk = new RevWalk(local);
 		reachableCommits = new RevCommitList<RevCommit>();
@@ -282,7 +288,8 @@ private String enableCapabilities() {
 		final StringBuilder line = new StringBuilder();
 		if (includeTags)
 			includeTags = wantCapability(line, OPTION_INCLUDE_TAG);
-		wantCapability(line, OPTION_OFS_DELTA);
+		if (allowOfsDelta)
+			wantCapability(line, OPTION_OFS_DELTA);
 		multiAck = wantCapability(line, OPTION_MULTI_ACK);
 		if (thinPack)
 			thinPack = wantCapability(line, OPTION_THIN_PACK);
-- 
1.6.3.rc3.212.g8c698
