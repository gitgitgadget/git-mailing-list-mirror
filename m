From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/15] More patch parsing support
Date: Thu, 11 Dec 2008 18:46:06 -0800
Message-ID: <1229049981-14152-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4u-00057A-GS
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbYLLCqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755889AbYLLCqY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:24 -0500
Received: from george.spearce.org ([209.20.77.23]:41565 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbYLLCqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:23 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id BE63838215; Fri, 12 Dec 2008 02:46:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9457A38194;
	Fri, 12 Dec 2008 02:46:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102865>

Unit test improvements, introduction of IntList (which Dscho also
needs for his diff code, its probably a drop-in replacement for him),
and support for parsing the meta data of binary patches.

I'm writing the "diff --cc" parser right now but the unit tests
for it still fail so I'm not including those changes just yet.


Shawn O. Pearce (15):
  Correct use of TemporaryBuffer in Patch
  Add tests for TemporaryBuffer
  Add IntList as a more efficient representation of List<Integer>
  Add lineMap computer to RawParseUtils to index locations of line
    starts
  Define FileHeader.PatchType to report the style of patch used
  Test for non-git binary files and mark them as PatchType.BINARY
  Set empty patches with no Git metadata to PatchType.BINARY
  Always use the FileHeader buffer during Patch.parseHunks
  Parse "GIT binary patch" style patch metadata
  Record patch parsing errors for later inspection by applications
  Fix Patch.parse to honor the end point passed in
  Correctly handle hunk headers such as "@@ -0,0 +1 @@"
  Patch parse test comparing "git log -p" output to "git log --numstat"
  Abstract the hunk header testing into a method
  Treat "diff --combined" the same as "diff --cc"

 .../spearce/jgit/patch/EGitPatchHistoryTest.java   |  221 ++++++++++++
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |   70 +++-
 .../tst/org/spearce/jgit/patch/PatchErrorTest.java |  174 +++++++++
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   78 ++++
 .../spearce/jgit/patch/testError_BodyTooLong.patch |   17 +
 .../jgit/patch/testError_DisconnectedHunk.patch    |   30 ++
 .../jgit/patch/testError_GarbageBetweenFiles.patch |   33 ++
 .../patch/testError_GitBinaryNoForwardHunk.patch   |   10 +
 .../jgit/patch/testError_TruncatedNew.patch        |   15 +
 .../jgit/patch/testError_TruncatedOld.patch        |   15 +
 .../spearce/jgit/patch/testParse_GitBinary.patch   |  135 +++++++
 .../spearce/jgit/patch/testParse_NoBinary.patch    |   83 +++++
 .../tst/org/spearce/jgit/util/IntListTest.java     |  156 ++++++++
 .../jgit/util/RawParseUtils_LineMapTest.java       |   88 +++++
 .../org/spearce/jgit/util/TemporaryBufferTest.java |  374 ++++++++++++++++++++
 .../tst/org/spearce/jgit/util/TestRng.java         |   61 ++++
 .../src/org/spearce/jgit/patch/BinaryHunk.java     |  127 +++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |   94 +++++-
 .../src/org/spearce/jgit/patch/FormatError.java    |   95 +++++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |   41 ++-
 .../src/org/spearce/jgit/patch/Patch.java          |  197 ++++++++---
 .../src/org/spearce/jgit/util/IntList.java         |  128 +++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   31 ++
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |    4 +-
 24 files changed, 2187 insertions(+), 90 deletions(-)
 create mode 100644 org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchErrorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_BodyTooLong.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_DisconnectedHunk.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GarbageBetweenFiles.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GitBinaryNoForwardHunk.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedNew.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedOld.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinary.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_NoBinary.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/TemporaryBufferTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/TestRng.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
