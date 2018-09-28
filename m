Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA9C1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 05:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeI1Lw5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 07:52:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:34828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726060AbeI1Lw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 07:52:57 -0400
Received: (qmail 31415 invoked by uid 109); 28 Sep 2018 05:31:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Sep 2018 05:31:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10254 invoked by uid 111); 28 Sep 2018 05:30:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Sep 2018 01:30:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2018 01:30:57 -0400
Date:   Fri, 28 Sep 2018 01:30:57 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v3 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180928053057.GD25850@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <48eb774c9e36f468549a278fd8cf703d8a34af28.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48eb774c9e36f468549a278fd8cf703d8a34af28.1538108385.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 09:25:45PM -0700, Taylor Blau wrote:

> The recently-introduced "core.alternateRefsCommand" allows callers to
> specify with high flexibility the tips that they wish to advertise from
> alternates. This flexibility comes at the cost of some inconvenience
> when the caller only wishes to limit the advertisement to one or more
> prefixes.
> 
> For example, to advertise only tags, a caller using
> 'core.alternateRefsCommand' would have to do:
> 
>   $ git config core.alternateRefsCommand ' \
>       git -C "$1" for-each-ref refs/tags --format="%(objectname)"'

This has the same "$@" issue as the previous one, I think (which only
makes your point about it being cumbersome more true!).

> In the case that the caller wishes to specify multiple prefixes, they
> may separate them by whitespace. If "core.alternateRefsCommand" is set,
> it will take precedence over "core.alternateRefsPrefixes".

Just a meta-comment: I don't particularly mind this discussion in the
commit message, but since these points ought to be in the documentation
anyway, it may make sense to omit them here in the name of brevity.

> +core.alternateRefsPrefixes::
> +	When listing references from an alternate, list only references that begin
> +	with the given prefix. Prefixes match as if they were given as arguments to
> +	linkgit:git-for-each-ref[1]. To list multiple prefixes, separate them with
> +	whitespace. If `core.alternateRefsCommand` is set, setting
> +	`core.alternateRefsPrefixes` has no effect.

Looks good.

> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> index 503dde35a4..3449967cc7 100755
> --- a/t/t5410-receive-pack.sh
> +++ b/t/t5410-receive-pack.sh
> @@ -46,4 +46,12 @@ test_expect_success 'with core.alternateRefsCommand' '
>  	test_cmp expect actual.haves
>  '
>  
> +test_expect_success 'with core.alternateRefsPrefixes' '
> +	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
> +	git rev-parse one three two >expect &&
> +	printf "0000" | git receive-pack fork >actual &&
> +	extract_haves <actual >actual.haves &&
> +	test_cmp expect actual.haves
> +'

If you follow my suggestion on the test setup from the last patch, it
would make sense to just put "refs/heads/public/" here. Although neither
that nor what you have here tests the whitespace separation. Possibly
there should be a third hierarchy.

> diff --git a/transport.c b/transport.c
> index e271b66603..83474add28 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
>  		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
>  		argv_array_push(&cmd->args, "for-each-ref");
>  		argv_array_push(&cmd->args, "--format=%(objectname)");
> +
> +		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
> +			argv_array_push(&cmd->args, "--");
> +			argv_array_split(&cmd->args, value);
> +		}

And this part looks good.

-Peff
