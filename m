From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/10] Support writing pack index version 2
Date: Mon, 23 Jun 2008 22:09:58 -0400
Message-ID: <1214273408-70793-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy05-0005dy-QW
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYFXCKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYFXCKW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49618 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbYFXCKV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxyv-0001M2-JG; Mon, 23 Jun 2008 22:10:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 4A8BF20FBC9; Mon, 23 Jun 2008 22:10:15 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id D904E20FBCA;
	Mon, 23 Jun 2008 22:10:08 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85968>

This series adds support for writing pack index v2 formatted files
out of IndexPack, and thus any pack we fetch over the network.  It
also abstracts out the index formatting functions so we can reuse
them efficiently inside of PackWriter to support creating packs on
the local disk, or to upload packs directly over a dumb transport.

I started down this path because we're missing index v2 support and
that is likely to become a default in the near future for C Git,
and because I want to support push over sftp style URLs now that
Marek has a pack writing implementation.

----

The following changes since commit 535041bba0836a3488fbd465adb171a2c70c9415:
  Florian Koeberle (1):
        Added the package fnmatch and two exceptions.

are available in the git repository at:

  repo.or.cz:/srv/git/egit/spearce.git index-v2

Shawn O. Pearce (10):
      Extract inner ObjectEntry from IndexPack class
      Make ObjectEntry's position field private
      Rename ObjectEntry to PackedObjectInfo
      Document PackedObjectInfo and make it public for reuse
      Refactor pack index writing to a common API
      Reuse the magic tOc constant for pack index headers
      Add 64 bit network byte order encoding to NB
      Compute packed object entry CRC32 data during IndexPack
      Add support for writing pack index v2 files
      Default IndexPack to honor pack.indexversion configuration

 .../src/org/spearce/jgit/lib/CoreConfig.java       |   11 +
 .../src/org/spearce/jgit/lib/PackIndex.java        |    3 +-
 .../src/org/spearce/jgit/lib/PackIndexWriter.java  |  267 ++++++++++++++++++++
 .../org/spearce/jgit/lib/PackIndexWriterV1.java    |   78 ++++++
 .../org/spearce/jgit/lib/PackIndexWriterV2.java    |  101 ++++++++
 .../src/org/spearce/jgit/pgm/IndexPack.java        |    4 +
 .../src/org/spearce/jgit/transport/IndexPack.java  |  225 ++++++++++-------
 .../spearce/jgit/transport/PackedObjectInfo.java   |  109 ++++++++
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   37 +++
 9 files changed, 743 insertions(+), 92 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV1.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV2.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
