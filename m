From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/28] Initialize TextBuiltins with the repository before execution
Date: Thu, 17 Jul 2008 21:43:59 -0400
Message-ID: <1216345461-59382-7-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2q-00060p-O7
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757696AbYGRBo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758383AbYGRBo4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:44:56 -0400
Received: from george.spearce.org ([209.20.77.23]:46955 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678AbYGRBob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B768B38460; Fri, 18 Jul 2008 01:44:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5864B3841A;
	Fri, 18 Jul 2008 01:44:25 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88954>

This way the default constructor used by the option parser does
not cause the output stream to allocate until we have chosen to
really work with this builtin command and have a repository for
it to read/write against.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Main.java             |    2 +-
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
index a155039..68748bf 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
@@ -110,7 +110,7 @@ public class Main {
 		}
 
 		final TextBuiltin cmd = createCommand(argv[argi++]);
-		cmd.db = new Repository(gitdir);
+		cmd.init(new Repository(gitdir));
 		try {
 			cmd.execute(subarray(argv, argi));
 		} finally {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index 5f2fbce..05ad211 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -71,13 +71,14 @@ public abstract class TextBuiltin {
 	/** Git repository the command was invoked within. */
 	protected Repository db;
 
-	TextBuiltin() {
+	void init(final Repository repo) {
 		try {
 			out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(
 					System.out, "UTF-8")));
 		} catch (IOException e) {
 			throw die("cannot create output stream");
 		}
+		db = repo;
 	}
 
 	/**
-- 
1.5.6.3.569.ga9185
