From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 12/16] Smart fetch and push over HTTP: server side
Date: Mon, 12 Oct 2009 19:25:11 -0700
Message-ID: <1255400715-10508-13-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDE-0004cs-K1
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbZJMC0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758827AbZJMC0k
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:40 -0400
Received: from george.spearce.org ([209.20.77.23]:56214 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758833AbZJMC0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:36 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B2D0638265; Tue, 13 Oct 2009 02:25:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 17971381FF
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 02:25:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130118>

Requests for $GIT_URL/git-receive-pack and $GIT_URL/git-upload-pack
are forwarded to the corresponding backend process by directly
executing it and leaving stdin and stdout connected to the invoking
web server.  Prior to starting the backend process the HTTP response
headers are sent, thereby freeing the backend from needing to know
about the HTTP protocol.

Requests that are encoded with Content-Encoding: gzip are
automatically inflated before being streamed into the backend.
This is primarily useful for the git-upload-pack backend, which
receives highly repetitive text data from clients that easily
compresses to 50% of its original size.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http-backend.c |  192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 191 insertions(+), 1 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 39cfd25..adb3256 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -77,6 +77,152 @@ static NORETURN void not_found(const char *err, ...)
 	exit(0);
 }
 
+static NORETURN void forbidden(const char *err, ...)
+{
+	va_list params;
+
+	write_status(403, "Forbidden");
+	write_nocache();
+	end_headers();
+
+	va_start(params, err);
+	if (err && *err) {
+		vsnprintf(buffer, sizeof(buffer), err, params);
+		fprintf(stderr, "%s\n", buffer);
+	}
+	va_end(params);
+	exit(0);
+}
+
+struct http_service {
+	const char *name;
+	const char *config_name;
+	int enabled;
+};
+static struct http_service *service;
+
+static struct http_service http_service[] = {
+	{ "upload-pack", "uploadpack", 1 },
+	{ "receive-pack", "receivepack", 0 },
+};
+
+static int http_config(const char *var, const char *value, void *cb)
+{
+	if (!prefixcmp(var, "http.") &&
+	    !strcmp(var + 5, service->config_name)) {
+		service->enabled = git_config_bool(var, value);
+		return 0;
+	}
+
+	/* we are not interested in parsing any other configuration here */
+	return 0;
+}
+
+static void select_service(const char *name)
+{
+	int i;
+
+	if (prefixcmp(name, "git-"))
+		forbidden("Unsupported service: '%s'", name);
+
+	for (i = 0; i < ARRAY_SIZE(http_service); i++) {
+		service = &http_service[i];
+		if (!strcmp(service->name, name + 4)) {
+			git_config(http_config, NULL);
+			if (!service->enabled)
+				forbidden("Service not enabled: '%s'", name);
+			return;
+		}
+	}
+	forbidden("Unsupported service: '%s'", name);
+}
+
+static void inflate_request(const char *prog_name, int out)
+{
+	z_stream stream;
+	unsigned char in_buf[8192];
+	unsigned char out_buf[8192];
+	unsigned long cnt = 0;
+	int ret;
+
+	memset(&stream, 0, sizeof(stream));
+	ret = inflateInit2(&stream, (15 + 16));
+	if (ret != Z_OK)
+		die("cannot start zlib inflater, zlib err %d", ret);
+
+	while (1) {
+		ssize_t n = xread(0, in_buf, sizeof(in_buf));
+		if (n <= 0)
+			die("request ended in the middle of the gzip stream");
+
+		stream.next_in = in_buf;
+		stream.avail_in = n;
+
+		while (0 < stream.avail_in) {
+			int ret;
+
+			stream.next_out = out_buf;
+			stream.avail_out = sizeof(out_buf);
+
+			ret = inflate(&stream, Z_NO_FLUSH);
+			if (ret != Z_OK && ret != Z_STREAM_END)
+				die("zlib error inflating request, result %d", ret);
+
+			n = stream.total_out - cnt;
+			if (write_in_full(out, out_buf, n) != n)
+				die("%s aborted reading request", prog_name);
+			cnt += n;
+
+			if (ret == Z_STREAM_END)
+				goto done;
+		}
+	}
+
+done:
+	inflateEnd(&stream);
+	close(out);
+}
+
+static void run_service(const char **argv)
+{
+	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
+	int use_gzip = 0;
+	struct child_process cld;
+
+	if (encoding && !strcmp(encoding, "gzip"))
+		use_gzip = 1;
+	else if (encoding && !strcmp(encoding, "x-gzip"))
+		use_gzip = 1;
+
+	memset(&cld, 0, sizeof(cld));
+	cld.argv = argv;
+	if (use_gzip)
+		cld.in = -1;
+	cld.git_cmd = 1;
+	if (start_command(&cld))
+		die_errno("Cannot start %s", argv[0]);
+
+	close(1);
+	if (use_gzip)
+		inflate_request(argv[0], cld.in);
+	else
+		close(0);
+
+	if (finish_command(&cld))
+		die("%s terminated with error", argv[0]);
+}
+
+static void require_content_type(const char *need_type)
+{
+	const char *input_type = getenv("CONTENT_TYPE");
+	if (!input_type || strcmp(input_type, need_type)) {
+		write_status(415, "Unsupported Media Type");
+		write_nocache();
+		end_headers();
+		exit(0);
+	}
+}
+
 static void write_file(const char *the_type, const char *name)
 {
 	const char *p = git_path("%s", name);
@@ -151,6 +297,25 @@ static int show_text_ref(const char *name, const unsigned char *sha1,
 
 static void get_info_refs(char *arg)
 {
+	char *query = getenv("QUERY_STRING");
+
+	if (query && !prefixcmp(query, "service=")) {
+		const char *argv[] = {NULL /* service name */,
+			"--one-shot-rpc", "--advertise-refs",
+			".", NULL};
+
+		select_service(query + 8);
+
+		write_nocache();
+		format_write("%s: application/x-git-%s-advertisement\r\n",
+			content_type, service->name);
+		end_headers();
+		packet_write(1, "# service=git-%s\n", service->name);
+
+		argv[0] = service->name;
+		run_service(argv);
+	}
+
 	write_nocache();
 	write_header(content_type, "text/plain; charset=utf-8");
 	end_headers();
@@ -176,6 +341,28 @@ static void get_info_packs(char *arg)
 	safe_write(1, "\n", 1);
 }
 
+static void post_to_service(char *service_name)
+{
+	const char *argv[] = {NULL, "--one-shot-rpc", ".", NULL};
+	unsigned n;
+
+	select_service(service_name);
+
+	n = snprintf(buffer, sizeof(buffer),
+		"application/x-git-%s-request", service->name);
+	if (n >= sizeof(buffer))
+		die("impossibly long service name");
+	require_content_type(buffer);
+
+	write_nocache();
+	format_write("%s: application/x-git-%s-result\r\n",
+		content_type, service->name);
+	end_headers();
+
+	argv[0] = service->name;
+	run_service(argv);
+}
+
 static NORETURN void die_webcgi(const char *err, va_list params)
 {
 	write_status(500, "Internal Server Error");
@@ -198,7 +385,10 @@ static struct service_cmd {
 	{"GET", "/objects/info/[^/]*$", get_text_file},
 	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
-	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file}
+	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
+
+	{"POST", "/git-upload-pack$", post_to_service},
+	{"POST", "/git-receive-pack$", post_to_service}
 };
 
 int main(int argc, char **argv)
-- 
1.6.5.52.g0ff2e
