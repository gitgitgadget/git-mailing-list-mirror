Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74B81F403
	for <e@80x24.org>; Sat,  2 Jun 2018 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeFBVgF (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 17:36:05 -0400
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:59811
        "EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750886AbeFBVgE (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Jun 2018 17:36:04 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jun 2018 17:36:01 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PE4if9a6maUaoPE4pfBxVt; Sat, 02 Jun 2018 14:28:45 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v7 1/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun,  3 Jun 2018 00:27:48 +0300
Message-Id: <20180602212749.21324-2-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: <20180602212749.21324-1-max@max630.net>
References: <20180602212749.21324-1-max@max630.net>
X-CMAE-Envelope: MS4wfGE3a8xx4gSv/FG58AB4Z/cS3alOioRbocbqAWQLbn49IRLsa10pziBnu+flqhTybLe8H9keA+xqgVVAKoOZZwTcOXcxkeEE6JWrgI0Vl3oCaJ04NfzW
 FQq6KUgZt4/9dV/Gi+qArzFBn1FAJewwWq/zfq/Idv3vIwecTq6iomPfIlHAbflFnDxJxRN4TSNrjOBJoopGzq2oUEPx6lXgTm3tlSPzuzKaiEVWE5kAhX95
 bDsxHcKHfjS65TNRSJeQinOACYrVLAtSPaHdITZCyR2DoOgeaFxmNExmyMn4FWngDZXmAkcjlVcrz19QnyebYwLm5+9l3ugUEpsPmfmnkBI54Rk5OztvDrTx
 cy8TOAaz9ePkb4knBlEdnYeeVGHs8mEoG5l60VKGjzwiFxHXrvM=
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

Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
[mk: fixed trivial build failures and polished style issues]
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
 config.c       |  2 +-
 config.h       |  1 +
 http-backend.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 2 deletions(-)

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
index 88d2a9bc40..3066697a24 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -283,7 +283,7 @@ static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
  * hit max_request_buffer we die (we'd rather reject a
  * maliciously large request than chew up infinite memory).
  */
-static ssize_t read_request(int fd, unsigned char **out)
+static ssize_t read_request_eof(int fd, unsigned char **out)
 {
 	size_t len = 0, alloc = 8192;
 	unsigned char *buf = xmalloc(alloc);
@@ -320,6 +320,47 @@ static ssize_t read_request(int fd, unsigned char **out)
 	}
 }
 
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
+static ssize_t read_request(int fd, unsigned char **out)
+{
+	ssize_t req_len = get_content_length();
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
2.17.0.1185.g782057d875

