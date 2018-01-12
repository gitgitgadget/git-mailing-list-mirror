Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2A71F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933582AbeALNjj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:39:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:42138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933508AbeALNji (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:39:38 -0500
Received: (qmail 4600 invoked by uid 109); 12 Jan 2018 13:39:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:39:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30813 invoked by uid 111); 12 Jan 2018 13:40:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:40:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:39:36 -0500
Date:   Fri, 12 Jan 2018 08:39:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 6/4] trace: avoid unnecessary quoting
Message-ID: <20180112133936.GB8290@sigill.intra.peff.net>
References: <20180112133613.GF27499@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180112133613.GF27499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trace output which contains arbitrary strings (e.g., the
arguments to commands which we are running) is always passed
through sq_quote_buf(). That function always adds
single-quotes, even if the output consists of vanilla
characters. This can make the output a bit hard to read.

Let's avoid the quoting if there are no characters which a
shell would interpret. Trace output doesn't necessarily need
to be shell-compatible, but:

  - the shell language is a good ballpark for what humans
    consider readable (well, humans versed in command line
    tools)

  - the run_command bits can be cut-and-pasted to a shell,
    and we'll keep that property

  - it covers any cases which would make the output
    visually ambiguous (e.g., embedded whitespace or quotes)

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c | 26 ++++++++++++++++++++++++++
 quote.h |  8 ++++++++
 trace.c | 10 +++++-----
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/quote.c b/quote.c
index b2970da627..37d2686865 100644
--- a/quote.c
+++ b/quote.c
@@ -43,6 +43,22 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	free(to_free);
 }
 
+void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
+{
+	static const char ok_punct[] = "+,-./:=@_^";
+	const char *p;
+
+	for (p = src; *p; p++) {
+		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
+			sq_quote_buf(dst, src);
+			return;
+		}
+	}
+
+	/* if we get here, we did not need quoting */
+	strbuf_addstr(dst, src);
+}
+
 void sq_quotef(struct strbuf *dst, const char *fmt, ...)
 {
 	struct strbuf src = STRBUF_INIT;
@@ -68,6 +84,16 @@ void sq_quote_argv(struct strbuf *dst, const char **argv)
 	}
 }
 
+void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
+{
+	int i;
+
+	for (i = 0; argv[i]; i++) {
+		strbuf_addch(dst, ' ');
+		sq_quote_buf_pretty(dst, argv[i]);
+	}
+}
+
 static char *sq_dequote_step(char *arg, char **next)
 {
 	char *dst = arg;
diff --git a/quote.h b/quote.h
index 48a75a416b..ea992dcc91 100644
--- a/quote.h
+++ b/quote.h
@@ -33,6 +33,14 @@ extern void sq_quote_buf(struct strbuf *, const char *src);
 extern void sq_quote_argv(struct strbuf *, const char **argv);
 extern void sq_quotef(struct strbuf *, const char *fmt, ...);
 
+/*
+ * These match their non-pretty variants, except that they avoid
+ * quoting when there are no exotic characters. These should only be used for
+ * human-readable output, as sq_dequote() is not smart enough to dequote it.
+ */
+void sq_quote_buf_pretty(struct strbuf *, const char *src);
+void sq_quote_argv_pretty(struct strbuf *, const char **argv);
+
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
  * produced.
diff --git a/trace.c b/trace.c
index 973e462a2c..aba2825044 100644
--- a/trace.c
+++ b/trace.c
@@ -158,7 +158,7 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	strbuf_vaddf(&buf, format, ap);
 
-	sq_quote_argv(&buf, argv);
+	sq_quote_argv_pretty(&buf, argv);
 	print_trace_line(&trace_default_key, &buf);
 }
 
@@ -341,7 +341,7 @@ static void concatenate_env(struct strbuf *dst, const char *const *deltaenv)
 			continue;
 
 		strbuf_addf(dst, " %s=", env);
-		sq_quote_buf(dst, p);
+		sq_quote_buf_pretty(dst, p);
 	}
 	string_list_clear(&envs, 0);
 }
@@ -360,7 +360,7 @@ void trace_run_command(const struct child_process *cp)
 
 	if (cp->dir) {
 		strbuf_addstr(&buf, " cd ");
-		sq_quote_buf(&buf, cp->dir);
+		sq_quote_buf_pretty(&buf, cp->dir);
 		strbuf_addch(&buf, ';');
 	}
 
@@ -374,7 +374,7 @@ void trace_run_command(const struct child_process *cp)
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
 
-	sq_quote_argv(&buf, cp->argv);
+	sq_quote_argv_pretty(&buf, cp->argv);
 	print_trace_line(&trace_default_key, &buf);
 }
 
@@ -532,6 +532,6 @@ void trace_command_performance(const char **argv)
 		atexit(print_command_performance_atexit);
 
 	strbuf_reset(&command_line);
-	sq_quote_argv(&command_line, argv);
+	sq_quote_argv_pretty(&command_line, argv);
 	command_start_time = getnanotime();
 }
-- 
2.16.0.rc1.459.g7b9f90244d
