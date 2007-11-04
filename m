From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC PATCH] Reduce the number of connects when fetching
Date: Sun, 4 Nov 2007 16:28:38 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711041614390.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ion1c-0005jB-4m
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 22:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbXKDV2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXKDV2k
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:28:40 -0500
Received: from iabervon.org ([66.92.72.58]:39885 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbXKDV2j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:28:39 -0500
Received: (qmail 6260 invoked by uid 1000); 4 Nov 2007 21:28:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2007 21:28:38 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63445>

This shares the connection between getting the remote ref list and
getting objects in the first batch. (A second connection is still used
to follow tags)

It passes all of the tests, and should be fine, but I don't entirely 
understand the git protocol, so I'd like people who know it better to 
check this over. In particular, I don't know if there's a way to have the 
connection end up in a state where objects for more refs can be requested 
after some refs have been requested and the resulting objects read.

The idea is to keep the open connection in the data for the transport in 
between getting the list of refs and doing anything further. This 
therefore moves the connection-handling aspects outside of fetch-pack() 
and handles them primarily in transport.c.

This is on top of current next.
---
 builtin-fetch-pack.c |   74 ++++++++++++++++++++++++++-----------------------
 fetch-pack.h         |    2 +
 transport.c          |   41 +++++++++++++++++++--------
 3 files changed, 70 insertions(+), 47 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 862652b..7783c05 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -7,6 +7,7 @@
 #include "pack.h"
 #include "sideband.h"
 #include "fetch-pack.h"
+#include "remote.h"
 #include "run-command.h"
 
 static int transfer_unpack_limit = -1;
@@ -558,14 +559,14 @@ static int get_pack(int xd[2], char **pack_lockfile)
 }
 
 static struct ref *do_fetch_pack(int fd[2],
+		const struct ref *orig_ref,
 		int nr_match,
 		char **match,
 		char **pack_lockfile)
 {
-	struct ref *ref;
+	struct ref *ref = copy_ref_list(orig_ref);
 	unsigned char sha1[20];
 
-	get_remote_heads(fd[0], &ref, 0, NULL, 0);
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack")) {
@@ -583,10 +584,6 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
-	if (!ref) {
-		packet_flush(fd[1]);
-		die("no matching remote head");
-	}
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
@@ -660,7 +657,7 @@ static void fetch_pack_setup(void)
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret, nr_heads;
-	struct ref *ref;
+	struct ref *ref = NULL;
 	char *dest = NULL, **heads;
 
 	nr_heads = 0;
@@ -716,9 +713,34 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!dest)
 		usage(fetch_pack_usage);
 
-	ref = fetch_pack(&args, dest, nr_heads, heads, NULL);
+	int fd[2];
+	struct child_process *conn = git_connect(fd, (char *)dest, args.uploadpack,
+                          args.verbose ? CONNECT_VERBOSE : 0);
+	if (conn) {
+		get_remote_heads(fd[0], &ref, 0, NULL, 0);
+
+		ref = fetch_pack(&args, fd, conn, ref, dest, nr_heads, heads, NULL);
+		close(fd[0]);
+		close(fd[1]);
+		if (finish_connect(conn))
+			ref = NULL;
+	} else {
+		ref = NULL;
+	}
 	ret = !ref;
 
+	if (!ret && nr_heads) {
+		/* If the heads to pull were given, we should have
+		 * consumed all of them by matching the remote.
+		 * Otherwise, 'git-fetch remote no-such-ref' would
+		 * silently succeed without issuing an error.
+		 */
+		for (i = 0; i < nr_heads; i++)
+			if (heads[i] && heads[i][0]) {
+				error("no such remote ref %s", heads[i]);
+				ret = 1;
+			}
+	}
 	while (ref) {
 		printf("%s %s\n",
 		       sha1_to_hex(ref->old_sha1), ref->name);
@@ -729,16 +751,15 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 }
 
 struct ref *fetch_pack(struct fetch_pack_args *my_args,
+		       int fd[], pid_t pid,
+		       const struct ref *ref,
 		const char *dest,
 		int nr_heads,
 		char **heads,
 		char **pack_lockfile)
 {
-	int i, ret;
-	int fd[2];
-	struct child_process *conn;
-	struct ref *ref;
 	struct stat st;
+	struct ref *ref_cpy;
 
 	fetch_pack_setup();
 	memcpy(&args, my_args, sizeof(args));
@@ -747,29 +768,15 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
-	conn = git_connect(fd, (char *)dest, args.uploadpack,
-                          args.verbose ? CONNECT_VERBOSE : 0);
 	if (heads && nr_heads)
 		nr_heads = remove_duplicates(nr_heads, heads);
-	ref = do_fetch_pack(fd, nr_heads, heads, pack_lockfile);
-	close(fd[0]);
-	close(fd[1]);
-	ret = finish_connect(conn);
-
-	if (!ret && nr_heads) {
-		/* If the heads to pull were given, we should have
-		 * consumed all of them by matching the remote.
-		 * Otherwise, 'git-fetch remote no-such-ref' would
-		 * silently succeed without issuing an error.
-		 */
-		for (i = 0; i < nr_heads; i++)
-			if (heads[i] && heads[i][0]) {
-				error("no such remote ref %s", heads[i]);
-				ret = 1;
-			}
+	if (!ref) {
+		packet_flush(fd[1]);
+		die("no matching remote head");
 	}
+	ref_cpy = do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
 
-	if (!ret && args.depth > 0) {
+	if (args.depth > 0) {
 		struct cache_time mtime;
 		char *shallow = git_path("shallow");
 		int fd;
@@ -798,8 +805,5 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		}
 	}
 
-	if (ret)
-		ref = NULL;
-
-	return ref;
+	return ref_cpy;
 }
diff --git a/fetch-pack.h b/fetch-pack.h
index a7888ea..8d35ef6 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,8 @@ struct fetch_pack_args
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
+		int fd[], struct child_process *conn,
+		const struct ref *ref,
 		const char *dest,
 		int nr_heads,
 		char **heads,
diff --git a/transport.c b/transport.c
index f4577b7..175cf2c 100644
--- a/transport.c
+++ b/transport.c
@@ -567,6 +567,8 @@ struct git_transport_data {
 	unsigned thin : 1;
 	unsigned keep : 1;
 	int depth;
+	struct child_process *conn;
+	int fd[2];
 	const char *uploadpack;
 	const char *receivepack;
 };
@@ -597,20 +599,20 @@ static int set_git_option(struct transport *connection,
 	return 1;
 }
 
+static int connect_setup(struct transport *transport)
+{
+	struct git_transport_data *data = transport->data;
+	data->conn = git_connect(data->fd, transport->url, data->uploadpack, 0);
+	return 0;
+}
+
 static struct ref *get_refs_via_connect(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
-	int fd[2];
-	char *dest = xstrdup(transport->url);
-	struct child_process *conn = git_connect(fd, dest, data->uploadpack, 0);
 
-	get_remote_heads(fd[0], &refs, 0, NULL, 0);
-	packet_flush(fd[1]);
-
-	finish_connect(conn);
-
-	free(dest);
+	connect_setup(transport);
+	get_remote_heads(data->fd[0], &refs, 0, NULL, 0);
 
 	return refs;
 }
@@ -621,7 +623,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
 	char **origh = xmalloc(nr_heads * sizeof(*origh));
-	struct ref *refs;
+	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
 	int i;
@@ -636,13 +638,27 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
-	refs = fetch_pack(&args, dest, nr_heads, heads, &transport->pack_lockfile);
+
+	refs = transport_get_remote_refs(transport);
+	if (!data->conn) {
+		struct ref *refs_tmp;
+		connect_setup(transport);
+		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0);
+		free_refs(refs_tmp);
+	}
+
+	refs = fetch_pack(&args, data->fd, data->conn, transport->remote_refs, 
+			  dest, nr_heads, heads, &transport->pack_lockfile);
+	close(data->fd[0]);
+	close(data->fd[1]);
+	if (finish_connect(data->conn))
+		refs = NULL;
+	data->conn = NULL;
 
 	for (i = 0; i < nr_heads; i++)
 		free(origh[i]);
 	free(origh);
 	free(heads);
-	free_refs(refs);
 	free(dest);
 	return 0;
 }
@@ -723,6 +739,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->disconnect = disconnect_git;
 
 		data->thin = 1;
+		data->conn = NULL;
 		data->uploadpack = "git-upload-pack";
 		if (remote && remote->uploadpack)
 			data->uploadpack = remote->uploadpack;
-- 
1.5.3.4.1206.g5f96
