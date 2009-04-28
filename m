From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/13] Clear dead OffsetCache cells when clearing a reference
Date: Tue, 28 Apr 2009 14:12:20 -0700
Message-ID: <1240953146-12878-8-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
 <1240953146-12878-3-git-send-email-spearce@spearce.org>
 <1240953146-12878-4-git-send-email-spearce@spearce.org>
 <1240953146-12878-5-git-send-email-spearce@spearce.org>
 <1240953146-12878-6-git-send-email-spearce@spearce.org>
 <1240953146-12878-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyubd-0004xr-Gp
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbZD1VMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756541AbZD1VMi
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:38 -0400
Received: from george.spearce.org ([209.20.77.23]:58328 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521AbZD1VMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D86AD38267; Tue, 28 Apr 2009 21:12:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1EE3538222;
	Tue, 28 Apr 2009 21:12:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117812>

If we just cleared a Reference from the queue than there is a good
chance that there is a dead Entry cell in the hash table's bucket
for this position.  If we find one that matches we know we should
clear out that chain.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/OffsetCache.java      |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
index 170c5d2..12912d9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
@@ -418,8 +418,22 @@ private void gc() {
 			// skew the resource counters we maintain. Our canClear() check here
 			// provides a way to skip the redundant dequeues, if any.
 			//
-			if (r.canClear())
+			if (r.canClear()) {
 				clear(r);
+
+				boolean found = false;
+				final int s = slot(r.pack, r.position);
+				final Entry<V> e1 = table.get(s);
+				for (Entry<V> n = e1; n != null; n = n.next) {
+					if (n.ref == r) {
+						n.dead = true;
+						found = true;
+						break;
+					}
+				}
+				if (found)
+					table.compareAndSet(s, e1, clean(e1));
+			}
 		}
 	}
 
-- 
1.6.3.rc1.205.g37f8
