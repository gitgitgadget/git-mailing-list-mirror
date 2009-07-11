From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/11] Add a use reference counter to Repository
Date: Sat, 11 Jul 2009 13:19:21 -0700
Message-ID: <1247343566-19025-7-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
 <1247343566-19025-5-git-send-email-spearce@spearce.org>
 <1247343566-19025-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj3q-0003g9-0e
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbZGKUTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZGKUTi
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:38 -0400
Received: from george.spearce.org ([209.20.77.23]:39706 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZGKUTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 41AE738265; Sat, 11 Jul 2009 20:19:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D920C381D2;
	Sat, 11 Jul 2009 20:19:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123123>

This permits callers to reuse Repository instances across threads,
by using incrementOpen() to indicate the instance is in use, and
a matched close() to release the usage counter.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index fb72b64..e3ac01b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -54,6 +54,7 @@
 import java.util.Map;
 import java.util.Set;
 import java.util.Vector;
+import java.util.concurrent.atomic.AtomicInteger;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.RevisionSyntaxException;
@@ -85,6 +86,8 @@
  *
  */
 public class Repository {
+	private final AtomicInteger useCnt = new AtomicInteger(1);
+
 	private final File gitDir;
 
 	private final RepositoryConfig config;
@@ -721,11 +724,17 @@ private ObjectId resolveSimple(final String revstr) throws IOException {
 		return r != null ? r.getObjectId() : null;
 	}
 
+	/** Increment the use counter by one, requiring a matched {@link #close()}. */
+	public void incrementOpen() {
+		useCnt.incrementAndGet();
+	}
+
 	/**
 	 * Close all resources used by this repository
 	 */
 	public void close() {
-		objectDatabase.close();
+		if (useCnt.decrementAndGet() == 0)
+			objectDatabase.close();
 	}
 
 	/**
-- 
1.6.4.rc0.117.g28cb
