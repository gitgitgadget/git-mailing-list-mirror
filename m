From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/3] Improved object validation
Date: Fri, 31 Oct 2008 07:55:01 -0700
Message-ID: <20081031145501.GT14786@spearce.org>
References: <1225388785-26818-1-git-send-email-spearce@spearce.org> <200810310101.12241.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 15:56:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvvQB-0001FM-AB
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 15:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbYJaOzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYJaOzF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 10:55:05 -0400
Received: from george.spearce.org ([209.20.77.23]:37609 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbYJaOzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 10:55:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B780F38360; Fri, 31 Oct 2008 14:55:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200810310101.12241.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99592>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> torsdagen den 30 oktober 2008 18.46.22 skrev Shawn O. Pearce:
> > This is mostly a resend as I haven't heard anything on the series.
> > One new patch at the end, to handle '.' and '..' cases.
> Ack, pushed now.  I never got to the push action, because I wanted
> to do some testing on the bundlewriter (which you did not resubmit) and
> the I went to a warmer place for a few days.
> 
> These patches and the bundlewrite + a small unit test for it now pushed.

Thanks for putting together the bundle writer test.  I had to fix
it a bit to avoid the /home/me path it had hardcoded in there.
This patch was applied on top of master and pushed out.

I meant to work on a test for BundleWriter myself, but I got too busy
with other stuff and totally forgot about it.  I wasn't pushing to
get the BundleWriter included as it was non-critical to my current
needs, but I had it written so I posted it in case someone else
cared about it.

--8<--
[PATCH] Fix BundleWriter unit test to work for people who are not 'me'

My system lacks a /home/me as I do not call myself me.  My login is
usually based upon my email address, and nobody else on my system is
'me'.  So we cannot use hardcoded paths like /home/me in a test case.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BundleWriterTest.java   |   68 ++++++++++----------
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java
index 4e33108..3cfb8b1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java
@@ -37,11 +37,13 @@
 
 package org.spearce.jgit.transport;
 
+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
 import java.io.FileNotFoundException;
-import java.io.FileOutputStream;
 import java.io.IOException;
 import java.net.URISyntaxException;
 import java.util.Collections;
+import java.util.Set;
 
 import org.spearce.jgit.errors.MissingBundlePrerequisiteException;
 import org.spearce.jgit.errors.NotSupportedException;
@@ -58,15 +60,14 @@
 
 	public void testWrite0() throws Exception {
 		// Create a tiny bundle, (well one of) the first commits only
-		URIish bundleURI = new URIish("file:///home/me/tmp/foo");
-		makeBundle("refs/heads/firstcommit",
-				"42e4e7c5e507e113ebbb7801b16b52cf867b7ce1", bundleURI, null);
+		final byte[] bundle = makeBundle("refs/heads/firstcommit",
+				"42e4e7c5e507e113ebbb7801b16b52cf867b7ce1", null);
 
 		// Then we clone a new repo from that bundle and do a simple test. This
 		// makes sure
 		// we could read the bundle we created.
 		Repository newRepo = createNewEmptyRepo();
-		FetchResult fetchResult = fetchFromBundle(newRepo, bundleURI);
+		FetchResult fetchResult = fetchFromBundle(newRepo, bundle);
 		Ref advertisedRef = fetchResult
 				.getAdvertisedRef("refs/heads/firstcommit");
 
@@ -80,19 +81,20 @@ assertEquals("42e4e7c5e507e113ebbb7801b16b52cf867b7ce1", newRepo
 
 	/**
 	 * Incremental bundle test
-	 *
+	 * 
 	 * @throws Exception
 	 */
 	public void testWrite1() throws Exception {
+		byte[] bundle;
+
 		// Create a small bundle, an early commit
-		URIish bundleURI = new URIish("file:///home/me/tmp/foo");
-		makeBundle("refs/heads/aa", db.resolve("a").name(), bundleURI, null);
+		bundle = makeBundle("refs/heads/aa", db.resolve("a").name(), null);
 
 		// Then we clone a new repo from that bundle and do a simple test. This
 		// makes sure
 		// we could read the bundle we created.
 		Repository newRepo = createNewEmptyRepo();
-		FetchResult fetchResult = fetchFromBundle(newRepo, bundleURI);
+		FetchResult fetchResult = fetchFromBundle(newRepo, bundle);
 		Ref advertisedRef = fetchResult.getAdvertisedRef("refs/heads/aa");
 
 		assertEquals(db.resolve("a").name(), advertisedRef.getObjectId().name());
@@ -101,9 +103,9 @@ assertEquals(db.resolve("a").name(), newRepo.resolve("refs/heads/aa")
 		assertNull(newRepo.resolve("refs/heads/a"));
 
 		// Next an incremental bundle
-		makeBundle("refs/heads/cc", db.resolve("c").name(), bundleURI,
+		bundle = makeBundle("refs/heads/cc", db.resolve("c").name(),
 				new RevWalk(db).parseCommit(db.resolve("a").toObjectId()));
-		fetchResult = fetchFromBundle(newRepo, bundleURI);
+		fetchResult = fetchFromBundle(newRepo, bundle);
 		advertisedRef = fetchResult.getAdvertisedRef("refs/heads/cc");
 		assertEquals(db.resolve("c").name(), advertisedRef.getObjectId().name());
 		assertEquals(db.resolve("c").name(), newRepo.resolve("refs/heads/cc")
@@ -114,7 +116,7 @@ assertEquals(db.resolve("c").name(), newRepo.resolve("refs/heads/cc")
 		try {
 			// Check that we actually needed the first bundle
 			Repository newRepo2 = createNewEmptyRepo();
-			fetchResult = fetchFromBundle(newRepo2, bundleURI);
+			fetchResult = fetchFromBundle(newRepo2, bundle);
 			fail("We should not be able to fetch from bundle with prerequisistes that are not fulfilled");
 		} catch (MissingBundlePrerequisiteException e) {
 			assertTrue(e.getMessage()
@@ -122,31 +124,29 @@ assertTrue(e.getMessage()
 		}
 	}
 
-	private FetchResult fetchFromBundle(Repository newRepo, URIish uriish)
-			throws URISyntaxException, NotSupportedException,
-			TransportException {
-		RemoteConfig remoteConfig = new RemoteConfig(newRepo.getConfig(),
-				"origin");
-		remoteConfig.addURI(uriish);
-		RefSpec theRefSpec = new RefSpec("refs/heads/*:refs/heads/*");
-		remoteConfig.addFetchRefSpec(theRefSpec);
-		Transport transport = Transport.open(newRepo, remoteConfig);
-		FetchResult fetch = transport.fetch(new NullProgressMonitor(),
-				Collections.singleton(theRefSpec));
-		return fetch;
+	private FetchResult fetchFromBundle(final Repository newRepo,
+			final byte[] bundle) throws URISyntaxException,
+			NotSupportedException, TransportException {
+		final URIish uri = new URIish("in-memory://");
+		final ByteArrayInputStream in = new ByteArrayInputStream(bundle);
+		final RefSpec rs = new RefSpec("refs/heads/*:refs/heads/*");
+		final Set<RefSpec> refs = Collections.singleton(rs);
+		return new TransportBundleStream(newRepo, uri, in).fetch(
+				NullProgressMonitor.INSTANCE, refs);
 	}
 
-	private void makeBundle(String name, String anObjectToInclude,
-			URIish bundleName, RevCommit assume) throws FileNotFoundException,
-			IOException {
-		BundleWriter bundleWriter = new BundleWriter(db,
-				new NullProgressMonitor());
-		bundleWriter.include(name, ObjectId.fromString(anObjectToInclude));
+	private byte[] makeBundle(final String name,
+			final String anObjectToInclude, final RevCommit assume)
+			throws FileNotFoundException, IOException {
+		final BundleWriter bw;
+
+		bw = new BundleWriter(db, NullProgressMonitor.INSTANCE);
+		bw.include(name, ObjectId.fromString(anObjectToInclude));
 		if (assume != null)
-			bundleWriter.assume(assume);
-		FileOutputStream os = new FileOutputStream(bundleName.getPath());
-		bundleWriter.writeBundle(os);
-		os.close();
+			bw.assume(assume);
+		final ByteArrayOutputStream out = new ByteArrayOutputStream();
+		bw.writeBundle(out);
+		return out.toByteArray();
 	}
 
 }
-- 
1.6.0.3.756.gb776d

-- 
Shawn.
