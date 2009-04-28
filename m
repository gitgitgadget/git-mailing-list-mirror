From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/13] Work around Sun JVM bug "Cleared SoftReference not added to queue"
Date: Tue, 28 Apr 2009 14:12:21 -0700
Message-ID: <1240953146-12878-9-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
 <1240953146-12878-3-git-send-email-spearce@spearce.org>
 <1240953146-12878-4-git-send-email-spearce@spearce.org>
 <1240953146-12878-5-git-send-email-spearce@spearce.org>
 <1240953146-12878-6-git-send-email-spearce@spearce.org>
 <1240953146-12878-7-git-send-email-spearce@spearce.org>
 <1240953146-12878-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyueQ-0006Nh-OZ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbZD1VM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756089AbZD1VMz
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:55 -0400
Received: from george.spearce.org ([209.20.77.23]:58331 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbZD1VMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5C42A38222; Tue, 28 Apr 2009 21:12:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7201738265;
	Tue, 28 Apr 2009 21:12:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117817>

> http://bugs.sun.com/view_bug.do?bug_id=4485942
>
> Normally all soft references cleared by the garbage collector are
> added to the reference queue the reference was created with (if any).
> But if a program happens to call SoftReference.get() after the reference
> has been cleared, but before it has been added to the reference queue it
> will never be added to the reference queue.
...
> This bug can be worked around by keeping track of calls to
> SoftReference.get() that returns null. The only problem is that the
> code must also allow for the behavior to change when/if the bug is
> fixed.

The bug was opened against JDK 1.3.1, reported to still exist in 1.4,
and isn't marked fixed yet despite 1.6 having shipped.

We already have a work around for this in our code.  We mark a reference
as cleared using our own boolean, as we need to work around another bug
in the ReferenceQueue implementation anyway.  So, we try to enqueue the
dead reference when we find it.  If its already enqueued, no harm.  If
we hit the enqueue bug and enqueue it twice, no harm, our cleared flag
will skip the second removal from the queue.  If the bug described in
4485942 exists, we'll enqueue the reference for the GC.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/OffsetCache.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
index 12912d9..e3ed37d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
@@ -232,7 +232,7 @@ private V scan(Entry<V> n, final PackFile pack, final long position) {
 					hit(r);
 					return v;
 				}
-				n.dead = true;
+				n.kill();
 				break;
 			}
 		}
-- 
1.6.3.rc1.205.g37f8
