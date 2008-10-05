From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/6] Peel annotated tags when getting all refs
Date: Mon,  6 Oct 2008 01:36:38 +0200
Message-ID: <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 01:39:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdCE-0003Jr-EM
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 01:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbYJEXiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 19:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbYJEXh6
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 19:37:58 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:39484 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbYJEXhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 19:37:54 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id E8D3A37F2D; Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id A8CB237F2D; Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 89AE037E47;
	Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97548>

For packed refs we got this automatically from packed-refs,
but for loose tags we have to follow the tags and get the leaf
object in order to comply with the documentation.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   24 ++++++++++++++++++-
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 5a1b85f..1ee70d9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -271,7 +271,16 @@ private void readOneLooseRef(final Map<String, Ref> avail,
 					return;
 				}
 
-				ref = new Ref(Ref.Storage.LOOSE, origName, refName, id);
+				Object tt = db.mapObject(id, refName);
+				if (tt != null && tt instanceof Tag) {
+					Tag t = (Tag)tt;
+					while (t != null && t.getType().equals(Constants.TYPE_TAG))
+						t = db.mapTag(t.getTag(), t.getObjId());
+					if (t != null)
+						ref = new Ref(Ref.Storage.LOOSE, origName, refName, id, t.getObjId());
+				} else
+					ref = new Ref(Ref.Storage.LOOSE, origName, refName, id);
+
 				looseRefs.put(ref.getName(), ref);
 				looseRefsMTime.put(ref.getName(), ent.lastModified());
 				avail.put(ref.getName(), ref);
@@ -363,7 +372,18 @@ private Ref readRefBasic(final String origName, final String name, final int dep
 			throw new IOException("Not a ref: " + name + ": " + line);
 		}
 
-		ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
+		Object tt = db.mapObject(id, origName);
+		if (tt != null && tt instanceof Tag) {
+			Tag t = (Tag)tt;
+			while (t != null && t.getType().equals(Constants.TYPE_TAG))
+				t = db.mapTag(t.getTag(), t.getObjId());
+			if (t != null)
+				ref = new Ref(Ref.Storage.LOOSE, origName, name, id, t.getObjId());
+		} else
+			ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
+
+		looseRefs.put(origName, ref);
+		ref = new Ref(Ref.Storage.LOOSE, origName, id);
 		looseRefs.put(name, ref);
 		looseRefsMTime.put(name, mtime);
 		return ref;
-- 
1.6.0.1.310.gf789d0.dirty
