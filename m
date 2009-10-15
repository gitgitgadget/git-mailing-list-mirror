From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v3 15/17] Smart push over HTTP: client side
Date: Wed, 14 Oct 2009 20:36:52 -0700
Message-ID: <1255577814-14745-16-git-send-email-spearce@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHFT-0007IV-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762476AbZJODig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762444AbZJODif
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:38:35 -0400
Received: from george.spearce.org ([209.20.77.23]:33050 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbZJODi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:38:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1F9D538215; Thu, 15 Oct 2009 03:37:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 31A6438269;
	Thu, 15 Oct 2009 03:36:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130370>

The git-remote-curl backend detects if the remote server supports
the git-receive-pack service, and if so, runs git-send-pack in a
pipe to dump the command and pack data as a single POST request.

The advertisements from the server that were obtained during the
discovery are passed into git-send-pack before the POST request
starts.  This permits git-send-pack to operate largely unmodified.

For smaller packs (those under 1 MiB) a HTTP/1.0 POST with a
Content-Length is used, permitting interaction with any server.
The 1 MiB limit is arbitrary, but is sufficent to fit most deltas
created by human authors against text sources with the occasional
small binary file (e.g. few KiB icon image).  The configuration
option http.postBuffer can be used to increase (or shink) this
buffer if the default is not sufficient.

For larger packs which cannot be spooled entirely into the helper's
memory space (due to http.postBuffer being too small), the POST
request requires HTTP/1.1 and sets "Transfer-Encoding: chunked".
This permits the client to upload an unknown amount of data in one
HTTP transaction without needing to pregenerate the entire pack
file locally.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/config.txt |    8 ++
 builtin-send-pack.c      |  116 ++++++++++++++++++++++-
 http.c                   |    9 ++
 http.h                   |    1 +
 remote-curl.c            |  234 +++++++++++++++++++++++++++++++++++++++++++++-
 send-pack.h              |    3 +-
 sideband.c               |   11 ++-
 transport.c              |    1 +
 8 files changed, 371 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd17814..7130d07 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1089,6 +1089,14 @@ http.maxRequests::
 	How many HTTP requests to launch in parallel. Can be overridden
 	by the 'GIT_HTTP_MAX_REQUESTS' environment variable. Default is 5.
 
+http.postBuffer::
+	Maximum size in bytes of the buffer used by smart HTTP
+	transports when POSTing data to the remote system.
+	For requests larger than this buffer size, HTTP/1.1 and
+	Transfer-Encoding: chunked is used to avoid creating a
+	massive pack file locally.  Default is 1 MiB, which is
+	sufficient for most requests.
+
 http.lowSpeedLimit, http.lowSpeedTime::
 	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
 	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 37e528e..a0fbad0 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -2,9 +2,11 @@
 #include "commit.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include "run-command.h"
 #include "remote.h"
 #include "send-pack.h"
+#include "quote.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -59,7 +61,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
-	po.out = fd;
+	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
 	if (start_command(&po))
 		die_errno("git pack-objects failed");
@@ -83,6 +85,20 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	}
 
 	close(po.in);
+
+	if (args->stateless_rpc) {
+		char *buf = xmalloc(LARGE_PACKET_MAX);
+		while (1) {
+			ssize_t n = xread(po.out, buf, LARGE_PACKET_MAX);
+			if (n <= 0)
+				break;
+			send_sideband(fd, -1, buf, n, LARGE_PACKET_MAX);
+		}
+		free(buf);
+		close(po.out);
+		po.out = -1;
+	}
+
 	if (finish_command(&po))
 		return error("pack-objects died with strange error");
 	return 0;
@@ -303,6 +319,59 @@ static int refs_pushed(struct ref *ref)
 	return 0;
 }
 
+static void print_helper_status(struct ref *ref)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	for (; ref; ref = ref->next) {
+		const char *msg = NULL;
+		const char *res;
+
+		switch(ref->status) {
+		case REF_STATUS_NONE:
+			res = "error";
+			msg = "no match";
+			break;
+
+		case REF_STATUS_OK:
+			res = "ok";
+			break;
+
+		case REF_STATUS_UPTODATE:
+			res = "ok";
+			msg = "up to date";
+			break;
+
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+			res = "error";
+			msg = "non-fast forward";
+			break;
+
+		case REF_STATUS_REJECT_NODELETE:
+		case REF_STATUS_REMOTE_REJECT:
+			res = "error";
+			break;
+
+		case REF_STATUS_EXPECTING_REPORT:
+		default:
+			continue;
+		}
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s %s", res, ref->name);
+		if (ref->remote_status)
+			msg = ref->remote_status;
+		if (msg) {
+			strbuf_addch(&buf, ' ');
+			quote_two_c_style(&buf, "", msg, 0);
+		}
+		strbuf_addch(&buf, '\n');
+
+		safe_write(1, buf.buf, buf.len);
+	}
+	strbuf_release(&buf);
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -310,6 +379,7 @@ int send_pack(struct send_pack_args *args,
 {
 	int in = fd[0];
 	int out = fd[1];
+	struct strbuf req_buf = STRBUF_INIT;
 	struct ref *ref;
 	int new_refs;
 	int ask_for_status_report = 0;
@@ -391,14 +461,14 @@ int send_pack(struct send_pack_args *args,
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
 			if (ask_for_status_report) {
-				packet_write(out, "%s %s %s%c%s",
+				packet_buf_write(&req_buf, "%s %s %s%c%s",
 					old_hex, new_hex, ref->name, 0,
 					"report-status");
 				ask_for_status_report = 0;
 				expect_status_report = 1;
 			}
 			else
-				packet_write(out, "%s %s %s",
+				packet_buf_write(&req_buf, "%s %s %s",
 					old_hex, new_hex, ref->name);
 		}
 		ref->status = expect_status_report ?
@@ -406,7 +476,17 @@ int send_pack(struct send_pack_args *args,
 			REF_STATUS_OK;
 	}
 
-	packet_flush(out);
+	if (args->stateless_rpc) {
+		if (!args->dry_run) {
+			packet_buf_flush(&req_buf);
+			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
+		}
+	} else {
+		safe_write(out, req_buf.buf, req_buf.len);
+		packet_flush(out);
+	}
+	strbuf_release(&req_buf);
+
 	if (new_refs && !args->dry_run) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
@@ -414,11 +494,15 @@ int send_pack(struct send_pack_args *args,
 			return -1;
 		}
 	}
+	if (args->stateless_rpc && !args->dry_run)
+		packet_flush(out);
 
 	if (expect_status_report)
 		ret = receive_status(in, remote_refs);
 	else
 		ret = 0;
+	if (args->stateless_rpc)
+		packet_flush(out);
 
 	if (ret < 0)
 		return ret;
@@ -478,6 +562,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	struct extra_have_objects extra_have;
 	struct ref *remote_refs, *local_refs;
 	int ret;
+	int helper_status = 0;
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
@@ -523,6 +608,14 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.use_thin_pack = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--stateless-rpc")) {
+				args.stateless_rpc = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--helper-status")) {
+				helper_status = 1;
+				continue;
+			}
 			usage(send_pack_usage);
 		}
 		if (!dest) {
@@ -551,7 +644,14 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	conn = git_connect(fd, dest, receivepack, args.verbose ? CONNECT_VERBOSE : 0);
+	if (args.stateless_rpc) {
+		conn = NULL;
+		fd[0] = 0;
+		fd[1] = 1;
+	} else {
+		conn = git_connect(fd, dest, receivepack,
+			args.verbose ? CONNECT_VERBOSE : 0);
+	}
 
 	memset(&extra_have, 0, sizeof(extra_have));
 
@@ -575,12 +675,16 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	ret = send_pack(&args, fd, conn, remote_refs, &extra_have);
 
+	if (helper_status)
+		print_helper_status(remote_refs);
+
 	close(fd[1]);
 	close(fd[0]);
 
 	ret |= finish_connect(conn);
 
-	print_push_status(dest, remote_refs);
+	if (!helper_status)
+		print_push_status(dest, remote_refs);
 
 	if (!args.dry_run && remote) {
 		struct ref *ref;
diff --git a/http.c b/http.c
index 23b2a19..07e188a 100644
--- a/http.c
+++ b/http.c
@@ -1,9 +1,11 @@
 #include "http.h"
 #include "pack.h"
+#include "sideband.h"
 
 int data_received;
 int active_requests;
 int http_is_verbose;
+size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
 #ifdef USE_CURL_MULTI
 static int max_requests = -1;
@@ -174,6 +176,13 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.proxy", var))
 		return git_config_string(&curl_http_proxy, var, value);
 
+	if (!strcmp("http.postbuffer", var)) {
+		http_post_buffer = git_config_int(var, value);
+		if (http_post_buffer < LARGE_PACKET_MAX)
+			http_post_buffer = LARGE_PACKET_MAX;
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
diff --git a/http.h b/http.h
index 4c4e99c..1b0562f 100644
--- a/http.h
+++ b/http.h
@@ -94,6 +94,7 @@ extern void http_cleanup(void);
 extern int data_received;
 extern int active_requests;
 extern int http_is_verbose;
+extern size_t http_post_buffer;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
diff --git a/remote-curl.c b/remote-curl.c
index c6e3172..45436d1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "pkt-line.h"
+#include "sideband.h"
 
 static struct remote *remote;
 static const char *url;
@@ -16,7 +17,8 @@ struct options {
 	unsigned long depth;
 	unsigned progress : 1,
 		followtags : 1,
-		dry_run : 1;
+		dry_run : 1,
+		thin : 1;
 };
 static struct options options;
 
@@ -274,6 +276,187 @@ static void output_refs(struct ref *refs)
 	free_refs(refs);
 }
 
+struct rpc_state {
+	const char *service_name;
+	const char **argv;
+	char *service_url;
+	char *hdr_content_type;
+	char *hdr_accept;
+	char *buf;
+	size_t alloc;
+	size_t len;
+	size_t pos;
+	int in;
+	int out;
+	struct strbuf result;
+};
+
+static size_t rpc_out(void *ptr, size_t eltsize,
+		size_t nmemb, void *buffer_)
+{
+	size_t max = eltsize * nmemb;
+	struct rpc_state *rpc = buffer_;
+	size_t avail = rpc->len - rpc->pos;
+
+	if (!avail) {
+		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		if (!avail)
+			return 0;
+		rpc->pos = 0;
+		rpc->len = avail;
+	}
+
+	if (max < avail);
+		avail = max;
+	memcpy(ptr, rpc->buf + rpc->pos, avail);
+	rpc->pos += avail;
+	return avail;
+}
+
+static size_t rpc_in(const void *ptr, size_t eltsize,
+		size_t nmemb, void *buffer_)
+{
+	size_t size = eltsize * nmemb;
+	struct rpc_state *rpc = buffer_;
+	write_or_die(rpc->in, ptr, size);
+	return size;
+}
+
+static int post_rpc(struct rpc_state *rpc)
+{
+	struct active_request_slot *slot;
+	struct slot_results results;
+	struct curl_slist *headers = NULL;
+	int err = 0, large_request = 0;
+
+	/* Try to load the entire request, if we can fit it into the
+	 * allocated buffer space we can use HTTP/1.0 and avoid the
+	 * chunked encoding mess.
+	 */
+	while (1) {
+		size_t left = rpc->alloc - rpc->len;
+		char *buf = rpc->buf + rpc->len;
+		int n;
+
+		if (left < LARGE_PACKET_MAX) {
+			large_request = 1;
+			break;
+		}
+
+		n = packet_read_line(rpc->out, buf, left);
+		if (!n)
+			break;
+		rpc->len += n;
+	}
+
+	slot = get_active_slot();
+	slot->results = &results;
+
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
+
+	headers = curl_slist_append(headers, rpc->hdr_content_type);
+	headers = curl_slist_append(headers, rpc->hdr_accept);
+
+	if (large_request) {
+		/* The request body is large and the size cannot be predicted.
+		 * We must use chunked encoding to send it.
+		 */
+		headers = curl_slist_append(headers, "Expect: 100-continue");
+		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
+		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
+		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
+		if (options.verbosity > 1) {
+			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
+			fflush(stderr);
+		}
+
+	} else {
+		/* We know the complete request size in advance, use the
+		 * more normal Content-Length approach.
+		 */
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, rpc->buf);
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, rpc->len);
+		if (options.verbosity > 1) {
+			fprintf(stderr, "POST %s (%lu bytes)\n",
+				rpc->service_name, (unsigned long)rpc->len);
+			fflush(stderr);
+		}
+	}
+
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			err |= error("RPC failed; result=%d, HTTP code = %ld",
+				results.curl_result, results.http_code);
+		}
+	}
+	curl_slist_free_all(headers);
+	return err;
+}
+
+static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
+{
+	const char *svc = rpc->service_name;
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process client;
+	int err = 0;
+
+	init_walker();
+	memset(&client, 0, sizeof(client));
+	client.in = -1;
+	client.out = -1;
+	client.git_cmd = 1;
+	client.argv = rpc->argv;
+	if (start_command(&client))
+		exit(1);
+	if (heads)
+		write_or_die(client.in, heads->buf, heads->len);
+
+	rpc->alloc = http_post_buffer;
+	rpc->buf = xmalloc(rpc->alloc);
+	rpc->in = client.in;
+	rpc->out = client.out;
+	strbuf_init(&rpc->result, 0);
+
+	strbuf_addf(&buf, "%s/%s", url, svc);
+	rpc->service_url = strbuf_detach(&buf, NULL);
+
+	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
+	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
+
+	strbuf_addf(&buf, "Accept: application/x-%s-response", svc);
+	rpc->hdr_accept = strbuf_detach(&buf, NULL);
+
+	while (!err) {
+		int n = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		if (!n)
+			break;
+		rpc->pos = 0;
+		rpc->len = n;
+		err |= post_rpc(rpc);
+	}
+	strbuf_read(&rpc->result, client.out, 0);
+
+	close(client.in);
+	close(client.out);
+	client.in = -1;
+	client.out = -1;
+
+	err |= finish_command(&client);
+	free(rpc->service_url);
+	free(rpc->hdr_content_type);
+	free(rpc->hdr_accept);
+	free(rpc->buf);
+	strbuf_release(&buf);
+	return err;
+}
+
 static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 {
 	char **targets = xmalloc(nr_heads * sizeof(char*));
@@ -371,6 +554,52 @@ static int push_dav(int nr_spec, char **specs)
 	return 0;
 }
 
+static int push_git(struct discovery *heads, int nr_spec, char **specs)
+{
+	struct rpc_state rpc;
+	const char **argv;
+	int argc = 0, i, err;
+
+	argv = xmalloc((10 + nr_spec) * sizeof(char*));
+	argv[argc++] = "send-pack";
+	argv[argc++] = "--stateless-rpc";
+	argv[argc++] = "--helper-status";
+	if (options.thin)
+		argv[argc++] = "--thin";
+	if (options.dry_run)
+		argv[argc++] = "--dry-run";
+	if (options.verbosity > 1)
+		argv[argc++] = "--verbose";
+	argv[argc++] = url;
+	for (i = 0; i < nr_spec; i++)
+		argv[argc++] = specs[i];
+	argv[argc++] = NULL;
+
+	memset(&rpc, 0, sizeof(rpc));
+	rpc.service_name = "git-receive-pack",
+	rpc.argv = argv;
+
+	err = rpc_service(&rpc, heads);
+	if (rpc.result.len)
+		safe_write(1, rpc.result.buf, rpc.result.len);
+	strbuf_release(&rpc.result);
+	free(argv);
+	return err;
+}
+
+static int push(int nr_spec, char **specs)
+{
+	struct discovery *heads = discover_refs("git-receive-pack");
+	int ret;
+
+	if (heads->proto_git)
+		ret = push_git(heads, nr_spec, specs);
+	else
+		ret = push_dav(nr_spec, specs);
+	free_discovery(heads);
+	return ret;
+}
+
 static void parse_push(struct strbuf *buf)
 {
 	char **specs = NULL;
@@ -391,7 +620,7 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);
 
-	if (push_dav(nr_spec, specs))
+	if (push(nr_spec, specs))
 		exit(128); /* error already reported */
 	for (i = 0; i < nr_spec; i++)
 		free(specs[i]);
@@ -414,6 +643,7 @@ int main(int argc, const char **argv)
 
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
+	options.thin = 1;
 
 	remote = remote_get(argv[1]);
 
diff --git a/send-pack.h b/send-pack.h
index 8b3cf02..28141ac 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -8,7 +8,8 @@ struct send_pack_args {
 		force_update:1,
 		use_thin_pack:1,
 		use_ofs_delta:1,
-		dry_run:1;
+		dry_run:1,
+		stateless_rpc:1;
 };
 
 int send_pack(struct send_pack_args *args,
diff --git a/sideband.c b/sideband.c
index 899b1ff..d5ffa1c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -135,9 +135,14 @@ ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet
 		n = sz;
 		if (packet_max - 5 < n)
 			n = packet_max - 5;
-		sprintf(hdr, "%04x", n + 5);
-		hdr[4] = band;
-		safe_write(fd, hdr, 5);
+		if (0 <= band) {
+			sprintf(hdr, "%04x", n + 5);
+			hdr[4] = band;
+			safe_write(fd, hdr, 5);
+		} else {
+			sprintf(hdr, "%04x", n + 4);
+			safe_write(fd, hdr, 4);
+		}
 		safe_write(fd, p, n);
 		p += n;
 		sz -= n;
diff --git a/transport.c b/transport.c
index 6d9652d..2ff1650 100644
--- a/transport.c
+++ b/transport.c
@@ -731,6 +731,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 				 NULL);
 	}
 
+	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
 	args.use_thin_pack = data->thin;
-- 
1.6.5.52.g0ff2e
