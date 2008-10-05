From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/6] Add a method to get refs by object Id
Date: Mon,  6 Oct 2008 01:36:39 +0200
Message-ID: <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 01:39:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdCD-0003Jr-MP
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 01:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbYJEXiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 19:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYJEXh4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 19:37:56 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:43656 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYJEXhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 19:37:54 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 1ED3437F8A; Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id CE44137E56; Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id B098E37E47;
	Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97553>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   28 ++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index dfce1b8..3fc5236 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -47,6 +47,7 @@
 import java.io.IOException;
 import java.util.ArrayList;
 import java.util.Collection;
+import java.util.Collections;
 import java.util.HashMap;
 import java.util.LinkedList;
 import java.util.List;
@@ -939,6 +940,33 @@ public String getBranch() throws IOException {
 	}
 
 	/**
+	 * @return a map with all objects referenced by a peeled ref.
+	 */
+	public Map<AnyObjectId, List<Ref>> getAllRefsByPeeledObjectId() {
+		Map<String, Ref> allRefs = getAllRefs();
+		HashMap<AnyObjectId, List<Ref>> ret = new HashMap<AnyObjectId, List<Ref>>(allRefs.size());
+		for (Map.Entry<String,Ref> e : allRefs.entrySet()) {
+			Ref ref = e.getValue();
+			AnyObjectId target = ref.getPeeledObjectId();
+			if (target == null)
+				target = ref.getObjectId();
+			List<Ref> list = ret.get(target);
+			if (list == null) {
+				list = Collections.singletonList(ref);
+			} else {
+				if (list.size() == 1) {
+					ArrayList<Ref> list2 = new ArrayList<Ref>(2);
+					list2.add(list.get(0));
+					list = list2;
+				}
+				list.add(ref);
+			}
+			ret.put(target, list);
+		}
+		return ret;
+	}
+
+	/**
 	 * @return true if HEAD points to a StGit patch.
 	 */
 	public boolean isStGitMode() {
-- 
1.6.0.1.310.gf789d0.dirty
