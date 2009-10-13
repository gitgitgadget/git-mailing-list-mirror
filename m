From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 15/16] Smart fetch over HTTP: client side
Date: Mon, 12 Oct 2009 19:25:14 -0700
Message-ID: <1255400715-10508-16-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDF-0004cs-4e
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbZJMC0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbZJMC0x
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:53 -0400
Received: from george.spearce.org ([209.20.77.23]:56208 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644AbZJMC0u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7CFE33821F; Tue, 13 Oct 2009 02:25:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E99B338269;
	Tue, 13 Oct 2009 02:25:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130120>

The git-remote-curl backend detects if the remote server supports
the git-upload-pack service, and if so, runs git-fetch-pack locally
in a pipe to generate the want/have commands.

The advertisements from the server that were obtained during the
discovery are passed into git-fetch-pack before the POST request
starts, permitting server capability discovery and enablement.

Common objects that are discovered are appended onto the request as
have lines and are sent again on the next request.  This allows the
remote side to reinitialize its in-memory list of common objects
during the next request.

Because all requests are relatively short, below git-remote-curl's
1 MiB buffer limit, requests will use the standard Content-Length
header and be valid HTTP/1.0 POST requests.  This makes the fetch
client more tolerant of proxy servers which don't support HTTP/1.1
or the chunked transfer encoding.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch-pack.c |  110 ++++++++++++++++++++++++++++++++++++++++++--------
 fetch-pack.h         |    3 +-
 remote-curl.c        |   75 +++++++++++++++++++++++++++++++++-
 3 files changed, 168 insertions(+), 20 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index b68b3eb..fba0c74 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -165,6 +165,24 @@ enum ack_type {
 	ACK_ready
 };
 
+static void consume_shallow_list(int fd)
+{
+	if (args.one_shot_rpc && args.depth > 0) {
+		/* If we sent a depth we will get back "duplicate"
+		 * shallow and unshallow commands every time there
+		 * is a block of have lines exchanged.
+		 */
+		char line[1000];
+		while (packet_read_line(fd, line, sizeof(line))) {
+			if (!prefixcmp(line, "shallow "))
+				continue;
+		 	if (!prefixcmp(line, "unshallow "))
+				continue;
+			die("git fetch-pack: expected shallow list");
+		}
+	}
+}
+
 static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
 	static char line[1000];
@@ -190,6 +208,15 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
 }
 
+static void send_request(int fd, struct strbuf *buf)
+{
+	if (args.one_shot_rpc) {
+		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
+		packet_flush(fd);
+	} else
+		safe_write(fd, buf->buf, buf->len);
+}
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
@@ -199,7 +226,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	unsigned in_vain = 0;
 	int got_continue = 0;
 	struct strbuf req_buf = STRBUF_INIT;
+	size_t state_len = 0;
 
+	if (args.one_shot_rpc && multi_ack == 1)
+		die("--one-shot-rpc requires multi_ack_2");
 	if (marked)
 		for_each_ref(clear_marks, NULL);
 	marked = 1;
@@ -256,13 +286,13 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	if (args.depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args.depth);
 	packet_buf_flush(&req_buf);
-
-	safe_write(fd[1], req_buf.buf, req_buf.len);
+	state_len = req_buf.len;
 
 	if (args.depth > 0) {
 		char line[1024];
 		unsigned char sha1[20];
 
+		send_request(fd[1], &req_buf);
 		while (packet_read_line(fd[0], line, sizeof(line))) {
 			if (!prefixcmp(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
@@ -284,28 +314,40 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			}
 			die("expected shallow/unshallow, got %s", line);
 		}
+	} else if (!args.one_shot_rpc)
+		send_request(fd[1], &req_buf);
+
+	if (!args.one_shot_rpc) {
+		/* If we aren't using the stateless one-shot-rpc
+		 * interface we don't need to retain the headers.
+		 */
+		strbuf_setlen(&req_buf, 0);
+		state_len = 0;
 	}
 
 	flushes = 0;
 	retval = -1;
 	while ((sha1 = get_rev())) {
-		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
+		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
 		if (args.verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		in_vain++;
 		if (!(31 & ++count)) {
 			int ack;
 
-			packet_flush(fd[1]);
+			packet_buf_flush(&req_buf);
+			send_request(fd[1], &req_buf);
+			strbuf_setlen(&req_buf, state_len);
 			flushes++;
 
 			/*
 			 * We keep one window "ahead" of the other side, and
 			 * will wait for an ACK only on the next one
 			 */
-			if (count == 32)
+			if (!args.one_shot_rpc && count == 32)
 				continue;
 
+			consume_shallow_list(fd[0]);
 			do {
 				ack = get_ack(fd[0], result_sha1);
 				if (args.verbose && ack)
@@ -322,6 +364,17 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				case ACK_continue: {
 					struct commit *commit =
 						lookup_commit(result_sha1);
+					if (args.one_shot_rpc
+					 && ack == ACK_common
+					 && !(commit->object.flags & COMMON)) {
+						/* We need to replay the have for this object
+						 * on the next RPC request so the peer knows
+						 * it is in common with us.
+						 */
+						const char *hex = sha1_to_hex(result_sha1);
+						packet_buf_write(&req_buf, "have %s\n", hex);
+						state_len = req_buf.len;
+					}
 					mark_common(commit, 0, 1);
 					retval = 0;
 					in_vain = 0;
@@ -339,7 +392,8 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		}
 	}
 done:
-	packet_write(fd[1], "done\n");
+	packet_buf_write(&req_buf, "done\n");
+	send_request(fd[1], &req_buf);
 	if (args.verbose)
 		fprintf(stderr, "done\n");
 	if (retval != 0) {
@@ -348,6 +402,7 @@ done:
 	}
 	strbuf_release(&req_buf);
 
+	consume_shallow_list(fd[0]);
 	while (flushes || multi_ack) {
 		int ack = get_ack(fd[0], result_sha1);
 		if (ack) {
@@ -672,6 +727,8 @@ static struct ref *do_fetch_pack(int fd[2],
 			 */
 			warning("no common commits");
 
+	if (args.one_shot_rpc)
+		packet_flush(fd[1]);
 	if (get_pack(fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
 
@@ -742,6 +799,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct ref *ref = NULL;
 	char *dest = NULL, **heads;
 	int fd[2];
+	char *pack_lockfile = NULL;
+	char **pack_lockfile_ptr = NULL;
 	struct child_process *conn;
 
 	nr_heads = 0;
@@ -791,6 +850,15 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				args.no_progress = 1;
 				continue;
 			}
+			if (!strcmp("--one-shot-rpc", arg)) {
+				args.one_shot_rpc = 1;
+				continue;
+			}
+			if (!strcmp("--lock-pack", arg)) {
+				args.lock_pack = 1;
+				pack_lockfile_ptr = &pack_lockfile;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest = (char *)arg;
@@ -801,19 +869,27 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!dest)
 		usage(fetch_pack_usage);
 
-	conn = git_connect(fd, (char *)dest, args.uploadpack,
-			   args.verbose ? CONNECT_VERBOSE : 0);
-	if (conn) {
-		get_remote_heads(fd[0], &ref, 0, NULL, 0, NULL);
-
-		ref = fetch_pack(&args, fd, conn, ref, dest, nr_heads, heads, NULL);
-		close(fd[0]);
-		close(fd[1]);
-		if (finish_connect(conn))
-			ref = NULL;
+	if (args.one_shot_rpc) {
+		conn = NULL;
+		fd[0] = 0;
+		fd[1] = 1;
 	} else {
-		ref = NULL;
+		conn = git_connect(fd, (char *)dest, args.uploadpack,
+				   args.verbose ? CONNECT_VERBOSE : 0);
+	}
+
+	get_remote_heads(fd[0], &ref, 0, NULL, 0, NULL);
+
+	ref = fetch_pack(&args, fd, conn, ref, dest,
+		nr_heads, heads, pack_lockfile_ptr);
+	if (pack_lockfile) {
+		printf("lock %s\n", pack_lockfile);
+		fflush(stdout);
 	}
+	close(fd[0]);
+	close(fd[1]);
+	if (finish_connect(conn))
+		ref = NULL;
 	ret = !ref;
 
 	if (!ret && nr_heads) {
diff --git a/fetch-pack.h b/fetch-pack.h
index 8bd9c32..ee6b17f 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -13,7 +13,8 @@ struct fetch_pack_args
 		fetch_all:1,
 		verbose:1,
 		no_progress:1,
-		include_tag:1;
+		include_tag:1,
+		one_shot_rpc:1;
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
diff --git a/remote-curl.c b/remote-curl.c
index 529df42..31d1d34 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -404,7 +404,10 @@ static int one_shot_rpc_service(const char *service,
 }
 
 struct fetch_args {
-	unsigned verbose : 1;
+	int depth;
+	unsigned verbose : 1,
+		thin : 1,
+		followtags : 1;
 };
 
 static int fetch_dumb(struct fetch_args *args,
@@ -413,6 +416,8 @@ static int fetch_dumb(struct fetch_args *args,
 	char **targets = xmalloc(nr_heads * sizeof(char*));
 	int ret, i;
 
+	if (args->depth)
+		die("dumb http transport does not support --depth");
 	for (i = 0; i < nr_heads; i++)
 		targets[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
 
@@ -431,6 +436,64 @@ static int fetch_dumb(struct fetch_args *args,
 	return ret ? error("Fetch failed.") : 0;
 }
 
+static int fetch_git(struct fetch_args *args,
+	struct discovery *heads,
+	int nr_heads, struct ref **to_fetch)
+{
+	struct strbuf res = STRBUF_INIT;
+	char *depth_arg = NULL;
+	const char **argv;
+	int argc = 0, i, err;
+
+	argv = xmalloc((15 + nr_heads) * sizeof(char*));
+	argv[argc++] = "fetch-pack";
+	argv[argc++] = "--one-shot-rpc";
+	argv[argc++] = "--lock-pack";
+	if (args->followtags)
+		argv[argc++] = "--include-tag";
+	if (args->thin)
+		argv[argc++] = "--thin";
+	if (args->verbose) {
+		argv[argc++] = "-v";
+		argv[argc++] = "-v";
+	}
+	if (args->depth) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "--depth=%d", args->depth);
+		depth_arg = strbuf_detach(&buf, NULL);
+		argv[argc++] = depth_arg;
+	}
+	argv[argc++] = url;
+	for (i = 0; i < nr_heads; i++) {
+		struct ref *ref = to_fetch[i];
+		if (!ref->name || !*ref->name)
+			die("cannot fetch by sha1 over smart http");
+		argv[argc++] = ref->name;
+	}
+	argv[argc++] = NULL;
+
+	err = one_shot_rpc_service("git-upload-pack",
+		args->verbose,
+		argv, heads, &res);
+	if (res.len)
+		safe_write(1, res.buf, res.len);
+	strbuf_release(&res);
+
+	free(argv);
+	free(depth_arg);
+	return err;
+}
+
+static int fetch(struct fetch_args *args,
+	int nr_heads, struct ref **to_fetch)
+{
+	struct discovery *d = discover_refs("git-upload-pack");
+	if (d->proto_git)
+		return fetch_git(args, d, nr_heads, to_fetch);
+	else 
+		return fetch_dumb(args, nr_heads, to_fetch);
+}
+
 static void parse_fetch(struct strbuf *buf, int multiple)
 {
 	struct ref **to_fetch = NULL;
@@ -470,6 +533,12 @@ static void parse_fetch(struct strbuf *buf, int multiple)
 		}
 		else if (!strcmp(buf->buf, "option verbose"))
 			args.verbose = 1;
+		else if (!strcmp(buf->buf, "option followtags"))
+			args.followtags = 1;
+		else if (!strcmp(buf->buf, "option thin"))
+			args.thin = 1;
+		else if (!prefixcmp(buf->buf, "option depth "))
+			args.depth = atoi(buf->buf + strlen("option depth "));
 		else
 			die("http transport does not support %s", buf->buf);
 
@@ -480,7 +549,7 @@ static void parse_fetch(struct strbuf *buf, int multiple)
 			break;
 	} while (1);
 
-	if (fetch_dumb(&args, nr_heads, to_fetch))
+	if (fetch(&args, nr_heads, to_fetch))
 		exit(128); /* error already reported */
 	free_refs(list_head);
 	free(to_fetch);
@@ -645,7 +714,9 @@ int main(int argc, const char **argv)
 			printf("fetch\n");
 			printf("fetch-multiple\n");
 			printf("push\n");
+			printf("option depth\n");
 			printf("option dry-run\n");
+			printf("option followtags\n");
 			printf("option thin\n");
 			printf("option verbose\n");
 			printf("\n");
-- 
1.6.5.52.g0ff2e
