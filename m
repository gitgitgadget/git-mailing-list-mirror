From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Enable ofs-delta during send-pack/receive-pack protocol
Date: Fri,  1 May 2009 14:56:08 -0700
Message-ID: <1241214968-28743-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 01 23:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M00iS-0000xr-0c
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 23:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbZEAV4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 17:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZEAV4K
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 17:56:10 -0400
Received: from george.spearce.org ([209.20.77.23]:58610 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZEAV4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 17:56:09 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6D2E23807E; Fri,  1 May 2009 21:56:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 861263807B;
	Fri,  1 May 2009 21:56:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118099>

In "allow OFS_DELTA objects during a push" Nicolas Pitre taught C
git how to enable OBJ_OFS_DELTA usage in a pack file created on a
client, to be processed by receive-pack on the server side.

This creates a smaller pack file during transfer, as the OFS_DELTA
format uses less per-delta header space than the classical REF_DELTA.
If the receiving peer is going to just store the pack to disk,
this would also produce a smaller on-disk pack file.

In his change, Nico tied the server side enablement of the capability
to the server's repack.usedeltabaseoffset setting, which can be
set to false in a repository that needs to service direct access
clients that are old to understand OFS_DELTA.  We do the same here
in JGit to match semantics.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BasePackPushConnection.java     |    6 ++++++
 .../org/spearce/jgit/transport/ReceivePack.java    |    9 +++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 07e8cb9..1117109 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -78,12 +78,16 @@
 
 	static final String CAPABILITY_DELETE_REFS = "delete-refs";
 
+	static final String CAPABILITY_OFS_DELTA = "ofs-delta";
+
 	private final boolean thinPack;
 
 	private boolean capableDeleteRefs;
 
 	private boolean capableReport;
 
+	private boolean capableOfsDelta;
+
 	private boolean sentCommand;
 
 	private boolean writePack;
@@ -180,6 +184,7 @@ private String enableCapabilities() {
 		final StringBuilder line = new StringBuilder();
 		capableReport = wantCapability(line, CAPABILITY_REPORT_STATUS);
 		capableDeleteRefs = wantCapability(line, CAPABILITY_DELETE_REFS);
+		capableOfsDelta = wantCapability(line, CAPABILITY_OFS_DELTA);
 		if (line.length() > 0)
 			line.setCharAt(0, '\0');
 		return line.toString();
@@ -202,6 +207,7 @@ private void writePack(final Map<String, RemoteRefUpdate> refUpdates,
 		}
 
 		writer.setThin(thinPack);
+		writer.setDeltaBaseAsOffset(capableOfsDelta);
 		writer.preparePack(newObjects, remoteObjects);
 		writer.writePack(out);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 89ddafe..f75a01a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -77,6 +77,8 @@
 
 	static final String CAPABILITY_DELETE_REFS = BasePackPushConnection.CAPABILITY_DELETE_REFS;
 
+	static final String CAPABILITY_OFS_DELTA = BasePackPushConnection.CAPABILITY_OFS_DELTA;
+
 	/** Database we write the stored objects into. */
 	private final Repository db;
 
@@ -95,6 +97,8 @@
 	/** Should an incoming transfer permit non-fast-forward requests? */
 	private boolean allowNonFastForwards;
 
+	private boolean allowOfsDelta;
+
 	/** Identity to record action as within the reflog. */
 	private PersonIdent refLogIdent;
 
@@ -145,6 +149,7 @@ public ReceivePack(final Repository into) {
 		allowDeletes = !cfg.getBoolean("receive", "denydeletes", false);
 		allowNonFastForwards = !cfg.getBoolean("receive",
 				"denynonfastforwards", false);
+		allowOfsDelta = cfg.getBoolean("repack", "usedeltabaseoffset", true);
 		preReceive = PreReceiveHook.NULL;
 		postReceive = PostReceiveHook.NULL;
 	}
@@ -455,6 +460,10 @@ private void sendAdvertisedRefs() throws IOException {
 			m.append(CAPABILITY_DELETE_REFS);
 			m.append(' ');
 			m.append(CAPABILITY_REPORT_STATUS);
+			if (allowOfsDelta) {
+				m.append(' ');
+				m.append(CAPABILITY_OFS_DELTA);
+			}
 			m.append(' ');
 			writeAdvertisedRef(m);
 		}
-- 
1.6.3.rc3.212.g8c698
