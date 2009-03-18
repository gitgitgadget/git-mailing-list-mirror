From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/12] Test that RevFilter.MERGE_BASE cannot use a TreeFilter
Date: Tue, 17 Mar 2009 18:40:43 -0700
Message-ID: <1237340451-31562-5-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpO-00052N-6E
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669AbZCRBlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756699AbZCRBlU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:20 -0400
Received: from george.spearce.org ([209.20.77.23]:56664 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623AbZCRBlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:18 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6862338221; Wed, 18 Mar 2009 01:41:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id EF4BD38222;
	Wed, 18 Mar 2009 01:40:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113557>

Only TreeFilter.ALL is permitted right now when computing a merge
base, as the generator pipeline doesn't support parent rewrites
during a merge base computation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/revwalk/RevWalkMergeBaseTest.java |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
index fc1a37c..c8fdf5e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.revwalk;
 
 import org.spearce.jgit.revwalk.filter.RevFilter;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 public class RevWalkMergeBaseTest extends RevWalkTestCase {
 	public void testNone() throws Exception {
@@ -50,6 +51,22 @@ public void testNone() throws Exception {
 		assertNull(rw.next());
 	}
 
+	public void testDisallowTreeFilter() throws Exception {
+		final RevCommit c1 = commit();
+		final RevCommit c2 = commit();
+
+		rw.setRevFilter(RevFilter.MERGE_BASE);
+		rw.setTreeFilter(TreeFilter.ANY_DIFF);
+		markStart(c1);
+		markStart(c2);
+		try {
+			assertNull(rw.next());
+			fail("did not throw IllegalStateException");
+		} catch (IllegalStateException ise) {
+			// expected result
+		}
+	}
+
 	public void testSimple() throws Exception {
 		final RevCommit a = commit();
 		final RevCommit b = commit(a);
-- 
1.6.2.1.286.g8173
