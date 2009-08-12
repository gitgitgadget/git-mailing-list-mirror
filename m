From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2] Rename RevTag.getName() to RevTag.getTagName()
Date: Wed, 12 Aug 2009 13:51:08 -0700
Message-ID: <20090812205108.GI1033@spearce.org>
References: <1250105956-17795-1-git-send-email-spearce@spearce.org> <200908122237.37148.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKn0-0001IM-7C
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbZHLUvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbZHLUvI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:51:08 -0400
Received: from george.spearce.org ([209.20.77.23]:49350 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbZHLUvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:51:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 41727381FD; Wed, 12 Aug 2009 20:51:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200908122237.37148.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125746>

The method getName() conflicts semantically with the method name()
we have inherited from our base class, ObjectId.  It is a rather
unfortunate turn of events that for performance reasons we wind up
subclassing what should be a property of this class, but since we
do that we need to pay attention to the methods declared on our
base class.

We want to use getName() to be a mirror of name() on AnyObjectId,
as it has a more JavaBeans style feel to the accessing of that
particular value.  So, rename getTagName() so it doesn't wind up
conflicting with the SHA-1 hex formatted string.

Noticed-by: Alex Blewitt <alex.blewitt@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
 > You forgot the rename of the method here, and all uses of it.

 Quite right.  #@*!! Eclipse.  I thought I refactored that method,
 but I guess it didn't actually do the work, and I failed to read
 the diff closely enough to notice.  *sigh* That's what I get for
 trying to quickly bang out a "simple" change.

 .../org/spearce/jgit/revwalk/RevTagParseTest.java  |    8 ++++----
 .../src/org/spearce/jgit/revwalk/RevTag.java       |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java
index 66bc901..9f91154 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java
@@ -75,7 +75,7 @@ private void testOneType(final int typeCode) throws Exception {
 
 		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
 		assertNull(c.getObject());
-		assertNull(c.getName());
+		assertNull(c.getTagName());
 
 		c.parseCanonical(rw, b.toString().getBytes("UTF-8"));
 		assertNotNull(c.getObject());
@@ -117,15 +117,15 @@ public void testParseAllFields() throws Exception {
 
 		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
 		assertNull(c.getObject());
-		assertNull(c.getName());
+		assertNull(c.getTagName());
 
 		c.parseCanonical(rw, body.toString().getBytes("UTF-8"));
 		assertNotNull(c.getObject());
 		assertEquals(treeId, c.getObject().getId());
 		assertSame(rw.lookupTree(treeId), c.getObject());
 
-		assertNotNull(c.getName());
-		assertEquals(name, c.getName());
+		assertNotNull(c.getTagName());
+		assertEquals(name, c.getTagName());
 		assertEquals("", c.getFullMessage());
 
 		final PersonIdent cTagger = c.getTaggerIdent();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index 2fab266..204e9b1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -56,7 +56,7 @@
 
 	private byte[] buffer;
 
-	private String name;
+	private String tagName;
 
 	/**
 	 * Create a new tag reference.
@@ -96,7 +96,7 @@ void parseCanonical(final RevWalk walk, final byte[] rawTag)
 
 		int p = pos.value += 4; // "tag "
 		final int nameEnd = RawParseUtils.nextLF(rawTag, p) - 1;
-		name = RawParseUtils.decode(Constants.CHARSET, rawTag, p, nameEnd);
+		tagName = RawParseUtils.decode(Constants.CHARSET, rawTag, p, nameEnd);
 
 		if (walk.isRetainBody())
 			buffer = rawTag;
@@ -186,7 +186,7 @@ public final String getShortMessage() {
 	 * @return parsed tag.
 	 */
 	public Tag asTag(final RevWalk walk) {
-		return new Tag(walk.db, this, name, buffer);
+		return new Tag(walk.db, this, tagName, buffer);
 	}
 
 	/**
@@ -203,8 +203,8 @@ public final RevObject getObject() {
 	 * 
 	 * @return name of the tag, according to the tag header.
 	 */
-	public final String getName() {
-		return name;
+	public final String getTagName() {
+		return tagName;
 	}
 
 	final void disposeBody() {
-- 
1.6.4.225.gb589e
