From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/7 v3] Add a method to get refs by object Id
Date: Sat, 15 Nov 2008 00:24:59 +0100
Message-ID: <1226705099-18066-5-git-send-email-robin.rosenberg@dewire.com>
References: <20081111183248.GR2932@spearce.org>
 <1226705099-18066-1-git-send-email-robin.rosenberg@dewire.com>
 <1226705099-18066-2-git-send-email-robin.rosenberg@dewire.com>
 <1226705099-18066-3-git-send-email-robin.rosenberg@dewire.com>
 <1226705099-18066-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Nov 15 00:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L183h-0004bR-2D
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYKNXZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYKNXZR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:25:17 -0500
Received: from mail.dewire.com ([83.140.172.130]:13641 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbYKNXZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 18:25:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4B365147D0FE;
	Sat, 15 Nov 2008 00:25:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fBUhVR-mdqR; Sat, 15 Nov 2008 00:25:07 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CDC1D147D4E9;
	Sat, 15 Nov 2008 00:25:00 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a.dirty
In-Reply-To: <1226705099-18066-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101030>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   30 ++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 4d6e6fd..5088150 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -47,10 +47,13 @@
 import java.io.IOException;
 import java.util.ArrayList;
 import java.util.Collection;
+import java.util.Collections;
 import java.util.HashMap;
+import java.util.HashSet;
 import java.util.LinkedList;
 import java.util.List;
 import java.util.Map;
+import java.util.Set;
 import java.util.Vector;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
@@ -952,6 +955,33 @@ public Ref peel(final Ref ref) {
 	}
 
 	/**
+	 * @return a map with all objects referenced by a peeled ref.
+	 */
+	public Map<AnyObjectId, Set<Ref>> getAllRefsByPeeledObjectId() {
+		Map<String, Ref> allRefs = getAllRefs();
+		Map<AnyObjectId, Set<Ref>> ret = new HashMap<AnyObjectId, Set<Ref>>(allRefs.size());
+		for (Ref ref : allRefs.values()) {
+			if (!ref.isPeeled())
+				ref = peel(ref);
+			AnyObjectId target = ref.getPeeledObjectId();
+			if (target == null)
+				target = ref.getObjectId();
+			// We assume most Sets here are singletons
+			Set<Ref> oset = ret.put(target, Collections.singleton(ref));
+			if (oset != null) {
+				// that was not the case (rare)
+				if (oset.size() == 1) {
+					// Was a read-only singleton, we must copy to a new Set
+					oset = new HashSet<Ref>(oset);
+				}
+				ret.put(target, oset);
+				oset.add(ref);
+			}
+		}
+		return ret;
+	}
+
+	/**
 	 * @return true if HEAD points to a StGit patch.
 	 */
 	public boolean isStGitMode() {
-- 
1.6.0.3.640.g6331a.dirty
