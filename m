From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/17] gc_boundary(): move the check "alloc <= nr" to caller
Date: Sun, 19 May 2013 22:27:04 +0200
Message-ID: <1368995232-11042-10-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADo-0004mK-LI
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab3ESU2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:12 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:63557 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754418Ab3ESU2K (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:10 -0400
X-AuditID: 12074414-b7fb86d000000905-45-519935d97b84
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 24.59.02309.9D539915; Sun, 19 May 2013 16:28:09 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5S026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:08 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHvTdGagwfNpOhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj/mOXgj88FfOvPmJvYJzA1cXIySEhYCKx6OJ7VghbTOLCvfVsXYxcHEIClxklJv1b
	wgrhnGeSeP2pnQWkik1AV2JRTzMTiC0iICvx/fBGRhCbWWACo8TS/kIQW1jAR2Lp2wvsIDaL
	gKrE9QdrmUFsXgFXia/Lj7BDbFOQuDxrDVicEyi+pX0X2BVCAi4S//pvs05g5F3AyLCKUS4x
	pzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIySkRHYwHjkpd4hRgINRiYe34cP0QCHW
	xLLiytxDjJIcTEqivMtVZwYK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHdIwSU401JrKxKLcqH
	SUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4HU3AWoULEpNT61Iy8wpQUgzcXCCCC6Q
	DTxAGxaBFPIWFyTmFmemQxSdYlSUEue9CJIQAElklObBDYBF/ytGcaB/hHmPgFTxABMHXPcr
	oMFMQINZr00FGVySiJCSamAU+bDJ4ZjYM6tqz8dMc40e/zFe2s5a/jPOd+k3IdW6pYLfOw+u
	22e1+PrPp3Wx95/zPpXcf132xgIJ9rxccV2haX1dG5ZtL/uye0lJmk/iFo5Lzd8b2ETjF91I
	Fqz99uRc5mQ7owdpzEneiWzSe3xY04qfLdPnFJ+p5BNlYfPnDkPd0zWrk44qsRRn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224917>

There is no logical reason for this test to be here.  At the caller we
might be able to figure out its meaning.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 revision.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/revision.c b/revision.c
index 8ac88d6..2e0992b 100644
--- a/revision.c
+++ b/revision.c
@@ -2437,23 +2437,19 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 static void gc_boundary(struct object_array *array)
 {
-	unsigned nr = array->nr;
-	unsigned alloc = array->alloc;
+	unsigned nr = array->nr, i, j;
 	struct object_array_entry *objects = array->objects;
 
-	if (alloc <= nr) {
-		unsigned i, j;
-		for (i = j = 0; i < nr; i++) {
-			if (objects[i].item->flags & SHOWN)
-				continue;
-			if (i != j)
-				objects[j] = objects[i];
-			j++;
-		}
-		for (i = j; i < nr; i++)
-			objects[i].item = NULL;
-		array->nr = j;
+	for (i = j = 0; i < nr; i++) {
+		if (objects[i].item->flags & SHOWN)
+			continue;
+		if (i != j)
+			objects[j] = objects[i];
+		j++;
 	}
+	for (i = j; i < nr; i++)
+		objects[i].item = NULL;
+	array->nr = j;
 }
 
 static void create_boundary_commit_list(struct rev_info *revs)
@@ -2577,7 +2573,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		if (p->flags & (CHILD_SHOWN | SHOWN))
 			continue;
 		p->flags |= CHILD_SHOWN;
-		gc_boundary(&revs->boundary_commits);
+		if (revs->boundary_commits.alloc <= revs->boundary_commits.nr)
+			gc_boundary(&revs->boundary_commits);
 		add_object_array(p, NULL, &revs->boundary_commits);
 	}
 
-- 
1.8.2.3
