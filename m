From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/6] cache_tree_find(): remove early return
Date: Wed,  5 Mar 2014 18:26:29 +0100
Message-ID: <1394040390-7954-6-git-send-email-mhagger@alum.mit.edu>
References: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:26:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFar-0007UZ-7U
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbaCER0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:26:54 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42946 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754222AbaCER0r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 12:26:47 -0500
X-AuditID: 1207440e-f79c76d000003e2c-d1-53175e56bb1e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.3B.15916.65E57135; Wed,  5 Mar 2014 12:26:46 -0500 (EST)
Received: from michael.fritz.box (p57A24002.dip0.t-ipconnect.de [87.162.64.2])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s25HQY7E022625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Mar 2014 12:26:45 -0500
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqBsWJx5s8PWJmsXsG9vYLLqudDNZ
	NPReYba4vWI+swOLx9/3H5g82qaZeVy8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfGzr2NjAX3
	WSuWf3/D2sC4g6WLkZNDQsBE4t3VP0wQtpjEhXvr2boYuTiEBC4zSmz7/BrKOcok8XXqG7AO
	NgFdiUU9zWAdIgJqEhPbDoHFmQXSJB5suQJkc3AIC9hJvP7nCxJmEVCV2PDoAzOIzSvgLHH9
	7h1WiGVyElN+L2AHsTkFXCQal3YwgbQKAdUs2s88gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLk
	xLy81CJdY73czBK91JTSTYyQ0OHbwdi+XuYQowAHoxIPL0egeLAQa2JZcWXuIUZJDiYlUd6r
	0UAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwBkUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTE
	ktTs1NSC1CKYrAwHh5IEr0IsUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KC7i
	i4GRAZLiAdrbCdLOW1yQmAsUhWg9xagoJc6rCJIQAElklObBjYUlhFeM4kBfCkNU8QCTCVz3
	K6DBTECDo/nABpckIqSkGhjlb0h/X7F1tibf63+FBw6G1LGtP/vqQQK7aJTmpz4ByZxz56X2
	zvnTuGCLzJXnN1lZONsK45gcvJZ/bLO/lVRmv6Ww7pfgPWff3RsCKku5BRZdDDjc2rtBMlrI
	2tv/g4Eh73LTMs+ElyY1MR0cb6+xHPZaqnDp09NHW+zcpIv2S+5Ze+7f8W4lluKM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243448>

There is no need for an early

    return it;

from the loop if slash points at the end of the string, because that
is exactly what will happen when the while condition fails at the
start of the next iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 39ad8c9..17db9f9 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -565,8 +565,6 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		it = sub->cache_tree;
 		while (*slash == '/')
 			slash++;
-		if (!*slash)
-			return it; /* prefix ended with slashes */
 		path = slash;
 	}
 	return it;
-- 
1.9.0
