Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5EE1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 11:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKRWFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 17:05:32 -0500
Received: from 0x63.nu ([109.74.10.199]:54706 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeKRWFc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 17:05:32 -0500
Received: from localhost ([127.0.0.1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gOLVx-0003J7-M3; Sun, 18 Nov 2018 12:45:21 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v3 2/5] pretty: allow showing specific trailers
Date:   Sun, 18 Nov 2018 12:44:24 +0100
Message-Id: <20181118114427.1397-3-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181118114427.1397-1-anders@0x63.nu>
References: <20181104152232.20671-1-anders@0x63.nu>
 <20181118114427.1397-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a new "key=X" option to "%(trailers)" which will cause it to only
print trailers lines which match the specified key.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 17 +++++++++------
 pretty.c                         | 31 ++++++++++++++++++++++++++-
 t/t4205-log-pretty-formats.sh    | 36 ++++++++++++++++++++++++++++++++
 trailer.c                        |  8 ++++---
 trailer.h                        |  2 ++
 5 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 417b638cd..75c2e838d 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -207,13 +207,18 @@ endif::git-rev-list[]
   than given and there are spaces on its left, use those spaces
 - '%><(<N>)', '%><|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
-- %(trailers[:options]): display the trailers of the body as interpreted
+- '%(trailers[:options])': display the trailers of the body as interpreted
   by linkgit:git-interpret-trailers[1]. The `trailers` string may be
-  followed by a colon and zero or more comma-separated options. If the
-  `only` option is given, omit non-trailer lines from the trailer block.
-  If the `unfold` option is given, behave as if interpret-trailer's
-  `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
-  both.
+  followed by a colon and zero or more comma-separated options:
+  ** 'only': omit non-trailer lines from the trailer block.
+  ** 'unfold': make it behave as if interpret-trailer's `--unfold`
+     option was given.
+  ** 'key=<K>': only show trailers with specified key. Matching is
+     done case-insensitively and trailing colon is optional. If option
+     is given multiple times only last one is used.
+  ** Examples: `%(trailers:only,unfold)` unfolds and shows all trailer
+     lines, `%(trailers:key=Reviewed-by,unfold)` unfolds and shows
+     trailer lines with key `Reviewed-by`.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index aa03d5b23..aaedc8447 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1074,6 +1074,17 @@ static int match_placeholder_arg(const char *to_parse, const char *candidate,
 	return 0;
 }
 
+struct format_trailer_match_data {
+	const char *trailer;
+	size_t trailer_len;
+};
+
+static int format_trailer_match_cb(const struct strbuf *sb, void *ud)
+{
+	struct format_trailer_match_data *data = ud;
+	return data->trailer_len == sb->len && !strncasecmp (data->trailer, sb->buf, sb->len);
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1312,6 +1323,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+		struct format_trailer_match_data filter_data;
 		size_t ret = 0;
 
 		opts.no_divider = 1;
@@ -1323,7 +1335,24 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.only_trailers = 1;
 				else if (match_placeholder_arg(arg, "unfold", &arg))
 					opts.unfold = 1;
-				else
+				else if (skip_prefix(arg, "key=", &arg)) {
+					const char *end = arg + strcspn(arg, ",)");
+
+					filter_data.trailer = arg;
+					filter_data.trailer_len = end - arg;
+
+					if (filter_data.trailer_len &&
+					    filter_data.trailer[filter_data.trailer_len - 1] == ':')
+						filter_data.trailer_len--;
+
+					opts.filter = format_trailer_match_cb;
+					opts.filter_data = &filter_data;
+					opts.only_trailers = 1;
+
+					arg = end;
+					if (*arg == ',')
+						arg++;
+				} else
 					break;
 			}
 		}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 978a8a66f..aba7ba206 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -598,6 +598,42 @@ test_expect_success ':only and :unfold work together' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:key=foo) shows that trailer' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by)" >actual &&
+	echo "Acked-by: A U Thor <author@example.com>" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty format %(trailers:key=foo) is case insensitive' '
+	git log --no-walk --pretty="format:%(trailers:key=AcKed-bY)" >actual &&
+	echo "Acked-by: A U Thor <author@example.com>" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty format %(trailers:key=foo:) trailing colon also works' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by:)" >actual &&
+	echo "Acked-by: A U Thor <author@example.com>" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=nonexistant) becomes empty' '
+	git log --no-walk --pretty="x%(trailers:key=Nacked-by)x" >actual &&
+	echo "xx" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=foo) handles multiple lines even if folded' '
+	git log --no-walk --pretty="format:%(trailers:key=Signed-Off-by)" >actual &&
+	grep -v patch.description <trailers | grep -v Acked-by >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
+	git log --no-walk --pretty="format:%(trailers:key=Signed-Off-by,unfold)" >actual &&
+	unfold <trailers | grep Signed-off-by >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index 0796f326b..97c8f2762 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1147,10 +1147,12 @@ static void format_trailer_info(struct strbuf *out,
 			struct strbuf val = STRBUF_INIT;
 
 			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
-			if (opts->unfold)
-				unfold_value(&val);
+			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
+				if (opts->unfold)
+					unfold_value(&val);
 
-			strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+				strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
 
diff --git a/trailer.h b/trailer.h
index b99773964..5255b676d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -72,6 +72,8 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	int (*filter)(const struct strbuf *, void *);
+	void *filter_data;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.17.1

