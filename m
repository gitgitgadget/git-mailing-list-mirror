From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 15/26] Smart fetch and push over HTTP: server side
Date: Wed, 28 Oct 2009 17:00:37 -0700
Message-ID: <1256774448-7625-16-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISl-0000kN-Jj
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbZJ2ABB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973AbZJ2ABA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:00 -0400
Received: from george.spearce.org ([209.20.77.23]:36246 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721AbZJ2AAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 26A0B38215; Thu, 29 Oct 2009 00:00:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6E1CF38222
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:00:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131519>

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
 Documentation/git-http-backend.txt |   39 +++++-
 http-backend.c                     |  324 +++++++++++++++++++++++++++++++++++-
 2 files changed, 359 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 867675f..022a243 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -22,6 +22,23 @@ By default, only the `upload-pack` service is enabled, which serves
 This is ideally suited for read-only updates, i.e., pulling from
 git repositories.
 
+SERVICES
+--------
+These services can be enabled/disabled using the per-repository
+configuration file:
+
+http.uploadpack::
+	This serves 'git-fetch-pack' and 'git-ls-remote' clients.
+	It is enabled by default, but a repository can disable it
+	by setting this configuration item to `false`.
+
+http.receivepack::
+	This serves 'git-send-pack' clients, allowing push.  It is
+	disabled by default for anonymous users, and enabled by
+	default for users authenticated by the web server.  It can be
+	disabled by setting this item to `false`, or enabled for all
+	users, including anonymous users, by setting it to `true`.
+
 URL TRANSLATION
 ---------------
 'git-http-backend' relies on the invoking web server to perform
@@ -49,7 +66,19 @@ ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/git/
 </Files>
 ----------------------------------------------------------------
 +
-To require authentication for reads, use a Directory
+To enable anonymous read access but authenticated write access,
+require authorization with a LocationMatch directive:
++
+----------------------------------------------------------------
+<LocationMatch ".*/git-receive-pack$">
+	AuthType Basic
+	AuthName "Git Access"
+	Require group committers
+	...
+</LocationMatch>
+----------------------------------------------------------------
++
+To require authentication for both reads and writes, use a Directory
 directive around the repository, or one of its parent directories:
 +
 ----------------------------------------------------------------
@@ -92,6 +121,14 @@ by the invoking web server, including:
 * QUERY_STRING
 * REQUEST_METHOD
 
+The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
+GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
+ensuring that any reflogs created by 'git-receive-pack' contain some
+identifying information of the remote user who performed the push.
+
+All CGI environment variables are available to each of the hooks
+invoked by the 'git-receive-pack'.
+
 Author
 ------
 Written by Shawn O. Pearce <spearce@spearce.org>.
diff --git a/http-backend.c b/http-backend.c
index 374f60d..67030b5 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -4,11 +4,109 @@
 #include "object.h"
 #include "tag.h"
 #include "exec_cmd.h"
+#include "run-command.h"
+#include "string-list.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
 static const char last_modified[] = "Last-Modified";
 
+static struct string_list *query_params;
+
+struct rpc_service {
+	const char *name;
+	const char *config_name;
+	signed enabled : 2;
+};
+
+static struct rpc_service rpc_service[] = {
+	{ "upload-pack", "uploadpack", 1 },
+	{ "receive-pack", "receivepack", -1 },
+};
+
+static int decode_char(const char *q)
+{
+	int i;
+	unsigned char val = 0;
+	for (i = 0; i < 2; i++) {
+		unsigned char c = *q++;
+		val <<= 4;
+		if (c >= '0' && c <= '9')
+			val += c - '0';
+		else if (c >= 'a' && c <= 'f')
+			val += c - 'a' + 10;
+		else if (c >= 'A' && c <= 'F')
+			val += c - 'A' + 10;
+		else
+			return -1;
+	}
+	return val;
+}
+
+static char *decode_parameter(const char **query, int is_name)
+{
+	const char *q = *query;
+	struct strbuf out;
+
+	strbuf_init(&out, 16);
+	do {
+		unsigned char c = *q;
+
+		if (!c)
+			break;
+		if (c == '&' || (is_name && c == '=')) {
+			q++;
+			break;
+		}
+
+		if (c == '%') {
+			int val = decode_char(q + 1);
+			if (0 <= val) {
+				strbuf_addch(&out, val);
+				q += 3;
+				continue;
+			}
+		}
+
+		if (c == '+')
+			strbuf_addch(&out, ' ');
+		else
+			strbuf_addch(&out, c);
+		q++;
+	} while (1);
+	*query = q;
+	return strbuf_detach(&out, NULL);
+}
+
+static struct string_list *get_parameters(void)
+{
+	if (!query_params) {
+		const char *query = getenv("QUERY_STRING");
+
+		query_params = xcalloc(1, sizeof(*query_params));
+		while (query && *query) {
+			char *name = decode_parameter(&query, 1);
+			char *value = decode_parameter(&query, 0);
+			struct string_list_item *i;
+
+			i = string_list_lookup(name, query_params);
+			if (!i)
+				i = string_list_insert(name, query_params);
+			else
+				free(i->util);
+			i->util = value;
+		}
+	}
+	return query_params;
+}
+
+static const char *get_parameter(const char *name)
+{
+	struct string_list_item *i;
+	i = string_list_lookup(name, get_parameters());
+	return i ? i->util : NULL;
+}
+
 static void format_write(int fd, const char *fmt, ...)
 {
 	static char buffer[1024];
@@ -81,6 +179,21 @@ static NORETURN void not_found(const char *err, ...)
 	exit(0);
 }
 
+static NORETURN void forbidden(const char *err, ...)
+{
+	va_list params;
+
+	http_status(403, "Forbidden");
+	hdr_nocache();
+	end_headers();
+
+	va_start(params, err);
+	if (err && *err)
+		vfprintf(stderr, err, params);
+	va_end(params);
+	exit(0);
+}
+
 static void send_strbuf(const char *type, struct strbuf *buf)
 {
 	hdr_int(content_length, buf->len);
@@ -147,6 +260,145 @@ static void get_idx_file(char *name)
 	send_file("application/x-git-packed-objects-toc", name);
 }
 
+static int http_config(const char *var, const char *value, void *cb)
+{
+	struct rpc_service *svc = cb;
+
+	if (!prefixcmp(var, "http.") &&
+	    !strcmp(var + 5, svc->config_name)) {
+		svc->enabled = git_config_bool(var, value);
+		return 0;
+	}
+
+	/* we are not interested in parsing any other configuration here */
+	return 0;
+}
+
+static struct rpc_service *select_service(const char *name)
+{
+	struct rpc_service *svc = NULL;
+	int i;
+
+	if (prefixcmp(name, "git-"))
+		forbidden("Unsupported service: '%s'", name);
+
+	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
+		struct rpc_service *s = &rpc_service[i];
+		if (!strcmp(s->name, name + 4)) {
+			svc = s;
+			break;
+		}
+	}
+
+	if (!svc)
+		forbidden("Unsupported service: '%s'", name);
+
+	git_config(http_config, svc);
+	if (svc->enabled < 0) {
+		const char *user = getenv("REMOTE_USER");
+		svc->enabled = (user && *user) ? 1 : 0;
+	}
+	if (!svc->enabled)
+		forbidden("Service not enabled: '%s'", svc->name);
+	return svc;
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
+	const char *user = getenv("REMOTE_USER");
+	const char *host = getenv("REMOTE_ADDR");
+	char *env[3];
+	struct strbuf buf = STRBUF_INIT;
+	int gzipped_request = 0;
+	struct child_process cld;
+
+	if (encoding && !strcmp(encoding, "gzip"))
+		gzipped_request = 1;
+	else if (encoding && !strcmp(encoding, "x-gzip"))
+		gzipped_request = 1;
+
+	if (!user || !*user)
+		user = "anonymous";
+	if (!host || !*host)
+		host = "(none)";
+
+	memset(&env, 0, sizeof(env));
+	strbuf_addf(&buf, "GIT_COMMITTER_NAME=%s", user);
+	env[0] = strbuf_detach(&buf, NULL);
+
+	strbuf_addf(&buf, "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
+	env[1] = strbuf_detach(&buf, NULL);
+	env[2] = NULL;
+
+	memset(&cld, 0, sizeof(cld));
+	cld.argv = argv;
+	cld.env = (const char *const *)env;
+	if (gzipped_request)
+		cld.in = -1;
+	cld.git_cmd = 1;
+	if (start_command(&cld))
+		exit(1);
+
+	close(1);
+	if (gzipped_request)
+		inflate_request(argv[0], cld.in);
+	else
+		close(0);
+
+	if (finish_command(&cld))
+		exit(1);
+	free(env[0]);
+	free(env[1]);
+	strbuf_release(&buf);
+}
+
 static int show_text_ref(const char *name, const unsigned char *sha1,
 	int flag, void *cb_data)
 {
@@ -167,11 +419,32 @@ static int show_text_ref(const char *name, const unsigned char *sha1,
 
 static void get_info_refs(char *arg)
 {
+	const char *service_name = get_parameter("service");
 	struct strbuf buf = STRBUF_INIT;
 
-	for_each_ref(show_text_ref, &buf);
 	hdr_nocache();
-	send_strbuf("text/plain", &buf);
+
+	if (service_name) {
+		const char *argv[] = {NULL /* service name */,
+			"--stateless-rpc", "--advertise-refs",
+			".", NULL};
+		struct rpc_service *svc = select_service(service_name);
+
+		strbuf_addf(&buf, "application/x-git-%s-advertisement",
+			svc->name);
+		hdr_str(content_type, buf.buf);
+		end_headers();
+
+		packet_write(1, "# service=git-%s\n", svc->name);
+		packet_flush(1);
+
+		argv[0] = svc->name;
+		run_service(argv);
+
+	} else {
+		for_each_ref(show_text_ref, &buf);
+		send_strbuf("text/plain", &buf);
+	}
 	strbuf_release(&buf);
 }
 
@@ -200,6 +473,48 @@ static void get_info_packs(char *arg)
 	strbuf_release(&buf);
 }
 
+static void check_content_type(const char *accepted_type)
+{
+	const char *actual_type = getenv("CONTENT_TYPE");
+
+	if (!actual_type)
+		actual_type = "";
+
+	if (strcmp(actual_type, accepted_type)) {
+		http_status(415, "Unsupported Media Type");
+		hdr_nocache();
+		end_headers();
+		format_write(1,
+			"Expected POST with Content-Type '%s',"
+			" but received '%s' instead.\n",
+			accepted_type, actual_type);
+		exit(0);
+	}
+}
+
+static void service_rpc(char *service_name)
+{
+	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
+	struct rpc_service *svc = select_service(service_name);
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
+	check_content_type(buf.buf);
+
+	hdr_nocache();
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "application/x-git-%s-result", svc->name);
+	hdr_str(content_type, buf.buf);
+
+	end_headers();
+
+	argv[0] = svc->name;
+	run_service(argv);
+	strbuf_release(&buf);
+}
+
 static NORETURN void die_webcgi(const char *err, va_list params)
 {
 	char buffer[1000];
@@ -226,7 +541,10 @@ static struct service_cmd {
 	{"GET", "/objects/info/[^/]*$", get_text_file},
 	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
-	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file}
+	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
+
+	{"POST", "/git-upload-pack$", service_rpc},
+	{"POST", "/git-receive-pack$", service_rpc}
 };
 
 int main(int argc, char **argv)
-- 
1.6.5.2.181.gd6f41
