From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/14] Change fetch_pack() and friends to take string_list arguments
Date: Sun,  9 Sep 2012 08:19:40 +0200
Message-ID: <1347171589-13327-6-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatf-0002rp-Ch
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab2IIGVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:17 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:60998 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752113Ab2IIGUg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:36 -0400
X-AuditID: 1207440d-b7f236d000000943-e0-504c3533ca32
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.F1.02371.3353C405; Sun,  9 Sep 2012 02:20:35 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIli029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:34 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqGts6hNgsPqZhkXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M87sjSlYFVKx6XlVA+MZxy5GTg4JAROJK1NPskPYYhIX7q1n62Lk4hASuMwoMf/gc1YI
	5wyTxJ3GM0wgVWwCuhKLeprBbBEBNYmJbYdYQIqYBboYJZav+8UGkhAWCJe4sHo/UDcHB4uA
	qsSvl1kgYV4BF4ndz5axQWxTlPjxfQ0ziM0p4CrxauZuRhBbCKhm085rrBMYeRcwMqxilEvM
	Kc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAkn3h2M/9fJHGIU4GBU4uFlvuMdIMSa
	WFZcmXuIUZKDSUmUV8PEJ0CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO9VdqAcb0piZVVqUT5M
	SpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC1xhkqGBRanpqRVpmTglCmomDE0RwgWzg
	AdoQDFLIW1yQmFucmQ5RdIpRUUqctwwkIQCSyCjNgxsAi/xXjOJA/wjz1oJU8QCTBlz3K6DB
	TECDRZ55gAwuSURISTUwxt5nMNzH7HhHRaVHbX9a6ZRdc9wX1+9rsp/EMp/3xoRffUUn3nLn
	GKtOmn3gWbBCmX8Ky82wk5snfIltfmbkxZgu71JlVRRz8S/Py4sH/v/j/3rY+6yok/fus6UX
	z7wMuh5Qynr2eln7jQ593a6/v7LEm6SyXdL8kh6vUFY7sc/b/uC9n1O2K7EUZyQa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205054>

Instead of juggling <nr_heads,heads> (sometimes called
<nr_match,match>), pass around the list of references to be sought in
a single string_list variable called "sought".  Future commits will
make more use of string_list functionality.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 88 +++++++++++++++++++++++-----------------------------
 fetch-pack.h         |  5 +--
 transport.c          | 18 +++++------
 3 files changed, 51 insertions(+), 60 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 30990c0..df81995 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -525,27 +525,27 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 	}
 }
 
-static void filter_refs(struct ref **refs, int nr_match, char **match)
+static void filter_refs(struct ref **refs, struct string_list *sought)
 {
 	struct ref **return_refs;
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
 	struct ref *fastarray[32];
-	int match_pos;
+	int sought_pos;
 
-	if (nr_match && !args.fetch_all) {
-		if (ARRAY_SIZE(fastarray) < nr_match)
-			return_refs = xcalloc(nr_match, sizeof(struct ref *));
+	if (sought->nr && !args.fetch_all) {
+		if (ARRAY_SIZE(fastarray) < sought->nr)
+			return_refs = xcalloc(sought->nr, sizeof(struct ref *));
 		else {
 			return_refs = fastarray;
-			memset(return_refs, 0, sizeof(struct ref *) * nr_match);
+			memset(return_refs, 0, sizeof(struct ref *) * sought->nr);
 		}
 	}
 	else
 		return_refs = NULL;
 
-	match_pos = 0;
+	sought_pos = 0;
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
@@ -560,17 +560,17 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 		}
 		else {
 			int cmp = -1;
-			while (match_pos < nr_match) {
-				cmp = strcmp(ref->name, match[match_pos]);
+			while (sought_pos < sought->nr) {
+				cmp = strcmp(ref->name, sought->items[sought_pos].string);
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					match[match_pos][0] = '\0';
-					return_refs[match_pos] = ref;
+					sought->items[sought_pos].string[0] = '\0';
+					return_refs[sought_pos] = ref;
 					break;
 				}
 				else /* might have it; keep looking */
-					match_pos++;
+					sought_pos++;
 			}
 			if (!cmp)
 				continue; /* we will link it later */
@@ -580,7 +580,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 
 	if (!args.fetch_all) {
 		int i;
-		for (i = 0; i < nr_match; i++) {
+		for (i = 0; i < sought->nr; i++) {
 			ref = return_refs[i];
 			if (ref) {
 				*newtail = ref;
@@ -599,7 +599,7 @@ static void mark_alternate_complete(const struct ref *ref, void *unused)
 	mark_complete(NULL, ref->old_sha1, 0, NULL);
 }
 
-static int everything_local(struct ref **refs, int nr_match, char **match)
+static int everything_local(struct ref **refs, struct string_list *sought)
 {
 	struct ref *ref;
 	int retval;
@@ -650,7 +650,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 		}
 	}
 
-	filter_refs(refs, nr_match, match);
+	filter_refs(refs, sought);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -781,8 +781,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 
 static struct ref *do_fetch_pack(int fd[2],
 		const struct ref *orig_ref,
-		int nr_match,
-		char **match,
+		struct string_list *sought,
 		char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -839,7 +838,7 @@ static struct ref *do_fetch_pack(int fd[2],
 				agent_len, agent_feature);
 	}
 
-	if (everything_local(&ref, nr_match, match)) {
+	if (everything_local(&ref, sought)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -859,16 +858,16 @@ static struct ref *do_fetch_pack(int fd[2],
 	return ref;
 }
 
-static int remove_duplicates(int nr_heads, char **heads)
+static int remove_duplicates(struct string_list *sought)
 {
 	int src, dst;
 
-	if (!nr_heads)
+	if (!sought->nr)
 		return 0;
 
-	for (src = dst = 1; src < nr_heads; src++)
-		if (strcmp(heads[src], heads[dst-1]))
-			heads[dst++] = heads[src];
+	for (src = dst = 1; src < sought->nr; src++)
+		if (strcmp(sought->items[src].string, sought->items[dst-1].string))
+			sought->items[dst++] = sought->items[src];
 	return dst;
 }
 
@@ -922,8 +921,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	int i, ret;
 	struct ref *ref = NULL;
 	const char *dest = NULL;
-	int alloc_heads = 0, nr_heads = 0;
-	char **heads = NULL;
+	struct string_list sought = STRING_LIST_INIT_DUP;
 	int fd[2];
 	char *pack_lockfile = NULL;
 	char **pack_lockfile_ptr = NULL;
@@ -1000,9 +998,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 * Copy refs from cmdline to growable list, then append any
 	 * refs from the standard input:
 	 */
-	ALLOC_GROW(heads, argc - i, alloc_heads);
 	for (; i < argc; i++)
-		heads[nr_heads++] = xstrdup(argv[i]);
+		string_list_append(&sought, xstrdup(argv[i]));
 	if (args.stdin_refs) {
 		if (args.stateless_rpc) {
 			/* in stateless RPC mode we use pkt-line to read
@@ -1015,17 +1012,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 					break;
 				if (line[n-1] == '\n')
 					n--;
-				ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
-				heads[nr_heads++] = xmemdupz(line, n);
+				string_list_append(&sought, xmemdupz(line, n));
 			}
 		}
 		else {
 			/* read from stdin one ref per line, until EOF */
 			struct strbuf line = STRBUF_INIT;
-			while (strbuf_getline(&line, stdin, '\n') != EOF) {
-				ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
-				heads[nr_heads++] = strbuf_detach(&line, NULL);
-			}
+			while (strbuf_getline(&line, stdin, '\n') != EOF)
+				string_list_append(&sought, strbuf_detach(&line, NULL));
 			strbuf_release(&line);
 		}
 	}
@@ -1042,7 +1036,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	get_remote_heads(fd[0], &ref, 0, NULL);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest,
-		nr_heads, heads, pack_lockfile_ptr);
+			 &sought, pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
@@ -1053,17 +1047,19 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		ref = NULL;
 	ret = !ref;
 
-	if (!ret && nr_heads) {
+	if (!ret && sought.nr) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git fetch remote no-such-ref' would
 		 * silently succeed without issuing an error.
 		 */
-		for (i = 0; i < nr_heads; i++)
-			if (heads[i] && heads[i][0]) {
-				error("no such remote ref %s", heads[i]);
+		for (i = 0; i < sought.nr; i++) {
+			char *s = sought.items[i].string;
+			if (s && s[0]) {
+				error("no such remote ref %s", s);
 				ret = 1;
 			}
+		}
 	}
 	while (ref) {
 		printf("%s %s\n",
@@ -1074,17 +1070,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int compare_heads(const void *a, const void *b)
-{
-	return strcmp(*(const char **)a, *(const char **)b);
-}
-
 struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       int nr_heads,
-		       char **heads,
+		       struct string_list *sought,
 		       char **pack_lockfile)
 {
 	struct stat st;
@@ -1098,16 +1088,16 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
-	if (heads && nr_heads) {
-		qsort(heads, nr_heads, sizeof(*heads), compare_heads);
-		nr_heads = remove_duplicates(nr_heads, heads);
+	if (sought->nr) {
+		sort_string_list(sought);
+		remove_duplicates(sought);
 	}
 
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy = do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
+	ref_cpy = do_fetch_pack(fd, ref, sought, pack_lockfile);
 
 	if (args.depth > 0) {
 		struct cache_time mtime;
diff --git a/fetch-pack.h b/fetch-pack.h
index 1dbe90f..a6a8a73 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -1,6 +1,8 @@
 #ifndef FETCH_PACK_H
 #define FETCH_PACK_H
 
+#include "string-list.h"
+
 struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
@@ -21,8 +23,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       int nr_heads,
-		       char **heads,
+		       struct string_list *sought,
 		       char **pack_lockfile);
 
 #endif
diff --git a/transport.c b/transport.c
index 1811b50..a847bf3 100644
--- a/transport.c
+++ b/transport.c
@@ -518,8 +518,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
-	char **heads = xmalloc(nr_heads * sizeof(*heads));
-	char **origh = xmalloc(nr_heads * sizeof(*origh));
+	struct string_list orig_sought = STRING_LIST_INIT_DUP;
+	struct string_list sought = STRING_LIST_INIT_NODUP;
 	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
@@ -537,8 +537,10 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
 
-	for (i = 0; i < nr_heads; i++)
-		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
+	for (i = 0; i < nr_heads; i++) {
+		string_list_append(&orig_sought, to_fetch[i]->name);
+		string_list_append(&sought, orig_sought.items[orig_sought.nr - 1].string);
+	}
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
@@ -548,7 +550,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	refs = fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, nr_heads, heads, &transport->pack_lockfile);
+			  dest, &sought, &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
 	if (finish_connect(data->conn))
@@ -558,10 +560,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 
-	for (i = 0; i < nr_heads; i++)
-		free(origh[i]);
-	free(origh);
-	free(heads);
+	string_list_clear(&sought, 0);
+	string_list_clear(&orig_sought, 0);
 	free(dest);
 	return (refs ? 0 : -1);
 }
-- 
1.7.11.3
