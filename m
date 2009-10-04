Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 11405 invoked by uid 107); 4 Oct 2009 14:57:00 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbZJDOw0 (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 10:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756884AbZJDOwZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 10:52:25 -0400
Received: from up.nbi.dk ([130.225.212.6]:53200 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbZJDOwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 10:52:25 -0400
Received: from bottom.nbi.dk (bottom.nbi.dk [130.225.212.9])
	by mail2.nbi.dk (Postfix) with ESMTP id 48AB23C94E;
	Sun,  4 Oct 2009 16:51:48 +0200 (CEST)
Received: by bottom.nbi.dk (Postfix, from userid 32342)
	id 373773C005; Sun,  4 Oct 2009 16:51:48 +0200 (CEST)
Date:	Sun, 4 Oct 2009 16:51:41 +0200
From:	Petter Urkedal <urkedal@nbi.dk>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, urkedal@nbi.dk
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Message-ID: <20091004145141.GA16477@eideticdew.org>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
 <20091004133333.GA13894@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20091004133333.GA13894@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2009-10-04, Jeff King wrote:
> Thanks, your fix looks sane. But I am curious about whether we are
> triggering some glibc pickiness that is in your setup, or if we are
> somehow violating the assumption that we only ever look at
> default_arg[1] and beyond.

I had a look at parse-options.c.  In parse_options_start, argv is
assigned to ctx->out, which is overwritten from index 0 in
parse_options_end.  This will show the problem:

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 3510a86..1c587ad 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -691,6 +691,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
                showbranch_use_color = git_use_color_default;
 
        /* If nothing is specified, try the default first */
+       printf("default_arg = %p\n", default_arg);
        if (ac == 1 && default_num) {
                ac = default_num + 1;
                av = default_arg - 1; /* ick; we would not address av[0] */
diff --git a/parse-options.c b/parse-options.c
index f559411..267e752 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -435,6 +435,7 @@ unknown:
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
+       printf("Assigning to %p\n", ctx->out + ctx->cpidx);
        memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
        ctx->out[ctx->cpidx + ctx->argc] = NULL;
        return ctx->cpidx + ctx->argc;

