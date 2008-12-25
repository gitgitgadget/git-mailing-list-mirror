From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/18] Misc. performance tweaks
Date: Wed, 24 Dec 2008 18:10:56 -0800
Message-ID: <1230171079-17156-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjF-00029A-FF
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbYLYCLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYLYCLX
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:23 -0500
Received: from george.spearce.org ([209.20.77.23]:59399 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbYLYCLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:22 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D12AD38215; Thu, 25 Dec 2008 02:11:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 09C4E38197;
	Thu, 25 Dec 2008 02:11:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103871>

Cloning linux-2.6.git through JGit was painful at best.  I found
and fixed some small bottlenecks after a day of profiling and
experimentation, but we're still slower than C git.

With this series I managed to drop the time for "git clone --bare"
over git:// using "jgit daemon" server and "C git" client.
Any difference between jgit and "C git" is in the server side.

  before:  7m42.488s
  after :  2m33.882s
  C git :  1m26.158s     ("git daemon" server)


So I'm still seeing a major bottleneck that I can't quite fix.

Object enumeration (aka "Counting ...") takes too long, because we
spend a huge amount of time unpacking delta chains for trees so we
can enumerate their referenced items.

Our UnpackedObjectCache gets <4% hit ratio when doing the trees
for linux-2.6.git.  Increasing the cache doesn't have a noticable
improvement on performance.

I tried rewriting UnpackedObjectCache to permit multiple objects
per hash bucket.  Even with that (and the maximum chain length
per bucket not exceeding 4 items) our hit ratio was still <5%,
so I tossed that implementation out.

"jgit rev-list --objects" vs. "git rev-list --objects" is a huge
difference, about 1m difference.  That's most of the time difference
I noted above between jgit and C git on the server side.

So with this series, we're better.  Its actually almost tolerable
to clone linux-2.6 through a jgit backed server.


Shawn O. Pearce (23):
  Improve hit performance on the UnpackedObjectCache
  Add MutableObjectId.clear() to set the id to zeroId
  Allow TreeWalk callers to pass a MutableObjectId to get the current
    id
  Switch ObjectWalk to use the new MutableObjectId form in TreeWalk
  Change walker based fetch to use TreeWalk's MutableObjectId accessor
  Reduce garbage allocation when using TreeWalk
  Switch ObjectWalk to use a naked CanonicalTreeParser because its
    faster
  Remove the unused PackFile.get(ObjectId) form
  Remove getId from ObjectLoader API as its unnecessary overhead
  Make mmap mode more reliable by forcing GC at the correct spot
  Rewrite WindowCache to use a hash table
  Change ByteArrayWindow to read content outside of WindowCache's lock
  Dispose of RevCommit buffers when they aren't used in PackWriter
  Don't unpack delta chains while writing a pack from a pack v1 index
  Don't unpack delta chains while converting delta to whole object
  Defer parsing of the ObjectId while walking a PackIndex Iterator
  Only do one getCachedBytes per whole object written
  Correctly use a long for the offsets within a generated pack
  Allow more direct access to determine isWritten
  Move "wantWrite" field of ObjectToPack into the flags field
  Use an ArrayList for the reuseLoader collection in PackWriter
  Don't cut off existing delta chains if we are reusing deltas
  Correctly honor the thin parameter to PackWriter.writePack

 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |    6 +-
 .../tst/org/spearce/jgit/lib/PackIndexTest.java    |    4 +-
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   14 +-
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    4 +-
 .../jgit/errors/CorruptObjectException.java        |   12 +
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |   31 ++
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |   17 +
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   20 ++-
 .../src/org/spearce/jgit/lib/Constants.java        |    2 +-
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |    3 +-
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |    9 +
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |   38 ---
 .../src/org/spearce/jgit/lib/PackFile.java         |   49 +---
 .../src/org/spearce/jgit/lib/PackIndex.java        |   48 ++--
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   20 +-
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   27 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |   63 +++--
 .../src/org/spearce/jgit/lib/Repository.java       |   29 +--
 .../org/spearce/jgit/lib/UnpackedObjectCache.java  |   21 +-
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   12 +-
 .../spearce/jgit/lib/WholePackedObjectLoader.java  |    3 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |  323 ++++++++++++--------
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   16 +
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   61 +++--
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   51 ++--
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    8 +-
 .../spearce/jgit/transport/PackedObjectInfo.java   |    2 +-
 .../src/org/spearce/jgit/transport/UploadPack.java |    1 +
 .../jgit/transport/WalkFetchConnection.java        |   48 ++-
 .../jgit/treewalk/AbstractTreeIterator.java        |   48 +++
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   85 +++++-
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   88 +++++-
 .../spearce/jgit/util/CountingOutputStream.java    |    5 +-
 33 files changed, 752 insertions(+), 416 deletions(-)
