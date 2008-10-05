From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/6] Add decorate option to log program
Date: Mon,  6 Oct 2008 01:36:41 +0200
Message-ID: <1223249802-9959-6-git-send-email-robin.rosenberg@dewire.com>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 01:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdCF-0003Jr-6b
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 01:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYJEXiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 19:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbYJEXh7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 19:37:59 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:36643 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbYJEXhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 19:37:54 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id BE094386ED; Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 5B20938594; Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 340A037E44;
	Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97550>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/Log.java              |   32 ++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
index e16387b..378d9e0 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
@@ -40,10 +40,17 @@
 
 import java.text.DateFormat;
 import java.text.SimpleDateFormat;
+import java.util.Iterator;
+import java.util.List;
+import java.util.Map;
 import java.util.TimeZone;
 
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevWalk;
 
 @Command(common = true, usage = "View commit history")
 class Log extends RevWalkTextBuiltin {
@@ -51,14 +58,39 @@
 
 	private final DateFormat fmt;
 
+	private Map<AnyObjectId, List<Ref>> allRefsByPeeledObjectId;
+
+	@Option(name="--decorate", usage="Show ref names matching commits")
+	private boolean decorate;
+
 	Log() {
 		fmt = new SimpleDateFormat("EEE MMM dd HH:mm:ss yyyy ZZZZZ");
 	}
 
 	@Override
+	protected org.spearce.jgit.revwalk.RevWalk createWalk() {
+		RevWalk ret = super.createWalk();
+		if (decorate)
+			allRefsByPeeledObjectId = getRepository().getAllRefsByPeeledObjectId();
+		return ret;
+	}
+
+	@Override
 	protected void show(final RevCommit c) throws Exception {
 		out.print("commit ");
 		c.getId().copyTo(outbuffer, out);
+		if (decorate) {
+			List<Ref> list = allRefsByPeeledObjectId.get(c.copy());
+			if (list != null) {
+				out.print(" (");
+				for (Iterator<Ref> i = list.iterator(); i.hasNext(); ) {
+					out.print(i.next().getOrigName());
+					if (i.hasNext())
+						out.print(" ");
+				}
+				out.print(")");
+			}
+		}
 		out.println();
 
 		final PersonIdent author = c.getAuthorIdent();
-- 
1.6.0.1.310.gf789d0.dirty
