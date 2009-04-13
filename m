From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Handle the case when the file timestamp in java is rounded to seconds
Date: Mon, 13 Apr 2009 22:45:00 +0200
Message-ID: <1239655500-13595-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Apr 13 22:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtT3H-00075k-DL
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 22:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZDMUpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 16:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbZDMUpK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 16:45:10 -0400
Received: from mail.dewire.com ([83.140.172.130]:5366 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbZDMUpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 16:45:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E099F14915DB;
	Mon, 13 Apr 2009 22:45:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHTEaPTYwZZ0; Mon, 13 Apr 2009 22:45:02 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3F41E14915DA;
	Mon, 13 Apr 2009 22:45:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116482>

Even if the file systems support subsecond timestamp resolution
the Java runtime, including the Eclipse resources may return
timestamps that are truncated to seconds only.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../decorators/DecoratableResourceAdapter.java     |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
index 5c68d5b..12f7ec3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
@@ -354,8 +354,12 @@ private static boolean timestampMatches(DirCacheEntry indexEntry,
 		// so we need to check to see if this is the case here, and possibly
 		// fix the timestamp of the resource to match the resolution of the
 		// index.
-		if (tIndex % 1000 == 0) {
-			return tIndex == (tWorkspaceResource - (tWorkspaceResource % 1000));
+		// It also appears the timestamp in Java on Linux may also be rounded
+		// in which case the index timestamp may have subseconds, but not
+		// the timestamp from the workspace resource.
+		// If either timestamp looks rounded we skip the subscond part.
+		if (tIndex % 1000 == 0 || tWorkspaceResource % 1000 == 0) {
+			return tIndex / 1000 == tWorkspaceResource / 1000;
 		} else {
 			return tIndex == tWorkspaceResource;
 		}
-- 
1.6.2.2.446.gfbdc0
