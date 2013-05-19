From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/17] get_revision_internal(): make check less mysterious
Date: Sun, 19 May 2013 22:27:05 +0200
Message-ID: <1368995232-11042-11-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADq-0004mK-77
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab3ESU2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:38 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52343 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754237Ab3ESU2M (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:12 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-0b-519935db57ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.AC.02380.BD539915; Sun, 19 May 2013 16:28:11 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5T026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:10 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqHvbdGagwb/LAhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTujaf0CxoL9PBWz+ucyNTD+4Oxi5OSQEDCRONy1kgXCFpO4cG89WxcjF4eQwGVGic37
	T4IlhATOM0l0PK0GsdkEdCUW9TQzgdgiArIS3w9vZASxmQUmMEos7S8EsYUFvCTOzN0J1MvB
	wSKgKrFtogVImFfAVaJj701miF0KEpdnrQGzOYHiW9p3sUKscpH413+bdQIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYIQHFt4Oxfb3MIUYBDkYlHl6Nd9MDhVgT
	y4orcw8xSnIwKYnyvjOZGSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHePEFCONyWxsiq1KB8m
	Jc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBaw6MHCHBotT01Iq0zJwShDQTByeI4ALZ
	wAO0QRqkkLe4IDG3ODMdougUo6KUOO9FkLMEQBIZpXlwA2Cx/4pRHOgfYV5bkHYeYNqA634F
	NJgJaDDrtakgg0sSEVJSDYxy7hdCV4Rt1/FdxTM7b9JFM+Od56Qfltu6NT8Uins4+Wjr47kR
	Oac81pdXxE5xZC6yfct3Pt2R+7iIcryM2I1Fxtp/4jZ9KFjc/jY5duanpBLlJff/WKd+naMv
	JTSlMVn1SLV0ROfPua3Nqd+Ua0Nkr7ZN0dqR+dwnImAex8mbHezzp2/Y9V2JpTgj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224921>

The condition under which gc_boundary() is called was previously

    if (alloc <= nr)

.  But by construction, nr can never exceed alloc, so the check looks
unnecessarily mysterious.  In fact, the purpose of the check is to try
to avoid a realloc() call by shrinking the array if possible if it is
at its allocation limit when a new element is about to be added.  So
change the check to

    if (nr == alloc)

and add a comment to explain what's going on.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Please check that I have properly described the purpose of this check.

The way the code is written, it looks like a bad pattern of growth and
shrinkage of the array (namely, just under the resize limit) could
cause gc_boundary() to be called over and over again with (most of)
the same data.  I hope that the author had some reason to believe that
such a pattern is unlikely.

 revision.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2e0992b..19c59f4 100644
--- a/revision.c
+++ b/revision.c
@@ -2573,8 +2573,10 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		if (p->flags & (CHILD_SHOWN | SHOWN))
 			continue;
 		p->flags |= CHILD_SHOWN;
-		if (revs->boundary_commits.alloc <= revs->boundary_commits.nr)
+		if (revs->boundary_commits.nr == revs->boundary_commits.alloc) {
+			/* Try to make space and thereby avoid a realloc(): */
 			gc_boundary(&revs->boundary_commits);
+		}
 		add_object_array(p, NULL, &revs->boundary_commits);
 	}
 
-- 
1.8.2.3
