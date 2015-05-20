From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] http-backend: spool ref negotiation requests to buffer
Date: Wed, 20 May 2015 03:37:09 -0400
Message-ID: <20150520073709.GC9818@peff.net>
References: <20150520073526.GA16784@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, gitster@pobox.com,
	git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Wed May 20 09:37:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuyZ9-0001Vn-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 09:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbbETHhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 03:37:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:33050 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751095AbbETHhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 03:37:12 -0400
Received: (qmail 19175 invoked by uid 102); 20 May 2015 07:37:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 02:37:12 -0500
Received: (qmail 21501 invoked by uid 107); 20 May 2015 07:37:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 03:37:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 03:37:09 -0400
Content-Disposition: inline
In-Reply-To: <20150520073526.GA16784@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269445>

When http-backend spawns "upload-pack" to do ref
negotiation, it streams the http request body to
upload-pack, who then streams the http response back to the
client as it reads. In theory, git can go full-duplex; the
client can consume our response while it is still sending
the request.  In practice, however, HTTP is a half-duplex
protocol. Even if our client is ready to read and write
simultaneously, we may have other HTTP infrastructure in the
way, including the webserver that spawns our CGI, or any
intermediate proxies.

In at least one documented case[1], this leads to deadlock
when trying a fetch over http. What happens is basically:

  1. Apache proxies the request to the CGI, http-backend.

  2. http-backend gzip-inflates the data and sends
     the result to upload-pack.

  3. upload-pack acts on the data and generates output over
     the pipe back to Apache. Apache isn't reading because
     it's busy writing (step 1).

This works fine most of the time, because the upload-pack
output ends up in a system pipe buffer, and Apache reads
it as soon as it finishes writing. But if both the request
and the response exceed the system pipe buffer size, then we
deadlock (Apache blocks writing to http-backend,
http-backend blocks writing to upload-pack, and upload-pack
blocks writing to Apache).

We need to break the deadlock by spooling either the input
or the output. In this case, it's ideal to spool the input,
because Apache does not start reading either stdout _or_
stderr until we have consumed all of the input. So until we
do so, we cannot even get an error message out to the
client.

The solution is fairly straight-forward: we read the request
body into an in-memory buffer in http-backend, freeing up
Apache, and then feed the data ourselves to upload-pack. But
there are a few important things to note:

  1. We limit the in-memory buffer to prevent an obvious
     denial-of-service attack. This is a new hard limit on
     requests, but it's unlikely to come into play. The
     default value is 10MB, which covers even the ridiculous
     100,000-ref negotation in the included test (that
     actually caps out just over 5MB). But it's configurable
     on the off chance that you don't mind spending some
     extra memory to make even ridiculous requests work.

  2. We must take care only to buffer when we have to. For
     pushes, the incoming packfile may be of arbitrary
     size, and we should connect the input directly to
     receive-pack. There's no deadlock problem here, though,
     because we do not produce any output until the whole
     packfile has been read.

     For upload-pack's initial ref advertisement, we
     similarly do not need to buffer. Even though we may
     generate a lot of output, there is no request body at
     all (i.e., it is a GET, not a POST).

[1] http://article.gmane.org/gmane.comp.version-control.git/269020

Test-adapted-from: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-http-backend.txt |  9 ++++
 http-backend.c                     | 97 +++++++++++++++++++++++++++++++++-----
 t/t5551-http-fetch-smart.sh        | 15 ++++++
 3 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index d422ba4..8c6acbe 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -255,6 +255,15 @@ The GIT_HTTP_EXPORT_ALL environmental variable may be passed to
 'git-http-backend' to bypass the check for the "git-daemon-export-ok"
 file in each repository before allowing export of that repository.
 
+The `GIT_HTTP_MAX_REQUEST_BUFFER` environment variable (or the
+`http.maxRequestBuffer` config variable) may be set to change the
+largest ref negotiation request that git will handle during a fetch; any
+fetch requiring a larger buffer will not succeed.  This value should not
+normally need to be changed, but may be helpful if you are fetching from
+a repository with an extremely large number of refs.  The value can be
+specified with a unit (e.g., `100M` for 100 megabytes). The default is
+10 megabytes.
+
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by 'git-receive-pack' contain some
diff --git a/http-backend.c b/http-backend.c
index 3ad82a8..d1333b8 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -13,18 +13,20 @@ static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
 static const char last_modified[] = "Last-Modified";
 static int getanyfile = 1;
+static unsigned long max_request_buffer = 10 * 1024 * 1024;
 
 static struct string_list *query_params;
 
 struct rpc_service {
 	const char *name;
 	const char *config_name;
+	unsigned buffer_input : 1;
 	signed enabled : 2;
 };
 
 static struct rpc_service rpc_service[] = {
-	{ "upload-pack", "uploadpack", 1 },
-	{ "receive-pack", "receivepack", -1 },
+	{ "upload-pack", "uploadpack", 1, 1 },
+	{ "receive-pack", "receivepack", 0, -1 },
 };
 
 static struct string_list *get_parameters(void)
@@ -225,6 +227,7 @@ static void http_config(void)
 	struct strbuf var = STRBUF_INIT;
 
 	git_config_get_bool("http.getanyfile", &getanyfile);
+	git_config_get_ulong("http.maxrequestbuffer", &max_request_buffer);
 
 	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 		struct rpc_service *svc = &rpc_service[i];
@@ -266,9 +269,53 @@ static struct rpc_service *select_service(const char *name)
 	return svc;
 }
 
-static void inflate_request(const char *prog_name, int out)
+/*
+ * This is basically strbuf_read(), except that if we
+ * hit max_request_buffer we die (we'd rather reject a
+ * maliciously large request than chew up infinite memory).
+ */
+static ssize_t read_request(int fd, unsigned char **out)
+{
+	size_t len = 0, alloc = 8192;
+	unsigned char *buf = xmalloc(alloc);
+
+	if (max_request_buffer < alloc)
+		max_request_buffer = alloc;
+
+	while (1) {
+		ssize_t cnt;
+
+		cnt = read_in_full(fd, buf + len, alloc - len);
+		if (cnt < 0) {
+			free(buf);
+			return -1;
+		}
+
+		/* partial read from read_in_full means we hit EOF */
+		len += cnt;
+		if (len < alloc) {
+			*out = buf;
+			warning("request size was %lu", (unsigned long)len);
+			return len;
+		}
+
+		/* otherwise, grow and try again (if we can) */
+		if (alloc == max_request_buffer)
+			die("request was larger than our maximum size (%lu);"
+			    " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
+			    max_request_buffer);
+
+		alloc = alloc_nr(alloc);
+		if (alloc > max_request_buffer)
+			alloc = max_request_buffer;
+		REALLOC_ARRAY(buf, alloc);
+	}
+}
+
+static void inflate_request(const char *prog_name, int out, int buffer_input)
 {
 	git_zstream stream;
+	unsigned char *full_request = NULL;
 	unsigned char in_buf[8192];
 	unsigned char out_buf[8192];
 	unsigned long cnt = 0;
@@ -277,11 +324,21 @@ static void inflate_request(const char *prog_name, int out)
 	git_inflate_init_gzip_only(&stream);
 
 	while (1) {
-		ssize_t n = xread(0, in_buf, sizeof(in_buf));
+		ssize_t n;
+
+		if (buffer_input) {
+			if (full_request)
+				n = 0; /* nothing left to read */
+			else
+				n = read_request(0, &full_request);
+			stream.next_in = full_request;
+		} else {
+			n = xread(0, in_buf, sizeof(in_buf));
+			stream.next_in = in_buf;
+		}
+
 		if (n <= 0)
 			die("request ended in the middle of the gzip stream");
-
-		stream.next_in = in_buf;
 		stream.avail_in = n;
 
 		while (0 < stream.avail_in) {
@@ -307,9 +364,22 @@ static void inflate_request(const char *prog_name, int out)
 done:
 	git_inflate_end(&stream);
 	close(out);
+	free(full_request);
+}
+
+static void copy_request(const char *prog_name, int out)
+{
+	unsigned char *buf;
+	ssize_t n = read_request(0, &buf);
+	if (n < 0)
+		die_errno("error reading request body");
+	if (write_in_full(out, buf, n) != n)
+		die("%s aborted reading request", prog_name);
+	close(out);
+	free(buf);
 }
 
-static void run_service(const char **argv)
+static void run_service(const char **argv, int buffer_input)
 {
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
 	const char *user = getenv("REMOTE_USER");
@@ -334,7 +404,7 @@ static void run_service(const char **argv)
 				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	cld.argv = argv;
-	if (gzipped_request)
+	if (buffer_input || gzipped_request)
 		cld.in = -1;
 	cld.git_cmd = 1;
 	if (start_command(&cld))
@@ -342,7 +412,9 @@ static void run_service(const char **argv)
 
 	close(1);
 	if (gzipped_request)
-		inflate_request(argv[0], cld.in);
+		inflate_request(argv[0], cld.in, buffer_input);
+	else if (buffer_input)
+		copy_request(argv[0], cld.in);
 	else
 		close(0);
 
@@ -392,7 +464,7 @@ static void get_info_refs(char *arg)
 		packet_flush(1);
 
 		argv[0] = svc->name;
-		run_service(argv);
+		run_service(argv, 0);
 
 	} else {
 		select_getanyfile();
@@ -496,7 +568,7 @@ static void service_rpc(char *service_name)
 	end_headers();
 
 	argv[0] = svc->name;
-	run_service(argv);
+	run_service(argv, svc->buffer_input);
 	strbuf_release(&buf);
 }
 
@@ -623,6 +695,9 @@ int main(int argc, char **argv)
 		not_found("Repository not exported: '%s'", dir);
 
 	http_config();
+	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
+					   max_request_buffer);
+
 	cmd->imp(cmd_arg);
 	return 0;
 }
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index c83cdf4..a540c6d 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -273,5 +273,20 @@ test_expect_success 'large fetch-pack requests can be split across POSTs' '
 	test_line_count = 2 posts
 '
 
+test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		create_tags 2001 50000
+	) &&
+	git -C too-many-refs fetch -q --tags &&
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		create_tags 50001 100000
+	) &&
+	git -C too-many-refs fetch -q --tags &&
+	git -C too-many-refs for-each-ref refs/tags >tags &&
+	test_line_count = 100000 tags
+'
+
 stop_httpd
 test_done
-- 
2.4.1.396.g7ba6d7b
