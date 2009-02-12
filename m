From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/6] Don't pass TagOpt to FetchProcess, get it from the Transport
Date: Thu, 12 Feb 2009 15:54:39 -0800
Message-ID: <1234482880-1316-6-git-send-email-spearce@spearce.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org>
 <1234482880-1316-2-git-send-email-spearce@spearce.org>
 <1234482880-1316-3-git-send-email-spearce@spearce.org>
 <1234482880-1316-4-git-send-email-spearce@spearce.org>
 <1234482880-1316-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlPn-0004ei-8A
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612AbZBLXyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756773AbZBLXyu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:54:50 -0500
Received: from george.spearce.org ([209.20.77.23]:49161 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbZBLXyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:54:45 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3673F38222; Thu, 12 Feb 2009 23:54:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 29AC13821F;
	Thu, 12 Feb 2009 23:54:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.226.gf08f
In-Reply-To: <1234482880-1316-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109685>

We are already passing the transport down.  Its just easier to get
the tagopt off the transport than it is to pass it as an argument
to the constructor.

In the future as we add more options into the Transport we will also
need to obtain those in the FetchProcess, so directly querying the
Transport will be more consistent.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/FetchProcess.java   |    7 ++-----
 .../src/org/spearce/jgit/transport/Transport.java  |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index 09718eb..2ca8aeb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -69,9 +69,6 @@
 	/** List of things we want to fetch from the remote repository. */
 	private final Collection<RefSpec> toFetch;
 
-	/** How to handle annotated tags, if any are advertised. */
-	private final TagOpt tagopt;
-
 	/** Set of refs we will actually wind up asking to obtain. */
 	private final HashMap<ObjectId, Ref> askFor = new HashMap<ObjectId, Ref>();
 
@@ -86,10 +83,9 @@
 
 	private FetchConnection conn;
 
-	FetchProcess(final Transport t, final Collection<RefSpec> f, final TagOpt o) {
+	FetchProcess(final Transport t, final Collection<RefSpec> f) {
 		transport = t;
 		toFetch = f;
-		tagopt = o;
 	}
 
 	void execute(final ProgressMonitor monitor, final FetchResult result)
@@ -114,6 +110,7 @@ void execute(final ProgressMonitor monitor, final FetchResult result)
 			}
 
 			Collection<Ref> additionalTags = Collections.<Ref> emptyList();
+			final TagOpt tagopt = transport.getTagOpt();
 			if (tagopt == TagOpt.AUTO_FOLLOW)
 				additionalTags = expandAutoFollowTags();
 			else if (tagopt == TagOpt.FETCH_TAGS)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 28700b7..e58b72a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -606,7 +606,7 @@ public FetchResult fetch(final ProgressMonitor monitor,
 		}
 
 		final FetchResult result = new FetchResult();
-		new FetchProcess(this, toFetch, tagopt).execute(monitor, result);
+		new FetchProcess(this, toFetch).execute(monitor, result);
 		return result;
 	}
 
-- 
1.6.2.rc0.226.gf08f
