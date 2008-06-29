From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/21] Remember how a Ref was read in from disk and created
Date: Sun, 29 Jun 2008 03:59:19 -0400
Message-ID: <1214726371-93520-10-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
 <1214726371-93520-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrl-0000I1-Rx
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbYF2IAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYF2IAu
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36778 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbYF2IAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpL-0004NN-0g; Sun, 29 Jun 2008 04:00:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 709E320FBC9; Sun, 29 Jun 2008 04:00:03 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 7B18A20FBD1;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-9-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86767>

To efficiently deleted or update a ref we need to know where
it came from when it was read into the process.  If the ref
is being updated we can usually just write the loose file,
but if it is being deleted we may need to remove not just a
loose file but also delete it from the packed-refs.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/PushProcessTest.java    |   94 ++++++++++----------
 .../spearce/jgit/transport/RefSpecTestCase.java    |   26 +++---
 org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java |   91 ++++++++++++++++++-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   23 +++--
 .../spearce/jgit/transport/BasePackConnection.java |    6 +-
 .../spearce/jgit/transport/TransportBundle.java    |    3 +-
 .../org/spearce/jgit/transport/TransportHttp.java  |    6 +-
 .../org/spearce/jgit/transport/TransportSftp.java  |   18 +++-
 8 files changed, 186 insertions(+), 81 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
index cfea4d5..bb912e6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
@@ -75,65 +75,65 @@ public class PushProcessTest extends RepositoryTestCase {
 
 	/**
 	 * Test for fast-forward remote update.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateFastForward() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		testOneUpdateStatus(rru, ref, Status.OK, true);
 	}
 
 	/**
 	 * Test for non fast-forward remote update, when remote object is not known
 	 * to local repository.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateNonFastForwardUnknownObject() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("0000000000000000000000000000000000000001"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("0000000000000000000000000000000000000001"));
 		testOneUpdateStatus(rru, ref, Status.REJECTED_NONFASTFORWARD, null);
 	}
 
 	/**
 	 * Test for non fast-forward remote update, when remote object is known to
 	 * local repository, but it is not an ancestor of new object.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateNonFastForward() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"ac7e7e44c1885efb472ad54a78327d66bfc4ecef",
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
 		testOneUpdateStatus(rru, ref, Status.REJECTED_NONFASTFORWARD, null);
 	}
 
 	/**
 	 * Test for non fast-forward remote update, when force update flag is set.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateNonFastForwardForced() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"ac7e7e44c1885efb472ad54a78327d66bfc4ecef",
 				"refs/heads/master", true, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
 		testOneUpdateStatus(rru, ref, Status.OK, false);
 	}
 
 	/**
 	 * Test for remote ref creation.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateCreateRef() throws IOException {
@@ -145,21 +145,21 @@ public class PushProcessTest extends RepositoryTestCase {
 
 	/**
 	 * Test for remote ref deletion.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateDelete() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db, null,
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
 		testOneUpdateStatus(rru, ref, Status.OK, true);
 	}
 
 	/**
 	 * Test for remote ref deletion (try), when that ref doesn't exist on remote
 	 * repo.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateDeleteNonExisting() throws IOException {
@@ -170,21 +170,21 @@ public class PushProcessTest extends RepositoryTestCase {
 
 	/**
 	 * Test for remote ref update, when it is already up to date.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateUpToDate() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
 		testOneUpdateStatus(rru, ref, Status.UP_TO_DATE, null);
 	}
 
 	/**
 	 * Test for remote ref update with expected remote object.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateExpectedRemote() throws IOException {
@@ -192,15 +192,15 @@ public class PushProcessTest extends RepositoryTestCase {
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, null, ObjectId
 						.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		testOneUpdateStatus(rru, ref, Status.OK, true);
 	}
 
 	/**
 	 * Test for remote ref update with expected old object set, when old object
 	 * is not that expected one.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateUnexpectedRemote() throws IOException {
@@ -208,8 +208,8 @@ public class PushProcessTest extends RepositoryTestCase {
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, null, ObjectId
 						.fromString("0000000000000000000000000000000000000001"));
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		testOneUpdateStatus(rru, ref, Status.REJECTED_REMOTE_CHANGED, null);
 	}
 
@@ -217,7 +217,7 @@ public class PushProcessTest extends RepositoryTestCase {
 	 * Test for remote ref update with expected old object set, when old object
 	 * is not that expected one and force update flag is set (which should have
 	 * lower priority) - shouldn't change behavior.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateUnexpectedRemoteVsForce() throws IOException {
@@ -225,14 +225,14 @@ public class PushProcessTest extends RepositoryTestCase {
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", true, null, ObjectId
 						.fromString("0000000000000000000000000000000000000001"));
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		testOneUpdateStatus(rru, ref, Status.REJECTED_REMOTE_CHANGED, null);
 	}
 
 	/**
 	 * Test for remote ref udpate, when connection rejects update.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateRejectedByConnection() throws IOException {
@@ -240,22 +240,22 @@ public class PushProcessTest extends RepositoryTestCase {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		testOneUpdateStatus(rru, ref, Status.REJECTED_OTHER_REASON, null);
 	}
 
 	/**
 	 * Test for remote refs updates with mixed cases that shouldn't depend on
 	 * each other.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testUpdateMixedCases() throws IOException {
 		final RemoteRefUpdate rruOk = new RemoteRefUpdate(db, null,
 				"refs/heads/master", false, null, null);
-		final Ref refToChange = new Ref("refs/heads/master", ObjectId
-				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final Ref refToChange = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
 		final RemoteRefUpdate rruReject = new RemoteRefUpdate(db, null,
 				"refs/heads/nonexisting", false, null, null);
 		refUpdates.add(rruOk);
@@ -269,15 +269,15 @@ public class PushProcessTest extends RepositoryTestCase {
 
 	/**
 	 * Test for local tracking ref update.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testTrackingRefUpdateEnabled() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, "refs/remotes/test/master", null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		refUpdates.add(rru);
 		advertisedRefs.add(ref);
 		final PushResult result = executePush();
@@ -290,15 +290,15 @@ public class PushProcessTest extends RepositoryTestCase {
 
 	/**
 	 * Test for local tracking ref update disabled.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testTrackingRefUpdateDisabled() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		refUpdates.add(rru);
 		advertisedRefs.add(ref);
 		final PushResult result = executePush();
@@ -307,15 +307,15 @@ public class PushProcessTest extends RepositoryTestCase {
 
 	/**
 	 * Test for local tracking ref update when remote update has failed.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testTrackingRefUpdateOnReject() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"ac7e7e44c1885efb472ad54a78327d66bfc4ecef",
 				"refs/heads/master", false, null, null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
 		final PushResult result = testOneUpdateStatus(rru, ref,
 				Status.REJECTED_NONFASTFORWARD, null);
 		assertTrue(result.getTrackingRefUpdates().isEmpty());
@@ -323,15 +323,15 @@ public class PushProcessTest extends RepositoryTestCase {
 
 	/**
 	 * Test for push operation result - that contains expected elements.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void testPushResult() throws IOException {
 		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
 				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
 				"refs/heads/master", false, "refs/remotes/test/master", null);
-		final Ref ref = new Ref("refs/heads/master", ObjectId
-				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref(Ref.Storage.LOOSE, "refs/heads/master",
+				ObjectId.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
 		refUpdates.add(rru);
 		advertisedRefs.add(ref);
 		final PushResult result = executePush();
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
index 33b3fba..341b4a4 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
@@ -53,12 +53,12 @@ public class RefSpecTestCase extends TestCase {
 		assertEquals(sn + ":" + sn, rs.toString());
 		assertEquals(rs, new RefSpec(rs.toString()));
 
-		Ref r = new Ref(sn, null);
+		Ref r = new Ref(Ref.Storage.LOOSE, sn, null);
 		assertTrue(rs.matchSource(r));
 		assertTrue(rs.matchDestination(r));
 		assertSame(rs, rs.expandFromSource(r));
 
-		r = new Ref(sn + "-and-more", null);
+		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 	}
@@ -73,12 +73,12 @@ public class RefSpecTestCase extends TestCase {
 		assertEquals("+" + sn + ":" + sn, rs.toString());
 		assertEquals(rs, new RefSpec(rs.toString()));
 
-		Ref r = new Ref(sn, null);
+		Ref r = new Ref(Ref.Storage.LOOSE, sn, null);
 		assertTrue(rs.matchSource(r));
 		assertTrue(rs.matchDestination(r));
 		assertSame(rs, rs.expandFromSource(r));
 
-		r = new Ref(sn + "-and-more", null);
+		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 	}
@@ -93,12 +93,12 @@ public class RefSpecTestCase extends TestCase {
 		assertEquals(sn, rs.toString());
 		assertEquals(rs, new RefSpec(rs.toString()));
 
-		Ref r = new Ref(sn, null);
+		Ref r = new Ref(Ref.Storage.LOOSE, sn, null);
 		assertTrue(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 		assertSame(rs, rs.expandFromSource(r));
 
-		r = new Ref(sn + "-and-more", null);
+		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 	}
@@ -113,12 +113,12 @@ public class RefSpecTestCase extends TestCase {
 		assertEquals("+" + sn, rs.toString());
 		assertEquals(rs, new RefSpec(rs.toString()));
 
-		Ref r = new Ref(sn, null);
+		Ref r = new Ref(Ref.Storage.LOOSE, sn, null);
 		assertTrue(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 		assertSame(rs, rs.expandFromSource(r));
 
-		r = new Ref(sn + "-and-more", null);
+		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 	}
@@ -133,12 +133,12 @@ public class RefSpecTestCase extends TestCase {
 		assertEquals(":" + sn, rs.toString());
 		assertEquals(rs, new RefSpec(rs.toString()));
 
-		Ref r = new Ref(sn, null);
+		Ref r = new Ref(Ref.Storage.LOOSE, sn, null);
 		assertFalse(rs.matchSource(r));
 		assertTrue(rs.matchDestination(r));
 		assertSame(rs, rs.expandFromSource(r));
 
-		r = new Ref(sn + "-and-more", null);
+		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 	}
@@ -157,7 +157,7 @@ public class RefSpecTestCase extends TestCase {
 		Ref r;
 		RefSpec expanded;
 
-		r = new Ref("refs/heads/master", null);
+		r = new Ref(Ref.Storage.LOOSE, "refs/heads/master", null);
 		assertTrue(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 		expanded = rs.expandFromSource(r);
@@ -167,11 +167,11 @@ public class RefSpecTestCase extends TestCase {
 		assertEquals(r.getName(), expanded.getSource());
 		assertEquals("refs/remotes/origin/master", expanded.getDestination());
 
-		r = new Ref("refs/remotes/origin/next", null);
+		r = new Ref(Ref.Storage.LOOSE, "refs/remotes/origin/next", null);
 		assertFalse(rs.matchSource(r));
 		assertTrue(rs.matchDestination(r));
 
-		r = new Ref("refs/tags/v1.0", null);
+		r = new Ref(Ref.Storage.LOOSE, "refs/tags/v1.0", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
index b7e361f..5b0e13f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
@@ -45,6 +45,74 @@ package org.spearce.jgit.lib;
  * commit, annotated tag, ...).
  */
 public class Ref {
+	/** Location where a {@link Ref} is stored. */
+	public static enum Storage {
+		/**
+		 * The ref does not exist yet, updating it may create it.
+		 * <p>
+		 * Creation is likely to choose {@link #LOOSE} storage.
+		 */
+		NEW(true, false),
+
+		/**
+		 * The ref is stored in a file by itself.
+		 * <p>
+		 * Updating this ref affects only this ref.
+		 */
+		LOOSE(true, false),
+
+		/**
+		 * The ref is stored in the <code>packed-refs</code> file, with
+		 * others.
+		 * <p>
+		 * Updating this ref requires rewriting the file, with perhaps many
+		 * other refs being included at the same time.
+		 */
+		PACKED(false, true),
+
+		/**
+		 * The ref is both {@link #LOOSE} and {@link #PACKED}.
+		 * <p>
+		 * Updating this ref requires only updating the loose file, but deletion
+		 * requires updating both the loose file and the packed refs file.
+		 */
+		LOOSE_PACKED(true, true),
+
+		/**
+		 * The ref came from a network advertisement and storage is unknown.
+		 * <p>
+		 * This ref cannot be updated without Git-aware support on the remote
+		 * side, as Git-aware code consolidate the remote refs and reported them
+		 * to this process.
+		 */
+		NETWORK(false, false);
+
+		private final boolean loose;
+
+		private final boolean packed;
+
+		private Storage(final boolean l, final boolean p) {
+			loose = l;
+			packed = p;
+		}
+
+		/**
+		 * @return true if this storage has a loose file.
+		 */
+		public boolean isLoose() {
+			return loose;
+		}
+
+		/**
+		 * @return true if this storage is inside the packed file.
+		 */
+		public boolean isPacked() {
+			return packed;
+		}
+	}
+
+	private final Storage storage;
+
 	private final String name;
 
 	private ObjectId objectId;
@@ -54,13 +122,16 @@ public class Ref {
 	/**
 	 * Create a new ref pairing.
 	 * 
+	 * @param st
+	 *            method used to store this ref.
 	 * @param refName
 	 *            name of this ref.
 	 * @param id
 	 *            current value of the ref. May be null to indicate a ref that
 	 *            does not exist yet.
 	 */
-	public Ref(final String refName, final ObjectId id) {
+	public Ref(final Storage st, final String refName, final ObjectId id) {
+		storage = st;
 		name = refName;
 		objectId = id;
 	}
@@ -68,6 +139,8 @@ public class Ref {
 	/**
 	 * Create a new ref pairing.
 	 * 
+	 * @param st
+	 *            method used to store this ref.
 	 * @param refName
 	 *            name of this ref.
 	 * @param id
@@ -77,7 +150,9 @@ public class Ref {
 	 *            peeled value of the ref's tag. May be null if this is not a
 	 *            tag or the peeled value is not known.
 	 */
-	public Ref(final String refName, final ObjectId id, final ObjectId peel) {
+	public Ref(final Storage st, final String refName, final ObjectId id,
+			final ObjectId peel) {
+		storage = st;
 		name = refName;
 		objectId = id;
 		peeledObjectId = peel;
@@ -112,6 +187,18 @@ public class Ref {
 		return peeledObjectId;
 	}
 
+	/**
+	 * How was this ref obtained?
+	 * <p>
+	 * The current storage model of a Ref may influence how the ref must be
+	 * updated or deleted from the repository.
+	 * 
+	 * @return type of ref.
+	 */
+	public Storage getStorage() {
+		return storage;
+	}
+
 	public String toString() {
 		return "Ref[" + name + "=" + getObjectId() + "]";
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 1857982..9e3e020 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -126,12 +126,12 @@ class RefDatabase {
 	RefUpdate newUpdate(final String name) throws IOException {
 		Ref r = readRefBasic(name, 0);
 		if (r == null)
-			r = new Ref(name, null);
+			r = new Ref(Ref.Storage.NEW, name, null);
 		return new RefUpdate(this, r, fileForRef(r.getName()));
 	}
 
 	void stored(final String name, final ObjectId id, final long time) {
-		looseRefs.put(name, new CachedRef(name, id, time));
+		looseRefs.put(name, new CachedRef(Ref.Storage.LOOSE, name, id, time));
 	}
 
 	/**
@@ -256,7 +256,8 @@ class RefDatabase {
 					return;
 				}
 
-				ref = new CachedRef(refName, id, ent.lastModified());
+				ref = new CachedRef(Ref.Storage.LOOSE, refName, id, ent
+						.lastModified());
 				looseRefs.put(ref.getName(), ref);
 				avail.put(ref.getName(), ref);
 			} finally {
@@ -307,7 +308,7 @@ class RefDatabase {
 		}
 
 		if (line == null || line.length() == 0)
-			return new Ref(name, null);
+			return new Ref(Ref.Storage.LOOSE, name, null);
 
 		if (line.startsWith("ref: ")) {
 			if (depth >= 5) {
@@ -317,7 +318,7 @@ class RefDatabase {
 
 			final String target = line.substring("ref: ".length());
 			final Ref r = readRefBasic(target, depth + 1);
-			return r != null ? r : new Ref(target, null);
+			return r != null ? r : new Ref(Ref.Storage.LOOSE, target, null);
 		}
 
 		final ObjectId id;
@@ -327,7 +328,7 @@ class RefDatabase {
 			throw new IOException("Not a ref: " + name + ": " + line);
 		}
 
-		ref = new CachedRef(name, id, mtime);
+		ref = new CachedRef(Ref.Storage.LOOSE, name, id, mtime);
 		looseRefs.put(name, ref);
 		return ref;
 	}
@@ -359,7 +360,8 @@ class RefDatabase {
 							throw new IOException("Peeled line before ref.");
 
 						final ObjectId id = ObjectId.fromString(p.substring(1));
-						last = new Ref(last.getName(), last.getObjectId(), id);
+						last = new Ref(Ref.Storage.PACKED, last.getName(), last
+								.getObjectId(), id);
 						newPackedRefs.put(last.getName(), last);
 						continue;
 					}
@@ -367,7 +369,7 @@ class RefDatabase {
 					final int sp = p.indexOf(' ');
 					final ObjectId id = ObjectId.fromString(p.substring(0, sp));
 					final String name = new String(p.substring(sp + 1));
-					last = new Ref(name, id);
+					last = new Ref(Ref.Storage.PACKED, name, id);
 					newPackedRefs.put(last.getName(), last);
 				}
 			} finally {
@@ -406,8 +408,9 @@ class RefDatabase {
 	private static class CachedRef extends Ref {
 		final long lastModified;
 
-		CachedRef(final String refName, final ObjectId id, final long mtime) {
-			super(refName, id);
+		CachedRef(final Storage st, final String refName, final ObjectId id,
+				final long mtime) {
+			super(st, refName, id);
 			lastModified = mtime;
 		}
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 2ccd422..a878f01 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -161,9 +161,11 @@ abstract class BasePackConnection extends BaseConnection {
 				if (prior.getPeeledObjectId() != null)
 					throw duplicateAdvertisement(name + "^{}");
 
-				avail.put(name, new Ref(name, prior.getObjectId(), id));
+				avail.put(name, new Ref(Ref.Storage.NETWORK, name, prior
+						.getObjectId(), id));
 			} else {
-				final Ref prior = avail.put(name, new Ref(name, id));
+				final Ref prior;
+				prior = avail.put(name, new Ref(Ref.Storage.NETWORK, name, id));
 				if (prior != null)
 					throw duplicateAdvertisement(name);
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 1bf081a..6169179 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -165,7 +165,8 @@ class TransportBundle extends PackTransport {
 
 				final String name = line.substring(41, line.length());
 				final ObjectId id = ObjectId.fromString(line.substring(0, 40));
-				final Ref prior = avail.put(name, new Ref(name, id));
+				final Ref prior = avail.put(name, new Ref(Ref.Storage.NETWORK,
+						name, id));
 				if (prior != null)
 					throw duplicateAdvertisement(name);
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index 33f9f90..b18b8e3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -235,9 +235,11 @@ class TransportHttp extends WalkTransport {
 					if (prior.getPeeledObjectId() != null)
 						throw duplicateAdvertisement(name + "^{}");
 
-					avail.put(name, new Ref(name, prior.getObjectId(), id));
+					avail.put(name, new Ref(Ref.Storage.NETWORK, name, prior
+							.getObjectId(), id));
 				} else {
-					final Ref prior = avail.put(name, new Ref(name, id));
+					final Ref prior = avail.put(name, new Ref(
+							Ref.Storage.NETWORK, name, id));
 					if (prior != null)
 						throw duplicateAdvertisement(name);
 				}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index 21657ef..092c5d3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -54,6 +54,7 @@ import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Ref.Storage;
 
 import com.jcraft.jsch.Channel;
 import com.jcraft.jsch.ChannelSftp;
@@ -277,7 +278,8 @@ class TransportSftp extends WalkTransport {
 					if (last == null)
 						throw new TransportException("Peeled line before ref.");
 					final ObjectId id = ObjectId.fromString(line + 1);
-					last = new Ref(last.getName(), last.getObjectId(), id);
+					last = new Ref(Ref.Storage.PACKED, last.getName(), last
+							.getObjectId(), id);
 					avail.put(last.getName(), last);
 					continue;
 				}
@@ -287,7 +289,7 @@ class TransportSftp extends WalkTransport {
 					throw new TransportException("Unrecognized ref: " + line);
 				final ObjectId id = ObjectId.fromString(line.substring(0, sp));
 				final String name = line.substring(sp + 1);
-				last = new Ref(name, id);
+				last = new Ref(Ref.Storage.PACKED, name, id);
 				avail.put(last.getName(), last);
 			}
 		}
@@ -342,14 +344,16 @@ class TransportSftp extends WalkTransport {
 				if (r == null)
 					r = avail.get(p);
 				if (r != null) {
-					r = new Ref(name, r.getObjectId(), r.getPeeledObjectId());
+					r = new Ref(loose(r), name, r.getObjectId(), r
+							.getPeeledObjectId());
 					avail.put(name, r);
 				}
 				return r;
 			}
 
 			if (ObjectId.isId(line)) {
-				final Ref r = new Ref(name, ObjectId.fromString(line));
+				final Ref r = new Ref(loose(avail.get(name)), name, ObjectId
+						.fromString(line));
 				avail.put(r.getName(), r);
 				return r;
 			}
@@ -357,6 +361,12 @@ class TransportSftp extends WalkTransport {
 			throw new TransportException("Bad ref: " + name + ": " + line);
 		}
 
+		private Storage loose(final Ref r) {
+			if (r != null && r.getStorage() == Storage.PACKED)
+				return Storage.LOOSE_PACKED;
+			return Storage.LOOSE;
+		}
+
 		@Override
 		void close() {
 			if (ftp != null) {
-- 
1.5.6.74.g8a5e
