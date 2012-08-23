From: mhagger@alum.mit.edu
Subject: [PATCH 17/17] fetch_refs(): simplify logic
Date: Thu, 23 Aug 2012 10:10:42 +0200
Message-ID: <1345709442-16046-18-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sdc-0001PZ-V3
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933664Ab2HWIT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:28 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:52683 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933655Ab2HWIS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:59 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:18:44 EDT
X-AuditID: 1207440f-b7fde6d00000095c-2a-5035e5bf65ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DA.11.02396.FB5E5305; Thu, 23 Aug 2012 04:11:43 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVH030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:42 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLv/qWmAwZKLvBZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujD33NrEW
	rBWv6PxzmqmB8YRgFyMnh4SAiUTr8ZlsELaYxIV764FsLg4hgcuMEk0THjGCJIQEzjJJbPxR
	AmKzCUhJvGzsYQexRQTUJCa2HWIBsZkFUiQ6nncD1XNwCAsYS2z8XgMSZhFQldj8ogusnFfA
	VWL5ZZhdihI/vq9hBrE5geILvm+CWuUi8bHxJvMERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT
	8/JSi3RN9HIzS/RSU0o3MUKCh38HY9d6mUOMAhyMSjy8L8xNA4RYE8uKK3MPMUpyMCmJ8v57
	BBTiS8pPqcxILM6ILyrNSS0+xCjBwawkwhs+DyjHm5JYWZValA+TkuZgURLnVV+i7ickkJ5Y
	kpqdmlqQWgSTleHgUJLgvfMEqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFBfx
	xcDIAEnxAO19CtLOW1yQmAsUhWg9xajL8f/kybuMQix5+XmpUuK8J0GKBECKMkrz4FbAUsUr
	RnGgj4V5z4FU8QDTDNykV0BLmICWqF01BllSkoiQkmpg7Lw9Y5Ea/5Qd19cGvcpSN41n/tyq
	aXdGc0tVaYTOOsasy0c0xPT8m4R0u1Rq79VZHeWe/NuO70/cqzKek7WfHGb+zDz335Fvg3pv
	z9IF5Rxly6pZVglzWh6aeyu2gCEg+Ng/nTAflbj9kgY/vBi6Xi9W2Ozft/YEi7DG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204129>

From: Michael Haggerty <mhagger@alum.mit.edu>

* Build linked list of return values as we go rather than recording
  them in a temporary array and linking them up later.

* Handle ref in a single if...else statement in the main loop, to make
  it clear that each ref has exactly two possible destinies.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 56 ++++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9650d04..90683ca 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -523,66 +523,48 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 
 static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 {
-	struct ref **return_refs;
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	int match_pos = 0, matched = 0, unmatched = 0;
-
-	if (*nr_heads && !args.fetch_all)
-		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
-	else
-		return_refs = NULL;
+	int match_pos = 0, unmatched = 0;
 
 	for (ref = *refs; ref; ref = next) {
+		int keep_ref = 0;
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
 		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else if (args.fetch_all &&
-			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
-			*newtail = ref;
-			ref->next = NULL;
-			newtail = &ref->next;
-			continue;
-		}
-		else {
-			int cmp = -1;
+			   (!args.depth || prefixcmp(ref->name, "refs/tags/")))
+			keep_ref = 1;
+		else
 			while (match_pos < *nr_heads) {
-				cmp = strcmp(ref->name, heads[match_pos]);
-				if (cmp < 0) /* definitely do not have it */
+				int cmp = strcmp(ref->name, heads[match_pos]);
+				if (cmp < 0) { /* definitely do not have it */
 					break;
-				else if (cmp == 0) { /* definitely have it */
-					return_refs[matched++] = ref;
+				} else if (cmp == 0) { /* definitely have it */
 					free(heads[match_pos++]);
+					keep_ref = 1;
 					break;
-				}
-				else { /* might have it; keep looking */
+				} else { /* might have it; keep looking */
 					heads[unmatched++] = heads[match_pos++];
 				}
 			}
-			if (!cmp)
-				continue; /* we will link it later */
-		}
-		free(ref);
-	}
-
-	if (!args.fetch_all) {
-		int i;
 
-		/* copy remaining unmatched heads: */
-		while (match_pos < *nr_heads)
-			heads[unmatched++] = heads[match_pos++];
-		*nr_heads = unmatched;
-
-		for (i = 0; i < matched; i++) {
-			ref = return_refs[i];
+		if (keep_ref) {
 			*newtail = ref;
 			ref->next = NULL;
 			newtail = &ref->next;
+		} else {
+			free(ref);
 		}
-		free(return_refs);
 	}
+
+	/* copy any remaining unmatched heads: */
+	while (match_pos < *nr_heads)
+		heads[unmatched++] = heads[match_pos++];
+	*nr_heads = unmatched;
+
 	*refs = newlist;
 }
 
-- 
1.7.11.3
