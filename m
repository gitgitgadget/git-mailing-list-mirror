From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [jgit] index v2 pull request
Date: Fri, 7 Mar 2008 21:50:27 -0500
Message-ID: <20080308025027.GZ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Dave Watson <dwatson@mimvista.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 03:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXp9r-0002EY-3O
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 03:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115AbYCHCuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 21:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbYCHCuc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 21:50:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51156 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030AbYCHCub (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 21:50:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JXp8b-00010s-AJ; Fri, 07 Mar 2008 21:50:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D042620FBAE; Fri,  7 Mar 2008 21:50:27 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76545>

So I've started to hack on jgit again, to build out more of the lower
level library.  

This particular series adds support for pack file index v2, which
Nico added to C Git several months ago and is slated to become the
default pack index file format in a future release of Git, due to
its increased error checking during delta reuse.

I also cleaned up the pack file access code to be shorter and more
concise.  Unfortunately the overall series diffstat doesn't show it
that way, but I think its now easier to follow how the control flows.

I've improved performance for packfile data access by adding a delta
base cache, like we did in C Git months ago.  This cache is really
necessary on modern repositories as pack-objects is tending to use
longer delta chains, due to the reader side now having this delta
base cache.  Profiling was showing jgit was spending a very large
amount of time in unpacking tree deltas.

We now actually use the following .git/config options to control
how the window cache limits work:

  core.packedGitWindowSize
  core.packedGitLimit
  core.deltaBaseCacheLimit
  core.packedGitMMAP

The configuration file parser now recognizes the "k/m/g" suffixes
that are comonly used in the first three parameters.  The last
option is a boolean and is unique to jgit.

The window cache and delta base cache also exploit SoftReferences to
make the caches memory-sensitive.  This way the JVM's GC can whack
our caches back if its running low on memory.  Its not quite the
same as C Git's concept of "malloc failed, flush out some windows
and retry" but its reasonably close.

Finally we now use a single WindowCache and delta base cache for
the entire JVM when running in an Eclipse workbench.  If the user
has multiple repositories open at once (say different projects)
they need to co-habitate in the JVM's virtual address space.  By
sharing the same caches the repositories can evict each other's
windows when they need to make room.

----

The following changes since commit 3cd4f3f9119b79750bbfc542119451a668c462e3:
  Robin Rosenberg (1):
        Readded qualifier to version 0.3.1

are available in the git repository at:

  repo.or.cz:/srv/git/egit/spearce.git master

Shawn O. Pearce (41):
      Make the absolute path of a WindowedFile available to callers
      Include the pack index file name when reporting a bad header
      Report pack file open failures to the console
      Refactor index reading code from PackFile to PackIndex
      Rename PackIndex.readIndexHeader to loadVersion1
      Read pack index files using FileInputStream and not WindowedFile
      Don't bother checking the index file length after reading it
      Move index:pack object count checking into PackFile class
      Refactor PackIndex version 1 handling code into PackIndexV1
      Fully document the PackIndex API
      Hoist readFully and decodeUInt32 up from PackIndexV1 to PackIndex
      Refactor PackIndex.readFully to support reading into the middle
      Read the pack index header to perform automatic version detection
      Add complete reading support for pack index v2
      Stop creating "new format" loose objects as C Git no longer likes them
      Refactor RepositoryConfig to be stacked many levels deep
      Don't make unit tests depend upon compressed file lengths
      Corrected name of the method that reloads the packed-refs data
      Cleanup misspelling in Javadoc of Repository class
      Extract StGitPatch from Repository to its own top-level type
      Refactor RepositoryState into its own top-level type
      Refactor PackFile construction to take the idxFile path from scan
      Shuffle the length of a WindowedFile down into its provider
      Defer opening pack files until we actually need object data
      Use Java 5 bit twiddling APIs rather than hand-rolling bit counting
      Support reading config file integers with k/m/g suffixes
      Honor core.packedGitWindowSize, packedGitLimit, packedGitMMAP config
      Enable easy access to the user's ~/.gitconfig
      Use a single WindowCache for the entire Eclipse workspace
      Modify the WindowedFile API to pass around a WindowCursor during reads
      Change ByteWindow implementations to hold data by SoftReferences
      Refactor WindowedFile/WindowCache so all windows are a uniform size
      Simplify WindowCache and WindowedFile internal APIs to be private
      Use a proper ReferenceQueue to avoid duplpicate window entries
      New RepositoryConfig getInt,getBoolean helper methods with no subsection
      Change delta packed object loaders to use a PackedObjectLoader for base
      Implement core.deltaBaseCacheLimit to improve unpacking performance
      Remove unnecessary bitwise AND masks in readTree
      Precount the number of tree entries during readTree
      Change the ObjectLoader.getType method to return int
      Fix ArrayIndexOutOfBoundsException in WindowCache

 .../egit/core/op/ConnectProviderOperation.java     |    4 +-
 .../spearce/egit/core/project/GitProjectData.java  |   27 +++-
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    2 +-
 .../internal/decorators/GitResourceDecorator.java  |    2 +-
 .../tst/org/spearce/jgit/lib/ReadTreeTest.java     |    4 +-
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |    9 +-
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   90 ---------
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |   11 +-
 org.spearce.jgit/META-INF/MANIFEST.MF              |    3 +-
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |   27 +--
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |   21 +--
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   42 +++--
 .../src/org/spearce/jgit/lib/Constants.java        |   21 ++
 .../src/org/spearce/jgit/lib/CoreConfig.java       |   61 +++++-
 .../jgit/lib/DeltaOfsPackedObjectLoader.java       |    2 +-
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |   29 ++-
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |    4 +-
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |    6 +-
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |   40 +---
 .../src/org/spearce/jgit/lib/PackFile.java         |  155 +++++----------
 .../src/org/spearce/jgit/lib/PackIndex.java        |  165 +++++++++++++++
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   84 ++++++++
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |  125 ++++++++++++
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |   13 +-
 .../src/org/spearce/jgit/lib/Repository.java       |  211 +++++---------------
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |  172 +++++++++++-----
 .../src/org/spearce/jgit/lib/RepositoryState.java  |  108 ++++++++++
 .../src/org/spearce/jgit/lib/Tree.java             |   40 ++--
 .../org/spearce/jgit/lib/UnpackedObjectCache.java  |  156 +++++++++++++++
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   20 +--
 .../spearce/jgit/lib/WholePackedObjectLoader.java  |   12 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |  151 +++++++++++---
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   67 ++++++
 .../src/org/spearce/jgit/lib/WindowProvider.java   |   75 -------
 .../src/org/spearce/jgit/lib/WindowedFile.java     |  207 +++++++++++--------
 .../src/org/spearce/jgit/stgit/StGitPatch.java     |   52 +++++
 36 files changed, 1459 insertions(+), 759 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WindowProvider.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/stgit/StGitPatch.java

-- 
Shawn.
