From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] bisect: use the new generic "sha1_pos" function to
 lookup sha1
Date: Sat, 4 Apr 2009 22:59:36 +0200
Message-ID: <20090404225936.cdcad81b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 23:02:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqD0e-0001uP-L9
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 23:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbZDDVAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 17:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbZDDVAp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 17:00:45 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:52607 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbZDDVAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 17:00:45 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EFC79818122;
	Sat,  4 Apr 2009 23:00:36 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id E7FF981808E;
	Sat,  4 Apr 2009 23:00:33 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115597>

instead of the specific one that was simpler but less efficient.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index affba41..336d611 100644
--- a/bisect.c
+++ b/bisect.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "list-objects.h"
 #include "quote.h"
+#include "sha1-lookup.h"
 #include "bisect.h"
 
 
@@ -461,22 +462,16 @@ static void prepare_skipped(void)
 	qsort(skipped_sha1, skipped_sha1_nr, sizeof(*skipped_sha1), skipcmp);
 }
 
+static const unsigned char *skipped_sha1_access(size_t index, void *table)
+{
+	unsigned char (*skipped)[20] = table;
+	return skipped[index];
+}
+
 static int lookup_skipped(unsigned char *sha1)
 {
-	int lo, hi;
-	lo = 0;
-	hi = skipped_sha1_nr;
-	while (lo < hi) {
-		int mi = (lo + hi) / 2;
-		int cmp = hashcmp(sha1, skipped_sha1[mi]);
-		if (!cmp)
-			return mi;
-		if (cmp < 0)
-			hi = mi;
-		else
-			lo = mi + 1;
-	}
-	return -lo - 1;
+	return sha1_pos(sha1, skipped_sha1, skipped_sha1_nr,
+			skipped_sha1_access);
 }
 
 struct commit_list *filter_skipped(struct commit_list *list,
-- 
1.6.2.2.404.ge96f3.dirty
