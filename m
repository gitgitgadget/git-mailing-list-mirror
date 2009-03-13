From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] RevWalk fixes for UNINTERESTING
Date: Thu, 12 Mar 2009 19:07:37 -0700
Message-ID: <1236910062-18476-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhwpm-0006Hf-FW
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZCMCHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 22:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZCMCHp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:07:45 -0400
Received: from george.spearce.org ([209.20.77.23]:46982 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbZCMCHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:07:44 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 15DA83814F; Fri, 13 Mar 2009 02:07:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8D96A3814F;
	Fri, 13 Mar 2009 02:07:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113131>

Today I uncovered some ugly cases with "jgit rev-list B ^A", where
some commits reachable from A were still being output, even though
we asked that they be excluded.

This series attempts to fix it by forcing date ordering, and delaying
output a little to try and work over any clock skew discovered near
the end of the traversal, just before we give up.

Shawn O. Pearce (5):
  Show critical flags in debug toString() descriptions of rev queues
  Make RevObject.getType implementations final
  Remove the horribly stupid RevSort.START_ORDER
  Fix RevWalk with Linus Torvald's occasional bad commit date hack
  Avoid incorrect output of UNINTERESTING commits when clock skew
    occurs

 .../org/spearce/jgit/revwalk/AbstractRevQueue.java |    5 +
 .../src/org/spearce/jgit/revwalk/DateRevQueue.java |   10 +--
 .../org/spearce/jgit/revwalk/DelayRevQueue.java    |   92 ++++++++++++++++++++
 .../src/org/spearce/jgit/revwalk/FIFORevQueue.java |   10 +--
 .../jgit/revwalk/FixUninterestingGenerator.java    |   77 ++++++++++++++++
 .../src/org/spearce/jgit/revwalk/LIFORevQueue.java |   10 +--
 .../org/spearce/jgit/revwalk/PendingGenerator.java |   59 +++++++++++--
 .../src/org/spearce/jgit/revwalk/RevBlob.java      |    2 +-
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |   15 +++-
 .../src/org/spearce/jgit/revwalk/RevObject.java    |   24 +++++
 .../src/org/spearce/jgit/revwalk/RevSort.java      |   11 ---
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    2 +-
 .../src/org/spearce/jgit/revwalk/RevTree.java      |    2 +-
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    6 +-
 .../org/spearce/jgit/revwalk/StartGenerator.java   |   27 ++++--
 15 files changed, 296 insertions(+), 56 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/revwalk/DelayRevQueue.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/revwalk/FixUninterestingGenerator.java
