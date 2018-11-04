Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDB21F453
	for <e@80x24.org>; Sun,  4 Nov 2018 15:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbeKEAj7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 19:39:59 -0500
Received: from 0x63.nu ([109.74.10.199]:37254 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbeKEAj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 19:39:59 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJKGQ-0005Wk-Mc; Sun, 04 Nov 2018 16:24:36 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v2 5/5] pretty: add support for separator option in %(trailers)
Date:   Sun,  4 Nov 2018 16:22:32 +0100
Message-Id: <20181104152232.20671-6-anders@0x63.nu>
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

By default trailer lines are terminated by linebreaks ('\n'). By
specifying the new 'separator' option they will instead be separated by
user provided string and have separator semantics rather than terminator
semantics. The separator string can contain the fundamental formatting
codes %n and %xNN allowing it to be things that are otherwise hard to
type as %x00, or command and end-parenthesis which would break parsing.

E.g:
 $ git log --pretty='%(trailers:key=Reviewed-by,nokey,separator=%x00)'

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 13 ++++++++-----
 pretty.c                         | 13 +++++++++++++
 t/t4205-log-pretty-formats.sh    |  6 ++++++
 trailer.c                        | 20 +++++++++++++++++---
 trailer.h                        |  1 +
 5 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e115e355d..3312850e6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -213,11 +213,14 @@ endif::git-rev-list[]
   allowed options are `only` which omits non-trailer lines from the
   trailer block, `unfold` to make it behave as if interpret-trailer's
   `--unfold` option was given, `key=T` to only show trailers with
-  specified key (matching is done case-insensitively), and `nokey`
-  which makes it skip over the key part of the trailer and only show
-  value. E.g. `%(trailers:only,unfold)` unfolds and shows all trailer
-  lines, `%(trailers:key=Reviewed-by,unfold)` unfolds and shows
-  trailer lines with key `Reviewed-by`.
+  specified key (matching is done case-insensitively), `nokey` which
+  makes it skip over the key part of the trailer and only show value
+  and `separator` which allows specifying an alternative separator
+  than the default line
+  break. E.g. `%(trailers:only,unfold,separator=%x00)` unfolds and
+  shows all trailer lines separated by NUL character,
+  `%(trailers:key=Reviewed-by,unfold)` unfolds and shows trailer lines
+  with key `Reviewed-by`.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 9fdddce9d..f73a2b0dc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1327,6 +1327,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+		struct strbuf sepbuf = STRBUF_INIT;
 		size_t ret = 0;
 
 		opts.no_divider = 1;
@@ -1352,6 +1353,17 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 						arg++;
 
 					opts.only_trailers = 1;
+				} else if (skip_prefix(arg, "separator=", &arg)) {
+					size_t seplen = strcspn(arg, ",)");
+					strbuf_reset(&sepbuf);
+					char *fmt = xstrndup(arg, seplen);
+					strbuf_expand(&sepbuf, fmt, format_fundamental, NULL);
+					free(fmt);
+					opts.separator = &sepbuf;
+
+					arg += seplen;
+					if (*arg == ',')
+						arg++;
 				} else
 					break;
 			}
@@ -1360,6 +1372,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
 			ret = arg - placeholder + 1;
 		}
+		strbuf_release (&sepbuf);
 		free(opts.filter_key);
 		return ret;
 	}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e7de3b18a..71218d22e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -652,6 +652,12 @@ test_expect_success '%(trailers:key=foo,nokey) shows only value' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:separator) changes separator' '
+	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
+	printf "XSigned-off-by: A U Thor <author@example.com>\0Acked-by: A U Thor <author@example.com>\0[ v2 updated patch description ]\0Signed-off-by: A U Thor <author@example.com>X" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index 4f19c34cb..a79e4e36a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1129,10 +1129,11 @@ static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
 				const struct process_trailer_options *opts)
 {
+	int first_printed = 0;
 	size_t i;
 
 	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold) {
+	if (!opts->only_trailers && !opts->unfold && !opts->separator) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
@@ -1150,16 +1151,29 @@ static void format_trailer_info(struct strbuf *out,
 			if (!opts->filter_key || !strcasecmp (tok.buf, opts->filter_key)) {
 				if (opts->unfold)
 					unfold_value(&val);
+				if (opts->separator && first_printed)
+					strbuf_addbuf(out, opts->separator);
 				if (opts->no_key)
-					strbuf_addf(out, "%s\n", val.buf);
+					strbuf_addf(out, "%s", val.buf);
 				else
-					strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+					strbuf_addf(out, "%s: %s", tok.buf, val.buf);
+				if (!opts->separator)
+					strbuf_addch(out, '\n');
+
+				first_printed = 1;
 			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
 
 		} else if (!opts->only_trailers) {
+			if (opts->separator && first_printed) {
+				strbuf_addbuf(out, opts->separator);
+			}
 			strbuf_addstr(out, trailer);
+			if (opts->separator) {
+				strbuf_rtrim(out);
+			}
+			first_printed = 1;
 		}
 	}
 
diff --git a/trailer.h b/trailer.h
index 83de87ee9..0e9d89660 100644
--- a/trailer.h
+++ b/trailer.h
@@ -74,6 +74,7 @@ struct process_trailer_options {
 	int no_divider;
 	int no_key;
 	char *filter_key;
+	const struct strbuf *separator;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.17.1

