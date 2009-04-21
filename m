From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/10] Change empty tree test case to use a temporary repository
Date: Mon, 20 Apr 2009 18:21:04 -0700
Message-ID: <1240276872-17893-3-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
 <1240276872-17893-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hR-00021g-RZ
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbZDUBVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757477AbZDUBVT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:19 -0400
Received: from george.spearce.org ([209.20.77.23]:33016 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581AbZDUBVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 574CF38262; Tue, 21 Apr 2009 01:21:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0DF8B3821F;
	Tue, 21 Apr 2009 01:21:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117062>

This test case looks for a loose object of the empty tree, but our
stock test repository contains the empty tree in a pack file.  So
the only way we can ensure it will be written is if we write to an
empty repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
index 6a296be..b9e8d1d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -75,14 +75,13 @@ public void test002_WriteEmptyTree() throws IOException {
 		// open when we create it we won't write the object file out as a loose
 		// object (as it already exists in the pack).
 		//
-		db.closePacks();
-
-		final Tree t = new Tree(db);
-		t.accept(new WriteTree(trash, db), TreeEntry.MODIFIED_ONLY);
+		final Repository newdb = createNewEmptyRepo();
+		final Tree t = new Tree(newdb);
+		t.accept(new WriteTree(trash, newdb), TreeEntry.MODIFIED_ONLY);
 		assertEquals("4b825dc642cb6eb9a060e54bf8d69288fbee4904", t.getId()
 				.name());
-		final File o = new File(new File(new File(trash_git, "objects"), "4b"),
-				"825dc642cb6eb9a060e54bf8d69288fbee4904");
+		final File o = new File(new File(new File(newdb.getDirectory(),
+				"objects"), "4b"), "825dc642cb6eb9a060e54bf8d69288fbee4904");
 		assertTrue("Exists " + o, o.isFile());
 		assertTrue("Read-only " + o, !o.canWrite());
 	}
-- 
1.6.3.rc1.188.ga02b
