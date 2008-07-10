From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Report remote SSH execution errors during push via TransportException
Date: Thu, 10 Jul 2008 02:13:22 -0400
Message-ID: <1215670403-19191-5-git-send-email-spearce@spearce.org>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org>
 <1215670403-19191-2-git-send-email-spearce@spearce.org>
 <1215670403-19191-3-git-send-email-spearce@spearce.org>
 <1215670403-19191-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGpQI-0004ug-2w
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 08:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbYGJGNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 02:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYGJGN3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 02:13:29 -0400
Received: from george.spearce.org ([209.20.77.23]:55199 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYGJGN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 02:13:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C6B72382A1; Thu, 10 Jul 2008 06:13:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B0637381FC;
	Thu, 10 Jul 2008 06:13:25 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1215670403-19191-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87946>

If the remote side failed to execute git-receive-pack we may
have the reason why on the stderr stream of the channel, as
the remote shell may have failed execution.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/TransportGitSsh.java    |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index b169f4c..9a6c719 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -228,7 +228,7 @@ class TransportGitSsh extends PackTransport {
 				if (channel.isConnected())
 					init(channel.getInputStream(), channel.getOutputStream());
 				else
-					throw new TransportException(errStream.toString());
+					throw new TransportException(uri, errStream.toString());
 
 			} catch (TransportException err) {
 				close();
@@ -263,7 +263,12 @@ class TransportGitSsh extends PackTransport {
 			super(TransportGitSsh.this);
 			try {
 				channel = exec(getOptionReceivePack());
-				init(channel.getInputStream(), channel.getOutputStream());
+
+				if (channel.isConnected())
+					init(channel.getInputStream(), channel.getOutputStream());
+				else
+					throw new TransportException(uri, errStream.toString());
+
 			} catch (TransportException err) {
 				close();
 				throw err;
-- 
1.5.6.2.393.g45096
