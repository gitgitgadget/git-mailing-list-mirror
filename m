From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 19/19] Use Config cache for fetch and receive configuration parsing
Date: Sat, 25 Jul 2009 11:53:02 -0700
Message-ID: <1248547982-4003-20-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
 <1248547982-4003-8-git-send-email-spearce@spearce.org>
 <1248547982-4003-9-git-send-email-spearce@spearce.org>
 <1248547982-4003-10-git-send-email-spearce@spearce.org>
 <1248547982-4003-11-git-send-email-spearce@spearce.org>
 <1248547982-4003-12-git-send-email-spearce@spearce.org>
 <1248547982-4003-13-git-send-email-spearce@spearce.org>
 <1248547982-4003-14-git-send-email-spearce@spearce.org>
 <1248547982-4003-15-git-send-email-spearce@spearce.org>
 <1248547982-4003-16-git-send-email-spearce@spearce.org>
 <1248547982-4003-17-git-send-email-spearce@spearce.org>
 <1248547982-4003-18-git-send-email-spearce@spearce.org>
 <1248547982-4003-19-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmOD-0002ZF-8N
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbZGYSxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZGYSxp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:45 -0400
Received: from george.spearce.org ([209.20.77.23]:35593 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZGYSxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2B519381FD; Sat, 25 Jul 2009 18:53:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E4A6138262;
	Sat, 25 Jul 2009 18:53:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-19-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124050>

Rather than parsing the fields on each transfer we now parse the
fields once and cache them in the Config object, under a unique
section key for the fetch or receive direction.  This permits the
keys to be scanned only once, rather than per-request.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BasePackFetchConnection.java    |   21 ++++++++-
 .../org/spearce/jgit/transport/ReceivePack.java    |   45 ++++++++++++++++----
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 7163e02..dea6181 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -46,12 +46,13 @@
 
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Config;
 import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
-import org.spearce.jgit.lib.RepositoryConfig;
+import org.spearce.jgit.lib.Config.SectionParser;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevCommitList;
 import org.spearce.jgit.revwalk.RevFlag;
@@ -146,10 +147,10 @@
 	BasePackFetchConnection(final PackTransport packTransport) {
 		super(packTransport);
 
-		final RepositoryConfig cfg = local.getConfig();
+		final FetchConfig cfg = local.getConfig().get(FetchConfig.KEY);
 		includeTags = transport.getTagOpt() != TagOpt.NO_TAGS;
 		thinPack = transport.isFetchThin();
-		allowOfsDelta = cfg.getBoolean("repack", "usedeltabaseoffset", true);
+		allowOfsDelta = cfg.allowOfsDelta;
 
 		walk = new RevWalk(local);
 		reachableCommits = new RevCommitList<RevCommit>();
@@ -162,6 +163,20 @@
 		walk.carry(ADVERTISED);
 	}
 
+	private static class FetchConfig {
+		static final SectionParser<FetchConfig> KEY = new SectionParser<FetchConfig>() {
+			public FetchConfig parse(final Config cfg) {
+				return new FetchConfig(cfg);
+			}
+		};
+
+		final boolean allowOfsDelta;
+
+		FetchConfig(final Config c) {
+			allowOfsDelta = c.getBoolean("repack", "usedeltabaseoffset", true);
+		}
+	}
+
 	public final void fetch(final ProgressMonitor monitor,
 			final Collection<Ref> want, final Set<ObjectId> have)
 			throws TransportException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 38f0b5c..ca4a7ec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -54,6 +54,7 @@
 
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.PackProtocolException;
+import org.spearce.jgit.lib.Config;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.NullProgressMonitor;
 import org.spearce.jgit.lib.ObjectId;
@@ -62,7 +63,7 @@
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
-import org.spearce.jgit.lib.RepositoryConfig;
+import org.spearce.jgit.lib.Config.SectionParser;
 import org.spearce.jgit.revwalk.ObjectWalk;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevFlag;
@@ -158,17 +159,45 @@ public ReceivePack(final Repository into) {
 		db = into;
 		walk = new RevWalk(db);
 
-		final RepositoryConfig cfg = db.getConfig();
-		checkReceivedObjects = cfg.getBoolean("receive", "fsckobjects", false);
-		allowCreates = true;
-		allowDeletes = !cfg.getBoolean("receive", "denydeletes", false);
-		allowNonFastForwards = !cfg.getBoolean("receive",
-				"denynonfastforwards", false);
-		allowOfsDelta = cfg.getBoolean("repack", "usedeltabaseoffset", true);
+		final ReceiveConfig cfg = db.getConfig().get(ReceiveConfig.KEY);
+		checkReceivedObjects = cfg.checkReceivedObjects;
+		allowCreates = cfg.allowCreates;
+		allowDeletes = cfg.allowDeletes;
+		allowNonFastForwards = cfg.allowNonFastForwards;
+		allowOfsDelta = cfg.allowOfsDelta;
 		preReceive = PreReceiveHook.NULL;
 		postReceive = PostReceiveHook.NULL;
 	}
 
+	private static class ReceiveConfig {
+		static final SectionParser<ReceiveConfig> KEY = new SectionParser<ReceiveConfig>() {
+			public ReceiveConfig parse(final Config cfg) {
+				return new ReceiveConfig(cfg);
+			}
+		};
+
+		final boolean checkReceivedObjects;
+
+		final boolean allowCreates;
+
+		final boolean allowDeletes;
+
+		final boolean allowNonFastForwards;
+
+		final boolean allowOfsDelta;
+
+		ReceiveConfig(final Config config) {
+			checkReceivedObjects = config.getBoolean("receive", "fsckobjects",
+					false);
+			allowCreates = true;
+			allowDeletes = !config.getBoolean("receive", "denydeletes", false);
+			allowNonFastForwards = !config.getBoolean("receive",
+					"denynonfastforwards", false);
+			allowOfsDelta = config.getBoolean("repack", "usedeltabaseoffset",
+					true);
+		}
+	}
+
 	/** @return the repository this receive completes into. */
 	public final Repository getRepository() {
 		return db;
-- 
1.6.4.rc2.216.g769fa
