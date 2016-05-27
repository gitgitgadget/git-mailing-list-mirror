From: David Kastrup <dak@gnu.org>
Subject: [PATCH] blame.c: don't drop origin blobs as eagerly
Date: Fri, 27 May 2016 15:35:41 +0200
Message-ID: <1464356141-3797-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Hx0-0004NR-Sg
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 15:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcE0NhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 09:37:12 -0400
Received: from eggs.gnu.org ([208.118.235.92]:59516 "EHLO eggs.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcE0NhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 09:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6Hwr-00037L-HG
	for git@vger.kernel.org; Fri, 27 May 2016 09:37:10 -0400
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on eggs.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_50,RP_MATCHES_RCVD
	autolearn=disabled version=3.3.2
Received: from fencepost.gnu.org ([2001:4830:134:3::e]:53747 helo=lola.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6Hwo-00035q-Q2; Fri, 27 May 2016 09:37:07 -0400
Received: by lola.localdomain (Postfix, from userid 1000)
	id C1411E248E; Fri, 27 May 2016 15:35:48 +0200 (CEST)
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4830:134:3::e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295751>

When a parent blob already has chunks queued up for blaming, dropping
the blob at the end of one blame step will cause it to get reloaded
right away, doubling the amount of I/O and unpacking when processing a
linear history.

Keeping such parent blobs in memory seems like a reasonable
optimization.  It's conceivable that this may incur additional memory
pressure particularly when the history contains lots of merges from
long-diverged branches.  In practice, this optimization appears to
behave quite benignly, and a viable strategy for limiting the total
amount of cached blobs in a useful manner seems rather hard to
implement.  In addition, calling git-blame with -C leads to similar
memory retention patterns.
---
 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..2596fbc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1556,7 +1556,8 @@ finish:
 	}
 	for (i = 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
-			drop_origin_blob(sg_origin[i]);
+			if (!sg_origin[i]->suspects)
+				drop_origin_blob(sg_origin[i]);
 			origin_decref(sg_origin[i]);
 		}
 	}
-- 
2.7.4
