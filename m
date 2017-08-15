Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9A11F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbdHOKXh (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:23:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:39290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753738AbdHOKXg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:23:36 -0400
Received: (qmail 31514 invoked by uid 109); 15 Aug 2017 10:23:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 10:23:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9816 invoked by uid 111); 15 Aug 2017 10:24:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 06:24:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 06:23:34 -0400
Date:   Tue, 15 Aug 2017 06:23:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 5/8] interpret-trailers: add --parse convenience option
Message-ID: <20170815102334.qc4w7akl44bti44x@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last few commits have added command line options that
can turn interpret-trailers into a parsing tool. Since
they'd most often be used together, let's provide a
convenient single option for callers to invoke this mode.

This is implemented as a callback rather than a boolean so
that its effect is applied immediately, as if those options
had been specified. Later options can then override them.
E.g.:

  git interpret-trailers --parse --no-unfold

would work.

Let's also update the documentation to make clear that this
parsing mode behaves quite differently than the normal
"add trailers to the input" mode.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-interpret-trailers.txt | 21 ++++++++++++++-------
 builtin/interpret-trailers.c             | 12 ++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index be948e8028..1df8aabf51 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -3,24 +3,27 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - help add structured information into commit messages
+git-interpret-trailers - add or parse structured information in commit messages
 
 SYNOPSIS
 --------
 [verse]
-'git interpret-trailers' [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]
+'git interpret-trailers' [options] [(--trailer <token>[(=|:)<value>])...] [<file>...]
+'git interpret-trailers' [options] [--parse] [<file>...]
 
 DESCRIPTION
 -----------
-Help adding 'trailers' lines, that look similar to RFC 822 e-mail
+Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
 This command reads some patches or commit messages from either the
-<file> arguments or the standard input if no <file> is specified. Then
-this command applies the arguments passed using the `--trailer`
-option, if any, to the commit message part of each input file. The
-result is emitted on the standard output.
+<file> arguments or the standard input if no <file> is specified. If
+`--parse` is specified, the output consists of the parsed trailers.
+
+Otherwise, the this command applies the arguments passed using the
+`--trailer` option, if any, to the commit message part of each input
+file. The result is emitted on the standard output.
 
 Some configuration variables control the way the `--trailer` arguments
 are applied to each commit message and the way any existing trailer in
@@ -92,6 +95,10 @@ OPTIONS
 	Remove any whitespace-continuation in trailers, so that each
 	trailer appears on a line by itself with its full content.
 
+--parse::
+	A convenience alias for `--only-trailers --only-input
+	--unfold`.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 922c3bad63..555111a078 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -16,6 +16,16 @@ static const char * const git_interpret_trailers_usage[] = {
 	NULL
 };
 
+static int parse_opt_parse(const struct option *opt, const char *arg,
+			   int unset)
+{
+	struct process_trailer_options *v = opt->value;
+	v->only_trailers = 1;
+	v->only_input = 1;
+	v->unfold = 1;
+	return 0;
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
@@ -27,6 +37,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
+		{ OPTION_CALLBACK, 0, "parse", &opts, NULL, N_("set parsing options"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse },
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
-- 
2.14.1.352.ge5efb0d3f3

