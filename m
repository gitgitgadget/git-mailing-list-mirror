From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [JGIT PATCH] Detect repository states according to post Git 1.5
Date: Tue, 21 Oct 2008 22:13:42 +0200
Message-ID: <200810212213.42294.robin.rosenberg.lists@dewire.com>
References: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi> <200810211950.50540.robin.rosenberg.lists@dewire.com> <f299b4f30810211109q7f2919f2r1d5cd8faf0048154@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: tomi.pakarinen@iki.fi
X-From: git-owner@vger.kernel.org Tue Oct 21 22:15:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsNdV-00053G-UD
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 22:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYJUUNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbYJUUNx
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 16:13:53 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:40503 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYJUUNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 16:13:52 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 6B60A380D5; Tue, 21 Oct 2008 22:13:49 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 46EF537EA2; Tue, 21 Oct 2008 22:13:49 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id F226537E48;
	Tue, 21 Oct 2008 22:13:48 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id ED5EF104;
	Tue, 21 Oct 2008 22:13:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 75E3B147EAEA;
	Tue, 21 Oct 2008 22:13:48 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwQ7NVSPW6vQ; Tue, 21 Oct 2008 22:13:47 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A3CF48026ED;
	Tue, 21 Oct 2008 22:13:47 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <f299b4f30810211109q7f2919f2r1d5cd8faf0048154@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98814>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

Seems we need this patch too in order to detect repository states. The new
resolution is more granular that before, though I suggest that one should
be restrictive when interpreting the state and not assume that these states
are the only ones. The methods on RepositoryState are the /only/ valid
ways of deciding what to, or not to, do. This implies we need to extend this
class somewhat, but I'm no hurry yet so we can think about what methods
we need.

 .../src/org/spearce/jgit/lib/Repository.java       |   17 +++++++++++++
 .../src/org/spearce/jgit/lib/RepositoryState.java  |   25 +++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index dfce1b8..26748e2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1017,14 +1017,31 @@ public GitIndex getIndex() throws IOException {
 	 * @return an important state
 	 */
 	public RepositoryState getRepositoryState() {
+		// Pre Git-1.6 logic
 		if (new File(getWorkDir(), ".dotest").exists())
 			return RepositoryState.REBASING;
 		if (new File(gitDir,".dotest-merge").exists())
 			return RepositoryState.REBASING_INTERACTIVE;
+
+		// From 1.6 onwards
+		if (new File(getDirectory(),"rebase-apply/rebasing").exists())
+			return RepositoryState.REBASING_REBASING;
+		if (new File(getDirectory(),"rebase-apply/applying").exists())
+			return RepositoryState.APPLY;
+		if (new File(getDirectory(),"rebase-apply").exists())
+			return RepositoryState.REBASING;
+
+		if (new File(getDirectory(),"rebase-merge/interactive").exists())
+			return RepositoryState.REBASING_INTERACTIVE;
+		if (new File(getDirectory(),"rebase-merge").exists())
+			return RepositoryState.REBASING_MERGE;
+
+		// Both versions
 		if (new File(gitDir,"MERGE_HEAD").exists())
 			return RepositoryState.MERGING;
 		if (new File(gitDir,"BISECT_LOG").exists())
 			return RepositoryState.BISECTING;
+
 		return RepositoryState.SAFE;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java
index c32c381..a916924 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java
@@ -40,6 +40,9 @@
 /**
  * Important state of the repository that affects what can and cannot bed
  * done. This is things like unhandled conflicted merges and unfinished rebase.
+ *
+ * The granularity and set of states are somewhat arbitrary. The methods
+ * on the state are the only supported means of deciding what to do.
  */
 public enum RepositoryState {
 	/**
@@ -62,7 +65,7 @@
 	},
 
 	/**
-	 * An unfinished rebase. Must resolve, skip or abort before normal work can take place
+	 * An unfinished rebase or am. Must resolve, skip or abort before normal work can take place
 	 */
 	REBASING {
 		public boolean canCheckout() { return false; }
@@ -72,6 +75,26 @@
 	},
 
 	/**
+	 * An unfinished rebase. Must resolve, skip or abort before normal work can take place
+	 */
+	REBASING_REBASING {
+		public boolean canCheckout() { return false; }
+		public boolean canResetHead() { return false; }
+		public boolean canCommit() { return true; }
+		public String getDescription() { return "Rebase"; }
+	},
+
+	/**
+	 * An unfinished apply. Must resolve, skip or abort before normal work can take place
+	 */
+	APPLY {
+		public boolean canCheckout() { return false; }
+		public boolean canResetHead() { return false; }
+		public boolean canCommit() { return true; }
+		public String getDescription() { return "Apply mailbox"; }
+	},
+
+	/**
 	 * An unfinished rebase with merge. Must resolve, skip or abort before normal work can take place
 	 */
 	REBASING_MERGE {
-- 
1.6.0.2.308.gef4a
