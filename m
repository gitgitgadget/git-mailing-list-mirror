Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29CCD1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbeGXL40 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:56:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:57298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388296AbeGXL40 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:56:26 -0400
Received: (qmail 10876 invoked by uid 109); 24 Jul 2018 10:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:50:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26401 invoked by uid 111); 24 Jul 2018 10:50:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:50:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:50:33 -0400
Date:   Tue, 24 Jul 2018 06:50:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] reencode_string: use size_t for string lengths
Message-ID: <20180724105032.GB17165@sigill.intra.peff.net>
References: <20180724104852.GA14638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724104852.GA14638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The iconv interface takes a size_t, which is the appropriate
type for an in-memory buffer. But our reencode_string_*
functions use integers, meaning we may get confusing results
when the sizes exceed INT_MAX. Let's use size_t
consistently.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c |  6 +++---
 pretty.c  |  2 +-
 strbuf.c  |  2 +-
 utf8.c    |  6 +++---
 utf8.h    | 10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/convert.c b/convert.c
index 56cfe31ec5..530a43cf63 100644
--- a/convert.c
+++ b/convert.c
@@ -390,7 +390,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			 struct strbuf *buf, const char *enc, int conv_flags)
 {
 	char *dst;
-	int dst_len;
+	size_t dst_len;
 	int die_on_error = conv_flags & CONV_WRITE_OBJECT;
 
 	/*
@@ -453,7 +453,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	 */
 	if (die_on_error && check_roundtrip(enc)) {
 		char *re_src;
-		int re_src_len;
+		size_t re_src_len;
 
 		re_src = reencode_string_len(dst, dst_len,
 					     enc, default_encoding,
@@ -481,7 +481,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 			      struct strbuf *buf, const char *enc)
 {
 	char *dst;
-	int dst_len;
+	size_t dst_len;
 
 	/*
 	 * No encoding is specified or there is nothing to encode.
diff --git a/pretty.c b/pretty.c
index 703fa6ff7b..e1e4060243 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1538,7 +1538,7 @@ void format_commit_message(const struct commit *commit,
 	}
 
 	if (output_enc) {
-		int outsz;
+		size_t outsz;
 		char *out = reencode_string_len(sb->buf, sb->len,
 						output_enc, utf8, &outsz);
 		if (out)
diff --git a/strbuf.c b/strbuf.c
index b0716ac585..e79758b942 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -134,7 +134,7 @@ void strbuf_ltrim(struct strbuf *sb)
 int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 {
 	char *out;
-	int len;
+	size_t len;
 
 	if (same_encoding(from, to))
 		return 0;
diff --git a/utf8.c b/utf8.c
index a2fd24c70a..edcd1e835a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -470,7 +470,7 @@ int utf8_fprintf(FILE *stream, const char *format, ...)
 #else
 	typedef char * iconv_ibp;
 #endif
-char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, int *outsz_p)
+char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, size_t *outsz_p)
 {
 	size_t outsz, outalloc;
 	char *out, *outpos;
@@ -534,9 +534,9 @@ static const char *fallback_encoding(const char *name)
 	return name;
 }
 
-char *reencode_string_len(const char *in, int insz,
+char *reencode_string_len(const char *in, size_t insz,
 			  const char *out_encoding, const char *in_encoding,
-			  int *outsz)
+			  size_t *outsz)
 {
 	iconv_t conv;
 	char *out;
diff --git a/utf8.h b/utf8.h
index db73a2d8d3..ce1c2696e0 100644
--- a/utf8.h
+++ b/utf8.h
@@ -25,14 +25,14 @@ void strbuf_utf8_replace(struct strbuf *sb, int pos, int width,
 
 #ifndef NO_ICONV
 char *reencode_string_iconv(const char *in, size_t insz,
-			    iconv_t conv, int *outsz);
-char *reencode_string_len(const char *in, int insz,
+			    iconv_t conv, size_t *outsz);
+char *reencode_string_len(const char *in, size_t insz,
 			  const char *out_encoding,
 			  const char *in_encoding,
-			  int *outsz);
+			  size_t *outsz);
 #else
-static inline char *reencode_string_len(const char *a, int b,
-					const char *c, const char *d, int *e)
+static inline char *reencode_string_len(const char *a, size_t b,
+					const char *c, const char *d, size_t *e)
 { if (e) *e = 0; return NULL; }
 #endif
 
-- 
2.18.0.542.g2bf2fc4f7e

