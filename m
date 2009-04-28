From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/13] Misc. bug fixes and cleanups
Date: Tue, 28 Apr 2009 14:12:13 -0700
Message-ID: <1240953146-12878-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:12:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyubZ-0004xr-Q1
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbZD1VM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755888AbZD1VM2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:28 -0400
Received: from george.spearce.org ([209.20.77.23]:58306 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbZD1VM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 358BA38260; Tue, 28 Apr 2009 21:12:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6330438215;
	Tue, 28 Apr 2009 21:12:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of my series from yesterday, as the first part of
it covers some minor corner-case bugs in the WindowCache rewrite.

The last patch in this series maybe should be held off for a while
as it deletes ObjectIdMap.  I'm inclined to just kill it off now,
as after 11/13, nobody uses it.

Shawn O. Pearce (13):
  Fix performance problem recently introduced to
    DeltaPackedObjectLoader
  Don't use ByteWindows when checking pack file headers/footers
  Rewrite WindowCache to be easier to follow and maintain
  Document the IllegalArgumentException thrown by
    WindowCache.reconfigure
  Create the new WindowCache before clearing the old one
  Better handle concurrent reads during a WindowCache reconfiguration
  Clear dead OffsetCache cells when clearing a reference
  Work around Sun JVM bug "Cleared SoftReference not added to queue"
  Replace inefficient new String(String) constructor to silence
    FindBugs
  Replace inefficient new Long(long) constructor to silence FindBugs
  Change IndexPack to use ObjectIdSubclassMap instead of ObjectIdMap
  Use getCachedBytes in IndexPack to avoid an unnecessary copy
  Remove ObjectIdMap from the JGit library

 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |    4 -
 .../tst/org/spearce/jgit/lib/ObjectIdMapTest.java  |  103 ----
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |   57 +--
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |   41 +-
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   91 +---
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |    1 +
 .../src/org/spearce/jgit/lib/ObjectIdMap.java      |  201 --------
 .../org/spearce/jgit/lib/ObjectIdSubclassMap.java  |   31 ++-
 .../src/org/spearce/jgit/lib/OffsetCache.java      |  536 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |  128 +++--
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    4 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    3 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |  417 ++++------------
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   42 +-
 .../src/org/spearce/jgit/transport/IndexPack.java  |  129 +++--
 .../src/org/spearce/jgit/transport/LongMap.java    |  152 ++++++
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   32 ++
 17 files changed, 1088 insertions(+), 884 deletions(-)
 delete mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectIdMapTest.java
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/LongMap.java
