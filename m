From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix performance problem recently introduced to DeltaPackedObjectLoader
Date: Mon, 27 Apr 2009 14:44:57 -0700
Message-ID: <1240868697-30971-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 23:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyYdR-0005rP-1t
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 23:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbZD0Vo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbZD0Vo7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 17:44:59 -0400
Received: from george.spearce.org ([209.20.77.23]:39840 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbZD0Vo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 17:44:58 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 58B8A38221; Mon, 27 Apr 2009 21:44:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D672038211;
	Mon, 27 Apr 2009 21:44:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117717>

In fe6c8248e1ed6bd9db76a8314103081a02d55393 ("Fully materialize an
ObjectLoader before returning it from ObjectDatabase") I missed a
crucial return call here in DeltaPackedObjectLoadeder.  That one
missing line caused cache hits in the UnpackedObjectCache to then
fall through and unpack the delta base, and apply the delta onto
it, ignoring the fact that we had a successful cache hit.

When packing and serving e.g. the Linux kernel repository this
resulted in a 10x increase in the number of WindowCache.get()
invocations we saw, as the UnpackedObjectCache was useless.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
index 8194d94..7d3f30d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
@@ -69,6 +69,7 @@ public void materialize(final WindowCursor curs) throws IOException {
 				objectType = cache.type;
 				objectSize = cache.data.length;
 				cachedBytes = cache.data;
+				return;
 			}
 		}
 
-- 
1.6.3.rc1.205.g37f8
