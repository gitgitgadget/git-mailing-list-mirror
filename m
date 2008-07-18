From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 20/28] Convert index-pack program to args4j
Date: Thu, 17 Jul 2008 21:44:13 -0400
Message-ID: <1216345461-59382-21-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
 <1216345461-59382-10-git-send-email-spearce@spearce.org>
 <1216345461-59382-11-git-send-email-spearce@spearce.org>
 <1216345461-59382-12-git-send-email-spearce@spearce.org>
 <1216345461-59382-13-git-send-email-spearce@spearce.org>
 <1216345461-59382-14-git-send-email-spearce@spearce.org>
 <1216345461-59382-15-git-send-email-spearce@spearce.org>
 <1216345461-59382-16-git-send-email-spearce@spearce.org>
 <1216345461-59382-17-git-send-email-spearce@spearce.org>
 <1216345461-59382-18-git-send-email-spearce@spearce.org>
 <1216345461-59382-19-git-send-email-spearce@spearce.org>
 <1216345461-59382-20-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4I-0006LD-Fs
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbYGRBpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758316AbYGRBpo
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:44 -0400
Received: from george.spearce.org ([209.20.77.23]:47014 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758357AbYGRBou (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 822C83844E; Fri, 18 Jul 2008 01:44:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E30053841A;
	Fri, 18 Jul 2008 01:44:30 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-20-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88968>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/IndexPack.java        |   35 +++++++-------------
 1 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
index 5f4134d..5eacaa4 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
@@ -40,39 +40,28 @@ package org.spearce.jgit.pgm;
 import java.io.BufferedInputStream;
 import java.io.File;
 
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.TextProgressMonitor;
 
 class IndexPack extends TextBuiltin {
-	@Override
-	public void execute(final String[] args) throws Exception {
-		boolean fixThin = false;
-		int argi = 0;
-		int version = 0;
-		for (; argi < args.length; argi++) {
-			final String a = args[argi];
-			if ("--fix-thin".equals(a))
-				fixThin = true;
-			else if (a.startsWith("--index-version="))
-				version = Integer.parseInt(a.substring(a.indexOf('=') + 1));
-			else if ("--".equals(a)) {
-				argi++;
-				break;
-			} else
-				break;
-		}
+	@Option(name = "--fix-thin", usage = "fix a thin pack to be complete")
+	private boolean fixThin;
+
+	@Option(name = "--index-version", usage = "index file format to create")
+	private int indexVersion;
 
-		if (argi == args.length)
-			throw die("usage: index-pack base");
-		else if (argi + 1 < args.length)
-			throw die("too many arguments");
+	@Argument(index = 0, required = true, metaVar = "base")
+	private File base;
 
-		final File base = new File(args[argi]);
+	@Override
+	protected void run() throws Exception {
 		final BufferedInputStream in;
 		final org.spearce.jgit.transport.IndexPack ip;
 		in = new BufferedInputStream(System.in);
 		ip = new org.spearce.jgit.transport.IndexPack(db, in, base);
 		ip.setFixThin(fixThin);
-		ip.setIndexVersion(version);
+		ip.setIndexVersion(indexVersion);
 		ip.index(new TextProgressMonitor());
 	}
 }
-- 
1.5.6.3.569.ga9185
