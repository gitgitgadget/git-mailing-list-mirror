From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Show critical flags in debug toString() descriptions of rev queues
Date: Thu, 12 Mar 2009 19:07:38 -0700
Message-ID: <1236910062-18476-2-git-send-email-spearce@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhwpn-0006Hf-9G
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbZCMCHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 22:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbZCMCHr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:07:47 -0400
Received: from george.spearce.org ([209.20.77.23]:46986 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbZCMCHp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:07:45 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 93EAD38222; Fri, 13 Mar 2009 02:07:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D12A738211;
	Fri, 13 Mar 2009 02:07:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
In-Reply-To: <1236910062-18476-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113130>

These can help identify the state of each object, especially the
important UNINTERESTING flag being present (or not).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/AbstractRevQueue.java |    5 ++++
 .../src/org/spearce/jgit/revwalk/DateRevQueue.java |   10 ++------
 .../src/org/spearce/jgit/revwalk/FIFORevQueue.java |   10 ++------
 .../src/org/spearce/jgit/revwalk/LIFORevQueue.java |   10 ++------
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |   12 ++++++++++
 .../src/org/spearce/jgit/revwalk/RevObject.java    |   23 ++++++++++++++++++++
 6 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java
index 4cf7dae..5bb969d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java
@@ -115,6 +115,11 @@ int outputType() {
 		return outputType;
 	}
 
+	protected static void describe(final StringBuilder s, final RevCommit c) {
+		s.append(c.toString());
+		s.append('\n');
+	}
+
 	private static class AlwaysEmptyQueue extends AbstractRevQueue {
 		@Override
 		public void add(RevCommit c) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
index f797477..210f985 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
@@ -126,13 +126,9 @@ int outputType() {
 	}
 
 	public String toString() {
-		final StringBuffer s = new StringBuffer();
-		for (Entry q = head; q != null; q = q.next) {
-			s.append(q.commit.name());
-			s.append(' ');
-			s.append(q.commit.commitTime);
-			s.append('\n');
-		}
+		final StringBuilder s = new StringBuilder();
+		for (Entry q = head; q != null; q = q.next)
+			describe(s, q.commit);
 		return s.toString();
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java
index 2c4c003..f086928 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java
@@ -149,14 +149,10 @@ void removeFlag(final int f) {
 	}
 
 	public String toString() {
-		final StringBuffer s = new StringBuffer();
+		final StringBuilder s = new StringBuilder();
 		for (Block q = head; q != null; q = q.next) {
-			for (int i = q.headIndex; i < q.tailIndex; i++) {
-				s.append(q.commits[i].name());
-				s.append(' ');
-				s.append(q.commits[i].commitTime);
-				s.append('\n');
-			}
+			for (int i = q.headIndex; i < q.tailIndex; i++)
+				describe(s, q.commits[i]);
 		}
 		return s.toString();
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java
index 5e885c0..045f7f1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java
@@ -104,14 +104,10 @@ boolean anybodyHasFlag(final int f) {
 	}
 
 	public String toString() {
-		final StringBuffer s = new StringBuffer();
+		final StringBuilder s = new StringBuilder();
 		for (Block q = head; q != null; q = q.next) {
-			for (int i = q.headIndex; i < q.tailIndex; i++) {
-				s.append(q.commits[i].name());
-				s.append(' ');
-				s.append(q.commits[i].commitTime);
-				s.append('\n');
-			}
+			for (int i = q.headIndex; i < q.tailIndex; i++)
+				describe(s, q.commits[i]);
 		}
 		return s.toString();
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index de11c39..1b25fce 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -388,4 +388,16 @@ public void dispose() {
 		flags &= ~PARSED;
 		buffer = null;
 	}
+
+	@Override
+	public String toString() {
+		final StringBuilder s = new StringBuilder();
+		s.append(Constants.typeString(getType()));
+		s.append(name());
+		s.append(' ');
+		s.append(commitTime);
+		s.append(' ');
+		appendCoreFlags(s);
+		return s.toString();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 451205c..7dadb7b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -167,4 +167,27 @@ public void remove(final RevFlagSet set) {
 	public void dispose() {
 		// Nothing needs to be done for most objects.
 	}
+
+	@Override
+	public String toString() {
+		final StringBuilder s = new StringBuilder();
+		s.append(Constants.typeString(getType()));
+		s.append(name());
+		s.append(' ');
+		appendCoreFlags(s);
+		return s.toString();
+	}
+
+	/**
+	 * @param s
+	 *            buffer to append a debug description of core RevFlags onto.
+	 */
+	protected void appendCoreFlags(final StringBuilder s) {
+		s.append((flags & RevWalk.TOPO_DELAY) != 0 ? 'o' : '-');
+		s.append((flags & RevWalk.TEMP_MARK) != 0 ? 't' : '-');
+		s.append((flags & RevWalk.REWRITE) != 0 ? 'r' : '-');
+		s.append((flags & RevWalk.UNINTERESTING) != 0 ? 'u' : '-');
+		s.append((flags & RevWalk.SEEN) != 0 ? 's' : '-');
+		s.append((flags & RevWalk.PARSED) != 0 ? 'p' : '-');
+	}
 }
-- 
1.6.2.288.gc3f22
