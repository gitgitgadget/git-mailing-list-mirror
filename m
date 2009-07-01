From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Avoid growing WorkingTreeIterator's path multiple times
Date: Wed,  1 Jul 2009 15:45:53 -0700
Message-ID: <1246488353-16867-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM8Z1-0008JD-JG
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbZGAWpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZGAWpx
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:45:53 -0400
Received: from george.spearce.org ([209.20.77.23]:43776 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbZGAWpw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:45:52 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 31ACE381FE; Wed,  1 Jul 2009 22:45:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D5692381D5;
	Wed,  1 Jul 2009 22:45:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.3.420.gd4b46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122611>

If the current path buffer isn't big enough for the current file
name to be appended onto it, we can immediately grow it to the
correct target size by using the new ensurePathCapacity method.
This may save us from growing the buffer twice in rapid succession
if the path name component is really long, and the current buffer
is still the fairly small default size.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index 836b01a..d4291ea 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -258,8 +258,7 @@ private void parseEntry() {
 		mode = e.getMode().getBits();
 
 		final int nameLen = e.encodedNameLen;
-		while (pathOffset + nameLen > path.length)
-			growPath(pathOffset);
+		ensurePathCapacity(pathOffset + nameLen, pathOffset);
 		System.arraycopy(e.encodedName, 0, path, pathOffset, nameLen);
 		pathLen = pathOffset + nameLen;
 	}
-- 
1.6.3.3.420.gd4b46
