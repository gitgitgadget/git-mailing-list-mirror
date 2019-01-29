Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36091F453
	for <e@80x24.org>; Tue, 29 Jan 2019 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfA2GtD (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 01:49:03 -0500
Received: from 0x63.nu ([109.74.10.199]:48022 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfA2GtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 01:49:03 -0500
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1goNCe-0004Fq-Tu; Tue, 29 Jan 2019 07:49:01 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20190128213337.24752-1-anders@0x63.nu> <20190128213337.24752-3-anders@0x63.nu> <xmqq8sz49zm1.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anders Waldenborg <anders@0x63.nu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/7 update] pretty: allow %(trailers) options with explicit value
In-reply-to: <xmqq8sz49zm1.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 29 Jan 2019 07:49:00 +0100
Message-ID: <87r2cwklgj.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In addition to old %(trailers:only) it is now allowed to write
%(trailers:only=yes)

By itself this only gives (the not quite so useful) possibility to have
users change their mind in the middle of a formatting
string (%(trailers:only=true,only=false)). However, it gives users the
opportunity to override defaults from future options.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 14 ++++++---
 pretty.c                         | 52 +++++++++++++++++++++++++++-----
 t/t4205-log-pretty-formats.sh    | 18 +++++++++++
 3 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 86d804fe97..d33b072eb2 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -225,10 +225,16 @@ endif::git-rev-list[]
                           linkgit:git-interpret-trailers[1]. The
                           `trailers` string may be followed by a colon
                           and zero or more comma-separated options:
-** 'only': omit non-trailer lines from the trailer block.
-** 'unfold': make it behave as if interpret-trailer's `--unfold`
-   option was given. E.g., `%(trailers:only,unfold)` unfolds and
-   shows all trailer lines.
+** 'only[=val]': select whether non-trailer lines from the trailer
+   block should be included. The `only` keyword may optionally be
+   followed by an equal sign and one of `true`, `on`, `yes` to omit or
+   `false`, `off`, `no` to show the non-trailer lines. If option is
+   given without value it is enabled. If given multiple times the last
+   value is used.
+** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
+   option was given. In same way as to for `only` it can be followed
+   by an equal sign and explicit value. E.g.,
+   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index b83a3ecd23..4dfbd38cf6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1056,13 +1056,26 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
-static int match_placeholder_arg(const char *to_parse, const char *candidate,
-				 const char **end)
+static int match_placeholder_arg_value(const char *to_parse, const char *candidate,
+				       const char **end, const char **valuestart,
+				       size_t *valuelen)
 {
 	const char *p;
 
 	if (!(skip_prefix(to_parse, candidate, &p)))
 		return 0;
+	if (valuestart) {
+		if (*p == '=') {
+			*valuestart = p + 1;
+			*valuelen = strcspn(*valuestart, ",)");
+			p = *valuestart + *valuelen;
+		} else {
+			if (*p != ',' && *p != ')')
+				return 0;
+			*valuestart = NULL;
+			*valuelen = 0;
+		}
+	}
 	if (*p == ',') {
 		*end = p + 1;
 		return 1;
@@ -1074,6 +1087,34 @@ static int match_placeholder_arg(const char *to_parse, const char *candidate,
 	return 0;
 }
 
+static int match_placeholder_bool_arg(const char *to_parse, const char *candidate,
+				      const char **end, int *val)
+{
+	const char *argval;
+	char *strval;
+	size_t arglen;
+	int v;
+
+	if (!match_placeholder_arg_value(to_parse, candidate, end, &argval, &arglen))
+		return 0;
+
+	if (!argval) {
+		*val = 1;
+		return 1;
+	}
+
+	strval = xstrndup(argval, arglen);
+	v = git_parse_maybe_bool(strval);
+	free(strval);
+
+	if (v == -1)
+		return 0;
+
+	*val = v;
+
+	return 1;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1318,11 +1359,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		if (*arg == ':') {
 			arg++;
 			for (;;) {
-				if (match_placeholder_arg(arg, "only", &arg))
-					opts.only_trailers = 1;
-				else if (match_placeholder_arg(arg, "unfold", &arg))
-					opts.unfold = 1;
-				else
+				if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
+				    !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold))
 					break;
 			}
 		}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 978a8a66ff..63730a4ec0 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -578,6 +578,24 @@ test_expect_success '%(trailers:only) shows only "key: value" trailers' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:only=yes) shows only "key: value" trailers' '
+	git log --no-walk --pretty=format:"%(trailers:only=yes)" >actual &&
+	grep -v patch.description <trailers >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:only=no) shows all trailers' '
+	git log --no-walk --pretty=format:"%(trailers:only=no)" >actual &&
+	cat trailers >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:only=no,only=true) shows only "key: value" trailers' '
+	git log --no-walk --pretty=format:"%(trailers:only=yes)" >actual &&
+	grep -v patch.description <trailers >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success '%(trailers:unfold) unfolds trailers' '
 	git log --no-walk --pretty="%(trailers:unfold)" >actual &&
 	{
-- 
2.17.1

