From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/3] Record pushes done over anonymous git:// using peer IP
Date: Wed,  4 Feb 2009 15:15:42 -0800
Message-ID: <1233789342-28079-3-git-send-email-spearce@spearce.org>
References: <1233789342-28079-1-git-send-email-spearce@spearce.org>
 <1233789342-28079-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqzg-0003e7-7f
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749AbZBDXPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755734AbZBDXPt
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:15:49 -0500
Received: from george.spearce.org ([209.20.77.23]:54324 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbZBDXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:15:45 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id A950438210; Wed,  4 Feb 2009 23:15:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 62C5138211;
	Wed,  4 Feb 2009 23:15:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.2.492.g8554a
In-Reply-To: <1233789342-28079-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108457>

The only data we have on the remote user on the other side of
a git:// network connection is their IP address/hostname.  So
we list that in the reflog as it is better than no data at all.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Daemon.java     |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index 646c88d..5087533 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -43,6 +43,7 @@
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.InterruptedIOException;
+import java.net.InetAddress;
 import java.net.InetSocketAddress;
 import java.net.ServerSocket;
 import java.net.Socket;
@@ -53,6 +54,7 @@
 import java.util.Map;
 import java.util.regex.Pattern;
 
+import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Repository;
 
 /** Basic daemon for the anonymous <code>git://</code> transport protocol. */
@@ -118,8 +120,15 @@ protected void execute(final DaemonClient dc,
 					@Override
 					protected void execute(final DaemonClient dc,
 							final Repository db) throws IOException {
+						final InetAddress peer = dc.getRemoteAddress();
+						String host = peer.getCanonicalHostName();
+						if (host == null)
+							host = peer.getHostAddress();
 						final ReceivePack rp = new ReceivePack(db);
 						final InputStream in = dc.getInputStream();
+						final String name = "anonymous";
+						final String email = name + "@" + host;
+						rp.setRefLogIdent(new PersonIdent(name, email));
 						rp.receive(in, dc.getOutputStream(), null);
 					}
 				} };
-- 
1.6.1.2.492.g8554a
