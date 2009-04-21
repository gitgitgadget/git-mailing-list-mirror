From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/10] Object access improvements
Date: Mon, 20 Apr 2009 18:21:02 -0700
Message-ID: <1240276872-17893-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hQ-00021g-7W
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbZDUBVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbZDUBVQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:16 -0400
Received: from george.spearce.org ([209.20.77.23]:33009 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbZDUBVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 297D0381CE; Tue, 21 Apr 2009 01:21:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5A0E3381CE;
	Tue, 21 Apr 2009 01:21:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117060>

This series tries to address issue 79[1] and GERRIT-81[2] by
detecting when packs have been overwritten on disk, or when
new packs have appeared and old packs have disappeared.

The first 5 patches are quite trivial and are just things I
found while working on the real issue.

Patch 6 is rather intrusive.  It starts a refactoring I have
always wanted to do, which is to split the object database out
of the Repository class, and also start to divorce it from the
local filesystem.  The library is in the same state after patch
5 as it was before patch 5; that is issue 79 is still an issue,
but everything else is fine.

Patch 7 and 8 fix issue 79.

Patch 9 is a rewritten version of your 1/3 posted Sun 19 Apr,
providing test cases for issue 79 / GERRIT-81.

Patch 10 is a broken test case.  Basically as I explain in the
commit message of 7, PackWriter can still crash randomly.

With 1-9 applied, issue 79 can be marked fixed, but GERRIT-81 is
still a problem, as any concurrent PackWriter thread may randomly
crash during a repack.

[1] http://code.google.com/p/egit/issues/detail?id=79
[2] http://jira.source.android.com/jira/browse/GERRIT-81

Shawn O. Pearce (10):
  Safely handle closing an already closed WindowedFile
  Change empty tree test case to use a temporary repository
  Replace hand-coded read fully loop with NB.readFully
  Clear the reverse index when closing a PackFile
  Introduce a new exception type for an in-place pack modification
  Refactor object database access with new abstraction
  Rescan packs if a pack is modified in-place (part 1)
  Scan for new packs if GIT_DIR/objects/pack has been modified
  Add test cases for loading new (or replaced) pack files
  BROKEN TEST: ObjectLoader stays valid across repacks

 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |  252 +++++++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    2 -
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   11 +-
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    1 -
 .../spearce/jgit/errors/PackMismatchException.java |   55 +++
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |  367 ++++++++++++++++
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |  438 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |   36 ++-
 .../src/org/spearce/jgit/lib/Repository.java       |  174 +--------
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   34 +-
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   16 +-
 11 files changed, 1183 insertions(+), 203 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/PackMismatchException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
