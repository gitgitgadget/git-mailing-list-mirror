From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 00/20] PackWriter, first usable attempt
Date: Sun, 15 Jun 2008 23:45:29 +0200
Message-ID: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804B-0001bl-Nv
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYFOVqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbYFOVqK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:31828 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbYFOVqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958498ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=f6w0YU+7svQs4oGxSmghuq5J0cBCWhuLu39Shr+vyac=;
        b=ZSv+NsqVmNZCVt3DqnVyypTkcMPBjfra7/HklgoHf1lQZL8C+IuWBT1e4fCWtdJ1Io
         3ur9TaDTcvGDl/XfzD8n+2oU4963/S1WqSc+YWnP1ayamKIuCjNJ41xMWWRuEXZiL6j4
         kK+nmJX36hAog5fX0CMU92nw8DytRy/74xLao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=j+t9xDeHgreON4szB2zYJeai87A70J5guoiSXXmzT2ANakY08jHqR+o1NFzG/dPmR4
         2sCa5CBU1U9FpdDisN3Tcu78H/HKIrWgwdzDG98XgsgD4yRachsgKjl+oOXJ4HtxT4x/
         Uu9EOwplxaxLD0468u8cpyHUs1HoXEe4rjt0I=
Received: by 10.151.110.9 with SMTP id n9mr9392451ybm.148.1213566353734;
        Sun, 15 Jun 2008 14:45:53 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 28sm15743697qbw.0.2008.06.15.14.45.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:45:52 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85127>

Studying made me busy last week, but I'm back:
with another GSoC series, adding some usable feature this time.

At first, some stuff was still missing to produce packs, mostly
raw-data access related and ObjectWalk related.

Finally, we've got some support for pack writing! It's not that
power that C git version offers, but something usable. Delta
generation is not supported. Although we can reuse deltas and objects,
and support all other (I hope) options of git-pack-objects directly or
indirectly, most importantly --thin.

Pack writing and some other features are tested, seem to work.

This implementation of packing is not a very valuable thing directly
(achieving efficient storage), however it's a base for enhancements
and can be used for sending packs over net (with some assumptions).
It's more a "repacking" than "packing" tool.

So... I'm switching now to push implementation. If time allows,
delta-algorithms will be added later.

Robin,
this series is based on master of egit.git when I saw it last time
before repo.or.cz went down (9354293) ;) I'll add packwriter branch
to my repo when server is up.

Marek Zawirski (20):
  Fix typo in PackIndexV2
  Integer versions of copyRawTo() and fromRaw() in ObjectId
  Add openObjectInAllPacks() to Repository, exposing packed objects
    storage
  WindowedFile fragments copying: copyToStream()
  Reverse pack index implementation: PackReverseIndex
  Tests for PackReverseIndex
  Refactor PackIndexV2 - extract binarySearchLevelTwo()
  CRC32 support for PackIndex
  CRC32 PackIndex tests
  Format PackedObjectLoader class
  Format UnpackedObjectLoader class
  Format DeltaOfsPackedObjectLoader class
  Raw-data operations in ObjectLoaders and PackFile
  Add hasRevSort() in RevWalk for faster sorting strategy checking
  Refactor getRevSort() calls to hasRevSort()
  Support for RevSort.BOUNDARY in ObjectWalk
  Rename confusing objects field in ObjectWalk
  New CountingOutputStream class - stream decorator
  Simplified implementation of pack creation: PackWriter
  PackWriter test suite

 .../tst/org/spearce/jgit/lib/PackIndexTest.java    |   10 +
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |   19 +
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |   30 +
 .../org/spearce/jgit/lib/PackReverseIndexTest.java |  115 +++
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |  454 ++++++++++
 org.spearce.jgit.test/tst/pack-huge.idx            |  Bin 0 -> 2368 bytes
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   16 +
 .../jgit/lib/DeltaOfsPackedObjectLoader.java       |   24 +-
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |    9 +-
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |   15 +-
 .../src/org/spearce/jgit/lib/ObjectId.java         |   26 +
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |   24 +
 .../src/org/spearce/jgit/lib/PackFile.java         |   85 ++-
 .../src/org/spearce/jgit/lib/PackIndex.java        |   23 +
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   10 +
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   73 +-
 .../src/org/spearce/jgit/lib/PackReverseIndex.java |  179 ++++
 .../src/org/spearce/jgit/lib/PackWriter.java       |  882 ++++++++++++++++++++
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |   47 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   42 +
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   26 +-
 .../spearce/jgit/lib/WholePackedObjectLoader.java  |   20 +-
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   43 +
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   40 +-
 .../src/org/spearce/jgit/revwalk/RevSort.java      |    5 +-
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   11 +
 .../org/spearce/jgit/revwalk/StartGenerator.java   |   14 +-
 .../spearce/jgit/util/CountingOutputStream.java    |   89 ++
 28 files changed, 2258 insertions(+), 73 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
 create mode 100644 org.spearce.jgit.test/tst/pack-huge.idx
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
