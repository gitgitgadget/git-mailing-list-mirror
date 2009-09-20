From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT] Make it possible to clear a PlotCommitList
Date: Sun, 20 Sep 2009 09:34:37 -0400
Message-ID: <1253453677-10126-1-git-send-email-fonseca@diku.dk>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 20 15:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpMZ0-0007Bd-3N
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 15:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbZITNek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 09:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbZITNej
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 09:34:39 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:11833 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbZITNej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 09:34:39 -0400
Received: by qw-out-2122.google.com with SMTP id 5so755749qwd.37
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=udUwq+EIvUdT0QQqDSmLqpAUmZumKsskhgjpybBlwuo=;
        b=s17wshDoIbqFk9rJtXIMjYlJJW+U7b1Ebnnt4JV7de1dSDwsjjq7c2AP45YaHU8NFm
         r8IJJhNON8hmm29ftq/eu0FED47UbMg2yiC9aQgu6++RBof61L50+KuiwDoyjETFKpI2
         HbOmzVqr4klFJkZ9sddfjFB2Mpbt7In4Zf9Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=iQdvBgRJXVP75+EOZMZpsq7G9DOQlOjis9MDXuqy3skiOWW0JK5nnb3BZlFJGqWAzV
         HJFBJglnFbdMcaOsTCOeJSmZISGyh9ueLN1rNqc5FqYJgi21yPWm5XbJ4flcOqB8Q++k
         X0it+XlSskq/gRgE+nkxNidL9l6XvF9+aW+iY=
Received: by 10.224.57.21 with SMTP id a21mr2775813qah.122.1253453682297;
        Sun, 20 Sep 2009 06:34:42 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178046084.dsl.bell.ca [70.55.142.132])
        by mx.google.com with ESMTPS id 7sm4506550qwf.28.2009.09.20.06.34.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 06:34:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128845>

This allows SwingGraphPanes to be reused by simply clearing and
re-filling. Requires RevObjectList initialization to not call clear()
from its constructor, because this will lead PlotCommitList.clear() to
be called before all variables have been initialized.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../org/spearce/jgit/revplot/PlotCommitList.java   |   12 ++++++++++--
 .../org/spearce/jgit/revwalk/RevObjectList.java    |    7 +++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java
index a0959e2..39e4759 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java
@@ -64,7 +64,15 @@
 
 	private final TreeSet<Integer> freeLanes = new TreeSet<Integer>();
 
-	private HashSet<PlotLane> activeLanes = new HashSet<PlotLane>(32);
+	private final HashSet<PlotLane> activeLanes = new HashSet<PlotLane>(32);
+
+	@Override
+	public void clear() {
+		super.clear();
+		lanesAllocated = 0;
+		freeLanes.clear();
+		activeLanes.clear();
+	}
 
 	@Override
 	public void source(final RevWalk w) {
@@ -133,7 +141,7 @@ protected void enter(final int index, final PlotCommit<L> currCommit) {
 				final PlotCommit c = currCommit.children[i];
 				if (activeLanes.remove(c.lane)) {
 					recycleLane((L) c.lane);
-					freeLanes.add(Integer.valueOf(c.lane.position));
+					freeLanes.add(Integer.valueOf(c.lane.getPosition()));
 				}
 			}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObjectList.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObjectList.java
index b95b127..d57c779 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObjectList.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObjectList.java
@@ -50,13 +50,12 @@
 
 	static final int BLOCK_SIZE = 1 << BLOCK_SHIFT;
 
-	Block contents;
+	protected Block contents = new Block(0);
 
-	int size;
+	protected int size = 0;
 
 	/** Create an empty object list. */
 	public RevObjectList() {
-		clear();
 	}
 
 	public void add(final int index, final E element) {
@@ -107,7 +106,7 @@ public void clear() {
 		size = 0;
 	}
 
-	static class Block {
+	protected static class Block {
 		final Object[] contents = new Object[BLOCK_SIZE];
 
 		final int shift;
-- 
1.6.5.rc0.164.g5f6b0
