Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14541208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbdHJSEP (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:04:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:34754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753025AbdHJSEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:04:13 -0400
Received: (qmail 19923 invoked by uid 109); 10 Aug 2017 18:04:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 18:04:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6872 invoked by uid 111); 10 Aug 2017 18:04:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 14:04:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 14:04:11 -0400
Date:   Thu, 10 Aug 2017 14:04:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 4/5] interpret-trailers: add an option to normalize output
Message-ID: <20170810180410.6spwzqq6bkzeyqax@sigill.intra.peff.net>
References: <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The point of "--only-trailers" is to give a caller an output
that's easy for them to parse. Getting rid of the
non-trailer material helps, but we still may see more
complicated syntax like whitespace continuation. Let's add
an option to normalize the output into one "key: value" line
per trailer.

As a bonus, this could be used even without --only-trailers
to clean up unusual formatting in the incoming data.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-interpret-trailers.txt |  5 +++++
 builtin/interpret-trailers.c             |  1 +
 t/t7513-interpret-trailers.sh            | 21 ++++++++++++++++++++
 trailer.c                                | 34 +++++++++++++++++++++++++++++++-
 trailer.h                                |  1 +
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 7cc43b0e3e..598b74efd7 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -88,6 +88,11 @@ OPTIONS
 	from the command-line or by following configured `trailer.*`
 	rules.
 
+--normalize::
+	Normalize trailer output so that trailers appear exactly one per
+	line, with any existing whitespace continuation folded into a
+	single line.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 2d90e0e480..b7592bedd9 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -26,6 +26,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
+		OPT_BOOL(0, "normalize", &opts.normalize, N_("normalize trailer formatting")),
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 94b6c52473..37c4f37882 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1330,4 +1330,25 @@ test_expect_success 'only input' '
 	test_cmp expected actual
 '
 
+test_expect_success 'normalize' '
+	cat >expected <<-\EOF &&
+		foo: continued across several lines
+	EOF
+	# pass through tr to make leading and trailing whitespace more obvious
+	tr _ " " <<-\EOF |
+		my subject
+
+		my body
+
+		foo:_
+		__continued
+		___across
+		____several
+		_____lines
+		___
+	EOF
+	git interpret-trailers --only-trailers --only-input --normalize >actual &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index 2b5269183a..07ef082284 100644
--- a/trailer.c
+++ b/trailer.c
@@ -887,7 +887,35 @@ static int ends_with_blank_line(const char *buf, size_t len)
 	return is_blank_line(buf + ll);
 }
 
+static void normalize_value(struct strbuf *val)
+{
+	struct strbuf out = STRBUF_INIT;
+	size_t i;
+
+	strbuf_grow(&out, val->len);
+	i = 0;
+	while (i < val->len) {
+		char c = val->buf[i++];
+		if (c == '\n') {
+			/* Collapse continuation down to a single space. */
+			while (i < val->len && isspace(val->buf[i]))
+				i++;
+			strbuf_addch(&out, ' ');
+		} else {
+			strbuf_addch(&out, c);
+		}
+	}
+
+	/* Empty lines may have left us with whitespace cruft at the edges */
+	strbuf_trim(&out);
+
+	/* output goes back to val as if we modified it in-place */
+	strbuf_swap(&out, val);
+	strbuf_release(&out);
+}
+
 static int process_input_file(FILE *outfile,
+			      int normalize,
 			      const char *str,
 			      struct list_head *head)
 {
@@ -914,12 +942,16 @@ static int process_input_file(FILE *outfile,
 		if (separator_pos >= 1) {
 			parse_trailer(&tok, &val, NULL, trailer,
 				      separator_pos);
+			if (normalize)
+				normalize_value(&val);
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
 		} else {
 			strbuf_addstr(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
+			if (normalize)
+				normalize_value(&val);
 			add_trailer_item(head,
 					 NULL,
 					 strbuf_detach(&val, NULL));
@@ -989,7 +1021,7 @@ void process_trailers(const char *file,
 
 	/* Print the lines before the trailers */
 	trailer_end = process_input_file(opts->only_trailers ? NULL : outfile,
-					 sb.buf, &head);
+					 opts->normalize, sb.buf, &head);
 
 	if (!opts->only_input) {
 		LIST_HEAD(arg_head);
diff --git a/trailer.h b/trailer.h
index 76c3b571bf..55bdec8320 100644
--- a/trailer.h
+++ b/trailer.h
@@ -27,6 +27,7 @@ struct process_trailer_options {
 	int trim_empty;
 	int only_trailers;
 	int only_input;
+	int normalize;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.14.0.614.g0beb26d5e9

