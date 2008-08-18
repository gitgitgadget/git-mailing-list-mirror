From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/14] TreeWalk D/F conflict detection
Date: Mon, 18 Aug 2008 16:53:08 -0700
Message-ID: <1219103602-32222-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:54:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEYN-0006b3-N0
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbYHRXxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbYHRXxY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:24 -0400
Received: from george.spearce.org ([209.20.77.23]:45130 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbYHRXxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 77D5838379; Mon, 18 Aug 2008 23:53:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C173038368;
	Mon, 18 Aug 2008 23:53:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92767>

This series is about fixing the "mistake" in Git trees where
subtrees sort as through their name is "path/" and not "path".

Within a TreeWalk this is a problem because the tree contents:

    Tree 1     Tree 2
  ------------------------
    100644 a
               100644 a.c
               040000 a
    100644 b

needs to merge together both "a" paths from tree 1 and tree 2, but
these appear at different points in time when we merge-sort the two
trees together.

We use an infinite look-ahead and look-behind to identify these cases
and make the iteration look like this instead:

    Tree 1     Tree 2
  ------------------------
    100644 a   040000 a
               100644 a.c
    100644 b

which allows the application to handle the D/F conflict in a single
step, even though the contents of "a" may now be out-of-order within
the DirCache.  Fortunately DirCacheBuilder can automatically fix this
sort of ordering problem.


Shawn O. Pearce (14):
  Detect path names which overflow the name length field in the index
  Fix NB.decodeUInt16 to correctly handle the high byte
  Add test cases for NB.encode and NB.decode family of routines
  Fix DirCache's skip over null byte padding when reading a DIRC file
  Fix usage of assertEquals in DirCacheIteratorTest
  Refactor AbstractTreeIterator.pathCompare to force another mode
  Micro-optimize AbstractTreeIterator.pathCompare
  Optimize path comparsion within subtrees during TreeWalk
  Refactor AbstractTreeIterator semantics to start on first entry
  Make all AbstractTreeIterator implementations bi-directional
  Expose beginning of iterator indication from AbstractTreeIterator
  Allow application code to set ObjectIds in DirCacheEntry
  Create NameConflictTreeWalk to transparently detect D/F conflicts
  Add test case for NameConflictTreeWalk

 .../spearce/egit/core/ContainerTreeIterator.java   |    9 +-
 .../jgit/dircache/DirCacheBuilderIteratorTest.java |    2 +-
 .../jgit/dircache/DirCacheIteratorTest.java        |   28 +-
 .../jgit/treewalk/CanonicalTreeParserTest.java     |  261 ++++++++++++++++
 .../jgit/treewalk/NameConflictTreeWalkTest.java    |  205 ++++++++++++
 .../tst/org/spearce/jgit/util/NBTest.java          |  328 ++++++++++++++++++++
 .../src/org/spearce/jgit/dircache/DirCache.java    |    2 +-
 .../jgit/dircache/DirCacheBuildIterator.java       |    9 +-
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   41 +++-
 .../spearce/jgit/dircache/DirCacheIterator.java    |   84 +++--
 .../jgit/treewalk/AbstractTreeIterator.java        |  129 +++++---
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   94 +++++-
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |   12 +-
 .../spearce/jgit/treewalk/FileTreeIterator.java    |    5 +-
 .../jgit/treewalk/NameConflictTreeWalk.java        |  237 ++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   18 +-
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |  132 ++++-----
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   29 ++-
 18 files changed, 1418 insertions(+), 207 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/NameConflictTreeWalkTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/NBTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java
