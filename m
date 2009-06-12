From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Fix major performance problems in UploadPack
Date: Fri, 12 Jun 2009 16:00:14 -0700
Message-ID: <1244847619-7364-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFjk-000336-RP
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbZFLXAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbZFLXAX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:00:23 -0400
Received: from george.spearce.org ([209.20.77.23]:40044 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZFLXAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:00:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E1A3F38221; Fri, 12 Jun 2009 23:00:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D0834381D6;
	Fri, 12 Jun 2009 23:00:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121460>

If the client is really far ahead of the server, JGit's UploadPack
can spend a massive amount of CPU time on the server just doing the
same work over and over again.  This series addresses the issue by
taking advantage of cached data more frequently.

Shawn O. Pearce (5):
  Make RevTag getObject(), getName() final to prevent overrides
  Allow exceptions to be created with integer type codes
  Unify RevWalk parsing code to be more consistent across types
  Change RevObject dispose() semantics to avoid reparses
  UploadPack: Only recompute okToGiveUp() if bases changed

 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |    2 +-
 .../jgit/errors/IncorrectObjectTypeException.java  |   13 +++
 .../jgit/errors/MissingObjectException.java        |   12 +++
 .../src/org/spearce/jgit/lib/PackWriter.java       |    3 +-
 .../spearce/jgit/revwalk/BoundaryGenerator.java    |    2 +-
 .../spearce/jgit/revwalk/MergeBaseGenerator.java   |    2 +-
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |    4 +-
 .../org/spearce/jgit/revwalk/PendingGenerator.java |    6 +-
 .../src/org/spearce/jgit/revwalk/RevBlob.java      |    5 -
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |   29 ++++----
 .../src/org/spearce/jgit/revwalk/RevObject.java    |   34 ++++++--
 .../src/org/spearce/jgit/revwalk/RevTag.java       |   32 ++++----
 .../src/org/spearce/jgit/revwalk/RevTree.java      |    5 -
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   82 ++++++++++++++-----
 .../spearce/jgit/revwalk/RewriteTreeFilter.java    |    2 +-
 .../src/org/spearce/jgit/transport/UploadPack.java |   31 +++++---
 .../jgit/transport/WalkFetchConnection.java        |   15 +---
 17 files changed, 179 insertions(+), 100 deletions(-)
