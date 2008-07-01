From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/8] Correctly name the stderr redirection thread for local transport
Date: Mon, 30 Jun 2008 23:04:02 -0400
Message-ID: <1214881445-3931-6-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
 <1214881445-3931-2-git-send-email-spearce@spearce.org>
 <1214881445-3931-3-git-send-email-spearce@spearce.org>
 <1214881445-3931-4-git-send-email-spearce@spearce.org>
 <1214881445-3931-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWK8-0003pl-4I
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbYGADN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYGADMu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:12:50 -0400
Received: from george.spearce.org ([209.20.77.23]:58259 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYGADMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5F0E538220; Tue,  1 Jul 2008 03:04:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E2F1938193;
	Tue,  1 Jul 2008 03:04:29 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86997>

When we open git-receive-pack for the local transport case we still
create a thread to redirect any error messages to the System.err
console.  In this case the thread should be named after the command
we are running.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportLocal.java |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index 761d1b8..b112267 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -96,7 +96,7 @@ class TransportLocal extends PackTransport {
 		try {
 			final Process proc = Runtime.getRuntime().exec(
 					new String[] { cmd, "." }, null, remoteGitDir);
-			new StreamRewritingThread(proc.getErrorStream()).start();
+			new StreamRewritingThread(cmd, proc.getErrorStream()).start();
 			return proc;
 		} catch (IOException err) {
 			throw new TransportException(uri, err.getMessage(), err);
@@ -158,8 +158,8 @@ class TransportLocal extends PackTransport {
 	class StreamRewritingThread extends Thread {
 		private final InputStream in;
 
-		StreamRewritingThread(final InputStream in) {
-			super("JGit " + getOptionUploadPack() + " Errors");
+		StreamRewritingThread(final String cmd, final InputStream in) {
+			super("JGit " + cmd + " Errors");
 			this.in = in;
 		}
 
-- 
1.5.6.74.g8a5e
