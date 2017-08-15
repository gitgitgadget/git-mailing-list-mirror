Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759DE1F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbdHOKZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:25:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:39326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753490AbdHOKZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:25:29 -0400
Received: (qmail 31650 invoked by uid 109); 15 Aug 2017 10:25:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 10:25:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9894 invoked by uid 111); 15 Aug 2017 10:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 06:25:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 06:25:27 -0400
Date:   Tue, 15 Aug 2017 06:25:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 8/8] pretty: support normalization options for %(trailers)
Message-ID: <20170815102527.5rblspnpao67srtq@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interpret-trailers command recently learned some options
to make its output easier to parse (for a caller whose only
interested in picking out the trailer values). But it's not
very efficient for asking for the trailers of many commits
in a single invocation.

We already have "%(trailers)" to do that, but it doesn't
know about unfolding or omitting non-trailers. Let's plumb
those options through, so you can have the best of both.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt |  5 ++++-
 pretty.c                         | 15 ++++++++++++---
 t/t4205-log-pretty-formats.sh    | 33 +++++++++++++++++++++++++++++++++
 trailer.c                        | 32 ++++++++++++++++++++++++++++++--
 4 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 973d19606b..d433d50f81 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -205,7 +205,10 @@ endif::git-rev-list[]
 - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
 - %(trailers): display the trailers of the body as interpreted by
-  linkgit:git-interpret-trailers[1]
+  linkgit:git-interpret-trailers[1]. If the `:only` option is given,
+  omit non-trailer lines from the trailer block.  If the `:unfold`
+  option is given, behave as if interpret-trailer's `--unfold` option
+  was given. E.g., `%(trailers:only:unfold)` to do both.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 99b309bb15..94eab5c89e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1064,6 +1064,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
+	const char *arg;
 	int ch;
 
 	/* these are independent of the commit */
@@ -1282,10 +1283,18 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	}
 
-	if (starts_with(placeholder, "(trailers)")) {
+	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-		format_trailers_from_commit(sb, msg + c->subject_off, &opts);
-		return strlen("(trailers)");
+		while (*arg == ':') {
+			if (skip_prefix(arg, ":only", &arg))
+				opts.only_trailers = 1;
+			else if (skip_prefix(arg, ":unfold", &arg))
+				opts.unfold = 1;
+		}
+		if (*arg == ')') {
+			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
+			return arg - placeholder + 1;
+		}
 	}
 
 	return 0;	/* unknown placeholder */
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 83ea85eb45..ec5f530102 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -543,6 +543,10 @@ Signed-off-by: A U Thor
   <author@example.com>
 EOF
 
+unfold () {
+	perl -0pe 's/\n\s+/ /'
+}
+
 test_expect_success 'set up trailer tests' '
 	echo "Some contents" >trailerfile &&
 	git add trailerfile &&
@@ -565,4 +569,33 @@ test_expect_success 'pretty format %(trailers) shows trailers' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:only) shows only "key: value" trailers' '
+	git log --no-walk --pretty="%(trailers:only)" >actual &&
+	{
+		grep -v patch.description <trailers &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:unfold) unfolds trailers' '
+	git log --no-walk --pretty="%(trailers:unfold)" >actual &&
+	{
+		unfold <trailers &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success ':only and :unfold work together' '
+	git log --no-walk --pretty="%(trailers:only:unfold)" >actual &&
+	git log --no-walk --pretty="%(trailers:unfold:only)" >reverse &&
+	test_cmp actual reverse &&
+	{
+		grep -v patch.description <trailers | unfold &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index 2d2b997ccc..5220d498e5 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1096,8 +1096,36 @@ static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
 				const struct process_trailer_options *opts)
 {
-	strbuf_add(out, info->trailer_start,
-		   info->trailer_end - info->trailer_start);
+	int i;
+
+	/* If we want the whole block untouched, we can take the fast path. */
+	if (!opts->only_trailers && !opts->unfold) {
+		strbuf_add(out, info->trailer_start,
+			   info->trailer_end - info->trailer_start);
+		return;
+	}
+
+	for (i = 0; i < info->trailer_nr; i++) {
+		char *trailer = info->trailers[i];
+		int separator_pos = find_separator(trailer, separators);
+
+		if (separator_pos >= 1) {
+			struct strbuf tok = STRBUF_INIT;
+			struct strbuf val = STRBUF_INIT;
+
+			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
+			if (opts->unfold)
+				unfold_value(&val);
+
+			strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+			strbuf_release(&tok);
+			strbuf_release(&val);
+
+		} else if (!opts->only_trailers) {
+			strbuf_addstr(out, trailer);
+		}
+	}
+
 }
 
 void format_trailers_from_commit(struct strbuf *out, const char *msg,
-- 
2.14.1.352.ge5efb0d3f3
