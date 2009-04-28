From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/13] Fix performance problem recently introduced to DeltaPackedObjectLoader
Date: Tue, 28 Apr 2009 14:12:14 -0700
Message-ID: <1240953146-12878-2-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyuba-0004xr-Gz
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbZD1VMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbZD1VMa
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:30 -0400
Received: from george.spearce.org ([209.20.77.23]:58310 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbZD1VM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C9C4938262; Tue, 28 Apr 2009 21:12:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C26C838221;
	Tue, 28 Apr 2009 21:12:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
