From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Fix deadlock in native git protocol client for upload-pack
Date: Sun, 10 May 2009 15:48:04 -0700
Message-ID: <1241995685-13260-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 11 00:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Hoe-0003Cz-Pn
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 00:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbZEJWsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 18:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZEJWsH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 18:48:07 -0400
Received: from george.spearce.org ([209.20.77.23]:43456 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbZEJWsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 18:48:06 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 564B6381FC; Sun, 10 May 2009 22:48:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CF2AA381D3;
	Sun, 10 May 2009 22:48:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.48.g99c76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118754>

The upload-pack protocol states that for every flush packet
(aka "0000") sent by the client, we get exactly one NAK or
ACK line back.  However, if multi_ack is enabled, we may
get multiple "ACK %s continue" lines before the ACK/NAK is
sent by the upload-pack server.

Unfortunately, JGit was counting an "ACK %s continue" as a response
to a flush packet, causing the client side to stop reading from
the server too early.  This left a lot of "ACK %s continue" lines
in the server output buffer, eventually causing the server to stop
and wait for the output buffer to drain.  However, the client would
also get stuck after sending too many "have %s" lines, eventually
deadlocking the entire client-server pair.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BasePackFetchConnection.java    |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index f07cc4e..eaa94bd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -359,15 +359,15 @@ private void negotiate(final ProgressMonitor monitor) throws IOException,
 				continue;
 			}
 
-			while (resultsPending > 0) {
+			for (;;) {
 				final PacketLineIn.AckNackResult anr;
 
 				anr = pckIn.readACK(ackId);
-				resultsPending--;
 				if (anr == PacketLineIn.AckNackResult.NAK) {
 					// More have lines are necessary to compute the
 					// pack on the remote side. Keep doing that.
 					//
+					resultsPending--;
 					break;
 				}
 
-- 
1.6.3.48.g99c76
