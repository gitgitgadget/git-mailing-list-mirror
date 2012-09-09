From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/14] filter_refs(): delete matched refs from sought list
Date: Sun,  9 Sep 2012 08:19:43 +0200
Message-ID: <1347171589-13327-9-git-send-email-mhagger@alum.mit.edu>
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
	id 1TAau5-0003F9-Vv
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2IIGVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:21 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:61151 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752485Ab2IIGUn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:43 -0400
X-AuditID: 12074412-b7f216d0000008e3-d3-504c353a34a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E0.9B.02275.A353C405; Sun,  9 Sep 2012 02:20:42 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIll029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:41 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqGtl6hNgMPeeuEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M+Y2H2MteKVYcfbuU9YGxg9SXYycHBICJhL/P/5ngrDFJC7cW8/WxcjFISRwmVFi59cd
	jBDOGSaJw18nsIFUsQnoSizqaQbrEBFQk5jYdogFpIhZoItRYvm6X2BFwgK+EvM67jJ3MXJw
	sAioSmy6bAcS5hVwkXhw9is7xDZFiR/f1zCD2JwCrhKvZu5mBLGFgGo27bzGOoGRdwEjwypG
	ucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkJAS2sG4/qTcIUYBDkYlHl6WO94B
	QqyJZcWVuYcYJTmYlER5NUx8AoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8F5lB8rxpiRWVqUW
	5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwGoMMFSxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAfFRnwxMDpAUjxAe4NB2nmLCxJzgaIQracYdTlm31xxn1GIJS8/L1VK
	nLcMpEgApCijNA9uBSyBvGIUB/pYmNcZpIoHmHzgJr0CWsIEtETkmQfIkpJEhJRUA2P4xUSu
	a63PtHmubUncM32vTbOB+p1tdrIJRrKRFzw/J3mssW/dLZTUd/nEwybNooJOO02jr+vWalcc
	qGNKiv4dtP8SA0PX/r37anmexUmtYfD+OWdNWeKjhvlnAq96aBX+s+54lR2kJ/BF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205062>

Remove any references that are available from the remote from the
sought list (rather than overwriting their names with NUL characters,
as previously).  Mark matching entries by writing a non-NULL pointer
to string_list_item::util during the iteration, then use
filter_string_list() later to filter out the entries that have been
marked.

Document this aspect of fetch_pack() in a comment in the header file.
(More documentation is obviously still needed.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 23 +++++++++++++++--------
 fetch-pack.h         |  7 +++++++
 transport.c          | 10 +++-------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 6cd734a..12ba009 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -525,6 +525,16 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 	}
 }
 
+static int non_matching_ref(struct string_list_item *item, void *unused)
+{
+	if (item->util) {
+		item->util = NULL;
+		return 0;
+	}
+	else
+		return 1;
+}
+
 static void filter_refs(struct ref **refs, struct string_list *sought)
 {
 	struct ref **return_refs;
@@ -566,7 +576,7 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 					break;
 				else if (cmp == 0) { /* definitely have it */
 					return_refs[sought_pos] = ref;
-					sought->items[sought_pos++].string[0] = '\0';
+					sought->items[sought_pos++].util = "matched";
 					break;
 				}
 				else /* might have it; keep looking */
@@ -590,6 +600,7 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 		}
 		if (return_refs != fastarray)
 			free(return_refs);
+		filter_string_list(sought, 0, non_matching_ref, NULL);
 	}
 	*refs = newlist;
 }
@@ -1040,13 +1051,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		 * Otherwise, 'git fetch remote no-such-ref' would
 		 * silently succeed without issuing an error.
 		 */
-		for (i = 0; i < sought.nr; i++) {
-			char *s = sought.items[i].string;
-			if (s && s[0]) {
-				error("no such remote ref %s", s);
-				ret = 1;
-			}
-		}
+		for (i = 0; i < sought.nr; i++)
+			error("no such remote ref %s", sought.items[i].string);
+		ret = 1;
 	}
 	while (ref) {
 		printf("%s %s\n",
diff --git a/fetch-pack.h b/fetch-pack.h
index a6a8a73..cb14871 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -19,6 +19,13 @@ struct fetch_pack_args {
 		stateless_rpc:1;
 };
 
+/*
+ * sought contains the full names of remote references that should be
+ * updated from.  On return, the names that were found on the remote
+ * will have been removed from the list.  The util members of the
+ * string_list_items are used internally; they must be NULL on entry
+ * (and will be NULL on exit).
+ */
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
diff --git a/transport.c b/transport.c
index a847bf3..9932f40 100644
--- a/transport.c
+++ b/transport.c
@@ -518,8 +518,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
-	struct string_list orig_sought = STRING_LIST_INIT_DUP;
-	struct string_list sought = STRING_LIST_INIT_NODUP;
+	struct string_list sought = STRING_LIST_INIT_DUP;
 	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
@@ -537,10 +536,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
 
-	for (i = 0; i < nr_heads; i++) {
-		string_list_append(&orig_sought, to_fetch[i]->name);
-		string_list_append(&sought, orig_sought.items[orig_sought.nr - 1].string);
-	}
+	for (i = 0; i < nr_heads; i++)
+		string_list_append(&sought, to_fetch[i]->name);
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
@@ -561,7 +558,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 	free_refs(refs_tmp);
 
 	string_list_clear(&sought, 0);
-	string_list_clear(&orig_sought, 0);
 	free(dest);
 	return (refs ? 0 : -1);
 }
-- 
1.7.11.3
