From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 7/7] Add decorate option to log program
Date: Fri,  7 Nov 2008 23:07:44 +0100
Message-ID: <1226095664-13759-8-git-send-email-robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZWM-0008MC-E0
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbYKGWIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYKGWH7
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:07:59 -0500
Received: from mail.dewire.com ([83.140.172.130]:11971 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbYKGWH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6C0F8147EAF9;
	Fri,  7 Nov 2008 23:07:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Or37batePor; Fri,  7 Nov 2008 23:07:54 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 25801147CED9;
	Fri,  7 Nov 2008 23:07:47 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
In-Reply-To: <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100344>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/Log.java              |   33 ++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
index e3a32c8..bb424d4 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
@@ -40,11 +40,19 @@
 
 import java.text.DateFormat;
 import java.text.SimpleDateFormat;
+import java.util.Collection;
+import java.util.Iterator;
 import java.util.Locale;
+import java.util.Map;
+import java.util.Set;
 import java.util.TimeZone;
 
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevWalk;
 
 @Command(common = true, usage = "View commit history")
 class Log extends RevWalkTextBuiltin {
@@ -52,14 +60,39 @@
 
 	private final DateFormat fmt;
 
+	private Map<AnyObjectId, Set<Ref>> allRefsByPeeledObjectId;
+
+	@Option(name="--decorate", usage="Show ref names matching commits")
+	private boolean decorate;
+
 	Log() {
 		fmt = new SimpleDateFormat("EEE MMM dd HH:mm:ss yyyy ZZZZZ", Locale.US);
 	}
 
 	@Override
+	protected RevWalk createWalk() {
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
+			Collection<Ref> list = allRefsByPeeledObjectId.get(c.copy());
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
1.6.0.3.578.g6a50
