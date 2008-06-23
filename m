From: =?utf-8?q?Florian=20K=C3=B6berle?= <florianskarten@web.de>
Subject: [[JGIT PATCH]] Implementation of a copy constructor for FileNameMatcher.
Date: Mon, 23 Jun 2008 19:43:34 +0200
Message-ID: <1214243014-8701-1-git-send-email-florianskarten@web.de>
References: <485FDE42.1060106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	=?utf-8?q?Florian=20K=C3=B6berle?= <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 19:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAq6C-0008SU-9e
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbYFWRnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2008 13:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754450AbYFWRnj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:43:39 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:36365 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYFWRnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 13:43:39 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 89767E52F8E2;
	Mon, 23 Jun 2008 19:43:37 +0200 (CEST)
Received: from [84.150.93.234] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KAq4m-0001UF-00; Mon, 23 Jun 2008 19:43:37 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <485FDE42.1060106@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19ykqB2iLJLcgAoWN92S391ZcebC0uT+iOnHNhJ
	xwac6E+zvCnACdlYmdTMRmglbK9VVa2XJ/tX55Pu8MtW0XpOyg
	FbExbRvKt4MW3mowwbsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85894>

Signed-off-by: Florian K=C3=B6berle <florianskarten@web.de>
---
 .../spearce/jgit/fnmatch/FileNameMatcherTest.java  |   31 ++++++++++++=
++++++++
 .../org/spearce/jgit/fnmatch/FileNameMatcher.java  |   30 ++++++++++++=
+++++--
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/FileNam=
eMatcherTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/=
=46ileNameMatcherTest.java
index ad72ac8..0c9501b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/FileNameMatche=
rTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/FileNameMatche=
rTest.java
@@ -723,4 +723,35 @@ public class FileNameMatcherTest extends TestCase =
{
 		assertEquals(true, childMatcher.isMatch());
 		assertEquals(false, childMatcher.canAppendMatch());
 	}
+
+	public void testCopyConstructor() throws Exception {
+		final String pattern =3D "helloworld";
+		final FileNameMatcher matcher =3D new FileNameMatcher(pattern, null)=
;
+		matcher.append("hello");
+		final FileNameMatcher copy =3D new FileNameMatcher(matcher);
+		assertEquals(false, matcher.isMatch());
+		assertEquals(true, matcher.canAppendMatch());
+		assertEquals(false, copy.isMatch());
+		assertEquals(true, copy.canAppendMatch());
+		matcher.append("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(false, copy.isMatch());
+		assertEquals(true, copy.canAppendMatch());
+		copy.append("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(true, copy.isMatch());
+		assertEquals(false, copy.canAppendMatch());
+		copy.reset();
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(false, copy.isMatch());
+		assertEquals(true, copy.canAppendMatch());
+		copy.append("helloworld");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(true, copy.isMatch());
+		assertEquals(false, copy.canAppendMatch());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileNameMatc=
her.java b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileNameMatche=
r.java
index 9ac1875..702f7b3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileNameMatcher.jav=
a
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileNameMatcher.jav=
a
@@ -99,10 +99,23 @@ public class FileNameMatcher {
 	 *            must be a list which will never be modified.
 	 */
 	private FileNameMatcher(final List<Head> headsStartValue) {
+		this(headsStartValue, headsStartValue);
+	}
+
+	/**
+	 *
+	 * @param headsStartValue
+	 *            must be a list which will never be modified.
+	 * @param heads
+	 *            a list which will be cloned and then used as current he=
ad
+	 *            list.
+	 */
+	private FileNameMatcher(final List<Head> headsStartValue,
+			final List<Head> heads) {
 		this.headsStartValue =3D headsStartValue;
-		this.heads =3D new ArrayList<Head>(headsStartValue.size());
-		this.heads.addAll(this.headsStartValue);
-		this.listForLocalUseage =3D new ArrayList<Head>(headsStartValue.size=
());
+		this.heads =3D new ArrayList<Head>(heads.size());
+		this.heads.addAll(heads);
+		this.listForLocalUseage =3D new ArrayList<Head>(heads.size());
 	}
=20
 	/**
@@ -120,6 +133,17 @@ public class FileNameMatcher {
 		this(createHeadsStartValues(patternString, invalidWildgetCharacter))=
;
 	}
=20
+	/**
+	 * A Copy Constructor which creates a new {@link FileNameMatcher} wit=
h the
+	 * same state and reset point like <code>other</code>.
+	 *
+	 * @param other
+	 *            another {@link FileNameMatcher} instance.
+	 */
+	public FileNameMatcher(FileNameMatcher other) {
+		this(other.headsStartValue, other.heads);
+	}
+
 	private static List<Head> createHeadsStartValues(
 			final String patternString, final Character invalidWildgetCharacter=
)
 			throws InvalidPatternException {
--=20
1.5.4.3
