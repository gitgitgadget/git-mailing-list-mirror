Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DF61F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbdHOKXY (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:23:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:39260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753704AbdHOKXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:23:23 -0400
Received: (qmail 31472 invoked by uid 109); 15 Aug 2017 10:23:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 10:23:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9762 invoked by uid 111); 15 Aug 2017 10:23:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 06:23:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 06:23:21 -0400
Date:   Tue, 15 Aug 2017 06:23:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 2/8] interpret-trailers: add an option to show only the
 trailers
Message-ID: <20170815102321.xpa3ywfizykyq4tz@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In theory it's easy for any reader who wants to parse
trailers to do so. But there are a lot of subtle corner
cases around what counts as a trailer, when the trailer
block begins and ends, etc. Since interpret-trailers already
has our parsing logic, let's let callers ask it to just
output the trailers.

They still have to parse the "key: value" lines, but at
least they can ignore all of the other corner cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-interpret-trailers.txt |  3 +++
 builtin/interpret-trailers.c             |  1 +
 t/t7513-interpret-trailers.sh            | 39 ++++++++++++++++++++++++++++++++
 trailer.c                                | 23 +++++++++++--------
 trailer.h                                |  1 +
 5 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 31cdeaecdf..295dffbd21 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -80,6 +80,9 @@ OPTIONS
 	trailer to the input messages. See the description of this
 	command.
 
+--only-trailers::
+	Output only the trailers, not any other parts of the input.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index bb0d7b937a..afb12c11bc 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -24,6 +24,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
+		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 0c6f91c433..90d30037b7 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1275,4 +1275,43 @@ test_expect_success 'with cut line' '
 	test_cmp expected actual
 '
 
+test_expect_success 'only trailers' '
+	git config trailer.sign.command "echo config-value" &&
+	cat >expected <<-\EOF &&
+		existing: existing-value
+		sign: config-value
+		added: added-value
+	EOF
+	git interpret-trailers \
+		--trailer added:added-value \
+		--only-trailers >actual <<-\EOF &&
+		my subject
+
+		my body
+
+		existing: existing-value
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'only-trailers omits non-trailer in middle of block' '
+	git config trailer.sign.command "echo config-value" &&
+	cat >expected <<-\EOF &&
+		Signed-off-by: nobody <nobody@nowhere>
+		Signed-off-by: somebody <somebody@somewhere>
+		sign: config-value
+	EOF
+	git interpret-trailers --only-trailers >actual <<-\EOF &&
+		subject
+
+		it is important that the trailers below are signed-off-by
+		so that they meet the "25% trailers Git knows about" heuristic
+
+		Signed-off-by: nobody <nobody@nowhere>
+		this is not a trailer
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index e21a0d1629..22146002e9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -164,13 +164,15 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
+static void print_all(FILE *outfile, struct list_head *head,
+		      const struct process_trailer_options *opts)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct trailer_item, list);
-		if (!trim_empty || strlen(item->value) > 0)
+		if ((!opts->trim_empty || strlen(item->value) > 0) &&
+		    (!opts->only_trailers || item->token))
 			print_tok_val(outfile, item->token, item->value);
 	}
 }
@@ -887,7 +889,8 @@ static int ends_with_blank_line(const char *buf, size_t len)
 
 static int process_input_file(FILE *outfile,
 			      const char *str,
-			      struct list_head *head)
+			      struct list_head *head,
+			      const struct process_trailer_options *opts)
 {
 	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
@@ -897,9 +900,10 @@ static int process_input_file(FILE *outfile,
 	trailer_info_get(&info, str);
 
 	/* Print lines before the trailers as is */
-	fwrite(str, 1, info.trailer_start - str, outfile);
+	if (!opts->only_trailers)
+		fwrite(str, 1, info.trailer_start - str, outfile);
 
-	if (!info.blank_line_before_trailer)
+	if (!opts->only_trailers && !info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
 
 	for (i = 0; i < info.trailer_nr; i++) {
@@ -914,7 +918,7 @@ static int process_input_file(FILE *outfile,
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
-		} else {
+		} else if (!opts->only_trailers) {
 			strbuf_addstr(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(head,
@@ -986,18 +990,19 @@ void process_trailers(const char *file,
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(outfile, sb.buf, &head);
+	trailer_end = process_input_file(outfile, sb.buf, &head, opts);
 
 	process_command_line_args(&arg_head, trailers);
 
 	process_trailers_lists(&head, &arg_head);
 
-	print_all(outfile, &head, opts->trim_empty);
+	print_all(outfile, &head, opts);
 
 	free_all(&head);
 
 	/* Print the lines after the trailers as is */
-	fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
+	if (!opts->only_trailers)
+		fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.h b/trailer.h
index 9da00bedec..3cf35ced00 100644
--- a/trailer.h
+++ b/trailer.h
@@ -25,6 +25,7 @@ struct trailer_info {
 struct process_trailer_options {
 	int in_place;
 	int trim_empty;
+	int only_trailers;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.14.1.352.ge5efb0d3f3

