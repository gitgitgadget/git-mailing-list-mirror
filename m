From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/1] Some error handling for GitDocument
Date: Mon, 3 Nov 2008 00:46:21 +0100
Message-ID: <200811030046.22265.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 00:47:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwmfS-000760-DS
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 00:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbYKBXqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYKBXqZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 18:46:25 -0500
Received: from mail.dewire.com ([83.140.172.130]:8646 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755AbYKBXqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 18:46:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1E25C8026D1;
	Mon,  3 Nov 2008 00:46:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u85Aauu6H6Wn; Mon,  3 Nov 2008 00:46:23 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 09BF0800254;
	Mon,  3 Nov 2008 00:46:23 +0100 (CET)
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99890>

We sometimes (rarely) gets errors from unresolvable trees. Do not just
throw a NullPointerException.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

This is primarily necessary to track down a rare problem, but we
should have error handling here anyway.

 .../egit/ui/internal/decorators/GitDocument.java   |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index 3724304..6e10144 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -21,6 +21,7 @@
 import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.RepositoryListener;
+import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 
 class GitDocument extends Document implements RepositoryListener {
@@ -52,7 +53,14 @@ void populate() throws IOException {
 		String baseline = GitQuickDiffProvider.baseline.get(repository);
 		if (baseline == null)
 			baseline = "HEAD";
-		TreeEntry blobEnry = repository.mapTree(baseline).findBlobMember(gitPath);
+		Tree baselineTree = repository.mapTree(baseline);
+		if (baselineTree == null) {
+			Activator.logError("Could not resolve quickdiff baseline "
+					+ baseline + " corresponding to " + resource + " in "
+					+ repository, new Throwable());
+			return;
+		}
+		TreeEntry blobEnry = baselineTree.findBlobMember(gitPath);
 		if (blobEnry != null) {
 			Activator.trace("(GitQuickDiffProvider) compareTo: " + baseline);
 			ObjectLoader loader = repository.openBlob(blobEnry.getId());
-- 
1.6.0.3.578.g6a50
