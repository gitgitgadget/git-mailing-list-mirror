From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT RFC PATCH 3/3] Rate limit warnings spewed by
	RepositoryTestCase.recursiveDelete
Date: Wed, 22 Oct 2008 10:34:20 +0200
Message-ID: <20081022083420.GC17940@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:36:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZC9-0006OL-BB
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYJVIeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbYJVIeZ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:34:25 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:44571 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbYJVIeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:34:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id CC67952C3DC;
	Wed, 22 Oct 2008 10:34:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZmGzp56p8Tm; Wed, 22 Oct 2008 10:34:22 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 0DBB552C3DA;
	Wed, 22 Oct 2008 10:34:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 29BF26DFB62; Wed, 22 Oct 2008 10:33:05 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2A4674F9FA3; Wed, 22 Oct 2008 10:34:20 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98846>

On Windows XP / NTFS / NetBeans 6.1 / Java 5 a lot of warnings are
printed. In most cases the path is in fact deleted and it seems to just
be a timing bug or something Windows or NTFS specific. Also, many of the
warnings are for the same paths and therefore a bit redundant.
Furthermore, when a lot of warnings are printed it gives the feeling of
slowing down the tests. By rate limiting the warnings the problem is
still made visible for developers to notice.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

 This is mostly an annoyance fix, but might be acceptable.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 9d7d133..44e24d7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -51,6 +51,8 @@
 
 public abstract class RepositoryTestCase extends TestCase {
 
+	private static long deleteFailures;
+
 	protected final File trashParent = new File("trash");
 
 	protected File trash;
@@ -79,7 +81,7 @@ protected static void recursiveDelete(final File dir) {
 			}
 		}
 		dir.delete();
-		if (dir.exists()) {
+		if (dir.exists() && deleteFailures++ < 42) {
 			System.out.println("Warning: Failed to delete " + dir);
 		}
 	}
-- 
1.6.0.2.1166.g8d97a.dirty

-- 
Jonas Fonseca
