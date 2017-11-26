Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799FA20954
	for <e@80x24.org>; Sun, 26 Nov 2017 01:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdKZBzC (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 20:55:02 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:33024
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751900AbdKZBzB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 20:55:01 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Im9jetQwL0TufIm9reDkyn; Sat, 25 Nov 2017 18:55:01 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v5 1/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun, 26 Nov 2017 03:54:47 +0200
Message-Id: <20171126015448.24111-2-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-Reply-To: <20171126015448.24111-1-max@max630.net>
References: <20171126015448.24111-1-max@max630.net>
X-CMAE-Envelope: MS4wfMSpghPudJZiz091PQko4Su1gJ1RHuvO20Te+x6q0CaqpZtrp/IcLzHRjGcqCrZYbyASy4a1DuKsPBUxWQIk85e27qjAtQs18bWRbqdNk/wmXfZP3vMh
 sh4nzbxupYF5ViQiD2927LCNLPcVyS0AeuTSg9rFthU5nMbWqHmip911YRf6hCbkyJsCE3u2PiDFi6f0mezVEzn6jd9Jm57x4x99GdNxOIfWcpxuKaGYNiEt
 kzF2PommNeZAEC2Mb99mNHLH5u/MKuTgZOZJH6vBEp8SpEWOvXAD3wa19AhggvsbR+8oAg/67vA2xQIO7thcEZQ2DDmhOuOOeTnaO0dOu/sJ95jfV8pk7La9
 XuFHzkK9HSJtfuawZ9BG1mh6w5zdo/shcAo4pFGHeffyaqbkkf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Author: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Date: Wed, 30 Mar 2016 09:08:56 +0000

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
 config.c       |  8 ++++++++
 config.h       |  1 +
 http-backend.c | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

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
index 519025d2c3..b4ba83b624 100644
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
@@ -317,6 +317,43 @@ static ssize_t read_request(int fd, unsigned char **out)
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
+static ssize_t read_request(int fd, unsigned char **out)
+{
+	ssize_t req_len = git_env_ssize_t("CONTENT_LENGTH", -1);
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

