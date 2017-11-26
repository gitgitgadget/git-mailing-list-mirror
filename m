Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A983420A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdKZTia (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:38:30 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:33285
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751766AbdKZTi2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2017 14:38:28 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id J2kreBvfThwvHJ2l0ewoBn; Sun, 26 Nov 2017 12:38:28 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun, 26 Nov 2017 21:38:12 +0200
Message-Id: <20171126193813.12531-2-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-Reply-To: <20171126193813.12531-1-max@max630.net>
References: <20171126193813.12531-1-max@max630.net>
X-CMAE-Envelope: MS4wfKcyhvBZ0oGdewUFJ8/nYaKRFkFOtUVHPN9k/saakFPzXDcHN53IFRKavF2QXthnj1Fy/ONYmuerhB7GudD3DYE5hT1f2NMSQYY1QLnhUvvS2Xm2q8Jz
 td7Oo9xrig5aJoNdn/hBIH6e+SmuWF2gAGr/3hAxkCP4GnqJtegj2JDWYPNtsyVxh3CfqfuP69hSjq/jnNRgqxLTtY6eY9CH1wNpOrpthDl0j9bN7mitFw4N
 j5kcop50758FdBiBSJEZmVk2KCa1Jo3bOsCqD4piGbqaYdsHI1X/3OP68pBo+qOoX6jKNL84mvx+fNgEz0rn17j/NFhoqqqqoe7/fopxYbI7Ru04sxGLYBhr
 6f+m2SXdchCQBLwXP9hkBiWFuPfNbjINzdPo7shyiwPX5QwLpbU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>

From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Date: Wed, 30 Mar 2016 10:54:21 +0200

http-backend reads whole input until EOF. However, the RFC 3875 specifies
that a script must read only as many bytes as specified by CONTENT_LENGTH
environment variable. Web server may exercise the specification by not closing
the script's standard input after writing content. In that case http-backend
would hang waiting for the input. The issue is known to happen with
IIS/Windows, for example.

Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
the whole input until EOF. If the variable is not defined, keep older behavior
of reading until EOF because it is used to support chunked transfer-encoding.

Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
[mk: fixed trivial build failures and polished style issues]
Signed-off-by: Max Kirillov <max@max630.net>
---
 config.c       |  2 +-
 config.h       |  1 +
 http-backend.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 231f9a750b..d3ec14ab74 100644
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
index 0352da117b..46a4989def 100644
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
index 519025d2c3..af7dd00d70 100644
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
@@ -317,6 +317,54 @@ static ssize_t read_request(int fd, unsigned char **out)
 	}
 }
 
+static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **out)
+{
+	unsigned char *buf = NULL;
+	ssize_t cnt = 0;
+
+	if (max_request_buffer < req_len) {
+		die("request was larger than our maximum size (%lu): %lu;"
+			    " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
+			    max_request_buffer,
+			    req_len);
+	}
+
+	if (req_len <= 0) {
+		*out = NULL;
+		return 0;
+	}
+
+	buf = xmalloc(req_len);
+	cnt = read_in_full(fd, buf, req_len);
+	if (cnt < 0) {
+		free(buf);
+		return -1;
+	} else {
+		*out = buf;
+		return cnt;
+	}
+}
+
+static ssize_t env_content_length(void)
+{
+	ssize_t val = -1;
+	const char *str = getenv("CONTENT_LENGTH");
+
+	if (str && !git_parse_ssize_t(str, &val))
+		die("failed to parse CONTENT_LENGTH: %s", str);
+	return val;
+}
+
+static ssize_t read_request(int fd, unsigned char **out)
+{
+	ssize_t req_len = env_content_length();
+
+	if (req_len < 0)
+		return read_request_eof(fd, out);
+	else
+		return read_request_fixed_len(fd, req_len, out);
+}
+
 static void inflate_request(const char *prog_name, int out, int buffer_input)
 {
 	git_zstream stream;
-- 
2.11.0.1122.gc3fec58.dirty

