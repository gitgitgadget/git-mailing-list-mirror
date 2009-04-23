From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Make ObjectLoader safer during repack
Date: Wed, 22 Apr 2009 20:36:18 -0700
Message-ID: <1240457783-21434-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 05:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwplS-0005xI-90
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 05:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbZDWDg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 23:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbZDWDgZ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 23:36:25 -0400
Received: from george.spearce.org ([209.20.77.23]:46493 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZDWDgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 23:36:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6D81D3821F; Thu, 23 Apr 2009 03:36:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DD8DD381CE;
	Thu, 23 Apr 2009 03:36:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117288>

This is a start to fixing the ObjectLoader save during repack
problems I talked about yesterday.  It applies on top of the
WindowedFile+PackFile patch I sent earlier today.

Patch 1 and 2 are trivial.

Patch 3 fixes the broken 10/10 test case I raised yesterday.

Patch 4 introduces that test case.

Patch 5 starts to fix PackWriter to be safe during repack.
Its still a bit iffy.  The basic logic here is sound, but I'm more
worried about someone else calling PackFile.close() and closing the
underlying RandomFile while we are otherwise accessing the file
during the copyRaw in PackWriter.  I *think* its impossible for
that to occur, but I haven't proven it to myself yet, and its late,
so this one is RFC for now.

Shawn O. Pearce (5):
  Remove throws IOException from UnpackedObjectLoader.getCachedBytes
  Add missing @Override annotations to UnpackedObjectLoader
  Fully materialize an ObjectLoader before returning it from
    ObjectDatabase
  Test that ObjectLoader stays valid across repacks
  Teach PackWriter to recover from removed/replaced packs

 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |   40 +++++++
 .../jgit/lib/DeltaOfsPackedObjectLoader.java       |    7 +-
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |   41 +++----
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |    9 +-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    3 +-
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |   23 +---
 .../src/org/spearce/jgit/lib/PackFile.java         |   14 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |  118 +++++++++++++-------
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |   78 +++++++++++--
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |    4 +-
 .../spearce/jgit/lib/WholePackedObjectLoader.java  |   21 ++--
 .../src/org/spearce/jgit/lib/WindowCache.java      |   59 +++++++----
 12 files changed, 280 insertions(+), 137 deletions(-)
