Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CEE1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 11:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeKRWFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 17:05:32 -0500
Received: from 0x63.nu ([109.74.10.199]:54720 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbeKRWFc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 17:05:32 -0500
Received: from localhost ([127.0.0.1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gOLVz-0003J7-14; Sun, 18 Nov 2018 12:45:23 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v3 5/5] pretty: add support for separator option in %(trailers)
Date:   Sun, 18 Nov 2018 12:44:27 +0100
Message-Id: <20181118114427.1397-6-anders@0x63.nu>
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

By default trailer lines are terminated by linebreaks ('\n'). By
specifying the new 'separator' option they will instead be separated by
user provided string and have separator semantics rather than terminator
semantics. The separator string can contain the literal formatting codes
%n and %xNN allowing it to be things that are otherwise hard to type as
%x00, or comma and end-parenthesis which would break parsing.

E.g:
 $ git log --pretty='%(trailers:key=Reviewed-by,valueonly,separator=%x00)'

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 13 +++++++++---
 pretty.c                         | 15 +++++++++++++
 t/t4205-log-pretty-formats.sh    | 36 ++++++++++++++++++++++++++++++++
 trailer.c                        | 15 +++++++++++--
 trailer.h                        |  1 +
 5 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 8cc8c3f9f..30e238338 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -218,9 +218,16 @@ endif::git-rev-list[]
      is given multiple times only last one is used.
   ** 'valueonly': skip over the key part of the trailer and only show
      the its value part.
-  ** Examples: `%(trailers:only,unfold)` unfolds and shows all trailer
-     lines, `%(trailers:key=Reviewed-by,unfold)` unfolds and shows
-     trailer lines with key `Reviewed-by`.
+  ** 'separator=<SEP>': specifying an alternative separator than the
+     default line feed character. SEP may can contain the literal
+     formatting codes %n and %xNN allowing it to contain characters
+     that are hard to type such as %x00, or comma and end-parenthesis
+     which would break parsing. If option is given multiple times only
+     the last one is used.
+  ** Examples: `%(trailers:only,unfold,separator=%x00)` unfolds and
+     shows all trailer lines separated by NUL character,
+     `%(trailers:key=Reviewed-by,unfold)` unfolds and shows trailer
+     lines with key `Reviewed-by`.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 819c5c50a..5b22a7237 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1318,6 +1318,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 		struct format_trailer_match_data filter_data;
+		struct strbuf sepbuf = STRBUF_INIT;
 		size_t ret = 0;
 
 		opts.no_divider = 1;
@@ -1348,6 +1349,19 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					arg = end;
 					if (*arg == ',')
 						arg++;
+				} else if (skip_prefix(arg, "separator=", &arg)) {
+					size_t seplen = strcspn(arg, ",)");
+					char *fmt;
+
+					strbuf_reset(&sepbuf);
+					fmt = xstrndup(arg, seplen);
+					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
+					free(fmt);
+					opts.separator = &sepbuf;
+
+					arg += seplen;
+					if (*arg == ',')
+						arg++;
 				} else
 					break;
 			}
@@ -1356,6 +1370,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
 			ret = arg - placeholder + 1;
 		}
+		strbuf_release(&sepbuf);
 		return ret;
 	}
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 095208d6b..562b56dda 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -640,6 +640,42 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:separator) changes separator' '
+	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
+	printf "XSigned-off-by: A U Thor <author@example.com>\0Acked-by: A U Thor <author@example.com>\0[ v2 updated patch description ]\0Signed-off-by: A U Thor <author@example.com>X" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty format %(trailers) combining separator/key/valueonly' '
+	git commit --allow-empty -F - <<-\EOF &&
+	Important fix
+
+	The fix is explained here
+
+	Closes: #1234
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	Another fix
+
+	The fix is explained here
+
+	Closes: #567
+	Closes: #890
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	Does not close any tickets
+	EOF
+
+	git log --pretty="%s% (trailers:separator=%x2c%x20,key=Closes,valueonly)" HEAD~3.. >actual &&
+	test_write_lines \
+		"Does not close any tickets" \
+		"Another fix #567, #890" \
+		"Important fix #1234" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index 662c7ff03..85cd2e52e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1129,10 +1129,11 @@ static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
 				const struct process_trailer_options *opts)
 {
+	size_t origlen = out->len;
 	size_t i;
 
 	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold) {
+	if (!opts->only_trailers && !opts->unfold && !opts->separator) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
@@ -1150,16 +1151,26 @@ static void format_trailer_info(struct strbuf *out,
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->unfold)
 					unfold_value(&val);
+
+				if (opts->separator && out->len != origlen)
+					strbuf_addbuf(out, opts->separator);
 				if (!opts->value_only)
 					strbuf_addf(out, "%s: ", tok.buf);
 				strbuf_addbuf(out, &val);
-				strbuf_addch(out, '\n');
+				if (!opts->separator)
+					strbuf_addch(out, '\n');
 			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
 
 		} else if (!opts->only_trailers) {
+			if (opts->separator && out->len != origlen) {
+				strbuf_addbuf(out, opts->separator);
+			}
 			strbuf_addstr(out, trailer);
+			if (opts->separator) {
+				strbuf_rtrim(out);
+			}
 		}
 	}
 
diff --git a/trailer.h b/trailer.h
index 06d417fe9..203acf4ee 100644
--- a/trailer.h
+++ b/trailer.h
@@ -73,6 +73,7 @@ struct process_trailer_options {
 	int unfold;
 	int no_divider;
 	int value_only;
+	const struct strbuf *separator;
 	int (*filter)(const struct strbuf *, void *);
 	void *filter_data;
 };
-- 
2.17.1

