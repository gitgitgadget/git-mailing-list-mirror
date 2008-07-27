From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Teach fetch command line a --verbose/-v switch for unchanged refs
Date: Sat, 26 Jul 2008 21:33:41 -0700
Message-ID: <1217133221-15513-2-git-send-email-spearce@spearce.org>
References: <1217133221-15513-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 06:35:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMxyX-0002cb-CJ
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 06:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbYG0Edq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 00:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbYG0Edq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 00:33:46 -0400
Received: from george.spearce.org ([209.20.77.23]:51354 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYG0Edo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 00:33:44 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9921A383A8; Sun, 27 Jul 2008 04:33:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A7F0A383A5;
	Sun, 27 Jul 2008 04:33:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217133221-15513-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90308>

We normally don't want to know about unchanged refs, as these
are not very interesting.  We now skip showing them by default
and only produce an output line for unchanged refs if -v is
given to us on the command line.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Fetch.java            |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index 194f669..84b5258 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -40,6 +40,7 @@ package org.spearce.jgit.pgm;
 import java.util.List;
 
 import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.TextProgressMonitor;
 import org.spearce.jgit.transport.FetchResult;
@@ -48,6 +49,9 @@ import org.spearce.jgit.transport.TrackingRefUpdate;
 import org.spearce.jgit.transport.Transport;
 
 class Fetch extends TextBuiltin {
+	@Option(name = "--verbose", aliases = { "-v" }, usage = "be more verbose")
+	private boolean verbose;
+
 	@Argument(index = 0, metaVar = "uri-ish")
 	private String remote = "origin";
 
@@ -66,15 +70,23 @@ class Fetch extends TextBuiltin {
 			tn.close();
 		}
 
-		out.print("From ");
-		out.print(tn.getURI());
-		out.println();
+		boolean shownURI = false;
 		for (final TrackingRefUpdate u : r.getTrackingRefUpdates()) {
+			if (!verbose && u.getResult() == RefUpdate.Result.NO_CHANGE)
+				continue;
+
 			final char type = shortTypeOf(u.getResult());
 			final String longType = longTypeOf(u);
 			final String src = abbreviateRef(u.getRemoteName(), false);
 			final String dst = abbreviateRef(u.getLocalName(), true);
 
+			if (!shownURI) {
+				out.print("From ");
+				out.print(tn.getURI());
+				out.println();
+				shownURI = true;
+			}
+
 			out.format(" %c %-17s %-10s -> %s", type, longType, src, dst);
 			out.println();
 		}
-- 
1.6.0.rc0.182.gb96c7
