From: mhagger@alum.mit.edu
Subject: [PATCH v2 12/17] filter_refs(): compress unmatched refs in heads array
Date: Sat, 25 Aug 2012 08:44:22 +0200
Message-ID: <1345877067-11841-13-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7p-0002ps-AF
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab2HYGpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:30 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:47415 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752850Ab2HYGpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:25 -0400
X-AuditID: 12074411-b7fa36d0000008cc-6b-503874849240
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 63.29.02252.48478305; Sat, 25 Aug 2012 02:45:24 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSn011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:23 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqNtSYhFgcHezgUXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M7bOX8JWcFO2Ysnz2SwNjC3iXYycHBICJhLz119ng7DFJC7cWw9kc3EICVxmlLh39j4r
	hHOWSWLFnLNgVWwCUhIvG3vYQWwRATWJiW2HWECKmAW6GCWWr/sFViQs4C/xZuF2oAQHB4uA
	qsSmn44gYV4BV4kJV8+yQGxTlPjxfQ0ziM0JEv91EWymkICLRNOxKywTGHkXMDKsYpRLzCnN
	1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJKcEdjDNOyh1iFOBgVOLhvXHGPECINbGs
	uDL3EKMkB5OSKK9YoUWAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe7wxAOd6UxMqq1KJ8mJQ0
	B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBO/3YqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi
	1LyU1KLE0pKMeFBsxBcDowMkxQO09y5IO29xQWIuUBSi9RSjLsf/kyfvMgqx5OXnpUqJ854C
	KRIAKcoozYNbAUsgrxjFgT4W5p1ZBFTFA0w+cJNeAS1hAlpS7moOsqQkESEl1cDI0RYU5nMk
	+8j3NTufKyqtjjc3aX6lKOKdVB+X8vHORNn4MznTIxOfv5nKtnHZoQrH+rKupOsd53tnfTlW
	wClYJ9dh8kdx1R7Fqas2TX62hkX3w72Wsh4+kTVfPE3n2f4IbK4647nin/S56EnC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204256>

From: Michael Haggerty <mhagger@alum.mit.edu>

Remove any references that were received from the remote from the list
(*nr_heads, heads) of requested references by squeezing them out of
the list (rather than overwriting their names with NUL characters, as
before).  On exit, *nr_heads is the number of requested references
that were not received.

Document this aspect of fetch_pack() in a comment in the header file.
(More documentation is obviously still needed.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 21 +++++++++++++--------
 fetch-pack.h         |  6 ++++++
 transport.c          |  3 ++-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index a995357..5ba1cef 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -527,7 +527,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	int head_pos = 0, matched = 0;
+	int head_pos = 0, matched = 0, unmatched = 0;
 
 	if (*nr_heads && !args.fetch_all)
 		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
@@ -554,11 +554,12 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 					break;
 				else if (cmp == 0) { /* definitely have it */
 					return_refs[matched++] = ref;
-					heads[head_pos++][0] = '\0';
+					head_pos++;
 					break;
 				}
-				else /* might have it; keep looking */
-					head_pos++;
+				else { /* might have it; keep looking */
+					heads[unmatched++] = heads[head_pos++];
+				}
 			}
 			if (!cmp)
 				continue; /* we will link it later */
@@ -568,6 +569,12 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 
 	if (!args.fetch_all) {
 		int i;
+
+		/* copy remaining unmatched heads: */
+		while (head_pos < *nr_heads)
+			heads[unmatched++] = heads[head_pos++];
+		*nr_heads = unmatched;
+
 		for (i = 0; i < matched; i++) {
 			ref = return_refs[i];
 			*newtail = ref;
@@ -1028,10 +1035,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		 * silently succeed without issuing an error.
 		 */
 		for (i = 0; i < nr_heads; i++)
-			if (heads[i] && heads[i][0]) {
-				error("no such remote ref %s", heads[i]);
-				ret = 1;
-			}
+			error("no such remote ref %s", heads[i]);
+		ret = 1;
 	}
 	while (ref) {
 		printf("%s %s\n",
diff --git a/fetch-pack.h b/fetch-pack.h
index a9d505b..915858e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -17,6 +17,12 @@ struct fetch_pack_args {
 		stateless_rpc:1;
 };
 
+/*
+ * (*nr_heads, heads) is an array of pointers to the full names of
+ * remote references that should be updated from.  On return, both
+ * will have been changed to list only the names that were not found
+ * on the remote.
+ */
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
diff --git a/transport.c b/transport.c
index f7bbf58..3c38d44 100644
--- a/transport.c
+++ b/transport.c
@@ -520,6 +520,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
 	char **origh = xmalloc(nr_heads * sizeof(*origh));
+	int orig_nr_heads = nr_heads;
 	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
@@ -558,7 +559,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 
-	for (i = 0; i < nr_heads; i++)
+	for (i = 0; i < orig_nr_heads; i++)
 		free(origh[i]);
 	free(origh);
 	free(heads);
-- 
1.7.11.3
