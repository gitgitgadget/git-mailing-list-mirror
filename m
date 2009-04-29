From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/11] Add tests for WindowCache.reconfigure cases
Date: Wed, 29 Apr 2009 11:54:47 -0700
Message-ID: <1241031288-23437-11-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
 <1241031288-23437-2-git-send-email-spearce@spearce.org>
 <1241031288-23437-3-git-send-email-spearce@spearce.org>
 <1241031288-23437-4-git-send-email-spearce@spearce.org>
 <1241031288-23437-5-git-send-email-spearce@spearce.org>
 <1241031288-23437-6-git-send-email-spearce@spearce.org>
 <1241031288-23437-7-git-send-email-spearce@spearce.org>
 <1241031288-23437-8-git-send-email-spearce@spearce.org>
 <1241031288-23437-9-git-send-email-spearce@spearce.org>
 <1241031288-23437-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwx-0003Rz-4m
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbZD2SzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757306AbZD2SzL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:55:11 -0400
Received: from george.spearce.org ([209.20.77.23]:32899 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbZD2Sy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:57 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9991138064; Wed, 29 Apr 2009 18:54:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A683038075;
	Wed, 29 Apr 2009 18:54:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117921>

Most of these cases occur when the window cache is misconfigured
by the application.  We should be throwing an exception out with
some sort of error message if they happen, so check for that.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 New test, to get better coverage.

 .../jgit/lib/WindowCacheReconfigureTest.java       |  119 ++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheReconfigureTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheReconfigureTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheReconfigureTest.java
new file mode 100644
index 0000000..9bd4d96
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheReconfigureTest.java
@@ -0,0 +1,119 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.lib;
+
+public class WindowCacheReconfigureTest extends RepositoryTestCase {
+	public void testConfigureCache_PackedGitLimit_0() {
+		try {
+			final WindowCacheConfig cfg = new WindowCacheConfig();
+			cfg.setPackedGitLimit(0);
+			WindowCache.reconfigure(cfg);
+			fail("incorrectly permitted PackedGitLimit = 0");
+		} catch (IllegalArgumentException e) {
+			//
+		}
+	}
+
+	public void testConfigureCache_PackedGitWindowSize_0() {
+		try {
+			final WindowCacheConfig cfg = new WindowCacheConfig();
+			cfg.setPackedGitWindowSize(0);
+			WindowCache.reconfigure(cfg);
+			fail("incorrectly permitted PackedGitWindowSize = 0");
+		} catch (IllegalArgumentException e) {
+			assertEquals("Invalid window size", e.getMessage());
+		}
+	}
+
+	public void testConfigureCache_PackedGitWindowSize_512() {
+		try {
+			final WindowCacheConfig cfg = new WindowCacheConfig();
+			cfg.setPackedGitWindowSize(512);
+			WindowCache.reconfigure(cfg);
+			fail("incorrectly permitted PackedGitWindowSize = 512");
+		} catch (IllegalArgumentException e) {
+			assertEquals("Invalid window size", e.getMessage());
+		}
+	}
+
+	public void testConfigureCache_PackedGitWindowSize_4097() {
+		try {
+			final WindowCacheConfig cfg = new WindowCacheConfig();
+			cfg.setPackedGitWindowSize(4097);
+			WindowCache.reconfigure(cfg);
+			fail("incorrectly permitted PackedGitWindowSize = 4097");
+		} catch (IllegalArgumentException e) {
+			assertEquals("Window size must be power of 2", e.getMessage());
+		}
+	}
+
+	public void testConfigureCache_PackedGitOpenFiles_0() {
+		try {
+			final WindowCacheConfig cfg = new WindowCacheConfig();
+			cfg.setPackedGitOpenFiles(0);
+			WindowCache.reconfigure(cfg);
+			fail("incorrectly permitted PackedGitOpenFiles = 0");
+		} catch (IllegalArgumentException e) {
+			assertEquals("Open files must be >= 1", e.getMessage());
+		}
+	}
+
+	public void testConfigureCache_PackedGitWindowSizeAbovePackedGitLimit() {
+		try {
+			final WindowCacheConfig cfg = new WindowCacheConfig();
+			cfg.setPackedGitLimit(1024);
+			cfg.setPackedGitWindowSize(8192);
+			WindowCache.reconfigure(cfg);
+			fail("incorrectly permitted PackedGitWindowSize > PackedGitLimit");
+		} catch (IllegalArgumentException e) {
+			assertEquals("Window size must be < limit", e.getMessage());
+		}
+	}
+
+	public void testConfigureCache_Limits1() {
+		// This test is just to force coverage over some lower bounds for
+		// the table. We don't want the table to wind up with too small
+		// of a size. This is highly dependent upon the table allocation
+		// algorithm actually implemented in WindowCache.
+		//
+		final WindowCacheConfig cfg = new WindowCacheConfig();
+		cfg.setPackedGitLimit(6 * 4096 / 5);
+		cfg.setPackedGitWindowSize(4096);
+		WindowCache.reconfigure(cfg);
+	}
+}
-- 
1.6.3.rc3.199.g24398
