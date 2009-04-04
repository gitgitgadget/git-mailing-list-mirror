From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] replace_object: use the new generic "sha1_pos" function
 to lookup sha1
Date: Sat, 4 Apr 2009 22:59:41 +0200
Message-ID: <20090404225941.7fef76a7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 23:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqD0f-0001uP-Du
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 23:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbZDDVAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 17:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbZDDVAv
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 17:00:51 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42691 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172AbZDDVAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 17:00:50 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6095B940130;
	Sat,  4 Apr 2009 23:00:41 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 1D8109400AF;
	Sat,  4 Apr 2009 23:00:39 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115599>

instead of the specific one that was simpler but less efficient.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 replace_object.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index 1227214..eb59604 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "sha1-lookup.h"
 #include "refs.h"
 
 static struct replace_object {
@@ -7,23 +8,16 @@ static struct replace_object {
 
 static int replace_object_alloc, replace_object_nr;
 
+static const unsigned char *replace_sha1_access(size_t index, void *table)
+{
+	struct replace_object **replace = table;
+	return replace[index]->sha1[0];
+}
+
 static int replace_object_pos(const unsigned char *sha1)
 {
-	int lo, hi;
-	lo = 0;
-	hi = replace_object_nr;
-	while (lo < hi) {
-		int mi = (lo + hi) / 2;
-		struct replace_object *rep = replace_object[mi];
-		int cmp = hashcmp(sha1, rep->sha1[0]);
-		if (!cmp)
-			return mi;
-		if (cmp < 0)
-			hi = mi;
-		else
-			lo = mi + 1;
-	}
-	return -lo - 1;
+	return sha1_pos(sha1, replace_object, replace_object_nr,
+			replace_sha1_access);
 }
 
 static int register_replace_object(struct replace_object *replace,
-- 
1.6.2.2.404.ge96f3.dirty
