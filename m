From: mhagger@alum.mit.edu
Subject: [PATCH 16/17] fetch_pack(): free matching heads
Date: Thu, 23 Aug 2012 10:10:41 +0200
Message-ID: <1345709442-16046-17-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sdn-0001fQ-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732Ab2HWITh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:37 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:57764 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030232Ab2HWITQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:19:16 -0400
X-AuditID: 12074412-b7f216d0000008e3-51-5035e5bdc929
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D0.C8.02275.DB5E5305; Thu, 23 Aug 2012 04:11:41 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVG030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:40 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLv3qWmAwZ0vuhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujO0TDAvO
	yVQcurGWrYHxhlgXIyeHhICJxIM9U1kgbDGJC/fWs3UxcnEICVxmlDi7fhsLhHOWSeLvsgOM
	IFVsAlISLxt72EFsEQE1iYlth8C6mQVSJDqed4PVCAtYSLRs/s0KYrMIqEq0HbnFDGLzCrhK
	HDnbwwSxTVHix/c1YHFOoPiC75vAeoUEXCQ+Nt5knsDIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrplebmaJXmpK6SZGSPgI7WBcf1LuEKMAB6MSD+8Lc9MAIdbEsuLK3EOMkhxMSqK8
	/x4BhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwhs8DyvGmJFZWpRblw6SkOViUxHl/Llb3ExJI
	TyxJzU5NLUgtgsnKcHAoSfBKAuNESLAoNT21Ii0zpwQhzcTBCSK4QDbwAG1QBCnkLS5IzC3O
	TIcoOsWoKCXOawKSEABJZJTmwQ2ARforRnGgf4R53UGqeIBJAq77FdBgJqDBaleNQQaXJCKk
	pBoYAx+ty1jq/SHjfPwJy/kPw28luVT0ZLDUCUzyb73E+j6+tz7iVcn0LeYGv8zml2fn7Pn4
	V4Gtlt3y6s96RXHhMMn+Su5XvNPr+HV/+bNxlbBIJVyeaHqp8Oa89oIFRVmv/NKKPc37wvz2
	v6z8ODv40mrJxQmie9QcWhID1IOytnza/GfpW2slluKMREMt5qLiRABJf5BBzwIA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204131>

From: Michael Haggerty <mhagger@alum.mit.edu>

fetch_pack() used to delete entries from the input list (*nr_heads,
heads) and drop them on the floor.  (Even earlier versions dropped
some names on the floor and modified others.)  This forced
fetch_refs_via_pack() to create a separate copy of the original list
so that it could free the all of the names.

Instead, teach fetch_pack() to free any names that it discards from
the list, and change fetch_refs_via_pack() to free only the remaining
(unmatched) names.

Document the change in the function comment in the header file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This change forces callers to allocate names on the heap.  But the two
existing callers did so already, and the function already modified the
list, so I think the new style is no more intrusive than the old.

 builtin/fetch-pack.c | 4 +++-
 fetch-pack.h         | 7 ++++---
 transport.c          | 9 +++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 6c1a48e..9650d04 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -554,7 +554,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 					break;
 				else if (cmp == 0) { /* definitely have it */
 					return_refs[matched++] = ref;
-					match_pos++;
+					free(heads[match_pos++]);
 					break;
 				}
 				else { /* might have it; keep looking */
@@ -844,6 +844,8 @@ static int remove_duplicates(int nr_heads, char **heads)
 	for (src = dst = 1; src < nr_heads; src++)
 		if (strcmp(heads[src], heads[dst-1]))
 			heads[dst++] = heads[src];
+		else
+			free(heads[src]);
 	return dst;
 }
 
diff --git a/fetch-pack.h b/fetch-pack.h
index 915858e..d1860eb 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -19,9 +19,10 @@ struct fetch_pack_args {
 
 /*
  * (*nr_heads, heads) is an array of pointers to the full names of
- * remote references that should be updated from.  On return, both
- * will have been changed to list only the names that were not found
- * on the remote.
+ * remote references that should be updated from.  The names must have
+ * been allocated from the heap.  The names that are found in the
+ * remote will be removed from the list and freed; the others will be
+ * left in the front of the array with *nr_heads adjusted accordingly.
  */
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
diff --git a/transport.c b/transport.c
index 3c38d44..f94b753 100644
--- a/transport.c
+++ b/transport.c
@@ -519,8 +519,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 {
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
-	char **origh = xmalloc(nr_heads * sizeof(*origh));
-	int orig_nr_heads = nr_heads;
 	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
@@ -539,7 +537,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.depth = data->options.depth;
 
 	for (i = 0; i < nr_heads; i++)
-		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
+		heads[i] = xstrdup(to_fetch[i]->name);
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
@@ -559,9 +557,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 
-	for (i = 0; i < orig_nr_heads; i++)
-		free(origh[i]);
-	free(origh);
+	for (i = 0; i < nr_heads; i++)
+		free(heads[i]);
 	free(heads);
 	free(dest);
 	return (refs ? 0 : -1);
-- 
1.7.11.3
