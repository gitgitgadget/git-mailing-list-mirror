Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5665D1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 12:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbdHIMYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:24:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:33208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751917AbdHIMYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:24:42 -0400
Received: (qmail 3080 invoked by uid 109); 9 Aug 2017 12:24:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:24:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26714 invoked by uid 111); 9 Aug 2017 12:25:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:25:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:24:40 -0400
Date:   Wed, 9 Aug 2017 08:24:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] interpret-trailers: add an option to show only existing
 trailers
Message-ID: <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be useful to invoke interpret-trailers for the
primary purpose of parsing existing trailers. But in that
case, we don't want to apply existing ifMissing or ifExists
rules from the config. Let's add a special mode where we
avoid applying those rules. Coupled with --only-trailers,
this gives us a reasonable parsing tool.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-interpret-trailers.txt |  5 +++++
 builtin/interpret-trailers.c             |  7 +++++++
 t/t7513-interpret-trailers.sh            | 15 +++++++++++++++
 trailer.c                                |  7 ++++---
 trailer.h                                |  1 +
 5 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 295dffbd21..b2a8fad248 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -83,6 +83,11 @@ OPTIONS
 --only-trailers::
 	Output only the trailers, not any other parts of the input.
 
+--only-existing::
+	Output only trailers that exist in the input; do not add any
+	from the command-line or by following configured `trailer.*`
+	rules.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index afb12c11bc..a49f94ba34 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -25,6 +25,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
+		OPT_BOOL(0, "only-existing", &opts.only_existing, N_("output only existing trailers")),
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
@@ -33,6 +34,12 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_interpret_trailers_usage, 0);
 
+	if (opts.only_existing && trailers.nr)
+		usage_msg_opt(
+			_("--trailer with --only-existing does not make sense"),
+			git_interpret_trailers_usage,
+			options);
+
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index e5b0718ef6..525fd53e5b 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1312,4 +1312,19 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
 	test_cmp expected actual
 '
 
+test_expect_success 'only existing' '
+	cat >expected <<-\EOF &&
+		existing: existing-value
+	EOF
+	git interpret-trailers \
+		--only-trailers --only-existing >actual <<-\EOF &&
+		my subject
+
+		my body
+
+		existing: existing-value
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index a4ff99f98a..88f6efe523 100644
--- a/trailer.c
+++ b/trailer.c
@@ -991,9 +991,10 @@ void process_trailers(const char *file, struct process_trailer_options *opts,
 	trailer_end = process_input_file(opts->only_trailers ? NULL : outfile,
 					 sb.buf, &head);
 
-	process_command_line_args(&arg_head, trailers);
-
-	process_trailers_lists(&head, &arg_head);
+	if (!opts->only_existing) {
+		process_command_line_args(&arg_head, trailers);
+		process_trailers_lists(&head, &arg_head);
+	}
 
 	print_all(outfile, &head, opts);
 
diff --git a/trailer.h b/trailer.h
index 4270849d80..6356b890ba 100644
--- a/trailer.h
+++ b/trailer.h
@@ -26,6 +26,7 @@ struct process_trailer_options {
 	int in_place;
 	int trim_empty;
 	int only_trailers;
+	int only_existing;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.14.0.609.gd2d1f7ddf

