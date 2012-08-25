From: mhagger@alum.mit.edu
Subject: [PATCH v2 16/17] fetch_pack(): free matching heads
Date: Sat, 25 Aug 2012 08:44:26 +0200
Message-ID: <1345877067-11841-17-git-send-email-mhagger@alum.mit.edu>
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
	id 1T5A82-00031W-JQ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab2HYGpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:44 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55644 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753068Ab2HYGpd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:33 -0400
X-AuditID: 12074414-b7f846d0000008b8-f2-5038748dab58
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BD.16.02232.D8478305; Sat, 25 Aug 2012 02:45:33 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSr011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:31 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqNtbYhFg8G6bqEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M5a+PM9S8FGq4ndvD2MD4yrRLkYODgkBE4kLh9m7GDmBTDGJC/fWs3UxcnEICVxmlFi/
	8B8LhHOWSeJq1y4mkCo2ASmJl409YB0iAmoSE9sOgRUxC3QxSixf94sNJCEsYC3xpHcVC8gG
	FgFVif5PQSBhXgFXiXW31rFBbFOU+PF9DTOIzQkUn/DrIthMIQEXiaZjV1gmMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESUCI7GI+clDvEKMDBqMTDe+OMeYAQ
	a2JZcWXuIUZJDiYlUV6xQosAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK83xmAcrwpiZVVqUX5
	MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKEry1xUCNgkWp6akVaZk5JQhpJg5OEMEF
	soEHaEMySCFvcUFibnFmOkTRKUZFKXFeA5CEAEgiozQPbgAs9l8xigP9I8w7swioigeYNuC6
	XwENZgIaXO5qDjK4JBEhJdXAuG6h6bnCZbs3SC3WznRjyJdpOt6/fUqmdvH1B/XSkcUc4kwv
	cy+oBqR3/vgXIub8xlt73afqB8tK+Fr1d/3PyvixTzI3S0Wgxa29787nFRoS9RLa+Rtmz3oT
	5p9wwbWW3bhplezVf2H2b2+cr5sm+db+4D2uUP1vN1jbWY/bbzB3SmWe/NVJiaU4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204259>

From: Michael Haggerty <mhagger@alum.mit.edu>

fetch_pack() used to delete entries from the input list (*nr_heads,
heads) and drop them on the floor.  (Even earlier versions dropped
some names on the floor and modified others.)  This forced
fetch_refs_via_pack() to create a separate copy of the original list
so that it could free all of the names.

Instead, teach fetch_pack() to free any names that it discards from
the list, and change fetch_refs_via_pack() to free only the remaining
(unmatched) names.

Document the change in the function comment in the header file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 4 +++-
 fetch-pack.h         | 7 ++++---
 transport.c          | 9 +++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c49dadf..1bc4599 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -554,7 +554,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 					break;
 				else if (cmp == 0) { /* definitely have it */
 					return_refs[matched++] = ref;
-					head_pos++;
+					free(heads[head_pos++]);
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
