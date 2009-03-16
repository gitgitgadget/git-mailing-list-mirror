From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Create a debugging tool "jgit rebuild-commitgraph"
Date: Mon, 16 Mar 2009 07:44:50 -0700
Message-ID: <20090316144450.GN22920@spearce.org>
References: <1236954901-30990-1-git-send-email-spearce@spearce.org> <200903151234.39367.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 15:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjE5L-0003mf-QE
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 15:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759524AbZCPOow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 10:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759203AbZCPOow
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 10:44:52 -0400
Received: from george.spearce.org ([209.20.77.23]:44433 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758764AbZCPOov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 10:44:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3392438211; Mon, 16 Mar 2009 14:44:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903151234.39367.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113330>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> 
> I'd hate to put such a dangerous thing in the list of normal tools. If the user
> want to shoot him/her-self in the foot they should get a license first.

How about squashing this in?

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCommitGraph.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCommitGraph.java
index ccee997..cc23438 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCommitGraph.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCommitGraph.java
@@ -50,6 +50,7 @@
 import java.util.Map;
 
 import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.ObjectWritingException;
 import org.spearce.jgit.lib.Commit;
@@ -85,6 +86,11 @@
  * <p>
  */
 class RebuildCommitGraph extends TextBuiltin {
+	private final String REALLY = "--destroy-this-repository";
+
+	@Option(name = REALLY, usage = "approve destruction of repository")
+	boolean really;
+
 	@Argument(index = 0, required = true, metaVar = "REFS", usage = "for-each-ref output")
 	File refList;
 
@@ -97,6 +103,30 @@
 
 	@Override
 	protected void run() throws Exception {
+		if (!really && !db.getAllRefs().isEmpty()) {
+			final StringBuilder m = new StringBuilder();
+			m.append("fatal: ");
+			m.append("This program will destroy the repository:");
+			m.append("\n");
+			m.append("fatal:\n");
+			m.append("fatal:    ");
+			m.append(db.getDirectory().getAbsolutePath());
+			m.append("\n");
+			m.append("fatal:\n");
+			m.append("fatal: ");
+			m.append("To continue, add ");
+			m.append(REALLY);
+			m.append(" to the command line");
+			m.append("\n");
+			m.append("fatal:");
+			System.err.println(m);
+			throw die("Need approval to destroy current repository");
+		}
+		if (!refList.isFile())
+			throw die("no such file: " + refList.getPath());
+		if (!graph.isFile())
+			throw die("no such file: " + graph.getPath());
+
 		recreateCommitGraph();
 		detachHead();
 		deleteAllRefs();
-- 
Shawn.
