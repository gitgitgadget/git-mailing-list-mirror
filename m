From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Correct Javadoc comment for TransportLocal about forking
Date: Sat,  2 May 2009 13:30:30 -0700
Message-ID: <1241296230-19342-2-git-send-email-spearce@spearce.org>
References: <1241296230-19342-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat May 02 22:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0Lr9-0000Ub-KT
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 22:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725AbZEBUae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 16:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756921AbZEBUad
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 16:30:33 -0400
Received: from george.spearce.org ([209.20.77.23]:36503 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596AbZEBUac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 16:30:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 61E0E38083; Sat,  2 May 2009 20:30:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 99E0F38081;
	Sat,  2 May 2009 20:30:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
In-Reply-To: <1241296230-19342-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118144>

Since a4548aedff ("Switch local fetch connection to use our own
UploadPack") this code has tried to avoid forking to execute the
CGit upload-pack or receive-pack processes, instead favoring the
creation of a helper thread and performing all work through a shared
memory buffer within the same JVM.

Update the Javadoc to better reflect what this class does.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportLocal.java |   24 +++++++++++++++----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index d5a6c14..230ab76 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -52,13 +52,27 @@
 import org.spearce.jgit.util.FS;
 
 /**
- * Transport that executes the Git "remote side" processes on a local directory.
+ * Transport to access a local directory as though it were a remote peer.
  * <p>
  * This transport is suitable for use on the local system, where the caller has
- * direct read or write access to the remote repository. This implementation
- * forks a C Git process to provide the remote side access, much as the
- * {@link TransportGitSsh} implementation causes the remote side to run a C Git
- * process.
+ * direct read or write access to the "remote" repository.
+ * <p>
+ * By default this transport works by spawning a helper thread within the same
+ * JVM, and processes the data transfer using a shared memory buffer between the
+ * calling thread and the helper thread. This is a pure-Java implementation
+ * which does not require forking an external process.
+ * <p>
+ * However, during {@link #openFetch()}, if the Transport has configured
+ * {@link Transport#getOptionUploadPack()} to be anything other than
+ * <code>"git-upload-pack"</code> or <code>"git upload-pack"</code>, this
+ * implementation will fork and execute the external process, using an operating
+ * system pipe to transfer data.
+ * <p>
+ * However, during {@link #openPush()}, if the Transport has configured
+ * {@link Transport#getOptionReceivePack()} to be anything other than
+ * <code>"git-receive-pack"</code> or <code>"git receive-pack"</code>, this
+ * implementation will fork and execute the external process, using an operating
+ * system pipe to transfer data.
  */
 class TransportLocal extends Transport implements PackTransport {
 	private static final String PWD = ".";
-- 
1.6.3.rc3.212.g8c698
