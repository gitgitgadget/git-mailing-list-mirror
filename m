Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A1020986
	for <e@80x24.org>; Thu, 29 Sep 2016 08:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755664AbcI2IjB (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 04:39:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755381AbcI2Iiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 04:38:54 -0400
Received: (qmail 10580 invoked by uid 109); 29 Sep 2016 08:38:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 08:38:53 +0000
Received: (qmail 32165 invoked by uid 111); 29 Sep 2016 08:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 04:39:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 04:38:51 -0400
Date:   Thu, 29 Sep 2016 04:38:51 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] log: add --commit-header option
Message-ID: <20160929083851.kx6itvrh4n2rttrx@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lets you stick a header right before a commit, but
suppresses headers that are duplicates. This means you can
do something like:

  git log --graph --author-date-order --commit-header='== %as =='

to get a marker in the graph whenever the day changes.

This probably needs some refactoring around the setup of the
pretty-print context.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 31 +++++++++++++++++++++++++++++++
 revision.c |  4 ++++
 revision.h |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index 8c24157..76cef51 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -536,6 +536,28 @@ static void show_mergetag(struct rev_info *opt, struct commit *commit)
 	for_each_mergetag(show_one_mergetag, commit, opt);
 }
 
+static void show_commit_header(struct rev_info *opt,
+			       struct pretty_print_context *pp,
+			       struct commit *commit)
+{
+	struct strbuf out = STRBUF_INIT;
+
+	format_commit_message(commit, opt->commit_header, &out, pp);
+	strbuf_complete_line(&out);
+
+	if (!strbuf_cmp(&out, &opt->last_commit_header)) {
+		strbuf_release(&out);
+		return;
+	}
+
+	graph_show_precommit(opt->graph);
+	graph_show_padding(opt->graph);
+	fwrite(out.buf, 1, out.len, opt->diffopt.file);
+
+	strbuf_swap(&out, &opt->last_commit_header);
+	strbuf_release(&out);
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -591,6 +613,15 @@ void show_log(struct rev_info *opt)
 	}
 	opt->shown_one = 1;
 
+	if (opt->commit_header) {
+		/*
+		 * XXX probably the initialization of the pretty ctx from "opt"
+		 * below should happen sooner so we can use it.
+		 */
+		ctx.color = opt->diffopt.use_color;
+		show_commit_header(opt, &ctx, commit);
+	}
+
 	/*
 	 * If the history graph was requested,
 	 * print the graph, up to this commit's line
diff --git a/revision.c b/revision.c
index 969b3d1..229ff86 100644
--- a/revision.c
+++ b/revision.c
@@ -1361,6 +1361,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	}
 
 	revs->notes_opt.use_default_notes = -1;
+
+	strbuf_init(&revs->last_commit_header, 0);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -1844,6 +1846,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
+	} else if (skip_prefix(arg, "--commit-header=", &arg)) {
+		revs->commit_header = arg;
 	} else if (!strcmp(arg, "--expand-tabs")) {
 		revs->expand_tabs_in_log = 8;
 	} else if (!strcmp(arg, "--no-expand-tabs")) {
diff --git a/revision.h b/revision.h
index 9fac1a6..39ec092 100644
--- a/revision.h
+++ b/revision.h
@@ -170,6 +170,9 @@ struct rev_info {
 	int		show_log_size;
 	struct string_list *mailmap;
 
+	const char *commit_header;
+	struct strbuf last_commit_header;
+
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
 	/* Negate the match of grep_filter */
-- 
2.10.0.566.g5365f87
