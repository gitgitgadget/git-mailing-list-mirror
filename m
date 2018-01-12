Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBC41F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeALNiN (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:38:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:42120 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933478AbeALNiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:38:12 -0500
Received: (qmail 4529 invoked by uid 109); 12 Jan 2018 13:38:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:38:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30774 invoked by uid 111); 12 Jan 2018 13:38:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:38:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:38:10 -0500
Date:   Fri, 12 Jan 2018 08:38:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/4] sq_quote_argv: drop maxlen parameter
Message-ID: <20180112133810.GA8290@sigill.intra.peff.net>
References: <20180112133613.GF27499@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180112133613.GF27499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No caller passes anything but "0" for this parameter, which
requests that the function ignore it completely. In fact, in
all of history there was only one such caller, and it went
away in 7f51f8bc2b (alias: use run_command api to execute
aliases, 2011-01-07).

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup, though it touches the caller you just added, too.

 builtin/am.c        | 2 +-
 builtin/rev-parse.c | 4 ++--
 quote.c             | 4 +---
 quote.h             | 2 +-
 trace.c             | 6 +++---
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..5bdd2d7578 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1061,7 +1061,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	}
 	write_state_text(state, "scissors", str);
 
-	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
+	sq_quote_argv(&sb, state->git_apply_opts.argv);
 	write_state_text(state, "apply-opt", sb.buf);
 
 	if (state->rebasing)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 74aa644cbb..96d06a5d01 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -516,7 +516,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_SHELL_EVAL);
 
 	strbuf_addstr(&parsed, " --");
-	sq_quote_argv(&parsed, argv, 0);
+	sq_quote_argv(&parsed, argv);
 	puts(parsed.buf);
 	return 0;
 }
@@ -526,7 +526,7 @@ static int cmd_sq_quote(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 
 	if (argc)
-		sq_quote_argv(&buf, argv, 0);
+		sq_quote_argv(&buf, argv);
 	printf("%s\n", buf.buf);
 	strbuf_release(&buf);
 
diff --git a/quote.c b/quote.c
index de2922ddd6..b2970da627 100644
--- a/quote.c
+++ b/quote.c
@@ -56,7 +56,7 @@ void sq_quotef(struct strbuf *dst, const char *fmt, ...)
 	strbuf_release(&src);
 }
 
-void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
+void sq_quote_argv(struct strbuf *dst, const char **argv)
 {
 	int i;
 
@@ -65,8 +65,6 @@ void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 	for (i = 0; argv[i]; ++i) {
 		strbuf_addch(dst, ' ');
 		sq_quote_buf(dst, argv[i]);
-		if (maxlen && dst->len > maxlen)
-			die("Too many or long arguments");
 	}
 }
 
diff --git a/quote.h b/quote.h
index 66f5644aa2..48a75a416b 100644
--- a/quote.h
+++ b/quote.h
@@ -30,7 +30,7 @@ struct strbuf;
  */
 
 extern void sq_quote_buf(struct strbuf *, const char *src);
-extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
+extern void sq_quote_argv(struct strbuf *, const char **argv);
 extern void sq_quotef(struct strbuf *, const char *fmt, ...);
 
 /* This unwraps what sq_quote() produces in place, but returns
diff --git a/trace.c b/trace.c
index a1f871e720..973e462a2c 100644
--- a/trace.c
+++ b/trace.c
@@ -158,7 +158,7 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	strbuf_vaddf(&buf, format, ap);
 
-	sq_quote_argv(&buf, argv, 0);
+	sq_quote_argv(&buf, argv);
 	print_trace_line(&trace_default_key, &buf);
 }
 
@@ -374,7 +374,7 @@ void trace_run_command(const struct child_process *cp)
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
 
-	sq_quote_argv(&buf, cp->argv, 0);
+	sq_quote_argv(&buf, cp->argv);
 	print_trace_line(&trace_default_key, &buf);
 }
 
@@ -532,6 +532,6 @@ void trace_command_performance(const char **argv)
 		atexit(print_command_performance_atexit);
 
 	strbuf_reset(&command_line);
-	sq_quote_argv(&command_line, argv, 0);
+	sq_quote_argv(&command_line, argv);
 	command_start_time = getnanotime();
 }
-- 
2.16.0.rc1.459.g7b9f90244d

