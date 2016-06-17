Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9299220179
	for <e@80x24.org>; Fri, 17 Jun 2016 00:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbcFQAP0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 20:15:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:56006 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752665AbcFQAP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 20:15:26 -0400
Received: (qmail 14411 invoked by uid 102); 17 Jun 2016 00:15:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 20:15:25 -0400
Received: (qmail 22139 invoked by uid 107); 17 Jun 2016 00:15:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 20:15:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 20:15:22 -0400
Date:	Thu, 16 Jun 2016 20:15:22 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] bisect: always call setup_revisions after init_revisions
Message-ID: <20160617001522.GA28061@sigill.intra.peff.net>
References: <20160616125326.GA314@x4>
 <20160616132952.GC314@x4>
 <20160616134742.GA25920@sigill.intra.peff.net>
 <xmqqporh3rqu.fsf@gitster.mtv.corp.google.com>
 <20160616233719.GB15013@sigill.intra.peff.net>
 <xmqqoa703cly.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa703cly.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 05:03:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The former initializes the rev_info struct to default
> > values, and the latter parsers any command-line arguments
> > and finalizes the struct.
> 
> The former refers to init and the latter setup?

Yeah, sorry, I guess I was reaching back to the subject line.

Maybe (also fixing a typo):

  init_revisions() initializes the rev_info struct to default values,
  and setup_revisions() parses any command-line arguments and finalizes
  the struct.

> I wonder if we can make it even harder to make the same mistake
> again somehow.  I notice that run_diff_files() and run_diff_index()
> in diff-lib.c share the ideal name for such an easy-to-use helper
> and run_diff_tree(), which does not exist yet, could sit alongside
> with them, but the actual implementation of the former two do not
> address this issue either.  I guess that the diversity of the set of
> pre-packaged options that various callers want to use are so graet
> that we need a rather unpleasntly large API refactoring before we
> could even contemplate doing so?
> 
> In any case, this is a strict improvement.  Let's queue it for the
> first maintenance release.

I wondered about something like the patch below, to detect such problems
consistently (and not just blow up on some corner case that isn't hit in
the test suite).

But it doesn't cover every way somebody might use a "struct rev_info",
so we'd have to sprinkle more "check" functions around. And a bunch of
stuff fails in the test suite (though it looks like it's mostly rebase
stuff, so it's probably all one or two plumbing call-sites).

I do notice some sites, like builtin/pull, use init_revisions() coupled
with diff_setup_done(). That's OK if you're just doing a diff, though
I'd argue they should use setup_revisions() to be on the safe side.

---
diff --git a/log-tree.c b/log-tree.c
index 78a5381..8303e64 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -538,6 +538,12 @@ static void show_mergetag(struct rev_info *opt, struct commit *commit)
 	for_each_mergetag(show_one_mergetag, commit, opt);
 }
 
+static void check_rev_info(struct rev_info *opt)
+{
+	if (!opt->setup_finished)
+		die("BUG: init_revisions called without setup_revisions");
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -547,6 +553,8 @@ void show_log(struct rev_info *opt)
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
 
+	check_rev_info(opt);
+
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
 		graph_show_commit(opt->graph);
@@ -799,6 +807,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	struct commit_list *parents;
 	struct object_id *oid;
 
+	check_rev_info(opt);
+
 	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
 		return 0;
 
diff --git a/revision.c b/revision.c
index d30d1c4..2677b2e 100644
--- a/revision.c
+++ b/revision.c
@@ -2341,6 +2341,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
 
+	revs->setup_finished = 1;
+
 	return left;
 }
 
diff --git a/revision.h b/revision.h
index 9fac1a6..2dc6ecb 100644
--- a/revision.h
+++ b/revision.h
@@ -213,6 +213,8 @@ struct rev_info {
 
 	struct commit_list *previous_parents;
 	const char *break_bar;
+
+	unsigned setup_finished;
 };
 
 extern int ref_excluded(struct string_list *, const char *path);
