From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Fix RepositoryConfig.setStringList to not corrupt internal state
Date: Sat, 26 Jul 2008 19:11:55 -0700
Message-ID: <1217124716-12063-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 04:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMvks-0004o2-SC
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 04:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYG0CL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 22:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbYG0CL6
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 22:11:58 -0400
Received: from george.spearce.org ([209.20.77.23]:59341 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbYG0CL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 22:11:57 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5A68C383A3; Sun, 27 Jul 2008 02:11:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9AE59383A3;
	Sun, 27 Jul 2008 02:11:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90299>

Calling setStringList was incorrectly storing the String objects
directly in byName.  The byName table should have either an Entry or
a List<Entry> stored within its value position.  Storing the String
(or List<String>) directly confused our get code as it did not find
the object type it expected.  This caused the get code to fallback
to the base configuration (e.g. ~/.gitconfig) or just return null
(claiming the value was never set).

A test case for this appears in the next commit.

Noticed-by: Marek Zawirski <marek.zawirski@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   23 ++++++++++++++++---
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 1431f1f..d1cd5fc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -381,10 +381,25 @@ public class RepositoryConfig {
 		key += "." + name.toLowerCase();
 		if (values.size() == 0)
 			byName.remove(key);
-		else if (values.size() == 1)
-			byName.put(key, values.get(0));
-		else
-			byName.put(key, new ArrayList<String>(values));
+		else if (values.size() == 1) {
+			final Entry e = new Entry();
+			e.base = section;
+			e.extendedBase = subsection;
+			e.name = name;
+			e.value = values.get(0);
+			byName.put(key, e);
+		} else {
+			final ArrayList<Entry> eList = new ArrayList<Entry>(values.size());
+			for (final String v : values) {
+				final Entry e = new Entry();
+				e.base = section;
+				e.extendedBase = subsection;
+				e.name = name;
+				e.value = v;
+				eList.add(e);
+			}
+			byName.put(key, eList);
+		}
 
 		int entryIndex = 0;
 		int valueIndex = 0;
-- 
1.6.0.rc0.182.gb96c7
