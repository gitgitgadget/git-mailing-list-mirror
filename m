From: mhagger@alum.mit.edu
Subject: [PATCH v2 17/17] filter_refs(): simplify logic
Date: Sat, 25 Aug 2012 08:44:27 +0200
Message-ID: <1345877067-11841-18-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A83-00031W-2Q
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab2HYGpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:49 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:55090 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753210Ab2HYGph (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:37 -0400
X-AuditID: 1207440d-b7f236d000000943-c2-5038748ffe44
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.13.02371.F8478305; Sat, 25 Aug 2012 02:45:35 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSs011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:34 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqNtfYhFgcOOSikXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M07vvsRWsEi84tiKu0wNjHsFuxg5OCQETCRu/jXtYuQEMsUkLtxbzwZiCwlcZpQ49ECo
	i5ELyD7LJNF49gMrSIJNQEriZWMPO4gtIqAmMbHtEAtIEbNAF6PE8nW/wLqFBcwlTnQvYwax
	WQRUJdZdXsgKsoxXwFXi5wpuiGWKEj++rwEr4QQKT/h1kR1isYtE07ErLBMYeRcwMqxilEvM
	Kc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAkn3h2M/9fJHGIU4GBU4uG9ccY8QIg1
	say4MvcQoyQHk5Ior1ihRYAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd7vDEA53pTEyqrUonyY
	lDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE755ioEbBotT01Iq0zJwShDQTByfIcC4p
	keLUvJTUosTSkox4UFzEFwMjAyTFA7R3Pkg7b3FBYi5QFKL1FKMux/+TJ+8yCrHk5eelSonz
	ngIpEgApyijNg1sBSx6vGMWBPhbmnVkEVMUDTDxwk14BLWECWlLuag6ypCQRISXVwNg0X0Xt
	yXyJG3Jmp65k/vIoXHv3wjqWX4eF0yf+X6l373JQ6H+NZeJ2LB7BG/rs1efeVEs/nmTjZrEo
	y4B7S5+5we0GGfZZk7/NiTmgkqU5aV5L4bTtKtJvF/wvFM7NPsb+q5Fh3Yv3efsE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204260>

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
index 1bc4599..db77ee6 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -523,66 +523,48 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 
 static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 {
-	struct ref **return_refs;
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	int head_pos = 0, matched = 0, unmatched = 0;
-
-	if (*nr_heads && !args.fetch_all)
-		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
-	else
-		return_refs = NULL;
+	int head_pos = 0, unmatched = 0;
 
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
 			while (head_pos < *nr_heads) {
-				cmp = strcmp(ref->name, heads[head_pos]);
-				if (cmp < 0) /* definitely do not have it */
+				int cmp = strcmp(ref->name, heads[head_pos]);
+				if (cmp < 0) { /* definitely do not have it */
 					break;
-				else if (cmp == 0) { /* definitely have it */
-					return_refs[matched++] = ref;
+				} else if (cmp == 0) { /* definitely have it */
 					free(heads[head_pos++]);
+					keep_ref = 1;
 					break;
-				}
-				else { /* might have it; keep looking */
+				} else { /* might have it; keep looking */
 					heads[unmatched++] = heads[head_pos++];
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
-		while (head_pos < *nr_heads)
-			heads[unmatched++] = heads[head_pos++];
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
+	while (head_pos < *nr_heads)
+		heads[unmatched++] = heads[head_pos++];
+	*nr_heads = unmatched;
+
 	*refs = newlist;
 }
 
-- 
1.7.11.3
