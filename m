Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F92202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 23:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdKWXxs (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 18:53:48 -0500
Received: from p3plsmtpa11-10.prod.phx3.secureserver.net ([68.178.252.111]:34059
        "EHLO p3plsmtpa11-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753333AbdKWXxr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2017 18:53:47 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Nov 2017 18:53:47 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id I1CGeB30a9pdmI1CMelVFo; Thu, 23 Nov 2017 16:46:28 -0700
From:   Max Kirillov <max@max630.net>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Fri, 24 Nov 2017 01:45:11 +0200
Message-Id: <20171123234511.574-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-Reply-To: <20160401235532.GA27941@sigill.intra.peff.net>
X-CMAE-Envelope: MS4wfNwhu1iiWv3I0MZRGzIHzVll+TyyTlQgFATkBhol2hvAogbjN2bZlMkOr/zroUOVFcV8S81s9bYwWsLXJsj3fjhT8Y9Gn0rgT5Ff/48bM3NRgtyEKhpf
 psCkQBI4HRtvHTLE/QpBEWR2bqHW3rrhz5D+mkQbiQxDWMcoFKCa3UnzvpdiyvqhWA9gd+Z/mb3Mgqmv/LtGRDdalBKXR+S0Gif561n/Re2JdnQO09rx/UJy
 t4siVZ0K8q8Q+LmQAwjd46MOXTVBZ/LuQVT7ZToGq6OD1k/WDkBKeKUpDkuFW2QSZ+mphmmWzVF7N8GYeb2WV0abAxe2f7LJyI4CU5+i/zc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

http-backend reads whole input until EOF. However, the RFC 3875 specifies
that a script must read only as many bytes as specified by CONTENT_LENGTH
environment variable. This causes hang under IIS/Windows, for example.

Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
the whole input until EOF. If the varibale is not defined, keep older behavior
of reading until EOF because it is used to support chunked transfer-encoding.

Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Authored-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Fixed-by: Max Kirillov <max@max630.net>
Signed-off-by: Max Kirillov <max@max630.net>
---
Hi

I came across this issue, and I think is should be good to restore the patch.
It is basically same but I squashed them, fixed the thing you mentioned and
also some trivial build failures (null -> NULL and missing return from the wrapper).
I hope I marked it correctly in the trailers.
 config.c       |  8 +++++++
 config.h       |  1 +
 http-backend.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 231f9a750b..925bb65dfa 100644
--- a/config.c
+++ b/config.c
@@ -1525,6 +1525,14 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
 	return val;
 }
 
+ssize_t git_env_ssize_t(const char *k, ssize_t val)
+{
+	const char *v = getenv(k);
+	if (v && !git_parse_ssize_t(v, &val))
+		die("failed to parse %s", k);
+	return val;
+}
+
 int git_config_system(void)
 {
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
diff --git a/config.h b/config.h
index 0352da117b..947695c304 100644
--- a/config.h
+++ b/config.h
@@ -74,6 +74,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
 extern const char *git_etc_gitconfig(void);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
+extern ssize_t git_env_ssize_t(const char *, ssize_t);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
 #if defined(__GNUC__)
diff --git a/http-backend.c b/http-backend.c
index 519025d2c3..317b99b87c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -280,7 +280,7 @@ static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
  * hit max_request_buffer we die (we'd rather reject a
  * maliciously large request than chew up infinite memory).
  */
-static ssize_t read_request(int fd, unsigned char **out)
+static ssize_t read_request_eof(int fd, unsigned char **out)
 {
 	size_t len = 0, alloc = 8192;
 	unsigned char *buf = xmalloc(alloc);
@@ -317,6 +317,76 @@ static ssize_t read_request(int fd, unsigned char **out)
 	}
 }
 
+/*
+ * replacement for original read_request, now renamed to read_request_eof,
+ * honoring given content_length (req_len),
+ * provided by new wrapper function read_request
+ */
+static ssize_t read_request_fix_len(int fd, size_t req_len, unsigned char **out)
+{
+	unsigned char *buf = NULL;
+	size_t len = 0;
+
+	/* check request size */
+	if (max_request_buffer < req_len) {
+		die("request was larger than our maximum size (%lu);"
+			    " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
+			    max_request_buffer);
+	}
+
+	if (req_len <= 0) {
+		*out = NULL;
+		return 0;
+	}
+
+	/* allocate buffer */
+	buf = xmalloc(req_len);
+
+
+	while (1) {
+		ssize_t cnt;
+
+		cnt = read_in_full(fd, buf + len, req_len - len);
+		if (cnt < 0) {
+			free(buf);
+			return -1;
+		}
+
+		/* partial read from read_in_full means we hit EOF */
+		len += cnt;
+		if (len < req_len) {
+			/* TODO request incomplete?? */
+			/* maybe just remove this block and condition along with the loop, */
+			/* if read_in_full is prooven reliable */
+			*out = buf;
+			return len;
+		} else {
+			/* request complete */
+			*out = buf;
+			return len;
+			
+		}
+	}
+}
+
+/**
+ * wrapper function, whcih determines based on CONTENT_LENGTH value,
+ * to
+ * - use old behaviour of read_request, to read until EOF
+ * => read_request_eof(...)
+ * - just read CONTENT_LENGTH-bytes, when provided
+ * => read_request_fix_len(...)
+ */
+static ssize_t read_request(int fd, unsigned char **out)
+{
+	/* get request size */
+	ssize_t req_len = git_env_ssize_t("CONTENT_LENGTH", -1);
+	if (req_len < 0)
+		return read_request_eof(fd, out);
+	else
+		return read_request_fix_len(fd, req_len, out);
+}
+
 static void inflate_request(const char *prog_name, int out, int buffer_input)
 {
 	git_zstream stream;
-- 
2.11.0.1122.gc3fec58.dirty

