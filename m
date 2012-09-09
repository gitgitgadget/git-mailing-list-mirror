From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/14] filter_refs(): do not check the same sought_pos twice
Date: Sun,  9 Sep 2012 08:19:41 +0200
Message-ID: <1347171589-13327-7-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:22:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAau5-0003F9-Fb
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab2IIGVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:20 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:48290 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752185Ab2IIGUi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:38 -0400
X-AuditID: 12074411-b7fa36d0000008cc-60-504c353580cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B3.70.02252.5353C405; Sun,  9 Sep 2012 02:20:37 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlj029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:36 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqGtq6hNgcPuZpUXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M+6e2MtWsIy9YueDR+wNjA9Yuxg5OSQETCR+fD/FAmGLSVy4t56ti5GLQ0jgMqPEyo7d
	jBDOGSaJM6/XM4NUsQnoSizqaWYCsUUE1CQmth1iASliFuhilFi+7hcbSEJYwF/i6erlYDaL
	gKrE1NlbwZp5BVwk9m2+wA6xThFo9RqwOKeAq8SrmSDbOIG2uUhs2nmNdQIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIUEluINxxkm5Q4wCHIxKPLzMd7wDhFgT
	y4orcw8xSnIwKYnyNuv5BAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b3KDpTjTUmsrEotyodJ
	SXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwfjAGahQsSk1PrUjLzClBSDNxcIIILpAN
	PEAbroMU8hYXJOYWZ6ZDFJ1iVJQS530IkhAASWSU5sENgMX/K0ZxoH+EeVlMgKp4gKkDrvsV
	0GAmoMEizzxABpckIqSkGhjnxBy98GFr3OQz75df1rnXcnDBp9eaT056Gaq+kf7h6fkggN3w
	XujGlGe/6tWv6sdJP5tdnsQ+v2ySzgkO6aXy8o8n7Cv+tdLQ33IT/1qP1qR0tpoWnRjzfKVW
	X5ebL4V2LP/fVHLp/a46+YJ7LTXFgfn7jq4uNzz797hywp3jH/ck8X386n1JiaU4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205064>

Once a match has been found at sought_pos, the entry is zeroed and no
future attempts will match that entry.  So increment sought_pos to
avoid checking against the zeroed-out entry during the next iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index df81995..63d455f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -565,8 +565,8 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					sought->items[sought_pos].string[0] = '\0';
 					return_refs[sought_pos] = ref;
+					sought->items[sought_pos++].string[0] = '\0';
 					break;
 				}
 				else /* might have it; keep looking */
-- 
1.7.11.3
