From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/11] Fix performance problem recently introduced to DeltaPackedObjectLoader
Date: Wed, 29 Apr 2009 11:54:39 -0700
Message-ID: <1241031288-23437-3-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
 <1241031288-23437-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwl-0003Rz-QI
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbZD2Syz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbZD2Syx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:54:53 -0400
Received: from george.spearce.org ([209.20.77.23]:32873 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbZD2Syu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8A7DB3806F; Wed, 29 Apr 2009 18:54:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B9A3438069;
	Wed, 29 Apr 2009 18:54:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117916>

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

 Unchanged.

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
1.6.3.rc3.199.g24398
