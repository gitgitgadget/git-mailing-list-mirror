Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3578920A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 16:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLHQhv (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:37:51 -0500
Received: from 0x63.nu ([109.74.10.199]:48544 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeLHQhr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:37:47 -0500
Received: from ip6-localhost ([::1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gVfbs-0000Dk-Nx; Sat, 08 Dec 2018 17:37:44 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v4 4/7] pretty: allow showing specific trailers
Date:   Sat,  8 Dec 2018 17:36:44 +0100
Message-Id: <20181208163647.19538-5-anders@0x63.nu>
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

Adds a new "key=X" option to "%(trailers)" which will cause it to only
print trailer lines which match any of the specified keys.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt |  8 +++++
 pretty.c                         | 47 ++++++++++++++++++++++++++---
 t/t4205-log-pretty-formats.sh    | 51 ++++++++++++++++++++++++++++++++
 trailer.c                        | 10 ++++---
 trailer.h                        |  2 ++
 5 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d33b072eb2..d6add831c0 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -225,6 +225,14 @@ endif::git-rev-list[]
                           linkgit:git-interpret-trailers[1]. The
                           `trailers` string may be followed by a colon
                           and zero or more comma-separated options:
+** 'key=<K>': only show trailers with specified key. Matching is done
+   case-insensitively and trailing colon is optional. If option is
+   given multiple times trailer lines matching any of the keys are
+   shown. This option automatically enables the `only` option so that
+   non-trailer lines in the trailer block are hidden. If that is not
+   desired it can be disabled with `only=false`.  E.g.,
+   `%(trailers:key=Reviewed-by)` shows trailer lines with key
+   `Reviewed-by`.
 ** 'only[=val]': select whether non-trailer lines from the trailer
    block should be included. The `only` keyword may optionally be
    followed by an equal sign and one of `true`, `on`, `yes` to omit or
diff --git a/pretty.c b/pretty.c
index 044447e6c0..541a553ccc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1056,13 +1056,20 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
-static int match_placeholder_arg(const char *to_parse, const char *candidate,
-				 const char **end)
+static int match_placeholder_arg_value(const char *to_parse, const char *candidate,
+				       const char **end, const char **valuestart, size_t *valuelen)
 {
 	const char *p;
 
 	if (!(skip_prefix(to_parse, candidate, &p)))
 		return 0;
+	if (valuestart) {
+		if (*p != '=')
+			return 0;
+		*valuestart = p + 1;
+		*valuelen = strcspn(*valuestart, ",)");
+		p = *valuestart + *valuelen;
+	}
 	if (*p == ',') {
 		*end = p + 1;
 		return 1;
@@ -1074,6 +1081,12 @@ static int match_placeholder_arg(const char *to_parse, const char *candidate,
 	return 0;
 }
 
+static int match_placeholder_arg(const char *to_parse, const char *candidate,
+				 const char **end)
+{
+	return match_placeholder_arg_value(to_parse, candidate, end, NULL, NULL);
+}
+
 static int match_placeholder_bool_arg(const char *to_parse, const char *candidate,
 				      const char **end, int *val)
 {
@@ -1095,7 +1108,19 @@ static int match_placeholder_bool_arg(const char *to_parse, const char *candidat
 		*val = 1;
 		return 1;
 	}
+	return 0;
+}
 
+static int format_trailer_match_cb(const struct strbuf *key, void *ud)
+{
+	const struct string_list *list = ud;
+	const struct string_list_item *item;
+
+	for_each_string_list_item (item, list) {
+		if (key->len == (uintptr_t)item->util &&
+		    !strncasecmp (item->string, key->buf, key->len))
+			return 1;
+	}
 	return 0;
 }
 
@@ -1337,6 +1362,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+		struct string_list filter_list = STRING_LIST_INIT_NODUP;
 		size_t ret = 0;
 
 		opts.no_divider = 1;
@@ -1344,8 +1370,20 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		if (*arg == ':') {
 			arg++;
 			for (;;) {
-				if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
-				    !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold))
+				const char *argval;
+				size_t arglen;
+
+				if (match_placeholder_arg_value(arg, "key", &arg, &argval, &arglen)) {
+					uintptr_t len = arglen;
+					if (len && argval[len - 1] == ':')
+						len--;
+					string_list_append(&filter_list, argval)->util = (char *)len;
+
+					opts.filter = format_trailer_match_cb;
+					opts.filter_data = &filter_list;
+					opts.only_trailers = 1;
+				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
+					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold))
 					break;
 			}
 		}
@@ -1353,6 +1391,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
 			ret = arg - placeholder + 1;
 		}
+		string_list_clear (&filter_list, 0);
 		return ret;
 	}
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 63730a4ec0..54239290cf 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -616,6 +616,57 @@ test_expect_success ':only and :unfold work together' '
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
+test_expect_success 'pretty format %(trailers:key=foo) multiple keys' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by:,key=Signed-off-By)" >actual &&
+	grep -v patch.description <trailers >expect &&
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
+test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by,only=no)" >actual &&
+	{
+		echo "Acked-by: A U Thor <author@example.com>" &&
+		grep patch.description <trailers
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index 0796f326b3..d6da555cd7 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1132,7 +1132,7 @@ static void format_trailer_info(struct strbuf *out,
 	size_t i;
 
 	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold) {
+	if (!opts->only_trailers && !opts->unfold && !opts->filter) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
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
index b997739649..5255b676de 100644
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

