From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Don't log TransportGitSsh error stream to JVM stderr
Date: Sun,  7 Jun 2009 15:31:24 -0700
Message-ID: <1244413884-17241-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:31:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQtp-0000vw-Cj
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbZFGWbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 18:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbZFGWbX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:31:23 -0400
Received: from george.spearce.org ([209.20.77.23]:55011 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbZFGWbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 18:31:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 259D8381FE; Sun,  7 Jun 2009 22:31:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AE875381D6;
	Sun,  7 Jun 2009 22:31:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.322.g117de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121016>

This is an API function, not a user interface routine.  We should not
be printing messages from the remote side to our console.  Instead we
should buffer them, and allow a TransportException to be thrown which
contains the message data.  Higher level user interface routines
can then catch that exception, and display the message, if any, in
a form that is appropriate to the context.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/TransportGitSsh.java    |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 2e9e0be..de72d02 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -166,17 +166,14 @@ public String toString() {
 			@Override
 			public void write(final int b) throws IOException {
 				if (b == '\r') {
-					System.err.print('\r');
 					return;
 				}
 
 				sb.append((char) b);
 
 				if (b == '\n') {
-					final String line = sb.toString();
-					System.err.print(line);
-					all.append(line);
-					sb = new StringBuilder();
+					all.append(sb);
+					sb.setLength(0);
 				}
 			}
 		};
-- 
1.6.3.2.322.g117de
