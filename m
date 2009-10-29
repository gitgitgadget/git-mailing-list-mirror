From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 23/26] Smart fetch over HTTP: client side
Date: Wed, 28 Oct 2009 17:00:45 -0700
Message-ID: <1256774448-7625-24-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISr-0000kN-92
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbZJ2ABh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbZJ2ABg
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:36 -0400
Received: from george.spearce.org ([209.20.77.23]:36270 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbZJ2ABA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:01:00 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 26097381FF; Thu, 29 Oct 2009 00:01:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0C8713821F;
	Thu, 29 Oct 2009 00:00:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131532>

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
 remote-curl.c        |   69 +++++++++++++++++++++++++++++--
 3 files changed, 160 insertions(+), 22 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 615f549..8ed4a6f 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -165,6 +165,24 @@ enum ack_type {
 	ACK_ready
 };
 
+static void consume_shallow_list(int fd)
+{
+	if (args.stateless_rpc && args.depth > 0) {
+		/* If we sent a depth we will get back "duplicate"
+		 * shallow and unshallow commands every time there
+		 * is a block of have lines exchanged.
+		 */
+		char line[1000];
+		while (packet_read_line(fd, line, sizeof(line))) {
+			if (!prefixcmp(line, "shallow "))
+				continue;
+			if (!prefixcmp(line, "unshallow "))
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
+	if (args.stateless_rpc) {
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
 
+	if (args.stateless_rpc && multi_ack == 1)
+		die("--stateless-rpc requires multi_ack_detailed");
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
+	} else if (!args.stateless_rpc)
+		send_request(fd[1], &req_buf);
+
+	if (!args.stateless_rpc) {
+		/* If we aren't using the stateless-rpc interface
+		 * we don't need to retain the headers.
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
+			if (!args.stateless_rpc && count == 32)
 				continue;
 
+			consume_shallow_list(fd[0]);
 			do {
 				ack = get_ack(fd[0], result_sha1);
 				if (args.verbose && ack)
@@ -322,6 +364,17 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				case ACK_continue: {
 					struct commit *commit =
 						lookup_commit(result_sha1);
+					if (args.stateless_rpc
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
 
+	if (args.stateless_rpc)
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
+			if (!strcmp("--stateless-rpc", arg)) {
+				args.stateless_rpc = 1;
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
+	if (args.stateless_rpc) {
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
index 8bd9c32..fbe85ac 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -13,7 +13,8 @@ struct fetch_pack_args
 		fetch_all:1,
 		verbose:1,
 		no_progress:1,
-		include_tag:1;
+		include_tag:1,
+		stateless_rpc:1;
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
diff --git a/remote-curl.c b/remote-curl.c
index f1206cb..0eb6fc4 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -45,7 +45,7 @@ static int set_option(const char *name, const char *value)
 			options.progress = 0;
 		else
 			return -1;
-		return 1 /* TODO implement later */;
+		return 0;
 	}
 	else if (!strcmp(name, "depth")) {
 		char *end;
@@ -53,7 +53,7 @@ static int set_option(const char *name, const char *value)
 		if (value == end || *end)
 			return -1;
 		options.depth = v;
-		return 1 /* TODO implement later */;
+		return 0;
 	}
 	else if (!strcmp(name, "followtags")) {
 		if (!strcmp(value, "true"))
@@ -62,7 +62,7 @@ static int set_option(const char *name, const char *value)
 			options.followtags = 0;
 		else
 			return -1;
-		return 1 /* TODO implement later */;
+		return 0;
 	}
 	else if (!strcmp(name, "dry-run")) {
 		if (!strcmp(value, "true"))
@@ -463,6 +463,8 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	char **targets = xmalloc(nr_heads * sizeof(char*));
 	int ret, i;
 
+	if (options.depth)
+		die("dumb http transport does not support --depth");
 	for (i = 0; i < nr_heads; i++)
 		targets[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
 
@@ -481,6 +483,65 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	return ret ? error("Fetch failed.") : 0;
 }
 
+static int fetch_git(struct discovery *heads,
+	int nr_heads, struct ref **to_fetch)
+{
+	struct rpc_state rpc;
+	char *depth_arg = NULL;
+	const char **argv;
+	int argc = 0, i, err;
+
+	argv = xmalloc((15 + nr_heads) * sizeof(char*));
+	argv[argc++] = "fetch-pack";
+	argv[argc++] = "--stateless-rpc";
+	argv[argc++] = "--lock-pack";
+	if (options.followtags)
+		argv[argc++] = "--include-tag";
+	if (options.thin)
+		argv[argc++] = "--thin";
+	if (options.verbosity >= 3) {
+		argv[argc++] = "-v";
+		argv[argc++] = "-v";
+	}
+	if (!options.progress)
+		argv[argc++] = "--no-progress";
+	if (options.depth) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "--depth=%lu", options.depth);
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
+	memset(&rpc, 0, sizeof(rpc));
+	rpc.service_name = "git-upload-pack",
+	rpc.argv = argv;
+
+	err = rpc_service(&rpc, heads);
+	if (rpc.result.len)
+		safe_write(1, rpc.result.buf, rpc.result.len);
+	strbuf_release(&rpc.result);
+	free(argv);
+	free(depth_arg);
+	return err;
+}
+
+static int fetch(int nr_heads, struct ref **to_fetch)
+{
+	struct discovery *d = discover_refs("git-upload-pack");
+	if (d->proto_git)
+		return fetch_git(d, nr_heads, to_fetch);
+	else
+		return fetch_dumb(nr_heads, to_fetch);
+}
+
 static void parse_fetch(struct strbuf *buf)
 {
 	struct ref **to_fetch = NULL;
@@ -523,7 +584,7 @@ static void parse_fetch(struct strbuf *buf)
 			break;
 	} while (1);
 
-	if (fetch_dumb(nr_heads, to_fetch))
+	if (fetch(nr_heads, to_fetch))
 		exit(128); /* error already reported */
 	free_refs(list_head);
 	free(to_fetch);
-- 
1.6.5.2.181.gd6f41
