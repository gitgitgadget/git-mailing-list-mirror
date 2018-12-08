Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B750520A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 16:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLHQhv (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:37:51 -0500
Received: from 0x63.nu ([109.74.10.199]:48572 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeLHQhs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:37:48 -0500
Received: from ip6-localhost ([::1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gVfbu-0000Dk-5n; Sat, 08 Dec 2018 17:37:46 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v4 7/7] pretty: add support for separator option in %(trailers)
Date:   Sat,  8 Dec 2018 17:36:47 +0100
Message-Id: <20181208163647.19538-8-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208163647.19538-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181208163647.19538-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: ::1
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
%n and %xNN allowing it to be things that are otherwise hard to type
such as %x00, or comma and end-parenthesis which would break parsing.

E.g:
 $ git log --pretty='%(trailers:key=Reviewed-by,valueonly,separator=%x00)'

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt |  9 ++++++++
 pretty.c                         | 10 +++++++++
 t/t4205-log-pretty-formats.sh    | 36 ++++++++++++++++++++++++++++++++
 trailer.c                        | 15 +++++++++++--
 trailer.h                        |  1 +
 5 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a920dd15b1..ce087dee80 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -239,6 +239,15 @@ endif::git-rev-list[]
    `false`, `off`, `no` to show the non-trailer lines. If option is
    given without value it is enabled. If given multiple times the last
    value is used.
+** 'separator=<SEP>': specify a separator inserted between trailer
+   lines. When this option is not given each trailer line is
+   terminated with a line feed character. The string SEP may contain
+   the literal formatting codes described above. To use comma as
+   separator one must use `%x2C` as it would otherwise be parsed as
+   next option. If separator option is given multiple times only the
+   last one is used. E.g., `%(trailers:key=Ticket,separator=%x2C )`
+   shows all trailer lines whose key is "Ticket" separated by a comma
+   and a space.
 ** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
    option was given. In same way as to for `only` it can be followed
    by an equal sign and explicit value. E.g.,
diff --git a/pretty.c b/pretty.c
index 50d0b5830d..c7609493ee 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1357,6 +1357,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 		struct string_list filter_list = STRING_LIST_INIT_NODUP;
+		struct strbuf sepbuf = STRBUF_INIT;
 		size_t ret = 0;
 
 		opts.no_divider = 1;
@@ -1376,6 +1377,14 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.filter = format_trailer_match_cb;
 					opts.filter_data = &filter_list;
 					opts.only_trailers = 1;
+				} else if (match_placeholder_arg_value(arg, "separator", &arg, &argval, &arglen)) {
+					char *fmt;
+
+					strbuf_reset(&sepbuf);
+					fmt = xstrndup(argval, arglen);
+					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
+					free(fmt);
+					opts.separator = &sepbuf;
 				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
 					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
 					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
@@ -1387,6 +1396,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			ret = arg - placeholder + 1;
 		}
 		string_list_clear (&filter_list, 0);
+		strbuf_release(&sepbuf);
 		return ret;
 	}
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 22336c5485..282369dac0 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -673,6 +673,42 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
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
index d0d9e91631..0c414f2fed 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1129,10 +1129,11 @@ static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
 				const struct process_trailer_options *opts)
 {
+	size_t origlen = out->len;
 	size_t i;
 
 	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold && !opts->filter) {
+	if (!opts->only_trailers && !opts->unfold && !opts->filter && !opts->separator) {
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
index 06d417fe93..203acf4ee1 100644
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

