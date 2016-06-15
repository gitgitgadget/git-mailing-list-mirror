From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2 09/10] Add test cases for loading new (or replaced)
	pack files
Date: Mon, 20 Apr 2009 19:10:35 -0700
Message-ID: <20090421021035.GB23604@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org> <1240276872-17893-2-git-send-email-spearce@spearce.org> <1240276872-17893-3-git-send-email-spearce@spearce.org> <1240276872-17893-4-git-send-email-spearce@spearce.org> <1240276872-17893-5-git-send-email-spearce@spearce.org> <1240276872-17893-6-git-send-email-spearce@spearce.org> <1240276872-17893-7-git-send-email-spearce@spearce.org> <1240276872-17893-8-git-send-email-spearce@spearce.org> <1240276872-17893-9-git-send-email-spearce@spearce.org> <1240276872-17893-10-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 04:12:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw5T2-0002jK-7h
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 04:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbZDUCKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 22:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbZDUCKh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 22:10:37 -0400
Received: from george.spearce.org ([209.20.77.23]:56483 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZDUCKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 22:10:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DDC6638211; Tue, 21 Apr 2009 02:10:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1240276872-17893-10-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117075>

Originally-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Matches with v2 08/10.  Tests take a few seconds longer now as
 we have to delay at least 1 second on most filesystems; longer if
 their modification timestamp granularity is larger than 1 second.

 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |  222 ++++++++++++++++++++
 1 files changed, 222 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
new file mode 100644
index 0000000..825fbb8
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
@@ -0,0 +1,222 @@
+/*
+ * Copyright (C) 2009, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevWalk;
+
+public class ConcurrentRepackTest extends RepositoryTestCase {
+	public void setUp() throws Exception {
+		WindowCacheConfig windowCacheConfig = new WindowCacheConfig();
+		windowCacheConfig.setPackedGitOpenFiles(1);
+		WindowCache.reconfigure(windowCacheConfig);
+		super.setUp();
+	}
+
+	protected void tearDown() throws Exception {
+		super.tearDown();
+		WindowCacheConfig windowCacheConfig = new WindowCacheConfig();
+		WindowCache.reconfigure(windowCacheConfig);
+	}
+
+	public void testObjectInNewPack() throws IncorrectObjectTypeException,
+			IOException {
+		// Create a new object in a new pack, and test that it is present.
+		//
+		final Repository eden = createNewEmptyRepo();
+		final RevObject o1 = writeBlob(eden, "o1");
+		pack(eden, o1);
+		assertEquals(o1.name(), parse(o1).name());
+	}
+
+	public void testObjectMovedToNewPack1()
+			throws IncorrectObjectTypeException, IOException {
+		// Create an object and pack it. Then remove that pack and put the
+		// object into a different pack file, with some other object. We
+		// still should be able to access the objects.
+		//
+		final Repository eden = createNewEmptyRepo();
+		final RevObject o1 = writeBlob(eden, "o1");
+		final File[] out1 = pack(eden, o1);
+		assertEquals(o1.name(), parse(o1).name());
+
+		final RevObject o2 = writeBlob(eden, "o2");
+		pack(eden, o2, o1);
+
+		// Force close, and then delete, the old pack.
+		//
+		whackCache();
+		delete(out1);
+
+		// Now here is the interesting thing. Will git figure the new
+		// object exists in the new pack, and not the old one.
+		//
+		assertEquals(o2.name(), parse(o2).name());
+		assertEquals(o1.name(), parse(o1).name());
+	}
+
+	public void testObjectMovedWithinPack()
+			throws IncorrectObjectTypeException, IOException {
+		// Create an object and pack it.
+		//
+		final Repository eden = createNewEmptyRepo();
+		final RevObject o1 = writeBlob(eden, "o1");
+		final File[] out1 = pack(eden, o1);
+		assertEquals(o1.name(), parse(o1).name());
+
+		// Force close the old pack.
+		//
+		whackCache();
+
+		// Now overwrite the old pack in place. This method of creating a
+		// different pack under the same file name is partially broken. We
+		// should also have a different file name because the list of objects
+		// within the pack has been modified.
+		//
+		final RevObject o2 = writeBlob(eden, "o2");
+		final PackWriter pw = new PackWriter(eden, NullProgressMonitor.INSTANCE);
+		pw.addObject(o2);
+		pw.addObject(o1);
+		write(out1, pw);
+
+		// Try the old name, then the new name. The old name should cause the
+		// pack to reload when it opens and the index and pack mismatch.
+		//
+		assertEquals(o1.name(), parse(o1).name());
+		assertEquals(o2.name(), parse(o2).name());
+	}
+
+	private static void whackCache() {
+		final WindowCacheConfig config = new WindowCacheConfig();
+
+		config.setPackedGitOpenFiles(0);
+		WindowCache.reconfigure(config);
+
+		config.setPackedGitOpenFiles(1);
+		WindowCache.reconfigure(config);
+	}
+
+	private RevObject parse(final AnyObjectId id)
+			throws MissingObjectException, IOException {
+		return new RevWalk(db).parseAny(id);
+	}
+
+	private File[] pack(final Repository src, final RevObject... list)
+			throws IOException {
+		final PackWriter pw = new PackWriter(src, NullProgressMonitor.INSTANCE);
+		for (final RevObject o : list) {
+			pw.addObject(o);
+		}
+
+		final ObjectId name = pw.computeName();
+		final File packFile = fullPackFileName(name, ".pack");
+		final File idxFile = fullPackFileName(name, ".idx");
+		final File[] files = new File[] { packFile, idxFile };
+		write(files, pw);
+		return files;
+	}
+
+	private static void write(final File[] files, final PackWriter pw)
+			throws IOException {
+		final long begin = files[0].getParentFile().lastModified();
+		FileOutputStream out;
+
+		out = new FileOutputStream(files[0]);
+		try {
+			pw.writePack(out);
+		} finally {
+			out.close();
+		}
+
+		out = new FileOutputStream(files[1]);
+		try {
+			pw.writeIndex(out);
+		} finally {
+			out.close();
+		}
+
+		touch(begin, files[0].getParentFile());
+	}
+
+	private static void delete(final File[] list) {
+		final long begin = list[0].getParentFile().lastModified();
+		for (final File f : list) {
+			f.delete();
+			assertFalse(f + " was removed", f.exists());
+		}
+		touch(begin, list[0].getParentFile());
+	}
+
+	private static void touch(final long begin, final File dir) {
+		while (begin >= dir.lastModified()) {
+			try {
+				Thread.sleep(25);
+			} catch (InterruptedException ie) {
+				//
+			}
+			dir.setLastModified(System.currentTimeMillis());
+		}
+	}
+
+	private File fullPackFileName(final ObjectId name, final String suffix) {
+		final File packdir = new File(db.getObjectsDirectory(), "pack");
+		return new File(packdir, "pack-" + name.name() + suffix);
+	}
+
+	private RevObject writeBlob(final Repository repo, final String data)
+			throws IOException {
+		final RevWalk revWalk = new RevWalk(repo);
+		final byte[] bytes = data.getBytes(Constants.CHARACTER_ENCODING);
+		final ObjectWriter ow = new ObjectWriter(repo);
+		final ObjectId id = ow.writeBlob(bytes);
+		try {
+			parse(id);
+			fail("Object " + id.name() + " should not exist in test repository");
+		} catch (MissingObjectException e) {
+			// Ok
+		}
+		return revWalk.lookupBlob(id);
+	}
+}
-- 
1.6.3.rc1.188.ga02b
