From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/6] Add RefSpec.expandFromDestination for reverse mappings
Date: Thu, 12 Feb 2009 15:54:37 -0800
Message-ID: <1234482880-1316-4-git-send-email-spearce@spearce.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org>
 <1234482880-1316-2-git-send-email-spearce@spearce.org>
 <1234482880-1316-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlPm-0004ei-HM
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbZBLXyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbZBLXyr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:54:47 -0500
Received: from george.spearce.org ([209.20.77.23]:49156 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbZBLXyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:54:44 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4EEDF38239; Thu, 12 Feb 2009 23:54:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8591738210;
	Thu, 12 Feb 2009 23:54:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.226.gf08f
In-Reply-To: <1234482880-1316-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109689>

This makes it easy to loop through the destination's refs and see
if any match up to a source name which doesn't actually exist in
the set of available source refs.  In such cases, we may want to
delete the destination ref.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/RefSpecTestCase.java    |   22 ++++++
 .../src/org/spearce/jgit/transport/RefSpec.java    |   73 ++++++++++++++------
 2 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
index 341b4a4..11e7cdb 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
@@ -232,4 +232,26 @@ public void testSetSourceDestination() {
 		assertEquals("HEAD", a.toString());
 		assertEquals("refs/heads/*:refs/remotes/origin/*", b.toString());
 	}
+
+	public void testExpandFromDestination_NonWildcard() {
+		final String src = "refs/heads/master";
+		final String dst = "refs/remotes/origin/master";
+		final RefSpec a = new RefSpec(src + ":" + dst);
+		final RefSpec r = a.expandFromDestination(dst);
+		assertSame(a, r);
+		assertFalse(r.isWildcard());
+		assertEquals(src, r.getSource());
+		assertEquals(dst, r.getDestination());
+	}
+
+	public void testExpandFromDestination_Wildcard() {
+		final String src = "refs/heads/master";
+		final String dst = "refs/remotes/origin/master";
+		final RefSpec a = new RefSpec("refs/heads/*:refs/remotes/origin/*");
+		final RefSpec r = a.expandFromDestination(dst);
+		assertNotSame(a, r);
+		assertFalse(r.isWildcard());
+		assertEquals(src, r.getSource());
+		assertEquals(dst, r.getDestination());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
index 521110b..bc6ea3a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
@@ -135,24 +135,6 @@ else if (isWildcard(srcName) || isWildcard(dstName))
 		}
 	}
 
-	/**
-	 * Expand a wildcard specification.
-	 * 
-	 * @param p
-	 *            the wildcard specification we should base ourselves on.
-	 * @param name
-	 *            actual name that matched the source of <code>p</code>.
-	 */
-	protected RefSpec(final RefSpec p, final String name) {
-		final String pdst = p.getDestination();
-		if (p.getSource() == null || pdst == null)
-			throw new IllegalArgumentException("Cannot expand from " + p);
-		force = p.isForceUpdate();
-		srcName = name;
-		dstName = pdst.substring(0, pdst.length() - 1)
-				+ name.substring(p.getSource().length() - 1);
-	}
-
 	private RefSpec(final RefSpec p) {
 		force = p.isForceUpdate();
 		wildcard = p.isWildcard();
@@ -349,7 +331,16 @@ public boolean matchDestination(final Ref r) {
 	 *         wildcard.
 	 */
 	public RefSpec expandFromSource(final String r) {
-		return isWildcard() ? new RefSpec(this, r) : this;
+		return isWildcard() ? new RefSpec(this).expandFromSourceImp(r) : this;
+	}
+
+	private RefSpec expandFromSourceImp(final String name) {
+		final String psrc = srcName, pdst = dstName;
+		wildcard = false;
+		srcName = name;
+		dstName = pdst.substring(0, pdst.length() - 1)
+				+ name.substring(psrc.length() - 1);
+		return this;
 	}
 
 	/**
@@ -366,7 +357,49 @@ public RefSpec expandFromSource(final String r) {
 	 *         wildcard.
 	 */
 	public RefSpec expandFromSource(final Ref r) {
-		return isWildcard() ? new RefSpec(this, r.getName()) : this;
+		return expandFromSource(r.getName());
+	}
+
+	/**
+	 * Expand this specification to exactly match a ref name.
+	 * <p>
+	 * Callers must first verify the passed ref name matches this specification,
+	 * otherwise expansion results may be unpredictable.
+	 * 
+	 * @param r
+	 *            a ref name that matched our destination specification. Could
+	 *            be a wildcard also.
+	 * @return a new specification expanded from provided ref name. Result
+	 *         specification is wildcard if and only if provided ref name is
+	 *         wildcard.
+	 */
+	public RefSpec expandFromDestination(final String r) {
+		return isWildcard() ? new RefSpec(this).expandFromDstImp(r) : this;
+	}
+
+	private RefSpec expandFromDstImp(final String name) {
+		final String psrc = srcName, pdst = dstName;
+		wildcard = false;
+		srcName = psrc.substring(0, psrc.length() - 1)
+				+ name.substring(pdst.length() - 1);
+		dstName = name;
+		return this;
+	}
+
+	/**
+	 * Expand this specification to exactly match a ref.
+	 * <p>
+	 * Callers must first verify the passed ref matches this specification,
+	 * otherwise expansion results may be unpredictable.
+	 * 
+	 * @param r
+	 *            a ref that matched our destination specification.
+	 * @return a new specification expanded from provided ref name. Result
+	 *         specification is wildcard if and only if provided ref name is
+	 *         wildcard.
+	 */
+	public RefSpec expandFromDestination(final Ref r) {
+		return expandFromDestination(r.getName());
 	}
 
 	private boolean match(final String refName, final String s) {
-- 
1.6.2.rc0.226.gf08f
