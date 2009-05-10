From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Decrease the fetch pack client buffer to the lower minimum
Date: Sun, 10 May 2009 15:48:05 -0700
Message-ID: <1241995685-13260-2-git-send-email-spearce@spearce.org>
References: <1241995685-13260-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 11 00:48:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Hof-0003Cz-DK
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 00:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbZEJWsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 18:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZEJWsJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 18:48:09 -0400
Received: from george.spearce.org ([209.20.77.23]:43459 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbZEJWsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 18:48:07 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B0F61381D6; Sun, 10 May 2009 22:48:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 19AFD381D5;
	Sun, 10 May 2009 22:48:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.48.g99c76
In-Reply-To: <1241995685-13260-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118755>

This is the lowest buffer size we actually require to keep the
client and server sides from deadlocking against each other.

Also added documentation, and renamed the symbol to better match
its real purpose; naming the lower threshold we can allow for a
buffer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BasePackFetchConnection.java    |   10 +++++++++-
 .../org/spearce/jgit/transport/TransportLocal.java |    2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index eaa94bd..1d1b801 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -89,7 +89,15 @@
 	 */
 	private static final int MAX_HAVES = 256;
 
-	protected static final int MAX_CLIENT_BUFFER = MAX_HAVES * 46 + 1024;
+	/**
+	 * Amount of data the client sends before starting to read.
+	 * <p>
+	 * Any output stream given to the client must be able to buffer this many
+	 * bytes before the client will stop writing and start reading from the
+	 * input stream. If the output stream blocks before this many bytes are in
+	 * the send queue, the system will deadlock.
+	 */
+	protected static final int MIN_CLIENT_BUFFER = 2 * 32 * 46 + 4;
 
 	static final String OPTION_INCLUDE_TAG = "include-tag";
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index cffdba1..428f73e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -175,7 +175,7 @@ InternalLocalFetchConnection() throws TransportException {
 					// force the buffer to be big enough, otherwise it
 					// will deadlock both threads.
 					{
-						buffer = new byte[MAX_CLIENT_BUFFER];
+						buffer = new byte[MIN_CLIENT_BUFFER];
 					}
 				};
 				out_w = new PipedOutputStream(out_r);
-- 
1.6.3.48.g99c76
