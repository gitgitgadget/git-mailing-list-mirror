From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/21] Remove unused index files when WalkFetchConnection closes
Date: Sun, 29 Jun 2008 03:59:11 -0400
Message-ID: <1214726371-93520-2-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrqi-00005Q-Br
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbYF2H76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 03:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYF2H7r
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 03:59:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36719 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYF2H7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:59:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrow-0004Ld-GM; Sun, 29 Jun 2008 03:59:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 9366220FBAE; Sun, 29 Jun 2008 03:59:38 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 3C12220FBC9;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-1-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86764>

If we downloaded an index but then didn't download the corresponding
pack file we never deleted the index from disk.  We should clear any
unused indexes that are left when we terminate the connection.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/WalkFetchConnection.java        |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 78116b2..5a21d24 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -201,6 +201,8 @@ class WalkFetchConnection extends BaseFetchConnection {
 
 	@Override
 	public void close() {
+		for (final RemotePack p : unfetchedPacks)
+			p.tmpIdx.delete();
 		for (final WalkRemoteObjectDatabase r : remotes)
 			r.close();
 	}
-- 
1.5.6.74.g8a5e
