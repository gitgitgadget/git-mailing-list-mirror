From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2 00/11] WindowCache rewrite... with tests
Date: Wed, 29 Apr 2009 11:54:37 -0700
Message-ID: <1241031288-23437-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwk-0003Rz-5O
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbZD2Syw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbZD2Syu
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:54:50 -0400
Received: from george.spearce.org ([209.20.77.23]:32866 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbZD2Syt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C62E738061; Wed, 29 Apr 2009 18:54:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3600638061;
	Wed, 29 Apr 2009 18:54:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117913>

Actually, this is my entire outstanding patch set series.

1 and 2 should be trivial to apply.

3-6 should be fairly straightforward.

7 maybe we delay until later, but I don't think any applications
use that map type.

8 is pretty trivial, and is needed to prevent 9 from deadlocking.

9-11 is the rewrite of WindowCache, with new unit tests to get higher
levels of coverage in this section of the code.  Actually doing
better is really hard, as we'd need to cause thread race conditions
deep within critical sections.  The only way I can think to do that
is to add injection points where we can insert "evil other thread"
logic during the unit test, and rely on the JIT to compile them
out in normal application usage.  Ick.  Its also quite fragile.

Shawn O. Pearce (11):
  Fix more computation of integer average overflows
  Fix performance problem recently introduced to
    DeltaPackedObjectLoader
  Replace inefficient new String(String) constructor to silence
    FindBugs
  Replace inefficient new Long(long) constructor to silence FindBugs
  Change IndexPack to use ObjectIdSubclassMap instead of ObjectIdMap
  Use getCachedBytes in IndexPack to avoid an unnecessary copy
  Remove ObjectIdMap from the JGit library
  Don't use ByteWindows when checking pack file headers/footers
  Rewrite WindowCache to be easier to follow and maintain
  Add tests for WindowCache.reconfigure cases
  Add tests to increase coverage of WindowCache

 .../jgit/test/resources/all_packed_objects.txt     |   96 ++++
 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |    4 -
 .../tst/org/spearce/jgit/lib/ObjectIdMapTest.java  |  103 ----
 .../org/spearce/jgit/lib/WindowCacheGetTest.java   |  143 ++++++
 .../jgit/lib/WindowCacheReconfigureTest.java       |  119 +++++
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |   57 +--
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |   41 +-
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   91 +---
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |    1 +
 .../src/org/spearce/jgit/lib/ObjectIdMap.java      |  201 --------
 .../org/spearce/jgit/lib/ObjectIdSubclassMap.java  |   31 ++-
 .../src/org/spearce/jgit/lib/OffsetCache.java      |  534 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |  128 +++--
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |    2 +-
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |    6 +-
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |   11 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    3 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |  424 +++++-----------
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   42 +-
 .../src/org/spearce/jgit/transport/IndexPack.java  |  129 +++--
 .../src/org/spearce/jgit/transport/LongMap.java    |  152 ++++++
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   32 ++
 22 files changed, 1465 insertions(+), 885 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/all_packed_objects.txt
 delete mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectIdMapTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheGetTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheReconfigureTest.java
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/LongMap.java
