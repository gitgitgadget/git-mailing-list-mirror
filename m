From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Extended test cases for RepositoryConfigTest
Date: Sat, 26 Jul 2008 19:11:56 -0700
Message-ID: <1217124716-12063-2-git-send-email-spearce@spearce.org>
References: <1217124716-12063-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 04:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMvkt-0004o2-HA
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 04:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbYG0CMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 22:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbYG0CMA
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 22:12:00 -0400
Received: from george.spearce.org ([209.20.77.23]:59346 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYG0CL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 22:11:58 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D4A383841A; Sun, 27 Jul 2008 02:11:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3AF58383A5;
	Sun, 27 Jul 2008 02:11:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217124716-12063-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90298>

From: Marek Zawirski <marek.zawirski@gmail.com>

Add cases for getting values after setting them. It's something
different from reading config file from scratch or writing it out after
modifications. It's case for getting values after modifications in
object model.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index 8c55fe8..da7e704 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -2,6 +2,7 @@
  * Copyright (C) 2007, Dave Watson <dwatson@mimvista.com>
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved.
  *
@@ -41,6 +42,8 @@ package org.spearce.jgit.lib;
 
 import java.io.File;
 import java.io.IOException;
+import java.util.Arrays;
+import java.util.LinkedList;
 
 /**
  * Test reading of git config
@@ -84,11 +87,26 @@ public class RepositoryConfigTest extends RepositoryTestCase {
 		checkFile(cfgFile, "[sec \"ext\"]\n\tname = value\n\tname2 = value2\n");
 	}
 
-	public void test004_PutSimple() throws IOException {
+	public void test004_PutGetSimple() throws IOException {
 		File cfgFile = writeTrashFile("config_004", "");
 		RepositoryConfig repositoryConfig = new RepositoryConfig(null, cfgFile);
 		repositoryConfig.setString("my", null, "somename", "false");
 		repositoryConfig.save();
 		checkFile(cfgFile, "[my]\n\tsomename = false\n");
+		assertEquals("false", repositoryConfig
+				.getString("my", null, "somename"));
+	}
+
+	public void test005_PutGetStringList() throws IOException {
+		File cfgFile = writeTrashFile("config_005", "");
+		RepositoryConfig repositoryConfig = new RepositoryConfig(null, cfgFile);
+		final LinkedList<String> values = new LinkedList<String>();
+		values.add("value1");
+		values.add("value2");
+		repositoryConfig.setStringList("my", null, "somename", values);
+		repositoryConfig.save();
+		assertTrue(Arrays.equals(values.toArray(), repositoryConfig
+				.getStringList("my", null, "somename")));
+		checkFile(cfgFile, "[my]\n\tsomename = value1\n\tsomename = value2\n");
 	}
 }
-- 
1.6.0.rc0.182.gb96c7
