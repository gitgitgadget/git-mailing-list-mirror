From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 00/26] New DirCache API
Date: Mon, 11 Aug 2008 18:07:47 -0700
Message-ID: <1218503293-14057-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiO1-0005x2-7c
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYHLBIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbYHLBIP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:15 -0400
Received: from george.spearce.org ([209.20.77.23]:38556 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYHLBIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4065338379; Tue, 12 Aug 2008 01:08:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 66978381FD;
	Tue, 12 Aug 2008 01:08:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92031>

This is (finally) my long-promised DirCache API.  It has been evolving
and growing since before April I think.  Its finally cleaned up enough
for public viewing and usage.

I started this change because I didn't see an easy way to plug
GitIndex into TreeWalk, I found GitIndex to be too slow, and it
required direct access to the working directory in order to handle
certain operations.  DirCache has none of these issues.

The API is meant to replace GitIndex, as we can now merge-sort a 'DIRC'
(aka .git/index) file against any other tree as part of any active
TreeWalk instance.  This makes it really easy to do n-way diffs against
commits, one or more index files, and the working directory.

The implementation is leaner and meaner than GitIndex.  It avoids a
lot of unnecessary conversion overheads, and it tries to reduce the
per-entry memory usage as much as possible.

We almost support the 'TREE' cache extension.  Updates to the index
through DirCacheBuilder or DirCacheEditor wind up throwing away the
entire 'TREE' extension, instead of invalidating only those trees
we know to be dirty.  This is certainly suboptimal and is an area
for future improvement.

>From here I'm going to start building 3 way merge support onto
this API, by taking advantage of TreeWalk to do the parallel
tree unpacks necessary for the merge operation.

Yes, its ~4.5k lines (excluding some test vectors).  However it
will allow us to eventually remove about 2k lines from jgit alone:

  AbstractIndexTreeVisitor  74
  GitIndex                 912
  IndexDiff                160
  IndexTreeWalker          241
  IndexTreeVisitor          97
  TreeIterator             203
  WorkDirCheckout          401
  ----------------------------
                          2088

Other classes like GitResourceDecorator simplify I think as a result
of this new API being available.  I have only started to port that
over, but found I was getting side-tracked in porting the existing
GitIndex users and I really want to focus on the merge code instead.

So overall we may see about a 2k line increase as a result of this
API being used in the tree rather than GitIndex, but since it fits
into the overall TreeWalk architecture its better suited for reuse,
so we may see more than 2k saved over time.


Shawn O. Pearce (26):
  Force all source code to UTF-8 encoding by default
  Protect WorkingTreeIterator's name encoding from weird ByteBuffers
  Add Constants.encode as a utility for quick encoding in UTF-8
  Rely upon Constants.CHARSET over Constants.CHARACTER_ENCODING
  Allow AbstractTreeIterators to find out about StopWalkExceptions
  Implement a new .git/index (aka dircache) read interface
  Export the new DirCache API to Eclipse plugins using jgit
  Support locking (and unlocking) a .git/index through DirCache
  Support writing a .git/index through DirCache
  Support the 'TREE' extension in .git/index through DirCache
  Support using a DirCache within a TreeWalk
  Support recreating a .git/index through DirCache
  Support iterating and building a DirCache at the same time
  Support creating a new DirCacheEntry for an arbitrary path
  Support a simplified model of editing index entries
  Support recursively getting all entries under a subtree path
  Support copying meta fields from one DirCacheEntry to another
  Add JUnit tests for new DirCache API
  Add JUnit tests for DirCache compatibility with C Git
  Allow the new DirCacheIterator in command line arguments
  Add debugging commands to interact with the new DirCache code
  Add a basic command line implementation of rm
  Rewrite GitMoveDeleteHook to use DirCacheBuilder
  Teach GitMoveDeleteHook how to move a folder recursively
  Rewrite UntrackOperation to use DirCacheBuilder
  Rewrite AssumeUnchangedOperation to use DirCache

 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../org/spearce/egit/core/GitMoveDeleteHook.java   |  156 ++-
 .../egit/core/op/AssumeUnchangedOperation.java     |  133 +-
 .../org/spearce/egit/core/op/UntrackOperation.java |   98 +-
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    6 +
 .../src/org/spearce/jgit/pgm/Rm.java               |   92 ++
 .../org/spearce/jgit/pgm/debug/MakeCacheTree.java  |   67 +
 .../org/spearce/jgit/pgm/debug/ReadDirCache.java   |   53 +
 .../org/spearce/jgit/pgm/debug/ShowCacheTree.java  |   69 +
 .../org/spearce/jgit/pgm/debug/ShowDirCache.java   |   72 +
 .../org/spearce/jgit/pgm/debug/WriteDirCache.java  |   54 +
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |   13 +
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 .../spearce/jgit/dircache/DirCacheBasicTest.java   |  185 +++
 .../jgit/dircache/DirCacheBuilderIteratorTest.java |   91 ++
 .../spearce/jgit/dircache/DirCacheBuilderTest.java |  253 ++++
 .../dircache/DirCacheCGitCompatabilityTest.java    |  204 +++
 .../spearce/jgit/dircache/DirCacheFindTest.java    |   86 ++
 .../jgit/dircache/DirCacheIteratorTest.java        |  273 ++++
 .../spearce/jgit/dircache/DirCacheTreeTest.java    |  150 ++
 .../tst/org/spearce/jgit/dircache/gitgit.index     |  Bin 0 -> 134799 bytes
 .../tst/org/spearce/jgit/dircache/gitgit.lsfiles   | 1437 ++++++++++++++++++++
 .../tst/org/spearce/jgit/dircache/gitgit.lstree    |  331 +++++
 .../spearce/jgit/lib/ConstantsEncodingTest.java    |   89 ++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +
 org.spearce.jgit/META-INF/MANIFEST.MF              |    3 +-
 .../spearce/jgit/dircache/BaseDirCacheEditor.java  |  194 +++
 .../src/org/spearce/jgit/dircache/DirCache.java    |  681 +++++++++
 .../jgit/dircache/DirCacheBuildIterator.java       |  124 ++
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |  175 +++
 .../org/spearce/jgit/dircache/DirCacheEditor.java  |  265 ++++
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |  385 ++++++
 .../spearce/jgit/dircache/DirCacheIterator.java    |  205 +++
 .../org/spearce/jgit/dircache/DirCacheTree.java    |  453 ++++++
 .../src/org/spearce/jgit/lib/Constants.java        |   25 +
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |    2 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    9 +-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    4 +-
 .../org/spearce/jgit/transport/PacketLineIn.java   |    3 +-
 .../jgit/transport/SideBandInputStream.java        |    3 +-
 .../spearce/jgit/transport/TransportBundle.java    |    3 +-
 .../spearce/jgit/transport/WalkPushConnection.java |    4 +-
 .../jgit/transport/WalkRemoteObjectDatabase.java   |    5 +-
 .../jgit/treewalk/AbstractTreeIterator.java        |   11 +
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |    6 +
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   12 +-
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    2 +-
 .../spearce/jgit/treewalk/filter/PathFilter.java   |   10 +-
 54 files changed, 6333 insertions(+), 190 deletions(-)
 create mode 100644 org.spearce.egit-feature/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit-updatesite/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit.core.test/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit.core/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit.ui/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Rm.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/MakeCacheTree.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ReadDirCache.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCacheTree.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/WriteDirCache.java
 create mode 100644 org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.index
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.lsfiles
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.lstree
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConstantsEncodingTest.java
 create mode 100644 org.spearce.jgit/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/BaseDirCacheEditor.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
