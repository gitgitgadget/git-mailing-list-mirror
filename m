From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/4] Don't create new pack lists if the directory hasn't changed
Date: Sat, 25 Jul 2009 15:52:22 -0700
Message-ID: <1248562343-18815-4-git-send-email-spearce@spearce.org>
References: <1248562343-18815-1-git-send-email-spearce@spearce.org>
 <1248562343-18815-2-git-send-email-spearce@spearce.org>
 <1248562343-18815-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUq6Y-0002UW-2Y
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 00:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbZGYWw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 18:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbZGYWw0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 18:52:26 -0400
Received: from george.spearce.org ([209.20.77.23]:58129 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbZGYWwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 18:52:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9E4B338200; Sat, 25 Jul 2009 22:52:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8697B381FF;
	Sat, 25 Jul 2009 22:52:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248562343-18815-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124088>

If we scan the directory and it hasn't changed since the last time we
scanned it, there is no reason to build a new PackList and update the
volatile reference.  This just generates unnecessary garbage and may
make it more difficult to detect an unmodified directory.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 5b28207..0bb3c01 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -260,10 +260,8 @@ protected ObjectLoader openObject2(final WindowCursor curs,
 	@Override
 	protected boolean tryAgain1() {
 		final PackList old = packList.get();
-		if (old.tryAgain(packDirectory.lastModified())) {
-			scanPacks(old);
-			return true;
-		}
+		if (old.tryAgain(packDirectory.lastModified()))
+			return old != scanPacks(old);
 		return false;
 	}
 
@@ -317,6 +315,8 @@ private PackList scanPacks(final PackList original) {
 					return o;
 				}
 				n = scanPacksImpl(o);
+				if (n == o)
+					return n;
 			} while (!packList.compareAndSet(o, n));
 			return n;
 		}
@@ -327,6 +327,7 @@ private PackList scanPacksImpl(final PackList old) {
 		final long lastModified = packDirectory.lastModified();
 		final Set<String> names = listPackDirectory();
 		final List<PackFile> list = new ArrayList<PackFile>(names.size() >> 2);
+		boolean foundNew = false;
 		for (final String indexName : names) {
 			// Must match "pack-[0-9a-f]{40}.idx" to be an index.
 			//
@@ -352,8 +353,17 @@ private PackList scanPacksImpl(final PackList old) {
 			final File packFile = new File(packDirectory, packName);
 			final File idxFile = new File(packDirectory, indexName);
 			list.add(new PackFile(idxFile, packFile));
+			foundNew = true;
 		}
 
+		// If we did not discover any new files, the modification time was not
+		// changed, and we did not remove any files, then the set of files is
+		// the same as the set we were given. Instead of building a new object
+		// return the same collection.
+		//
+		if (!foundNew && lastModified == old.lastModified && forReuse.isEmpty())
+			return old;
+
 		for (final PackFile p : forReuse.values()) {
 			p.close();
 		}
-- 
1.6.4.rc2.216.g769fa
