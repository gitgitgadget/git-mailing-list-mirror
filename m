Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F0F1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 23:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbcHIXrd (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 19:47:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50466 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbcHIXrc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 19:47:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C58B1F859;
	Tue,  9 Aug 2016 23:47:31 +0000 (UTC)
Date:	Tue, 9 Aug 2016 23:47:31 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH] http-backend: buffer headers before sending
Message-ID: <20160809234731.GA10310@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Avoid waking up the readers for unnecessary context switches for
each line of header data being written, as all the headers are
written in short succession.

It is unlikely any HTTP/1.x server would want to read a CGI
response one-line-at-a-time and trickle each to the client.
Instead, I'd expect HTTP servers want to minimize syscall and
TCP/IP framing overhead by trying to send all of its response
headers in a single syscall or even combining the headers and
first chunk of the body with MSG_MORE or writev.

Verified by strace-ing response parsing on the CGI side.

Signed-off-by: Eric Wong <e@80x24.org>
---
  I admit I only noticed this because I was being lazy when
  implementing the reader-side on an HTTP server by making
  a single read(2) call :x

 http-backend.c | 220 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 116 insertions(+), 104 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 0d59499..adc8c8c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -75,55 +75,57 @@ static void format_write(int fd, const char *fmt, ...)
 	write_or_die(fd, buffer, n);
 }
 
-static void http_status(unsigned code, const char *msg)
+static void http_status(struct strbuf *hdr, unsigned code, const char *msg)
 {
-	format_write(1, "Status: %u %s\r\n", code, msg);
+	strbuf_addf(hdr, "Status: %u %s\r\n", code, msg);
 }
 
-static void hdr_str(const char *name, const char *value)
+static void hdr_str(struct strbuf *hdr, const char *name, const char *value)
 {
-	format_write(1, "%s: %s\r\n", name, value);
+	strbuf_addf(hdr, "%s: %s\r\n", name, value);
 }
 
-static void hdr_int(const char *name, uintmax_t value)
+static void hdr_int(struct strbuf *hdr, const char *name, uintmax_t value)
 {
-	format_write(1, "%s: %" PRIuMAX "\r\n", name, value);
+	strbuf_addf(hdr, "%s: %" PRIuMAX "\r\n", name, value);
 }
 
-static void hdr_date(const char *name, unsigned long when)
+static void hdr_date(struct strbuf *hdr, const char *name, unsigned long when)
 {
 	const char *value = show_date(when, 0, DATE_MODE(RFC2822));
-	hdr_str(name, value);
+	hdr_str(hdr, name, value);
 }
 
-static void hdr_nocache(void)
+static void hdr_nocache(struct strbuf *hdr)
 {
-	hdr_str("Expires", "Fri, 01 Jan 1980 00:00:00 GMT");
-	hdr_str("Pragma", "no-cache");
-	hdr_str("Cache-Control", "no-cache, max-age=0, must-revalidate");
+	hdr_str(hdr, "Expires", "Fri, 01 Jan 1980 00:00:00 GMT");
+	hdr_str(hdr, "Pragma", "no-cache");
+	hdr_str(hdr, "Cache-Control", "no-cache, max-age=0, must-revalidate");
 }
 
-static void hdr_cache_forever(void)
+static void hdr_cache_forever(struct strbuf *hdr)
 {
 	unsigned long now = time(NULL);
-	hdr_date("Date", now);
-	hdr_date("Expires", now + 31536000);
-	hdr_str("Cache-Control", "public, max-age=31536000");
+	hdr_date(hdr, "Date", now);
+	hdr_date(hdr, "Expires", now + 31536000);
+	hdr_str(hdr, "Cache-Control", "public, max-age=31536000");
 }
 
-static void end_headers(void)
+static void end_headers(struct strbuf *hdr)
 {
-	write_or_die(1, "\r\n", 2);
+	strbuf_add(hdr, "\r\n", 2);
+	write_or_die(1, hdr->buf, hdr->len);
+	strbuf_release(hdr);
 }
 
-__attribute__((format (printf, 1, 2)))
-static NORETURN void not_found(const char *err, ...)
+__attribute__((format (printf, 2, 3)))
+static NORETURN void not_found(struct strbuf *hdr, const char *err, ...)
 {
 	va_list params;
 
-	http_status(404, "Not Found");
-	hdr_nocache();
-	end_headers();
+	http_status(hdr, 404, "Not Found");
+	hdr_nocache(hdr);
+	end_headers(hdr);
 
 	va_start(params, err);
 	if (err && *err)
@@ -132,14 +134,14 @@ static NORETURN void not_found(const char *err, ...)
 	exit(0);
 }
 
-__attribute__((format (printf, 1, 2)))
-static NORETURN void forbidden(const char *err, ...)
+__attribute__((format (printf, 2, 3)))
+static NORETURN void forbidden(struct strbuf *hdr, const char *err, ...)
 {
 	va_list params;
 
-	http_status(403, "Forbidden");
-	hdr_nocache();
-	end_headers();
+	http_status(hdr, 403, "Forbidden");
+	hdr_nocache(hdr);
+	end_headers(hdr);
 
 	va_start(params, err);
 	if (err && *err)
@@ -148,21 +150,23 @@ static NORETURN void forbidden(const char *err, ...)
 	exit(0);
 }
 
-static void select_getanyfile(void)
+static void select_getanyfile(struct strbuf *hdr)
 {
 	if (!getanyfile)
-		forbidden("Unsupported service: getanyfile");
+		forbidden(hdr, "Unsupported service: getanyfile");
 }
 
-static void send_strbuf(const char *type, struct strbuf *buf)
+static void send_strbuf(struct strbuf *hdr,
+			const char *type, struct strbuf *buf)
 {
-	hdr_int(content_length, buf->len);
-	hdr_str(content_type, type);
-	end_headers();
+	hdr_int(hdr, content_length, buf->len);
+	hdr_str(hdr, content_type, type);
+	end_headers(hdr);
 	write_or_die(1, buf->buf, buf->len);
 }
 
-static void send_local_file(const char *the_type, const char *name)
+static void send_local_file(struct strbuf *hdr, const char *the_type,
+				const char *name)
 {
 	char *p = git_pathdup("%s", name);
 	size_t buf_alloc = 8192;
@@ -172,14 +176,14 @@ static void send_local_file(const char *the_type, const char *name)
 
 	fd = open(p, O_RDONLY);
 	if (fd < 0)
-		not_found("Cannot open '%s': %s", p, strerror(errno));
+		not_found(hdr, "Cannot open '%s': %s", p, strerror(errno));
 	if (fstat(fd, &sb) < 0)
 		die_errno("Cannot stat '%s'", p);
 
-	hdr_int(content_length, sb.st_size);
-	hdr_str(content_type, the_type);
-	hdr_date(last_modified, sb.st_mtime);
-	end_headers();
+	hdr_int(hdr, content_length, sb.st_size);
+	hdr_str(hdr, content_type, the_type);
+	hdr_date(hdr, last_modified, sb.st_mtime);
+	end_headers(hdr);
 
 	for (;;) {
 		ssize_t n = xread(fd, buf, buf_alloc);
@@ -194,32 +198,32 @@ static void send_local_file(const char *the_type, const char *name)
 	free(p);
 }
 
-static void get_text_file(char *name)
+static void get_text_file(struct strbuf *hdr, char *name)
 {
-	select_getanyfile();
-	hdr_nocache();
-	send_local_file("text/plain", name);
+	select_getanyfile(hdr);
+	hdr_nocache(hdr);
+	send_local_file(hdr, "text/plain", name);
 }
 
-static void get_loose_object(char *name)
+static void get_loose_object(struct strbuf *hdr, char *name)
 {
-	select_getanyfile();
-	hdr_cache_forever();
-	send_local_file("application/x-git-loose-object", name);
+	select_getanyfile(hdr);
+	hdr_cache_forever(hdr);
+	send_local_file(hdr, "application/x-git-loose-object", name);
 }
 
-static void get_pack_file(char *name)
+static void get_pack_file(struct strbuf *hdr, char *name)
 {
-	select_getanyfile();
-	hdr_cache_forever();
-	send_local_file("application/x-git-packed-objects", name);
+	select_getanyfile(hdr);
+	hdr_cache_forever(hdr);
+	send_local_file(hdr, "application/x-git-packed-objects", name);
 }
 
-static void get_idx_file(char *name)
+static void get_idx_file(struct strbuf *hdr, char *name)
 {
-	select_getanyfile();
-	hdr_cache_forever();
-	send_local_file("application/x-git-packed-objects-toc", name);
+	select_getanyfile(hdr);
+	hdr_cache_forever(hdr);
+	send_local_file(hdr, "application/x-git-packed-objects-toc", name);
 }
 
 static void http_config(void)
@@ -241,14 +245,14 @@ static void http_config(void)
 	strbuf_release(&var);
 }
 
-static struct rpc_service *select_service(const char *name)
+static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
 {
 	const char *svc_name;
 	struct rpc_service *svc = NULL;
 	int i;
 
 	if (!skip_prefix(name, "git-", &svc_name))
-		forbidden("Unsupported service: '%s'", name);
+		forbidden(hdr, "Unsupported service: '%s'", name);
 
 	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 		struct rpc_service *s = &rpc_service[i];
@@ -259,14 +263,14 @@ static struct rpc_service *select_service(const char *name)
 	}
 
 	if (!svc)
-		forbidden("Unsupported service: '%s'", name);
+		forbidden(hdr, "Unsupported service: '%s'", name);
 
 	if (svc->enabled < 0) {
 		const char *user = getenv("REMOTE_USER");
 		svc->enabled = (user && *user) ? 1 : 0;
 	}
 	if (!svc->enabled)
-		forbidden("Service not enabled: '%s'", svc->name);
+		forbidden(hdr, "Service not enabled: '%s'", svc->name);
 	return svc;
 }
 
@@ -442,23 +446,23 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 	return 0;
 }
 
-static void get_info_refs(char *arg)
+static void get_info_refs(struct strbuf *hdr, char *arg)
 {
 	const char *service_name = get_parameter("service");
 	struct strbuf buf = STRBUF_INIT;
 
-	hdr_nocache();
+	hdr_nocache(hdr);
 
 	if (service_name) {
 		const char *argv[] = {NULL /* service name */,
 			"--stateless-rpc", "--advertise-refs",
 			".", NULL};
-		struct rpc_service *svc = select_service(service_name);
+		struct rpc_service *svc = select_service(hdr, service_name);
 
 		strbuf_addf(&buf, "application/x-git-%s-advertisement",
 			svc->name);
-		hdr_str(content_type, buf.buf);
-		end_headers();
+		hdr_str(hdr, content_type, buf.buf);
+		end_headers(hdr);
 
 		packet_write(1, "# service=git-%s\n", svc->name);
 		packet_flush(1);
@@ -467,9 +471,9 @@ static void get_info_refs(char *arg)
 		run_service(argv, 0);
 
 	} else {
-		select_getanyfile();
+		select_getanyfile(hdr);
 		for_each_namespaced_ref(show_text_ref, &buf);
-		send_strbuf("text/plain", &buf);
+		send_strbuf(hdr, "text/plain", &buf);
 	}
 	strbuf_release(&buf);
 }
@@ -494,24 +498,24 @@ static int show_head_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static void get_head(char *arg)
+static void get_head(struct strbuf *hdr, char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	select_getanyfile();
+	select_getanyfile(hdr);
 	head_ref_namespaced(show_head_ref, &buf);
-	send_strbuf("text/plain", &buf);
+	send_strbuf(hdr, "text/plain", &buf);
 	strbuf_release(&buf);
 }
 
-static void get_info_packs(char *arg)
+static void get_info_packs(struct strbuf *hdr, char *arg)
 {
 	size_t objdirlen = strlen(get_object_directory());
 	struct strbuf buf = STRBUF_INIT;
 	struct packed_git *p;
 	size_t cnt = 0;
 
-	select_getanyfile();
+	select_getanyfile(hdr);
 	prepare_packed_git();
 	for (p = packed_git; p; p = p->next) {
 		if (p->pack_local)
@@ -525,12 +529,12 @@ static void get_info_packs(char *arg)
 	}
 	strbuf_addch(&buf, '\n');
 
-	hdr_nocache();
-	send_strbuf("text/plain; charset=utf-8", &buf);
+	hdr_nocache(hdr);
+	send_strbuf(hdr, "text/plain; charset=utf-8", &buf);
 	strbuf_release(&buf);
 }
 
-static void check_content_type(const char *accepted_type)
+static void check_content_type(struct strbuf *hdr, const char *accepted_type)
 {
 	const char *actual_type = getenv("CONTENT_TYPE");
 
@@ -538,9 +542,9 @@ static void check_content_type(const char *accepted_type)
 		actual_type = "";
 
 	if (strcmp(actual_type, accepted_type)) {
-		http_status(415, "Unsupported Media Type");
-		hdr_nocache();
-		end_headers();
+		http_status(hdr, 415, "Unsupported Media Type");
+		hdr_nocache(hdr);
+		end_headers(hdr);
 		format_write(1,
 			"Expected POST with Content-Type '%s',"
 			" but received '%s' instead.\n",
@@ -549,23 +553,23 @@ static void check_content_type(const char *accepted_type)
 	}
 }
 
-static void service_rpc(char *service_name)
+static void service_rpc(struct strbuf *hdr, char *service_name)
 {
 	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
-	struct rpc_service *svc = select_service(service_name);
+	struct rpc_service *svc = select_service(hdr, service_name);
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
-	check_content_type(buf.buf);
+	check_content_type(hdr, buf.buf);
 
-	hdr_nocache();
+	hdr_nocache(hdr);
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-result", svc->name);
-	hdr_str(content_type, buf.buf);
+	hdr_str(hdr, content_type, buf.buf);
 
-	end_headers();
+	end_headers(hdr);
 
 	argv[0] = svc->name;
 	run_service(argv, svc->buffer_input);
@@ -576,11 +580,13 @@ static int dead;
 static NORETURN void die_webcgi(const char *err, va_list params)
 {
 	if (dead <= 1) {
+		struct strbuf hdr = STRBUF_INIT;
+
 		vreportf("fatal: ", err, params);
 
-		http_status(500, "Internal Server Error");
-		hdr_nocache();
-		end_headers();
+		http_status(&hdr, 500, "Internal Server Error");
+		hdr_nocache(&hdr);
+		end_headers(&hdr);
 	}
 	exit(0); /* we successfully reported a failure ;-) */
 }
@@ -617,7 +623,7 @@ static char* getdir(void)
 static struct service_cmd {
 	const char *method;
 	const char *pattern;
-	void (*imp)(char *);
+	void (*imp)(struct strbuf *, char *);
 } services[] = {
 	{"GET", "/HEAD$", get_head},
 	{"GET", "/info/refs$", get_info_refs},
@@ -632,6 +638,21 @@ static struct service_cmd {
 	{"POST", "/git-receive-pack$", service_rpc}
 };
 
+static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
+{
+	const char *proto = getenv("SERVER_PROTOCOL");
+
+	if (proto && !strcmp(proto, "HTTP/1.1")) {
+		http_status(hdr, 405, "Method Not Allowed");
+		hdr_str(hdr, "Allow",
+			!strcmp(c->method, "GET") ? "GET, HEAD" : c->method);
+	} else
+		http_status(hdr, 400, "Bad Request");
+	hdr_nocache(hdr);
+	end_headers(hdr);
+	return 0;
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	char *method = getenv("REQUEST_METHOD");
@@ -639,6 +660,7 @@ int cmd_main(int argc, const char **argv)
 	struct service_cmd *cmd = NULL;
 	char *cmd_arg = NULL;
 	int i;
+	struct strbuf hdr = STRBUF_INIT;
 
 	set_die_routine(die_webcgi);
 	set_die_is_recursing_routine(die_webcgi_recursing);
@@ -659,18 +681,8 @@ int cmd_main(int argc, const char **argv)
 		if (!regexec(&re, dir, 1, out, 0)) {
 			size_t n;
 
-			if (strcmp(method, c->method)) {
-				const char *proto = getenv("SERVER_PROTOCOL");
-				if (proto && !strcmp(proto, "HTTP/1.1")) {
-					http_status(405, "Method Not Allowed");
-					hdr_str("Allow", !strcmp(c->method, "GET") ?
-						"GET, HEAD" : c->method);
-				} else
-					http_status(400, "Bad Request");
-				hdr_nocache();
-				end_headers();
-				return 0;
-			}
+			if (strcmp(method, c->method))
+				return bad_request(&hdr, c);
 
 			cmd = c;
 			n = out[0].rm_eo - out[0].rm_so;
@@ -682,19 +694,19 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (!cmd)
-		not_found("Request not supported: '%s'", dir);
+		not_found(&hdr, "Request not supported: '%s'", dir);
 
 	setup_path();
 	if (!enter_repo(dir, 0))
-		not_found("Not a git repository: '%s'", dir);
+		not_found(&hdr, "Not a git repository: '%s'", dir);
 	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
 	    access("git-daemon-export-ok", F_OK) )
-		not_found("Repository not exported: '%s'", dir);
+		not_found(&hdr, "Repository not exported: '%s'", dir);
 
 	http_config();
 	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
 					   max_request_buffer);
 
-	cmd->imp(cmd_arg);
+	cmd->imp(&hdr, cmd_arg);
 	return 0;
 }
-- 
EW
