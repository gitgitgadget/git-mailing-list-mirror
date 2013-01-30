From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/8] fetch: use struct ref to represent refs to be fetched
Date: Wed, 30 Jan 2013 10:45:39 -0800
Message-ID: <1359571542-19852-6-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg5-0004fU-El
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691Ab3A3SqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:46:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670Ab3A3Spz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4AFBC40A;
	Wed, 30 Jan 2013 13:45:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=h7Pc
	92+Vnpkv9YBmuvo6Qxf9vjw=; b=oaZpZQ+bO8Qx8YiSk178zKz0rOJnpvjVtwq+
	ltKUq30/dHFfKEl+DZ0twnSf4AEdn2aIcX+I4P+4DELc+knItAWBioIDsr5Q4vNh
	yOCicm1r1uwcG2HcSj6cqST4zhaG2X6e2e02t5AIVFs9Sh816TD3I38KtilEtjni
	2Wdr15M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	r/Yw0S34ULQTCCya/SZGEH0rhTDM+PSi/37m3y737e3VFjZ7K5QKMp2TQtGrveH1
	IQxIKOMYmVy93TycDTvCvIvROokVQG+lI8B5yKtKLTljvW8IHNtOvJmwcFnNAdjj
	q9jFsS78I/n+a3bgIC/NoFxdjHbjX5iWA3In2rJsoM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA688C409;
	Wed, 30 Jan 2013 13:45:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA8C8C407; Wed, 30 Jan 2013
 13:45:53 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4698DBD4-6B0D-11E2-8282-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215053>

Even though "git fetch" has full infrastructure to parse refspecs to
be fetched and match them against the list of refs to come up with
the final list of refs to be fetched, the list of refs that are
requested to be fetched were internally converted to a plain list of
strings at the transport layer and then passed to the underlying
fetch-pack driver.

Stop this conversion and instead pass around an array of refs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch-pack.c | 40 ++++++++++++++++++++------
 cache.h              |  3 +-
 fetch-pack.c         | 79 +++++++++++++++++++++++++++++++---------------------
 fetch-pack.h         | 11 ++++----
 transport.c          |  9 ++----
 5 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 940ae35..cc6bf8f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -7,12 +7,31 @@ static const char fetch_pack_usage[] =
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
 "[--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 
+static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
+				 const char *name, int namelen)
+{
+	struct ref *ref = xcalloc(1, sizeof(*ref) + namelen + 1);
+
+	memcpy(ref->name, name, namelen);
+	ref->name[namelen] = '\0';
+	(*nr)++;
+	ALLOC_GROW(*sought, *nr, *alloc);
+	(*sought)[*nr - 1] = ref;
+}
+
+static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
+			     const char *string)
+{
+	add_sought_entry_mem(sought, nr, alloc, string, strlen(string));
+}
+
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret;
 	struct ref *ref = NULL;
 	const char *dest = NULL;
-	struct string_list sought = STRING_LIST_INIT_DUP;
+	struct ref **sought;
+	int nr_sought = 0, alloc_sought = 0;
 	int fd[2];
 	char *pack_lockfile = NULL;
 	char **pack_lockfile_ptr = NULL;
@@ -94,7 +113,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 * refs from the standard input:
 	 */
 	for (; i < argc; i++)
-		string_list_append(&sought, xstrdup(argv[i]));
+		add_sought_entry(&sought, &nr_sought, &alloc_sought, argv[i]);
 	if (args.stdin_refs) {
 		if (args.stateless_rpc) {
 			/* in stateless RPC mode we use pkt-line to read
@@ -107,14 +126,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 					break;
 				if (line[n-1] == '\n')
 					n--;
-				string_list_append(&sought, xmemdupz(line, n));
+				add_sought_entry_mem(&sought, &nr_sought,  &alloc_sought, line, n);
 			}
 		}
 		else {
 			/* read from stdin one ref per line, until EOF */
 			struct strbuf line = STRBUF_INIT;
 			while (strbuf_getline(&line, stdin, '\n') != EOF)
-				string_list_append(&sought, strbuf_detach(&line, NULL));
+				add_sought_entry(&sought, &nr_sought, &alloc_sought, line.buf);
 			strbuf_release(&line);
 		}
 	}
@@ -131,7 +150,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	get_remote_heads(fd[0], &ref, 0, NULL);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest,
-			 &sought, pack_lockfile_ptr);
+			 sought, nr_sought, pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
@@ -141,7 +160,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (finish_connect(conn))
 		return 1;
 
-	ret = !ref || sought.nr;
+	ret = !ref;
 
 	/*
 	 * If the heads to pull were given, we should have consumed
@@ -149,8 +168,13 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 * remote no-such-ref' would silently succeed without issuing
 	 * an error.
 	 */
-	for (i = 0; i < sought.nr; i++)
-		error("no such remote ref %s", sought.items[i].string);
+	for (i = 0; i < nr_sought; i++) {
+		if (!sought[i] || sought[i]->matched)
+			continue;
+		error("no such remote ref %s", sought[i]->name);
+		ret = 1;
+	}
+
 	while (ref) {
 		printf("%s %s\n",
 		       sha1_to_hex(ref->old_sha1), ref->name);
diff --git a/cache.h b/cache.h
index c257953..03b3285 100644
--- a/cache.h
+++ b/cache.h
@@ -1013,7 +1013,8 @@ struct ref {
 		nonfastforward:1,
 		not_forwardable:1,
 		update:1,
-		deletion:1;
+		deletion:1,
+		matched:1;
 	enum {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
diff --git a/fetch-pack.c b/fetch-pack.c
index f0acdf7..915c0b7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -520,47 +520,37 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	}
 }
 
-static int non_matching_ref(struct string_list_item *item, void *unused)
-{
-	if (item->util) {
-		item->util = NULL;
-		return 0;
-	}
-	else
-		return 1;
-}
-
 static void filter_refs(struct fetch_pack_args *args,
-			struct ref **refs, struct string_list *sought)
+			struct ref **refs,
+			struct ref **sought, int nr_sought)
 {
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	int sought_pos;
+	int i;
 
-	sought_pos = 0;
+	i = 0;
 	for (ref = *refs; ref; ref = next) {
 		int keep = 0;
 		next = ref->next;
+
 		if (!memcmp(ref->name, "refs/", 5) &&
 		    check_refname_format(ref->name + 5, 0))
 			; /* trash */
 		else {
-			while (sought_pos < sought->nr) {
-				int cmp = strcmp(ref->name, sought->items[sought_pos].string);
+			while (i < nr_sought) {
+				int cmp = strcmp(ref->name, sought[i]->name);
 				if (cmp < 0)
 					break; /* definitely do not have it */
 				else if (cmp == 0) {
 					keep = 1; /* definitely have it */
-					sought->items[sought_pos++].util = "matched";
-					break;
+					sought[i]->matched = 1;
 				}
-				else
-					sought_pos++; /* might have it; keep looking */
+				i++;
 			}
 		}
 
-		if (! keep && args->fetch_all &&
+		if (!keep && args->fetch_all &&
 		    (!args->depth || prefixcmp(ref->name, "refs/tags/")))
 			keep = 1;
 
@@ -573,7 +563,6 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 
-	filter_string_list(sought, 0, non_matching_ref, NULL);
 	*refs = newlist;
 }
 
@@ -583,7 +572,8 @@ static void mark_alternate_complete(const struct ref *ref, void *unused)
 }
 
 static int everything_local(struct fetch_pack_args *args,
-			    struct ref **refs, struct string_list *sought)
+			    struct ref **refs,
+			    struct ref **sought, int nr_sought)
 {
 	struct ref *ref;
 	int retval;
@@ -634,7 +624,7 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
-	filter_refs(args, refs, sought);
+	filter_refs(args, refs, sought, nr_sought);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -764,10 +754,17 @@ static int get_pack(struct fetch_pack_args *args,
 	return 0;
 }
 
+static int cmp_ref_by_name(const void *a_, const void *b_)
+{
+	const struct ref *a = *((const struct ref **)a_);
+	const struct ref *b = *((const struct ref **)b_);
+	return strcmp(a->name, b->name);
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
-				 struct string_list *sought,
+				 struct ref **sought, int nr_sought,
 				 char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -776,6 +773,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	int agent_len;
 
 	sort_ref_list(&ref, ref_compare_name);
+	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
 
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
@@ -824,7 +822,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				agent_len, agent_feature);
 	}
 
-	if (everything_local(args, &ref, sought)) {
+	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -887,11 +885,32 @@ static void fetch_pack_setup(void)
 	did_setup = 1;
 }
 
+static int remove_duplicates_in_refs(struct ref **ref, int nr)
+{
+	struct string_list names = STRING_LIST_INIT_NODUP;
+	int src, dst;
+
+	for (src = dst = 0; src < nr; src++) {
+		struct string_list_item *item;
+		item = string_list_insert(&names, ref[src]->name);
+		if (item->util)
+			continue; /* already have it */
+		item->util = ref[src];
+		if (src != dst)
+			ref[dst] = ref[src];
+		dst++;
+	}
+	for (src = dst; src < nr; src++)
+		ref[src] = NULL;
+	string_list_clear(&names, 0);
+	return dst;
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       struct string_list *sought,
+		       struct ref **sought, int nr_sought,
 		       char **pack_lockfile)
 {
 	struct stat st;
@@ -903,16 +922,14 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 			st.st_mtime = 0;
 	}
 
-	if (sought->nr) {
-		sort_string_list(sought);
-		string_list_remove_duplicates(sought, 0);
-	}
+	if (nr_sought)
+		nr_sought = remove_duplicates_in_refs(sought, nr_sought);
 
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy = do_fetch_pack(args, fd, ref, sought, pack_lockfile);
+	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lockfile);
 
 	if (args->depth > 0) {
 		static struct lock_file lock;
diff --git a/fetch-pack.h b/fetch-pack.h
index cb14871..dc5266c 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -20,17 +20,16 @@ struct fetch_pack_args {
 };
 
 /*
- * sought contains the full names of remote references that should be
- * updated from.  On return, the names that were found on the remote
- * will have been removed from the list.  The util members of the
- * string_list_items are used internally; they must be NULL on entry
- * (and will be NULL on exit).
+ * sought represents remote references that should be updated from.
+ * On return, the names that were found on the remote will have been
+ * marked as such.
  */
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       struct string_list *sought,
+		       struct ref **sought,
+		       int nr_sought,
 		       char **pack_lockfile);
 
 #endif
diff --git a/transport.c b/transport.c
index 2673d27..64ce651 100644
--- a/transport.c
+++ b/transport.c
@@ -518,11 +518,9 @@ static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
-	struct string_list sought = STRING_LIST_INIT_DUP;
 	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
-	int i;
 	struct ref *refs_tmp = NULL;
 
 	memset(&args, 0, sizeof(args));
@@ -536,9 +534,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
 
-	for (i = 0; i < nr_heads; i++)
-		string_list_append(&sought, to_fetch[i]->name);
-
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL);
@@ -547,7 +542,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	refs = fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, &sought, &transport->pack_lockfile);
+			  dest, to_fetch, nr_heads,
+			  &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
 	if (finish_connect(data->conn))
@@ -557,7 +553,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 
-	string_list_clear(&sought, 0);
 	free(dest);
 	return (refs ? 0 : -1);
 }
-- 
1.8.1.2.589.ga9b91ac
