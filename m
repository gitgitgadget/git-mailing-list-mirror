From: mhagger@alum.mit.edu
Subject: [PATCH 10/17] Remove ineffective optimization
Date: Thu, 23 Aug 2012 10:10:35 +0200
Message-ID: <1345709442-16046-11-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4SdC-0000rv-7p
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720Ab2HWIS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:59 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59284 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933716Ab2HWISz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:55 -0400
X-AuditID: 1207440d-b7f236d000000943-0f-5035e5b192f7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 79.50.02371.1B5E5305; Thu, 23 Aug 2012 04:11:29 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVA030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:28 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvxqWmAwaJpPBZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujPWf7rAX
	HOSu2LdjM1sD4xzOLkZODgkBE4kPr46wQ9hiEhfurWfrYuTiEBK4zCix59MKZpCEkMBZJonW
	D0ogNpuAlMTLxh6wBhEBNYmJbYdYQGxmgRSJjufdjCC2sICZxMYZp5hAbBYBVYn3jdfZQGxe
	AVeJ7pszmSCWKUr8+L4GbD4nUHzB902MELtcJD423mSewMi7gJFhFaNcYk5prm5uYmZOcWqy
	bnFyYl5eapGukV5uZoleakrpJkZI+PDuYPy/TuYQowAHoxIP7wtz0wAh1sSy4srcQ4ySHExK
	orz/HgGF+JLyUyozEosz4otKc1KLDzFKcDArifCGzwPK8aYkVlalFuXDpKQ5WJTEedWWqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeCWBcSIkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIR
	D4qM+GJgbICkeID2KoK08xYXJOYCRSFaTzHqcvw/efIuoxBLXn5eqpQ4rwlIkQBIUUZpHtwK
	WLJ4xSgO9LEwrztIFQ8w0cBNegW0hAloidpVY5AlJYkIKakGRr0fd+6eXnL/rNsRnQkpiu9u
	HtEQvrw6Pm3zyizROz+l1mfviVrV8lu4L9g4dNqljCRmteLZ3H9KIvw1FvwPZWV0PcUcsiFo
	+5sXFh/fLnV9bf27rufblMmvGm6/25p39WS3qedPl9lrz/cofQx61TWjJ3xZT7LX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204125>

From: Michael Haggerty <mhagger@alum.mit.edu>

I cannot find a scenario in which this function is called any
significant number of times, so simplify the code by always allocating
an array for return_refs rather than trying to use a stack-allocated
array for small lists.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 0426cf4..9398059 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -527,17 +527,10 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	struct ref *fastarray[32];
 	int match_pos;
 
-	if (*nr_heads && !args.fetch_all) {
-		if (ARRAY_SIZE(fastarray) < *nr_heads)
-			return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
-		else {
-			return_refs = fastarray;
-			memset(return_refs, 0, sizeof(struct ref *) * *nr_heads);
-		}
-	}
+	if (*nr_heads && !args.fetch_all)
+		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
 	else
 		return_refs = NULL;
 
@@ -584,8 +577,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 				newtail = &ref->next;
 			}
 		}
-		if (return_refs != fastarray)
-			free(return_refs);
+		free(return_refs);
 	}
 	*refs = newlist;
 }
-- 
1.7.11.3
