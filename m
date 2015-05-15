From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] http-backend: spool ref negotiation requests to buffer
Date: Fri, 15 May 2015 02:33:39 -0400
Message-ID: <20150515063339.GB30890@peff.net>
References: <20150515062901.GA30768@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 08:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt9Br-0003vW-G5
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 08:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbbEOGdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 02:33:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:59054 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751221AbbEOGdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 02:33:42 -0400
Received: (qmail 23099 invoked by uid 102); 15 May 2015 06:33:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 01:33:42 -0500
Received: (qmail 31502 invoked by uid 107); 15 May 2015 06:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 02:33:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 02:33:39 -0400
Content-Disposition: inline
In-Reply-To: <20150515062901.GA30768@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269130>

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

  1. We limit in-memory buffer to no larger than 1 megabyte
     to prevent an obvious denial-of-service attack. This
     is a new hard limit on requests, but it's likely that
     requests of this size didn't work before at all (i.e.,
     they would have run into the pipe buffer thing and
     deadlocked).

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

Signed-off-by: Jeff King <peff@peff.net>
---
 http-backend.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 11 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 3ad82a8..7cc2e8c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -19,12 +19,13 @@ static struct string_list *query_params;
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
@@ -266,9 +267,49 @@ static struct rpc_service *select_service(const char *name)
 	return svc;
 }
 
-static void inflate_request(const char *prog_name, int out)
+/*
+ * This is basically strbuf_read(), except that if we
+ * hit MAX_REQUEST_BUFFER we die (we'd rather reject a
+ * maliciously large request than chew up infinite memory).
+ */
+#define MAX_REQUEST_BUFFER (1024 * 1024)
+static ssize_t read_request(int fd, unsigned char **out)
+{
+	size_t len = 0, alloc = 8192;
+	unsigned char *buf = xmalloc(alloc);
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
+			return len;
+		}
+
+		/* otherwise, grow and try again (if we can) */
+		if (alloc == MAX_REQUEST_BUFFER)
+			die("request was larger than our maximum size (%lu)",
+			    (unsigned long)(MAX_REQUEST_BUFFER-1));
+
+		alloc = alloc_nr(alloc);
+		if (alloc > MAX_REQUEST_BUFFER)
+			alloc = MAX_REQUEST_BUFFER;
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
@@ -277,11 +318,21 @@ static void inflate_request(const char *prog_name, int out)
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
@@ -307,9 +358,22 @@ static void inflate_request(const char *prog_name, int out)
 done:
 	git_inflate_end(&stream);
 	close(out);
+	free(full_request);
 }
 
-static void run_service(const char **argv)
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
+}
+
+static void run_service(const char **argv, int buffer_input)
 {
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
 	const char *user = getenv("REMOTE_USER");
@@ -334,7 +398,7 @@ static void run_service(const char **argv)
 				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	cld.argv = argv;
-	if (gzipped_request)
+	if (buffer_input || gzipped_request)
 		cld.in = -1;
 	cld.git_cmd = 1;
 	if (start_command(&cld))
@@ -342,7 +406,9 @@ static void run_service(const char **argv)
 
 	close(1);
 	if (gzipped_request)
-		inflate_request(argv[0], cld.in);
+		inflate_request(argv[0], cld.in, buffer_input);
+	else if (buffer_input)
+		copy_request(argv[0], cld.in);
 	else
 		close(0);
 
@@ -392,7 +458,7 @@ static void get_info_refs(char *arg)
 		packet_flush(1);
 
 		argv[0] = svc->name;
-		run_service(argv);
+		run_service(argv, 0);
 
 	} else {
 		select_getanyfile();
@@ -496,7 +562,7 @@ static void service_rpc(char *service_name)
 	end_headers();
 
 	argv[0] = svc->name;
-	run_service(argv);
+	run_service(argv, svc->buffer_input);
 	strbuf_release(&buf);
 }
 
-- 
2.4.1.396.g7ba6d7b
