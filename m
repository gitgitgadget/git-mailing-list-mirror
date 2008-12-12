From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/12] Patch API bug fixes and diff --cc suport
Date: Fri, 12 Dec 2008 14:05:46 -0800
Message-ID: <1229119558-1293-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGAK-0004ah-1n
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYLLWGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbYLLWGA
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:00 -0500
Received: from george.spearce.org ([209.20.77.23]:50658 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbYLLWF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:05:59 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2A16738194; Fri, 12 Dec 2008 22:05:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7C49538194;
	Fri, 12 Dec 2008 22:05:58 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102948>

This series addes new unit tests for the patch API, closing some
gaps in our test coverage.  Some of those tests identified bugs in
the implementation, and those are now fixed.

The final patch in the series adds support for "diff -cc" patches,
used to show an "evil merge" commit's conflict resolution.

Shawn O. Pearce (12):
  Assert the HunkHeader.getFileHeader returns the right file
  Add tests to cover more methods of BinaryHunk
  Add a simple toString to FormatError to facilitate debugging
  Allow FileHeader to create its HunkHeader children
  Refactor the old/pre-image data in HunkHeader to support >1 ancestor
  Assert the ChunkHeader.OldImage.getId uses FileHeader.getOldImage
  Allow a stray LF at the end of a hunk
  Fix HunkHeader start line when parsing "@@ -1 +1 @@" style headers
  Add test cases for parsing "\ No newline at end of file" style
    patches
  Use FileMode.MISSING when a file is added or deleted rather than null
  Add a test for delta binary patch parsing and fix a bug in it
  Add support for parsing "diff --cc" style patches

 .../spearce/jgit/patch/EGitPatchHistoryTest.java   |    4 +-
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |    4 +-
 .../org/spearce/jgit/patch/PatchCcErrorTest.java   |   97 +++++++++
 .../tst/org/spearce/jgit/patch/PatchCcTest.java    |  200 ++++++++++++++++++
 .../tst/org/spearce/jgit/patch/PatchTest.java      |  165 +++++++++++++--
 .../jgit/patch/testError_CcTruncatedOld.patch      |   24 +++
 .../jgit/patch/testParse_AddNoNewline.patch        |   20 ++
 .../jgit/patch/testParse_CcDeleteFile.patch        |   12 +
 .../spearce/jgit/patch/testParse_CcNewFile.patch   |   14 ++
 .../jgit/patch/testParse_FixNoNewline.patch        |   20 ++
 .../jgit/patch/testParse_GitBinaryDelta.patch      |   21 ++
 ...nary.patch => testParse_GitBinaryLiteral.patch} |    0
 .../spearce/jgit/patch/testParse_OneFileCc.patch   |   27 +++
 .../src/org/spearce/jgit/patch/BinaryHunk.java     |    2 +-
 .../org/spearce/jgit/patch/CombinedFileHeader.java |  213 ++++++++++++++++++++
 .../org/spearce/jgit/patch/CombinedHunkHeader.java |  191 ++++++++++++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |   64 ++++--
 .../src/org/spearce/jgit/patch/FormatError.java    |   14 ++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |  134 +++++++-----
 .../src/org/spearce/jgit/patch/Patch.java          |   24 ++-
 20 files changed, 1134 insertions(+), 116 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcErrorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_CcTruncatedOld.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_AddNoNewline.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcDeleteFile.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcNewFile.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_FixNoNewline.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryDelta.patch
 rename org.spearce.jgit.test/tst/org/spearce/jgit/patch/{testParse_GitBinary.patch => testParse_GitBinaryLiteral.patch} (100%)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_OneFileCc.patch
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java
