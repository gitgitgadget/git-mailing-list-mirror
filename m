Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1008C1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 03:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeG0FJF (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 01:09:05 -0400
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:60337
        "EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbeG0FJE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Jul 2018 01:09:04 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id itkTfU4KgK5J2itkcflkuo; Thu, 26 Jul 2018 20:49:13 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v9 2/3] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Fri, 27 Jul 2018 06:48:58 +0300
Message-Id: <20180727034859.15769-3-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: <20180727034859.15769-1-max@max630.net>
References: <20180727034859.15769-1-max@max630.net>
X-CMAE-Envelope: MS4wfKkNh7nO4PGPCiV+XVRN1fP04i+LjLBqX8OjUsfVFGN769P5PGCu+q1jTKY3kQpthAu2uAiT0YqNKNwypceuesQ632PEPOaLfsNdJX1GBT1KrtPxKphk
 Oq7EDDANbBg2pqYoh6RiQwIuyKu/rMajEF9GyZ4pfgDKmdC6udzvZK/+G0LJ3YwGbhfzQEbaJKTdZB/+6R+CQOe0HLRmXyMCt3fdff9vaapSVAG3VCZ2MgeB
 PmUsq3sVirtAMvXuQuP94jKrrsrSrEiB/jCuD4OwiQ2zamI63pwVNzcqkxwGIakqadEBEKy4Vx6WZZqn3bZDjTzOQk+/WjfJFtj8oqQQGWLCTrlR1W7jTw3d
 BebVG5WtoU5Ck/TBi4b4vWV/bXQ9OeJowVOhpCerrWVKPx5WphuGuW499zod1G5B72yNGWeqG3C8DHrkU67l4vTrtqJwtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

http-backend reads whole input until EOF. However, the RFC 3875 specifies
that a script must read only as many bytes as specified by CONTENT_LENGTH
environment variable. Web server may exercise the specification by not closing
the script's standard input after writing content. In that case http-backend
would hang waiting for the input. The issue is known to happen with
IIS/Windows, for example.

Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
the whole input until EOF. If the variable is not defined, keep older behavior
of reading until EOF because it is used to support chunked transfer-encoding.

This commit only fixes buffered input, whcih reads whole body before
processign it. Non-buffered input is going to be fixed in subsequent commit.

Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
[mk: fixed trivial build failures and polished style issues]
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Max Kirillov <max@max630.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c       |  2 +-
 config.h       |  1 +
 http-backend.c | 54 +++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index fbbf0f8e9f..158afa858b 100644
--- a/config.c
+++ b/config.c
@@ -921,7 +921,7 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 1;
 }
 
-static int git_parse_ssize_t(const char *value, ssize_t *ret)
+int git_parse_ssize_t(const char *value, ssize_t *ret)
 {
 	intmax_t tmp;
 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
diff --git a/config.h b/config.h
index cdac2fc73e..7808413bd0 100644
--- a/config.h
+++ b/config.h
@@ -73,6 +73,7 @@ extern void git_config(config_fn_t fn, void *);
 extern int config_with_options(config_fn_t fn, void *,
 			       struct git_config_source *config_source,
 			       const struct config_options *opts);
+extern int git_parse_ssize_t(const char *, ssize_t *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
diff --git a/http-backend.c b/http-backend.c
index cefdfd6fc6..d0b6cb1b09 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -290,7 +290,7 @@ static void write_to_child(int out, const unsigned char *buf, ssize_t len, const
  * hit max_request_buffer we die (we'd rather reject a
  * maliciously large request than chew up infinite memory).
  */
-static ssize_t read_request(int fd, unsigned char **out)
+static ssize_t read_request_eof(int fd, unsigned char **out)
 {
 	size_t len = 0, alloc = 8192;
 	unsigned char *buf = xmalloc(alloc);
@@ -327,7 +327,46 @@ static ssize_t read_request(int fd, unsigned char **out)
 	}
 }
 
-static void inflate_request(const char *prog_name, int out, int buffer_input)
+static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **out)
+{
+	unsigned char *buf = NULL;
+	ssize_t cnt = 0;
+
+	if (max_request_buffer < req_len) {
+		die("request was larger than our maximum size (%lu): "
+		    "%" PRIuMAX "; try setting GIT_HTTP_MAX_REQUEST_BUFFER",
+		    max_request_buffer, (uintmax_t)req_len);
+	}
+
+	buf = xmalloc(req_len);
+	cnt = read_in_full(fd, buf, req_len);
+	if (cnt < 0) {
+		free(buf);
+		return -1;
+	}
+	*out = buf;
+	return cnt;
+}
+
+static ssize_t get_content_length(void)
+{
+	ssize_t val = -1;
+	const char *str = getenv("CONTENT_LENGTH");
+
+	if (str && !git_parse_ssize_t(str, &val))
+		die("failed to parse CONTENT_LENGTH: %s", str);
+	return val;
+}
+
+static ssize_t read_request(int fd, unsigned char **out, ssize_t req_len)
+{
+	if (req_len < 0)
+		return read_request_eof(fd, out);
+	else
+		return read_request_fixed_len(fd, req_len, out);
+}
+
+static void inflate_request(const char *prog_name, int out, int buffer_input, ssize_t req_len)
 {
 	git_zstream stream;
 	unsigned char *full_request = NULL;
@@ -345,7 +384,7 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 			if (full_request)
 				n = 0; /* nothing left to read */
 			else
-				n = read_request(0, &full_request);
+				n = read_request(0, &full_request, req_len);
 			stream.next_in = full_request;
 		} else {
 			n = xread(0, in_buf, sizeof(in_buf));
@@ -381,10 +420,10 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 	free(full_request);
 }
 
-static void copy_request(const char *prog_name, int out)
+static void copy_request(const char *prog_name, int out, ssize_t req_len)
 {
 	unsigned char *buf;
-	ssize_t n = read_request(0, &buf);
+	ssize_t n = read_request(0, &buf, req_len);
 	if (n < 0)
 		die_errno("error reading request body");
 	write_to_child(out, buf, n, prog_name);
@@ -399,6 +438,7 @@ static void run_service(const char **argv, int buffer_input)
 	const char *host = getenv("REMOTE_ADDR");
 	int gzipped_request = 0;
 	struct child_process cld = CHILD_PROCESS_INIT;
+	ssize_t req_len = get_content_length();
 
 	if (encoding && !strcmp(encoding, "gzip"))
 		gzipped_request = 1;
@@ -425,9 +465,9 @@ static void run_service(const char **argv, int buffer_input)
 
 	close(1);
 	if (gzipped_request)
-		inflate_request(argv[0], cld.in, buffer_input);
+		inflate_request(argv[0], cld.in, buffer_input, req_len);
 	else if (buffer_input)
-		copy_request(argv[0], cld.in);
+		copy_request(argv[0], cld.in, req_len);
 	else
 		close(0);
 
-- 
2.17.0.1185.g782057d875

