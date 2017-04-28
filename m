Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E471FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424694AbdD1IGg (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:06:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:41527 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424686AbdD1IGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:06:23 -0400
Received: (qmail 2164 invoked by uid 109); 28 Apr 2017 08:06:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 08:06:22 +0000
Received: (qmail 17368 invoked by uid 111); 28 Apr 2017 08:06:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 04:06:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 04:06:20 -0400
Date:   Fri, 28 Apr 2017 04:06:20 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] Have the diff-* builtins configure diff before
 initializing revisions.
Message-ID: <20170428080620.cbnreh5invwpasxr@sigill.intra.peff.net>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170427205037.1787-3-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427205037.1787-3-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 04:50:37PM -0400, Marc Branchaud wrote:

> Subject: [PATCH 2/2] Have the diff-* builtins configure diff before initializing revisions.
>
> This makes the commands respect diff configuration options, such as
> indentHeuristic.
> 
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

I think it would be helpful to future readers to explain what is going
on here. I.e., the bit about calling diff_setup_done(), which copies the
globals into the diff struct.

The same comments about the subject line from the last patch apply here,
too.

>  builtin/diff-files.c | 2 +-
>  builtin/diff-index.c | 2 +-
>  builtin/diff-tree.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

It would be nice to have a test. Testing that dirstat's permille option
has an effect might be the easiest way to do so.

> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index 15c61fd8d..a572da9d5 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -20,9 +20,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  	int result;
>  	unsigned options = 0;
>  
> +	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>  	init_revisions(&rev, prefix);
>  	gitmodules_config();
> -	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>  	rev.abbrev = 0;
>  	precompose_argv(argc, argv);

It's somewhat odd to me that diff_files uses a rev_info struct at all.
It doesn't traverse at all, and doesn't respect most of the options.
There's a half-hearted attempt to reject some obviously bogus cases, but
most of the options are just silently ignored.

I think it's mostly a historical wart (especially around the fact that
some diff options like combine_merges are in rev_info, which they
probably should not be). Anyway, none of that is your problem, and is
way outside the scope of this patch.

-Peff
