From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT] Make Repository.stripWorkDir more robust
Date: Wed, 19 Aug 2009 08:50:59 -0400
Message-ID: <1250686259-15301-1-git-send-email-fonseca@diku.dk>
References: <200908122147.52530.robin.rosenberg.lists@dewire.com>
Cc: awhawks@writeme.com, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 14:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdkdJ-0001ky-SV
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 14:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbZHSMvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 08:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZHSMvJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 08:51:09 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:53413 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbZHSMvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 08:51:07 -0400
Received: by yxe5 with SMTP id 5so5354879yxe.33
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=fHtjkna6gFsAvDwiZ2eQRZp2e2IIqzcr8Z3Nlf3nGJU=;
        b=k0j2TqJ1IXFWRsE7t0J76CioyskrcrctZU2iO6+/uLQYVc7sCiTabWceURk7MI5mSB
         z1ACeWMUjCAI44qMxl2AOxc82Wuctk5IEmnuI7yJcDrPw0SpwwJvdbvOGSOkVct+0mQx
         fICauTtOzZxyAeVSQWUBIGpFehBA3TJgTBCt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=aYU3esObxtwhdccpjp+P2Hlq5XxDrtmy7pCbNy96hjJIIwvt/hcJlsXQ3f4eZ4+Drb
         pHyCvtf70SIO9KgnzCKh3dQ0+MqQurxzZRdjC4qTgzXL6RgoTo61ckRb2NKsAM90VG/p
         Gi3sTyAZu+me5DCIZjh0/z7p4kskgqB9qqEsE=
Received: by 10.91.142.6 with SMTP id u6mr4830031agn.8.1250686263438;
        Wed, 19 Aug 2009 05:51:03 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178046713.dsl.bell.ca [70.55.144.249])
        by mx.google.com with ESMTPS id 21sm2264962agb.25.2009.08.19.05.51.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 05:51:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.195.g2b05f
In-Reply-To: <200908122147.52530.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126540>

Repository.stripWorkDir was assuming too much about its File arguments,
namely that the given file was always a decendant of the workdir.
Futhermore, it did not "normalize" paths of relative files, but simpy
relied on the path returned by File.getPath().

The new behavior is to fall-back to using File.getAbsolutePath() if the
path returned by File.getPath() cannot be normalized. Test the new
behavior against mix of relative and absolute paths given as arguments.
Fixes problem with string out of bound exception when the path of the
given file is shorter than the workdir, usually meaning it is not a
decendant of the workdir.

Reported-by: Adam W. Hawks <awhawks@writeme.com>
Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 On Wed, Aug 12, 2009 at 15:47, Robin Rosenberg<robin.rosenberg.lists@dewire.com> wrote:
 > Why not convert both paths? A trickier issue is that getAbsolutePath is very slow when
 > the path is not absolute. I don't think we will always need to normalize in order to
 > fix this. A few unit tests to show the cases solved would help.

 Something like this? I am myself interested in fixing the string out of bound
 exception, which makes this method unusable for me.

 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   25 ++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   31 ++++++++++++++-----
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
index 3660b45..c2b1b91 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -545,6 +545,31 @@ public void test029_mapObject() throws IOException {
 		assertEquals(Commit.class, db.mapObject(ObjectId.fromString("540a36d136cf413e4b064c2b0e0a4db60f77feab"), null).getClass());
 		assertEquals(Tree.class, db.mapObject(ObjectId.fromString("aabf2ffaec9b497f0950352b3e582d73035c2035"), null).getClass());
 		assertEquals(Tag.class, db.mapObject(ObjectId.fromString("17768080a2318cd89bba4c8b87834401e2095703"), null).getClass());
+	}
+
+	public void test30_stripWorkDir() {
+		File relCwd = new File(".");
+		File absCwd = relCwd.getAbsoluteFile();
+		File absBase = new File(new File(absCwd, "repo"), "workdir");
+		File relBase = new File(new File(relCwd, "repo"), "workdir");
+		assertEquals(absBase.getAbsolutePath(), relBase.getAbsolutePath());
+
+		File relBaseFile = new File(new File(relBase, "other"), "module.c");
+		File absBaseFile = new File(new File(absBase, "other"), "module.c");
+		assertEquals("other/module.c", Repository.stripWorkDir(relBase, relBaseFile));
+		assertEquals("other/module.c", Repository.stripWorkDir(relBase, absBaseFile));
+		assertEquals("other/module.c", Repository.stripWorkDir(absBase, relBaseFile));
+		assertEquals("other/module.c", Repository.stripWorkDir(absBase, absBaseFile));
+
+		File relNonFile = new File(new File(relCwd, "not-repo"), ".gitignore");
+		File absNonFile = new File(new File(absCwd, "not-repo"), ".gitignore");
+		assertEquals("", Repository.stripWorkDir(relBase, relNonFile));
+		assertEquals("", Repository.stripWorkDir(absBase, absNonFile));
+
+		assertEquals("", Repository.stripWorkDir(db.getWorkDir(), db.getWorkDir()));
+
+		File file = new File(new File(db.getWorkDir(), "subdir"), "File.java");
+		assertEquals("subdir/File.java", Repository.stripWorkDir(db.getWorkDir(), file));
 
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index d6be9bf..46b7804 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -729,7 +729,7 @@ else if (item.equals("")) {
 					}
 				}
 				if (time != null)
-					throw new RevisionSyntaxException("reflogs not yet supported by revision parser yet", revstr);
+					throw new RevisionSyntaxException("reflogs not yet supported by revision parser", revstr);
 				i = m - 1;
 				break;
 			default:
@@ -1029,15 +1029,30 @@ public static boolean isValidRefName(final String refName) {
 	}
 
 	/**
-	 * Strip work dir and return normalized repository path
+	 * Strip work dir and return normalized repository path.
 	 *
-	 * @param wd Work dir
-	 * @param f File whose path shall be stripped of its workdir
-	 * @return normalized repository relative path
+	 * @param workDir Work dir
+	 * @param file File whose path shall be stripped of its workdir
+	 * @return normalized repository relative path or the empty
+	 *         string if the file is not relative to the work directory.
 	 */
-	public static String stripWorkDir(File wd, File f) {
-		String relName = f.getPath().substring(wd.getPath().length() + 1);
-		relName = relName.replace(File.separatorChar, '/');
+	public static String stripWorkDir(File workDir, File file) {
+		final String filePath = file.getPath();
+		final String workDirPath = workDir.getPath();
+
+		if (filePath.length() <= workDirPath.length() ||
+		    filePath.charAt(workDirPath.length()) != File.separatorChar ||
+		    !filePath.startsWith(workDirPath)) {
+			File absWd = workDir.isAbsolute() ? workDir : workDir.getAbsoluteFile();
+			File absFile = file.isAbsolute() ? file : file.getAbsoluteFile();
+			if (absWd == workDir && absFile == file)
+				return "";
+			return stripWorkDir(absWd, absFile);
+		}
+
+		String relName = filePath.substring(workDirPath.length() + 1);
+		if (File.separatorChar != '/')
+			relName = relName.replace(File.separatorChar, '/');
 		return relName;
 	}
 
-- 
1.6.4.rc3.195.g2b05f
