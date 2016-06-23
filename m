Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D25D1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbcFWQ3k (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34256 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbcFWQ3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id l184so18868564lfl.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALq0CYAXfzWZZtyEmLZMpKYjRgjfIKs5Dzvw1z3SW14=;
        b=W3aISTH3T37AVDiHrdF+EWNSkuxQE/3v0DGMxfvnBzL52qP0Yp2Im/LUl636jF9Klg
         /L6Aod3I/VEVDMeSfmV1vgpb3O1/jRyAdQFoSw+xVY9o7PEwV2nlimPFjvHCPrTa4RMW
         928arRDnS2vl2qJyL0GNy6CTXdFT9fgqsMSSPlHx/WAm3cGJv0u8dFtRt4smARdI8Xo/
         /sAePHc2rT2GD6iz1Kkzp5SJ/wl9rfoNBxu8/0i8jUJp6lKaaCUn5YHw1eWWsmaBIOP+
         7TJWZfPJhe2t/3b3e9iOqaPr1wgLQiK7tsC4gJoJEheSmQqcGFvUKA98Ah+EFgAe3O3+
         ATpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALq0CYAXfzWZZtyEmLZMpKYjRgjfIKs5Dzvw1z3SW14=;
        b=adCw8AjW8VIvbZvbpnene6DB0p/+FTlIQyfw8o+6IdEMvVnbgoDPYxSjZKTQSveObT
         UYwtvg+bSoH/o4DhSqvcNV6ykAXEDFfWPOY3rjz/nftV/Lp/6gY08WzT3TMu35068/Bp
         cDFWPpzl/Rq1jqhoe4B26bwiS7tGVupjdPW5TqSnb2o5ahTfz6zZiZcJVVU1ACp1TPLw
         oNdBi5G6FpOytRKQ5wPqx1rbl8J/WLnuv0TvWzX26FR8euL47L67a+VdpcDOO7409kdy
         hlYW6/P6pYYbaTiDXPT+KQtRiu+n1C44E85igYgbOyoZVA+Uvh/9J6wJCTqz5oNmwS04
         NpzQ==
X-Gm-Message-State: ALyK8tL8s6AdeKx4sqKQnfRokhv99y0sCLtg7v3DKCj+LPgZdSwOcpE7qx+s3CZs7C48/w==
X-Received: by 10.25.154.72 with SMTP id c69mr7770176lfe.72.1466699374373;
        Thu, 23 Jun 2016 09:29:34 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:33 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/11] grep/icase: avoid kwsset when -F is specified
Date:	Thu, 23 Jun 2016 18:29:01 +0200
Message-Id: <20160623162907.23295-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to the previous commit, we can't use kws on icase search
outside ascii range. But we can't simply pass the pattern to
regcomp/pcre like the previous commit because it may contain regex
special characters, so we need to quote the regex first.

To avoid misquote traps that could lead to undefined behavior, we
always stick to basic regex engine in this case. We don't need fancy
features for grepping a literal string anyway.

basic_regex_quote_buf() assumes that if the pattern is in a multibyte
encoding, ascii chars must be unambiguously encoded as single
bytes. This is true at least for UTF-8. For others, let's wait until
people yell up. Chances are nobody uses multibyte, non utf-8 charsets
anymore.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                          | 25 ++++++++++++++++++++++++-
 quote.c                         | 37 +++++++++++++++++++++++++++++++++++++
 quote.h                         |  1 +
 t/t7812-grep-icase-non-ascii.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index f192727..6de58f3 100644
--- a/grep.c
+++ b/grep.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "commit.h"
+#include "quote.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -397,6 +398,24 @@ static int is_fixed(const char *s, size_t len)
 	return 1;
 }
 
+static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int err;
+
+	basic_regex_quote_buf(&sb, p->pattern);
+	err = regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTENDED);
+	if (opt->debug)
+		fprintf(stderr, "fixed %s\n", sb.buf);
+	strbuf_release(&sb);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &p->regexp, errbuf, sizeof(errbuf));
+		regfree(&p->regexp);
+		compile_regexp_failed(p, errbuf);
+	}
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int icase, ascii_only;
@@ -408,7 +427,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	ascii_only     = !has_non_ascii(p->pattern);
 
 	if (opt->fixed) {
-		p->fixed = 1;
+		p->fixed = !icase || ascii_only;
+		if (!p->fixed) {
+			compile_fixed_regexp(p, opt);
+			return;
+		}
 	} else if ((!icase || ascii_only) &&
 		   is_fixed(p->pattern, p->patternlen))
 		p->fixed = 1;
diff --git a/quote.c b/quote.c
index fe884d2..c67adb7 100644
--- a/quote.c
+++ b/quote.c
@@ -440,3 +440,40 @@ void tcl_quote_buf(struct strbuf *sb, const char *src)
 	}
 	strbuf_addch(sb, '"');
 }
+
+void basic_regex_quote_buf(struct strbuf *sb, const char *src)
+{
+	char c;
+
+	if (*src == '^') {
+		/* only beginning '^' is special and needs quoting */
+		strbuf_addch(sb, '\\');
+		strbuf_addch(sb, *src++);
+	}
+	if (*src == '*')
+		/* beginning '*' is not special, no quoting */
+		strbuf_addch(sb, *src++);
+
+	while ((c = *src++)) {
+		switch (c) {
+		case '[':
+		case '.':
+		case '\\':
+		case '*':
+			strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		case '$':
+			/* only the end '$' is special and needs quoting */
+			if (*src == '\0')
+				strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		default:
+			strbuf_addch(sb, c);
+			break;
+		}
+	}
+}
diff --git a/quote.h b/quote.h
index 99e04d3..362d315 100644
--- a/quote.h
+++ b/quote.h
@@ -67,5 +67,6 @@ extern char *quote_path_relative(const char *in, const char *prefix,
 extern void perl_quote_buf(struct strbuf *sb, const char *src);
 extern void python_quote_buf(struct strbuf *sb, const char *src);
 extern void tcl_quote_buf(struct strbuf *sb, const char *src);
+extern void basic_regex_quote_buf(struct strbuf *sb, const char *src);
 
 #endif
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index b78a774..1929809 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,4 +20,30 @@ test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: HALLÓ HEIMUR!"
 '
 
+test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
+	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
+		 grep fixed >debug1 &&
+	test_write_lines "fixed TILRAUN: Halló Heimur!" >expect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "TILRAUN: HALLÓ HEIMUR!"  2>&1 >/dev/null |
+		 grep fixed >debug2 &&
+	test_write_lines "fixed TILRAUN: HALLÓ HEIMUR!" >expect2 &&
+	test_cmp expect2 debug2
+'
+
+test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
+	test_write_lines "^*TILR^AUN:.* \\Halló \$He[]imur!\$" >file &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\Halló \$He[]imur!\$" 2>&1 >/dev/null |
+		 grep fixed >debug1 &&
+	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\Halló \$He\\[]imur!\\\$" >expect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\HALLÓ \$HE[]IMUR!\$"  2>&1 >/dev/null |
+		 grep fixed >debug2 &&
+	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\HALLÓ \$HE\\[]IMUR!\\\$" >expect2 &&
+	test_cmp expect2 debug2
+'
+
 test_done
-- 
2.8.2.526.g02eed6d

