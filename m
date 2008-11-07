From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/7] Add a method to get refs by object Id
Date: Fri,  7 Nov 2008 23:07:42 +0100
Message-ID: <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZWN-0008MC-3E
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbYKGWIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYKGWIB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:08:01 -0500
Received: from mail.dewire.com ([83.140.172.130]:11966 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbYKGWHz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 178AD147EAE3;
	Fri,  7 Nov 2008 23:07:53 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGmC68iEV-16; Fri,  7 Nov 2008 23:07:51 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6C5E31456A36;
	Fri,  7 Nov 2008 23:07:46 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
In-Reply-To: <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100346>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   34 ++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 4d6e6fd..82a7454 100644
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
@@ -952,6 +955,37 @@ public Ref peel(final Ref ref) {
 	}
 
 	/**
+	 * @return a map with all objects referenced by a peeled ref.
+	 */
+	public Map<AnyObjectId, Set<Ref>> getAllRefsByPeeledObjectId() {
+		Map<String, Ref> allRefs = getAllRefs();
+		Map<AnyObjectId, Set<Ref>> ret = new HashMap<AnyObjectId, Set<Ref>>(allRefs.size());
+		for (Ref ref : allRefs.values()) {
+			if (ref == null)
+				continue;
+			if (!ref.isPeeled()) {
+				ref = peel(ref);
+				allRefs.put(ref.getOrigName(), ref);
+			}
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
1.6.0.3.578.g6a50
