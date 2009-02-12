From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/9] Misc. pack code cleanups
Date: Wed, 11 Feb 2009 18:36:50 -0800
Message-ID: <1234406219-19547-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTa-0002tJ-K4
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbZBLChF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756491AbZBLChD
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:03 -0500
Received: from george.spearce.org ([209.20.77.23]:39166 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZBLChB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:01 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1356E38215; Thu, 12 Feb 2009 02:37:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7E1D43819E;
	Thu, 12 Feb 2009 02:36:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109560>

This is a short batch of misc. cleanups related to pack handling.
I'm trying to work towards making it safer to run "git gc" while
JGit has a repository open.

Currently:

  - when a new pack is added we don't notice it;
  - when a previously listed pack is removed, we crash;
  - if a pack stays but its offsets change, we crash;
  - objects can go *poof* if they were loose and get packed;

This series doesn't fix any of these issues, but it cleans
up the code enough that I can start to consider this more.

The last patch is perhaps a bit more controversial.  It sets
core.packindex to 2 by default, which was done in C Git back
when 1.6.0 shipped.


Shawn O. Pearce (9):
  Remove the Repository parameter from PackFile's constructor
  Remove dead stats code from WindowCache
  Document why WindowFile's hash is *31
  Allow PackFile to lazily load its PackIndex on first demand
  Arrange pack files in recency order to improve quick hits
  Rename readPackHeader() to be onOpenPack()
  Validate the pack's footer checksum matches that in the index
  Remove yet another legacy StGit utility function
  Make pack.indexversion config option default to version 2

 .../src/org/spearce/jgit/pgm/IndexPack.java        |    4 +-
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    2 +-
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    2 +-
 .../org/spearce/jgit/transport/IndexPackTest.java  |    4 +-
 .../src/org/spearce/jgit/lib/CoreConfig.java       |    3 +-
 .../src/org/spearce/jgit/lib/PackFile.java         |   95 +++++++++++++------
 .../src/org/spearce/jgit/lib/PackIndex.java        |    3 +
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |    3 +
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |    3 +
 .../src/org/spearce/jgit/lib/PackWriter.java       |    1 +
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    4 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   41 +++------
 .../src/org/spearce/jgit/lib/WindowCache.java      |   31 +------
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    4 +
 14 files changed, 106 insertions(+), 94 deletions(-)
