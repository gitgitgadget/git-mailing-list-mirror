From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Fix missing packed-refs entries during ref lookup/enumeration
Date: Sat, 26 Jul 2008 21:33:40 -0700
Message-ID: <1217133221-15513-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 06:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMxyW-0002cb-NQ
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 06:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbYG0Edo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 00:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbYG0Edn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 00:33:43 -0400
Received: from george.spearce.org ([209.20.77.23]:51349 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYG0Edn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 00:33:43 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E24A73841A; Sun, 27 Jul 2008 04:33:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 20FC1383A3;
	Sun, 27 Jul 2008 04:33:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90307>

Some codepaths in RefDatabase allowed the caller to lookup a ref
without making sure the packed-refs file was loaded into memory.
This caused refs which were only packed to appear to not exist,
which meant fetch would still try to fetch something we already
have had for quite some time.

This resolves the issue I was seeing where `jgit fetch` was always
downloading the stable branch of egit.git, even though it has not
changed in many weeks.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 82b995e..98c365e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -115,6 +115,7 @@ class RefDatabase {
 	}
 
 	ObjectId idOf(final String name) throws IOException {
+		refreshPackedRefs();
 		final Ref r = readRefBasic(name, 0);
 		return r != null ? r.getObjectId() : null;
 	}
@@ -132,6 +133,7 @@ class RefDatabase {
 	 *             to the base ref, as the symbolic ref could not be read.
 	 */
 	RefUpdate newUpdate(final String name) throws IOException {
+		refreshPackedRefs();
 		Ref r = readRefBasic(name, 0);
 		if (r == null)
 			r = new Ref(Ref.Storage.NEW, name, null);
-- 
1.6.0.rc0.182.gb96c7
