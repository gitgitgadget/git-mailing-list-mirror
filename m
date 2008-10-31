From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT RFC PATCH 3/3] Rate limit warnings spewed by RepositoryTestCase.recursiveDelete
Date: Fri, 31 Oct 2008 01:16:27 +0100
Message-ID: <200810310116.28046.robin.rosenberg@dewire.com>
References: <20081022083420.GC17940@diku.dk> <200810240110.21755.robin.rosenberg@dewire.com> <20081030104620.GB17131@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:18:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvhiA-0003YU-W7
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 01:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYJaAQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbYJaAQm
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 20:16:42 -0400
Received: from mail.dewire.com ([83.140.172.130]:18092 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbYJaAQk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2008 20:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E60A0147CF70;
	Fri, 31 Oct 2008 01:16:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-oC8lPf6ASO; Fri, 31 Oct 2008 01:16:37 +0100 (CET)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 71FE1147CF76;
	Fri, 31 Oct 2008 01:16:37 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20081030104620.GB17131@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99539>

torsdagen den 30 oktober 2008 11.46.20 skrev Jonas Fonseca:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote Fri, Oct 24, 2008:
> > onsdagen den 22 oktober 2008 10.34.20 skrev Jonas Fonseca:
> > > On Windows XP / NTFS / NetBeans 6.1 / Java 5 a lot of warnings are
> > > printed. In most cases the path is in fact deleted and it seems to
> > > just be a timing bug or something Windows or NTFS specific.
> >
> > The problem is actually flaws in the unit tests and in the supporting
> > RepositoryTestCase.  I think I'll fix that instead.
> 
> Thanks. Any progress on this? Can I help in any way?

Ok here is a W-I-P. One test case is not cleaning up properly. You may note that I
still give some room for gc not to unmap immediately, but at the end of the program
we hope that will be the case and I think the missing case is just a bug and not GC
being delayed.  The counter testcount is only here for debugging this problem.

-- robin

>From b3907a11bec0158a99bc77a7655379725203da9c Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosnberg@dewire.com>
Date: Thu, 23 Oct 2008 01:27:50 +0200
Subject: [EGIT PATCH] Make the cleanup less verbose when it fails to delete temporary stuff.

---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   57 +++++++++++++++-----
 1 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 9d7d133..8015a18 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -47,6 +47,7 @@
 import java.io.Reader;
 
 import junit.framework.TestCase;
+
 import org.spearce.jgit.util.JGitTestUtil;
 
 public abstract class RepositoryTestCase extends TestCase {
@@ -66,22 +67,34 @@
 		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
 	}
 
-	protected static void recursiveDelete(final File dir) {
+	protected static boolean recursiveDelete(final File dir) {
+		return recursiveDelete(dir, false);
+	}
+
+	protected static boolean recursiveDelete(final File dir, boolean silent) {
+		if (!dir.exists())
+			return silent;
 		final File[] ls = dir.listFiles();
 		if (ls != null) {
 			for (int k = 0; k < ls.length; k++) {
 				final File e = ls[k];
 				if (e.isDirectory()) {
-					recursiveDelete(e);
+					silent = recursiveDelete(e, silent);
 				} else {
-					e.delete();
+					if (!e.delete()) {
+						if (!silent)
+							System.out.println("Warning: Failed to delete " + e);
+						silent = true;
+					}
 				}
 			}
 		}
-		dir.delete();
-		if (dir.exists()) {
-			System.out.println("Warning: Failed to delete " + dir);
+		if (!dir.delete()) {
+			if (!silent)
+				System.out.println("Warning: Failed to delete " + dir);
+			silent = true;
 		}
+		return silent;
 	}
 
 	protected static void copyFile(final File src, final File dst)
@@ -121,19 +134,31 @@ protected static void checkFile(File f, final String checkData)
 
 	protected Repository db;
 
+	private static int testcount;
+	private static Thread shutdownhook;
+
 	public void setUp() throws Exception {
 		super.setUp();
-		recursiveDelete(trashParent);
-		trash = new File(trashParent,"trash"+System.currentTimeMillis());
+		System.gc();
+		trash = new File(trashParent,"xtrash"+System.currentTimeMillis()+"."+(testcount++));
+		recursiveDelete(trashParent, true);
 		trash_git = new File(trash, ".git");
-
+		if (shutdownhook == null) {
+			shutdownhook = new Thread() {
+				@Override
+				public void run() {
+					System.gc();
+					recursiveDelete(trashParent, false);
+				}
+			};
+			Runtime.getRuntime().addShutdownHook(shutdownhook);
+		}
 		Runtime.getRuntime().addShutdownHook(new Thread() {
 			@Override
 			public void run() {
-				recursiveDelete(trashParent);
+				recursiveDelete(trash);
 			}
 		});
-
 		db = new Repository(trash_git);
 		db.create();
 
@@ -170,12 +195,18 @@ protected void tearDown() throws Exception {
 	 * @throws IOException
 	 */
 	protected Repository createNewEmptyRepo() throws IOException {
-		File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"/.git");
+		final File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"."+(testcount++)+"/.git");
 		assertFalse(newTestRepo.exists());
-		File unusedDir = new File(trashParent, "tmp"+System.currentTimeMillis());
+		File unusedDir = new File(trashParent, "tmp"+System.currentTimeMillis()+"."+(testcount++));
 		assertTrue(unusedDir.mkdirs());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
+		Runtime.getRuntime().addShutdownHook(new Thread() {
+			@Override
+			public void run() {
+				recursiveDelete(newTestRepo);
+			}
+		});
 		return newRepo;
 	}
 
-- 
1.6.0.2.308.gef4a
