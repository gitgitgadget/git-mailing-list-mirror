Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DA41F428
	for <e@80x24.org>; Sat, 30 Dec 2017 18:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdL3SQA (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 13:16:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:49654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750977AbdL3SQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 13:16:00 -0500
Received: (qmail 6037 invoked by uid 109); 30 Dec 2017 18:16:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Dec 2017 18:16:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5599 invoked by uid 111); 30 Dec 2017 18:16:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 30 Dec 2017 13:16:29 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Dec 2017 13:15:58 -0500
Date:   Sat, 30 Dec 2017 13:15:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Zefram <zefram@fysh.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] diff-tree: obey the color.ui configuration
Message-ID: <20171230181557.GA30351@sigill.intra.peff.net>
References: <87zi616vgf.fsf@evledraar.gmail.com>
 <20171229225121.13805-1-avarab@gmail.com>
 <20171229231631.GS3693@zaya.teonanacatl.net>
 <20171230015533.GA27130@sigill.intra.peff.net>
 <87tvw875vh.fsf@evledraar.gmail.com>
 <20171230144505.GA29252@sigill.intra.peff.net>
 <87po6w6yul.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87po6w6yul.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 30, 2017 at 04:04:50PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I do like the idea of using "show", though. We know the point is to show
> > the output to the user, so we don't mind at all if the behavior or
> > output of show changes in future versions (unless we consider the final
> > output of bisect to be machine-readable, but I certainly don't).
> 
> Not knowing the internal APIs for that well, is this basically a matter
> of copy/pasting (or factoring out into a function), some of this:
> 
>     git grep -W cmd_show -- builtin/log.c
> 
> I.e. boilerplate + calling cmd_log_walk() to yield a result similar to
> e22278c0a0 ("bisect: display first bad commit without forking a new
> process", 2009-05-28).
> 
> Or is it preferred to just fake up argc/argv and call cmd_show()
> directly? I haven't seen many examples of that in the codebase:
> 
>     git grep -W '(return|=)\s*cmd.*argc' -- '*.c'
> 
> But I don't see why it wouldn't work, the cmd_show() doesn't call exit()
> itself, and we're right about to call exit anyway when our current
> diff-tree invocation is called.

Hmm, I just assumed we were actually calling diff-tree. But looking at
that code in bisect, it literally is calling log_tree_commit(), which is
the same thing that git-show is doing.

So yet another option is to just set up our options similarly:

diff --git a/bisect.c b/bisect.c
index 0fca17c02b..1eadecd42a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -893,9 +893,11 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 
 	/* diff-tree init */
 	init_revisions(&opt, prefix);
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	git_config(git_diff_ui_config, NULL);
 	opt.abbrev = 0;
 	opt.diff = 1;
+	opt.combine_merges = 1;
+	opt.dense_combined_merges = 1;
 
 	/* This is what "--pretty" does */
 	opt.verbose_header = 1;

Though I do kind of like the idea of just delegating to git-show.
There's no real need for us to have our own logic.

I think calling cmd_show() from bisect.c is supposed to be forbidden
(library code shouldn't call up to builtin code). I was going to suggest
just using run_command() to call git-show. After all, we do this only
once at the very end of the bisection (which is pretty heavy-weight, as
it surely has forked a lot of processes to do the actual testing).

But that would be directly undoing Christian's e22278c0a0 (bisect:
display first bad commit without forking a new process, 2009-05-28). I'm
of the opinion that would be OK, but maybe Christian has input. :)

-Peff
