Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8091F517
	for <e@80x24.org>; Sun, 10 Jun 2018 15:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeFJPNR (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 11:13:17 -0400
Received: from p3plsmtpa06-02.prod.phx3.secureserver.net ([173.201.192.103]:35040
        "EHLO p3plsmtpa06-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753375AbeFJPNQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 11:13:16 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2018 11:13:11 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id S1uNfeU0REJZQS1umfyRGn; Sun, 10 Jun 2018 08:05:58 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v8 2/3] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun, 10 Jun 2018 18:05:20 +0300
Message-Id: <20180610150521.9714-3-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: <20180610150521.9714-1-max@max630.net>
References: <20180610150521.9714-1-max@max630.net>
X-CMAE-Envelope: MS4wfFCHOtMUsyCSipvl/0UVabfcXxwWoCfO7tliSNrgroaEJwyWmj1w/1t5Owt/WJsBFQHCeK/JCFmcn4jZZ1N5O+hVzpc9NnV/h2H4/wciH3PoxWIZZdJY
 m9uBkEepBFNZO7dCPnuW8rk+cNxgNlZ6A/v4YSp2q5GiVM/RlBp/H/xHPY3RaS8ywIHK1GUiZ7gNVlJT3OYoBle8qxoMrkHjiPiuniCgIiFC4RHvQwlYf9sR
 BCrvCTc9I6jtj8fgz2K5Wu82aGBd70OSrsfPAwxFD5eOs+oHMzB/3u1+IR+NGyYTBRI52R7AGQi8zy//98IcjXeqfbjwZGhZ922gqbfO1BEaqyAwd4Weqp3U
 iHE6yWYQgTTmwZARkvuG32rSVRxMCyCG53tRErrh84naH5Rj5f0=
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
---
 config.c       |  2 +-
 config.h       |  1 +
 http-backend.c | 54 +++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index c698988f5e..4148a3529d 100644
--- a/config.c
+++ b/config.c
@@ -853,7 +853,7 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 1;
 }
 
-static int git_parse_ssize_t(const char *value, ssize_t *ret)
+int git_parse_ssize_t(const char *value, ssize_t *ret)
 {
 	intmax_t tmp;
 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
diff --git a/config.h b/config.h
index ef70a9cac1..c143a1b634 100644
--- a/config.h
+++ b/config.h
@@ -48,6 +48,7 @@ extern void git_config(config_fn_t fn, void *);
 extern int config_with_options(config_fn_t fn, void *,
 			       struct git_config_source *config_source,
 			       const struct config_options *opts);
+extern int git_parse_ssize_t(const char *, ssize_t *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
diff --git a/http-backend.c b/http-backend.c
index 206dc28e07..0c9e9be2b7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -289,7 +289,7 @@ static void write_to_child(int out, const unsigned char *buf, ssize_t len, const
  * hit max_request_buffer we die (we'd rather reject a
  * maliciously large request than chew up infinite memory).
  */
-static ssize_t read_request(int fd, unsigned char **out)
+static ssize_t read_request_eof(int fd, unsigned char **out)
 {
 	size_t len = 0, alloc = 8192;
 	unsigned char *buf = xmalloc(alloc);
@@ -326,7 +326,46 @@ static ssize_t read_request(int fd, unsigned char **out)
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
@@ -344,7 +383,7 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 			if (full_request)
 				n = 0; /* nothing left to read */
 			else
-				n = read_request(0, &full_request);
+				n = read_request(0, &full_request, req_len);
 			stream.next_in = full_request;
 		} else {
 			n = xread(0, in_buf, sizeof(in_buf));
@@ -380,10 +419,10 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
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
@@ -398,6 +437,7 @@ static void run_service(const char **argv, int buffer_input)
 	const char *host = getenv("REMOTE_ADDR");
 	int gzipped_request = 0;
 	struct child_process cld = CHILD_PROCESS_INIT;
+	ssize_t req_len = get_content_length();
 
 	if (encoding && !strcmp(encoding, "gzip"))
 		gzipped_request = 1;
@@ -424,9 +464,9 @@ static void run_service(const char **argv, int buffer_input)
 
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

