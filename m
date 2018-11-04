Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50811F453
	for <e@80x24.org>; Sun,  4 Nov 2018 15:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeKEAjx (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 19:39:53 -0500
Received: from 0x63.nu ([109.74.10.199]:37224 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbeKEAjx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 19:39:53 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJKGM-0005Wk-Eu; Sun, 04 Nov 2018 16:24:30 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v2 2/5] pretty: allow showing specific trailers
Date:   Sun,  4 Nov 2018 16:22:29 +0100
Message-Id: <20181104152232.20671-3-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104152232.20671-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181104152232.20671-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a new "key=X" option to "%(trailers)" which will cause it to only
print trailers lines which matches the specified key.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 13 +++++----
 pretty.c                         | 15 ++++++++++-
 t/t4205-log-pretty-formats.sh    | 45 ++++++++++++++++++++++++++++++++
 trailer.c                        |  8 +++---
 trailer.h                        |  1 +
 5 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 417b638cd..8326fc45e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -209,11 +209,14 @@ endif::git-rev-list[]
   respectively, but padding both sides (i.e. the text is centered)
 - %(trailers[:options]): display the trailers of the body as interpreted
   by linkgit:git-interpret-trailers[1]. The `trailers` string may be
-  followed by a colon and zero or more comma-separated options. If the
-  `only` option is given, omit non-trailer lines from the trailer block.
-  If the `unfold` option is given, behave as if interpret-trailer's
-  `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
-  both.
+  followed by a colon and zero or more comma-separated options. The
+  allowed options are `only` which omits non-trailer lines from the
+  trailer block, `unfold` to make it behave as if interpret-trailer's
+  `--unfold` option was given, and `key=T` to only show trailers with
+  specified key (matching is done
+  case-insensitively). E.g. `%(trailers:only,unfold)` unfolds and
+  shows all trailer lines, `%(trailers:key=Reviewed-by,unfold)`
+  unfolds and shows trailer lines with key `Reviewed-by`.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index aa03d5b23..cdca9dce2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1323,7 +1323,19 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.only_trailers = 1;
 				else if (match_placeholder_arg(arg, "unfold", &arg))
 					opts.unfold = 1;
-				else
+				else if (skip_prefix(arg, "key=", &arg)) {
+					const char *end = arg + strcspn(arg, ",)");
+
+					if (opts.filter_key)
+						free(opts.filter_key);
+
+					opts.filter_key = xstrndup(arg, end - arg);
+					arg = end;
+					if (*arg == ',')
+						arg++;
+
+					opts.only_trailers = 1;
+				} else
 					break;
 			}
 		}
@@ -1331,6 +1343,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
 			ret = arg - placeholder + 1;
 		}
+		free(opts.filter_key);
 		return ret;
 	}
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 978a8a66f..0f5207242 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -598,6 +598,51 @@ test_expect_success ':only and :unfold work together' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:key=foo) shows that trailer' '
+	git log --no-walk --pretty="%(trailers:key=Acked-by)" >actual &&
+	{
+		echo "Acked-by: A U Thor <author@example.com>" &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty format %(trailers:key=foo) is case insensitive' '
+	git log --no-walk --pretty="%(trailers:key=AcKed-bY)" >actual &&
+	{
+		echo "Acked-by: A U Thor <author@example.com>" &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=nonexistant) becomes empty' '
+	git log --no-walk --pretty="x%(trailers:key=Nacked-by)x" >actual &&
+	{
+		echo "xx"
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=foo) handles multiple lines even if folded' '
+	git log --no-walk --pretty="%(trailers:key=Signed-Off-by)" >actual &&
+	{
+		grep -v patch.description <trailers | grep -v Acked-by &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
+	git log --no-walk --pretty="%(trailers:key=Signed-Off-by,unfold)" >actual &&
+	{
+		echo "Signed-off-by: A U Thor <author@example.com>" &&
+		echo "Signed-off-by: A U Thor <author@example.com>" &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index 0796f326b..cbbb553e4 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1147,10 +1147,12 @@ static void format_trailer_info(struct strbuf *out,
 			struct strbuf val = STRBUF_INIT;
 
 			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
-			if (opts->unfold)
-				unfold_value(&val);
+			if (!opts->filter_key || !strcasecmp (tok.buf, opts->filter_key)) {
+				if (opts->unfold)
+					unfold_value(&val);
 
-			strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+				strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
 
diff --git a/trailer.h b/trailer.h
index b99773964..d052d02ae 100644
--- a/trailer.h
+++ b/trailer.h
@@ -72,6 +72,7 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	char *filter_key;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.17.1

