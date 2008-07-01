From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/8] Support 'git upload-pack' and 'git receive-pack' over SSH
Date: Mon, 30 Jun 2008 23:04:03 -0400
Message-ID: <1214881445-3931-7-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
 <1214881445-3931-2-git-send-email-spearce@spearce.org>
 <1214881445-3931-3-git-send-email-spearce@spearce.org>
 <1214881445-3931-4-git-send-email-spearce@spearce.org>
 <1214881445-3931-5-git-send-email-spearce@spearce.org>
 <1214881445-3931-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWKC-0003pl-Hm
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYGADNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbYGADNg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:13:36 -0400
Received: from george.spearce.org ([209.20.77.23]:58266 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbYGADMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id AFBA438222; Tue,  1 Jul 2008 03:04:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 41B7138153;
	Tue,  1 Jul 2008 03:04:30 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87000>

Within the next 6 months C git clients will begin asking remote
servers for 'git $command' rather than 'git-$command' when using the
SSH transport.  This change is to allow the C git programs to be
removed from the user's $PATH, leaving only the git wrapper binary.

For the first 6 months after C git 1.6.0 gets released clients will
continue to ask for 'git-$command' but users may change that behavior
by specifically asking for 'git $command' in remote.$name.uploadpack
or remote.$name.receivepack.  Later clients (including jgit) will
change to ask for 'git $command' by default.

If we are asking for 'git $command' we cannot quote this as a single
command with a space in the path.  We split on the whitespace and
quote both sides (if necessary) to protect the strings from the shell.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/TransportGitSsh.java    |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index caf531d..1bbdf04 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -182,7 +182,13 @@ class TransportGitSsh extends PackTransport {
 				path = (uri.getPath().substring(1));
 
 			final StringBuilder cmd = new StringBuilder();
-			sqMinimal(cmd, exe);
+			final int gitspace = exe.indexOf("git ");
+			if (gitspace >= 0) {
+				sqMinimal(cmd, exe.substring(0, gitspace + 3));
+				cmd.append(' ');
+				sqMinimal(cmd, exe.substring(gitspace + 4));
+			} else
+				sqMinimal(cmd, exe);
 			cmd.append(' ');
 			sqAlways(cmd, path);
 			channel.setCommand(cmd.toString());
-- 
1.5.6.74.g8a5e
