Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E99920899
	for <e@80x24.org>; Thu, 10 Aug 2017 08:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbdHJID3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 04:03:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:34198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751456AbdHJIDY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 04:03:24 -0400
Received: (qmail 27072 invoked by uid 109); 10 Aug 2017 08:03:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 08:03:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2436 invoked by uid 111); 10 Aug 2017 08:03:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 04:03:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 04:03:22 -0400
Date:   Thu, 10 Aug 2017 04:03:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] interpret-trailers: add an option to show only existing
 trailers
Message-ID: <20170810080322.3jlbzjmmxg2jidbg@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
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
 t/t7513-interpret-trailers.sh            | 16 ++++++++++++++++
 trailer.c                                |  9 +++++----
 trailer.h                                |  1 +
 5 files changed, 34 insertions(+), 4 deletions(-)

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
index 90d30037b7..97f4ac0fb3 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1314,4 +1314,20 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
 	test_cmp expected actual
 '
 
+test_expect_success 'only existing' '
+	git config trailer.sign.command "echo config-value" &&
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
index 706351fc98..3abac3db37 100644
--- a/trailer.c
+++ b/trailer.c
@@ -976,7 +976,6 @@ void process_trailers(const char *file,
 		      struct string_list *trailers)
 {
 	LIST_HEAD(head);
-	LIST_HEAD(arg_head);
 	struct strbuf sb = STRBUF_INIT;
 	int trailer_end;
 	FILE *outfile = stdout;
@@ -992,9 +991,11 @@ void process_trailers(const char *file,
 	trailer_end = process_input_file(opts->only_trailers ? NULL : outfile,
 					 sb.buf, &head);
 
-	process_command_line_args(&arg_head, trailers);
-
-	process_trailers_lists(&head, &arg_head);
+	if (!opts->only_existing) {
+		LIST_HEAD(arg_head);
+		process_command_line_args(&arg_head, trailers);
+		process_trailers_lists(&head, &arg_head);
+	}
 
 	print_all(outfile, &head, opts);
 
diff --git a/trailer.h b/trailer.h
index 3cf35ced00..96dcbe801a 100644
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
2.14.0.614.g0beb26d5e9

