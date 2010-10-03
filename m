From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH 3/6] Allow the transport fetch command to add additional refs
Date: Sun,  3 Oct 2010 14:21:48 +0200
Message-ID: <1286108511-55876-3-git-send-email-tom@dbservice.com>
References: <4CA86A12.6080905@dbservice.com>
Cc: Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 14:22:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2NaD-0005Mv-Pk
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 14:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab0JCMWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 08:22:14 -0400
Received: from gw.ptr-62-65-141-13.customer.ch.netstream.com ([62.65.141.13]:60849
	"EHLO calvin.caurea.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752042Ab0JCMWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 08:22:11 -0400
Received: by calvin.caurea.org (Postfix, from userid 501)
	id E76F0245A750; Sun,  3 Oct 2010 14:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.37.gb6088b
In-Reply-To: <4CA86A12.6080905@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157863>

The fetch transport command (in particular in remote helpers) may need to create
or update additional refs which are used internally by the helper, but which
it doesn't want to present to the user. Those refs are refered to as 'silent'
throughout the code because git should be silent about their presence, but yet
process those just like the other refs.

Example use case:
Remote helpers such as those for svn may chose to save the Git SHA1 -> Subversion
revision mapping as notes attached to the commits (as opposed to strings in the
commit message itself). The helper would need to update the notes on each fetch,
but the user should not be bothered by the presence of that ref. The remote
helper can update the notes tree through fast-import and then inform Git core
that it should silently update the notes ref.

Signed-off-by: Tomas Carnecky <tom@dbservice.com>
---
 builtin/clone.c    |   11 +++++++----
 builtin/fetch.c    |   15 ++++++++++++---
 transport-helper.c |   32 ++++++++++++++++++++++++++++----
 transport.c        |   16 ++++++++++------
 transport.h        |    6 ++++--
 5 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..78355b6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -348,13 +348,16 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	return local_refs;
 }
 
-static void write_remote_refs(const struct ref *local_refs)
+static void write_remote_refs(const struct ref *local_refs, struct ref *silent)
 {
 	const struct ref *r;
 
 	for (r = local_refs; r; r = r->next)
 		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);
 
+	for (r = silent; r; r = r->next)
+		add_extra_ref(r->name, r->old_sha1, 0);
+
 	pack_refs(PACK_REFS_ALL);
 	clear_extra_refs();
 }
@@ -369,7 +372,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *refs, *remote_head;
 	const struct ref *remote_head_points_at;
 	const struct ref *our_head_points_at;
-	struct ref *mapped_refs;
+	struct ref *mapped_refs, *silent = NULL;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
@@ -542,14 +545,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		refs = transport_get_remote_refs(transport);
 		if (refs) {
 			mapped_refs = wanted_peer_refs(refs, refspec);
-			transport_fetch_refs(transport, mapped_refs);
+			transport_fetch_refs(transport, mapped_refs, &silent);
 		}
 	}
 
 	if (refs) {
 		clear_extra_refs();
 
-		write_remote_refs(mapped_refs);
+		write_remote_refs(mapped_refs, silent);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6fc5047..71db090 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -313,7 +313,7 @@ static int update_local_ref(struct ref *ref,
 }
 
 static int store_updated_refs(const char *raw_url, const char *remote_name,
-		struct ref *ref_map)
+		struct ref *ref_map, struct ref *silent)
 {
 	FILE *fp;
 	struct commit *commit;
@@ -411,6 +411,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				fprintf(stderr, " %s\n", note);
 		}
 	}
+
+	/* Also update the silent refs. */
+	for (rm = silent; rm; rm = rm->next) {
+		snprintf(note, 1024, "note here"); /* TODO */
+		update_local_ref(rm, rm->name, note);
+	}
+
 	free(url);
 	fclose(fp);
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
@@ -496,13 +503,15 @@ static int quickfetch(struct ref *ref_map)
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
+	struct ref *silent = NULL;
+
 	int ret = quickfetch(ref_map);
 	if (ret)
-		ret = transport_fetch_refs(transport, ref_map);
+		ret = transport_fetch_refs(transport, ref_map, &silent);
 	if (!ret)
 		ret |= store_updated_refs(transport->url,
 				transport->remote->name,
-				ref_map);
+				ref_map, silent);
 	transport_unlock_pack(transport);
 	return ret;
 }
diff --git a/transport-helper.c b/transport-helper.c
index dcaaa89..c0133ca 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -330,8 +330,29 @@ static void map_impure_ref(int nr_heads, struct ref **to_fetch, char *map)
 	}
 }
 
+/* `buf` points to the 'silent' response from the helper. Parse it and
+ * add the ref to the `silent` list. */
+static void add_silent_ref(struct strbuf *buf, struct ref **silent)
+{
+	if (!silent)
+		return;
+
+	struct ref *ref;
+	char *eon = strchr(buf->buf + 7, ' ');
+	if (!eon)
+		warning("Malformed helper response: %s", buf->buf);
+
+	*eon = '\0';
+	ref = alloc_ref(buf->buf + 7);
+	get_sha1_hex(eon + 1, ref->new_sha1);
+	
+	ref->next = *silent;
+	*silent = ref;
+}
+
 static int fetch_with_fetch(struct transport *transport,
-			    int nr_heads, struct ref **to_fetch)
+			    int nr_heads, struct ref **to_fetch,
+			    struct ref **silent)
 {
 	struct helper_data *data = transport->data;
 	int i;
@@ -365,6 +386,8 @@ static int fetch_with_fetch(struct transport *transport,
 			transport_keep(transport, name);
 		} else if (!prefixcmp(buf.buf, "map ")) {
 			map_impure_ref(nr_heads, to_fetch, buf.buf + 4);
+		} else if (!prefixcmp(buf.buf, "silent ")) {
+			add_silent_ref(&buf, silent);
 		}
 		else if (!buf.len)
 			break;
@@ -559,14 +582,15 @@ static int connect_helper(struct transport *transport, const char *name,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, struct ref **to_fetch)
+		 int nr_heads, struct ref **to_fetch,
+		 struct ref **silent)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
-		return transport->fetch(transport, nr_heads, to_fetch);
+		return transport->fetch(transport, nr_heads, to_fetch, silent);
 	}
 
 	count = 0;
@@ -578,7 +602,7 @@ static int fetch(struct transport *transport,
 		return 0;
 
 	if (data->fetch)
-		return fetch_with_fetch(transport, nr_heads, to_fetch);
+		return fetch_with_fetch(transport, nr_heads, to_fetch, silent);
 
 	if (data->import)
 		return fetch_with_import(transport, nr_heads, to_fetch);
diff --git a/transport.c b/transport.c
index df2baa7..eaab276 100644
--- a/transport.c
+++ b/transport.c
@@ -253,7 +253,8 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 }
 
 static int fetch_objs_via_rsync(struct transport *transport,
-				int nr_objs, struct ref **to_fetch)
+				int nr_objs, struct ref **to_fetch,
+				struct ref **silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process rsync;
@@ -428,7 +429,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch,
+			       struct ref **silent)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd);
@@ -508,7 +510,8 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch,
+			       struct ref **silent)
 {
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
@@ -1083,7 +1086,8 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 	return transport->remote_refs;
 }
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs)
+int transport_fetch_refs(struct transport *transport, struct ref *refs,
+				struct ref **silent)
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
@@ -1113,9 +1117,9 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->fetch(transport, nr_heads, heads);
-
+	rc = transport->fetch(transport, nr_heads, heads, silent);
 	free(heads);
+
 	return rc;
 }
 
diff --git a/transport.h b/transport.h
index 6320d28..22daf60 100644
--- a/transport.h
+++ b/transport.h
@@ -52,7 +52,7 @@ struct transport {
 	 * get_refs_list(), it should set the old_sha1 fields in the
 	 * provided refs now.
 	 **/
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs, struct ref **silent);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
@@ -149,7 +149,9 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs,
+			struct ref **silent);
+
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
1.7.3.37.gb6088b
