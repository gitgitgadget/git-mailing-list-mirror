From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4] Add fetch methods to transport library.
Date: Wed, 11 Jul 2007 21:37:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707112107520.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 03:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ncK-0000Ct-CY
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 03:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXGLBhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 21:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763094AbXGLBhN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 21:37:13 -0400
Received: from iabervon.org ([66.92.72.58]:1588 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763980AbXGLBhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 21:37:10 -0400
Received: (qmail 31937 invoked by uid 1000); 12 Jul 2007 01:37:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2007 01:37:08 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52231>

These don't include bundle or rsync. It would be great if people would 
write at least bundle; rsync may well be deprecatable at this point (since 
people are more likely to have http than anonymous rsync and more likely 
to have ssh+git than non-anonymous rsync).

In any case, it identifies such URLs and fails cleanly on them.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 transport.c |  286 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 transport.h |   23 +++++-
 2 files changed, 305 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index ce03133..487d315 100644
--- a/transport.c
+++ b/transport.c
@@ -1,6 +1,39 @@
 #include "cache.h"
 #include "transport.h"
 #include "run-command.h"
+#include "http.h"
+#include "pkt-line.h"
+#include "fetch-pack.h"
+#include "walker.h"
+
+/* Generic functions for using commit walkers */
+
+static int fetch_objs_via_walker(const struct transport *transport,
+				 int nr_objs, char **objs)
+{
+	char *dest = xstrdup(transport->url);
+	struct walker *walker = transport->data;
+
+	walker->get_all = 1;
+	walker->get_tree = 1;
+	walker->get_history = 1;
+	walker->get_verbosely = transport->verbose;
+	walker->get_recover = 0;
+
+	if (walker_fetch(walker, nr_objs, objs, NULL, dest))
+		die("Fetch failed.");
+
+	free(dest);
+	return 0;
+}
+
+static int disconnect_walker(struct transport *transport)
+{
+	struct walker *walker = transport->data;
+	if (walker)
+		walker_free(walker);
+	return 0;
+}
 
 static const struct transport_ops rsync_transport = {
 };
@@ -37,9 +70,119 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	return !!err;
 }
 
+#ifndef NO_CURL
+static int missing__target(int code, int result)
+{
+	return	/* file:// URL -- do we ever use one??? */
+		(result == CURLE_FILE_COULDNT_READ_FILE) ||
+		/* http:// and https:// URL */
+		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
+		/* ftp:// URL */
+		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
+		;
+}
+
+#define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
+
+static struct ref *get_refs_via_curl(const struct transport *transport)
+{
+	struct buffer buffer;
+	char *data, *start, *mid;
+	char *ref_name;
+	char *refs_url;
+	int i = 0;
+
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	struct ref *refs = NULL;
+	struct ref *ref = NULL;
+	struct ref *last_ref = NULL;
+
+	data = xmalloc(4096);
+	buffer.size = 4096;
+	buffer.posn = 0;
+	buffer.buffer = data;
+
+	refs_url = xmalloc(strlen(transport->url) + 11);
+	sprintf(refs_url, "%s/info/refs", transport->url);
+
+	http_init();
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, refs_url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			if (missing_target(&results)) {
+				free(buffer.buffer);
+				return NULL;
+			} else {
+				free(buffer.buffer);
+				error("%s", curl_errorstr);
+				return NULL;
+			}
+		}
+	} else {
+		free(buffer.buffer);
+		error("Unable to start request");
+		return NULL;
+	}
+
+	http_cleanup();
+
+	data = buffer.buffer;
+	start = NULL;
+	mid = data;
+	while (i < buffer.posn) {
+		if (!start)
+			start = &data[i];
+		if (data[i] == '\t')
+			mid = &data[i];
+		if (data[i] == '\n') {
+			data[i] = 0;
+			ref_name = mid + 1;
+			ref = xmalloc(sizeof(struct ref) +
+				      strlen(ref_name) + 1);
+			memset(ref, 0, sizeof(struct ref));
+			strcpy(ref->name, ref_name);
+			get_sha1_hex(start, ref->old_sha1);
+			if (!refs)
+				refs = ref;
+			if (last_ref)
+				last_ref->next = ref;
+			last_ref = ref;
+			start = NULL;
+		}
+		i++;
+	}
+
+	free(buffer.buffer);
+
+	return refs;
+}
+
+#else
+
+static struct ref *get_refs_via_curl(const struct transport *transport)
+{
+	die("Cannot fetch from '%s' without curl ...", transport->url);
+	return NULL;
+}
+
+#endif
+
 static const struct transport_ops curl_transport = {
 	/* set_option */	NULL,
-	/* push */		curl_transport_push
+	/* get_refs_list */	get_refs_via_curl,
+	/* fetch_refs */	NULL,
+	/* fetch_objs */	fetch_objs_via_walker,
+	/* push */		curl_transport_push,
+	/* disconnect */	disconnect_walker
 };
 
 static const struct transport_ops bundle_transport = {
@@ -47,7 +190,13 @@ static const struct transport_ops bundle_transport = {
 
 struct git_transport_data {
 	unsigned thin : 1;
+	unsigned keep : 1;
 
+	int unpacklimit;
+
+	int depth;
+
+	const char *uploadpack;
 	const char *receivepack;
 };
 
@@ -55,16 +204,86 @@ static int set_git_option(struct transport *connection,
 			  const char *name, const char *value)
 {
 	struct git_transport_data *data = connection->data;
-	if (!strcmp(name, TRANS_OPT_RECEIVEPACK)) {
+	if (!strcmp(name, TRANS_OPT_UPLOADPACK)) {
+		data->uploadpack = value;
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_RECEIVEPACK)) {
 		data->receivepack = value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_THIN)) {
 		data->thin = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_KEEP)) {
+		data->keep = !!value;
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_UNPACKLIMIT)) {
+		data->unpacklimit = atoi(value);
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
+		if (!value)
+			data->depth = 0;
+		else
+			data->depth = atoi(value);
+		return 0;
 	}
 	return 1;
 }
 
+static struct ref *get_refs_via_connect(const struct transport *transport)
+{
+	struct git_transport_data *data = transport->data;
+	struct ref *refs;
+	int fd[2];
+	pid_t pid;
+	char *dest = xstrdup(transport->url);
+
+	pid = git_connect(fd, dest, data->uploadpack, 0);
+
+	if (pid < 0)
+		die("Failed to connect to \"%s\"", transport->url);
+
+	get_remote_heads(fd[0], &refs, 0, NULL, 0);
+	packet_flush(fd[1]);
+
+	finish_connect(pid);
+
+	free(dest);
+
+	return refs;
+}
+
+static int fetch_refs_via_pack(const struct transport *transport,
+			       int nr_heads, char **heads)
+{
+	struct git_transport_data *data = transport->data;
+	struct ref *refs;
+	char *dest = xstrdup(transport->url);
+	struct fetch_pack_args args;
+
+	args.uploadpack = data->uploadpack;
+	args.quiet = 0;
+	args.keep_pack = data->keep;
+	args.unpacklimit = data->unpacklimit;
+	args.use_thin_pack = data->thin;
+	args.fetch_all = 0;
+	args.verbose = transport->verbose;
+	args.depth = data->depth;
+	args.no_progress = 0;
+
+	setup_fetch_pack(&args);
+
+	refs = fetch_pack(dest, nr_heads, heads);
+
+	// ???? check that refs got everything?
+
+	/* free the memory used for the refs list ... */
+
+	free_refs(refs);
+
+	free(dest);
+	return 0;
+}
+
 static int git_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
 	struct git_transport_data *data = transport->data;
 	const char **argv;
@@ -111,6 +330,9 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 
 static const struct transport_ops git_transport = {
 	/* set_option */	set_git_option,
+	/* get_refs_list */	get_refs_via_connect,
+	/* fetch_refs */	fetch_refs_via_pack,
+	/* fetch_objs */	NULL,
 	/* push */		git_transport_push
 };
 
@@ -141,7 +363,10 @@ struct transport *transport_get(struct remote *remote, const char *url,
 		   !prefixcmp(url, "ftp://")) {
 		ret = xmalloc(sizeof(*ret));
 		ret->ops = &curl_transport;
-		ret->data = NULL;
+		if (fetch)
+			ret->data = get_http_walker(url);
+		else
+			ret->data = NULL;
 	} else if (is_local(url) && is_file(url)) {
 		ret = xmalloc(sizeof(*ret));
 		ret->data = NULL;
@@ -151,14 +376,19 @@ struct transport *transport_get(struct remote *remote, const char *url,
 		ret = xcalloc(1, sizeof(*ret));
 		ret->data = data;
 		data->thin = 1;
+		data->uploadpack = "git-upload-pack";
+		if (remote->uploadpack)
+			data->uploadpack = remote->uploadpack;
 		data->receivepack = "git-receive-pack";
 		if (remote->receivepack)
 			data->receivepack = remote->receivepack;
+		data->unpacklimit = -1;
 		ret->ops = &git_transport;
 	}
 	if (ret) {
 		ret->remote = remote;
 		ret->url = url;
+		ret->remote_refs = NULL;
 		ret->fetch = !!fetch;
 	}
 	return ret;
@@ -187,6 +417,54 @@ int transport_push(struct transport *transport,
 	return transport->ops->push(transport, refspec_nr, refspec, flags);
 }
 
+struct ref *transport_get_remote_refs(struct transport *transport)
+{
+	if (!transport->remote_refs)
+		transport->remote_refs =
+			transport->ops->get_refs_list(transport);
+	return transport->remote_refs;
+}
+
+#define PACK_HEADS_CHUNK_COUNT 256
+
+int transport_fetch_refs(struct transport *transport, struct ref *refs)
+{
+	int i;
+	int nr_heads = 0;
+	char **heads = xmalloc(PACK_HEADS_CHUNK_COUNT * sizeof(char *));
+	struct ref *rm;
+	int use_objs = !transport->ops->fetch_refs;
+
+	for (rm = refs; rm; rm = rm->next) {
+		if (rm->peer_ref &&
+		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
+			continue;
+		if (use_objs) {
+			heads[nr_heads++] = xstrdup(sha1_to_hex(rm->old_sha1));
+		} else {
+			heads[nr_heads++] = xstrdup(rm->name);
+		}
+		if (nr_heads % PACK_HEADS_CHUNK_COUNT == 0)
+			heads = xrealloc(heads,
+					 (nr_heads + PACK_HEADS_CHUNK_COUNT) *
+					 sizeof(char *));
+	}
+
+	if (use_objs) {
+		if (transport->ops->fetch_objs(transport, nr_heads, heads))
+			return -1;
+	} else {
+		if (transport->ops->fetch_refs(transport, nr_heads, heads))
+			return -1;
+	}
+
+	/* free the memory used for the heads list ... */
+	for (i = 0; i < nr_heads; i++)
+		free(heads[i]);
+	free(heads);
+	return 0;
+}
+
 int transport_disconnect(struct transport *transport)
 {
 	int ret = 0;
@@ -195,3 +473,5 @@ int transport_disconnect(struct transport *transport)
 	free(transport);
 	return ret;
 }
+
+
diff --git a/transport.h b/transport.h
index 5c2eb95..947db66 100644
--- a/transport.h
+++ b/transport.h
@@ -29,6 +29,11 @@ struct transport_ops {
 	int (*set_option)(struct transport *connection, const char *name,
 			  const char *value);
 
+	struct ref *(*get_refs_list)(const struct transport *transport);
+	int (*fetch_refs)(const struct transport *transport,
+			  int nr_refs, char **refs);
+	int (*fetch_objs)(const struct transport *transport,
+			  int nr_objs, char **objs);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
 	int (*disconnect)(struct transport *connection);
@@ -40,12 +45,24 @@ struct transport *transport_get(struct remote *remote, const char *url,
 
 /* Transport options which apply to git:// and scp-style URLs */
 
+/* The program to use on the remote side to send a pack */
+#define TRANS_OPT_UPLOADPACK "uploadpack"
+
 /* The program to use on the remote side to receive a pack */
 #define TRANS_OPT_RECEIVEPACK "receivepack"
 
 /* Transfer the data as a thin pack if not null */
 #define TRANS_OPT_THIN "thin"
 
+/* Keep the pack that was transferred if not null */
+#define TRANS_OPT_KEEP "keep"
+
+/* Unpack the objects if fewer than this number of objects are fetched */
+#define TRANS_OPT_UNPACKLIMIT "unpacklimit"
+
+/* Limit the depth of the fetch if not null */
+#define TRANS_OPT_DEPTH "depth"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
@@ -53,9 +70,13 @@ struct transport *transport_get(struct remote *remote, const char *url,
 int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
 
-int transport_push(struct transport *connection,
+int transport_push(struct transport *connection, 
 		   int refspec_nr, const char **refspec, int flags);
 
+struct ref *transport_get_remote_refs(struct transport *transport);
+
+int transport_fetch_refs(struct transport *transport, struct ref *refs);
+
 int transport_disconnect(struct transport *transport);
 
 #endif
-- 
1.5.2.2.1600.ga4e5
