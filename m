Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE851F453
	for <e@80x24.org>; Thu, 20 Sep 2018 19:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbeIUBcl (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 21:32:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:54220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726582AbeIUBcl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 21:32:41 -0400
Received: (qmail 4109 invoked by uid 109); 20 Sep 2018 19:47:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Sep 2018 19:47:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28252 invoked by uid 111); 20 Sep 2018 19:47:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Sep 2018 15:47:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2018 15:47:34 -0400
Date:   Thu, 20 Sep 2018 15:47:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180920194734.GD29603@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 02:04:13PM -0400, Taylor Blau wrote:

> The recently-introduced "core.alternateRefsCommand" allows callers to
> specify with high flexibility the tips that they wish to advertise from
> alternates. This flexibility comes at the cost of some inconvenience
> when the caller only wishes to limit the advertisement to one or more
> prefixes.

To be clear: this isn't something we plan to use at GitHub at all. It
just seemed like a nice "in between" the current inflexible state and
the "incredibly flexible but not trivial to use" command from patch 2.

Note that unlike core.alternateRefsCommand, there are no security issues
here with reading this from the alternate, although:

 - it's a little awkward to read the config from the alternate

 - since these are clearly related config, it probably makes sense for
   them to be consistent

> For example, to advertise only tags, a caller using
> 'core.alternateRefsCommand' would have to do:
> 
>   $ git config core.alternateRefsCommand ' \
>       git -C "$1" for-each-ref refs/tags \
>       --format="%(objectname) %(refname)" \
>     '

I think it's more likely that advertising only heads would make sense.
The pathological repos I see are usually a sane number of branches and
then an absurd number of tags.

Not that it's super important, but I wonder if we should give a
motivating example like this in the documentation. In which case we'd
probably want to give the most plausible one.

> Since the value of "core.alternateRefsPrefixes" is appended to 'git
> for-each-ref' and then executed, include a "--" before taking the
> configured value to avoid misinterpreting arguments as flags to 'git
> for-each-ref'.

Good idea.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b908bc5825..d768c57310 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -622,6 +622,12 @@ core.alternateRefsCommand::
>  	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
>  	Output must be of the form: `%(objectname) SPC %(refname)`.
>  
> +core.alternateRefsPrefixes::
> +	When listing references from an alternate, list only references that begin
> +	with the given prefix. To list multiple prefixes, separate them with a
> +	whitespace character. If `core.alternateRefsCommand` is set, setting
> +	`core.alternateRefsPrefixes` has no effect.

I can't remember all of the rules for how for-each-ref matches prefixes,
but I remember that it's subtly different than git-branch (and that's
why ref-filter.c has two matching modes). Do we need to spell out the
rules here (or at least say "it matches like for-each-ref")?

Also, a minor nit, but I think the argv_array_split() helper you're
using soaks up arbitrary amounts of whitespace. So maybe "separate them
with whitespace" instead of "a whitespace character". Or maybe we should
be strict in what we suggest and liberal in what we parse. ;)

> +test_expect_success 'with core.alternateRefsPrefixes' '
> +	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
> +	cat >expect <<-EOF &&
> +	$(git rev-parse one) .have
> +	$(git rev-parse three) .have
> +	$(git rev-parse two) .have
> +	EOF
> +	printf "0000" | git receive-pack fork | extract_haves >actual &&
> +	test_cmp expect actual

Looks sane, though the same pipe comment applies as before.

>  test_done
> diff --git a/transport.c b/transport.c
> index e7d2cdf00b..9323e5c3cd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
>  		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
>  		argv_array_push(&cmd->args, "for-each-ref");
>  		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> +
> +		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
> +			argv_array_push(&cmd->args, "--");
> +			argv_array_split(&cmd->args, value);
> +		}
>  	}

The implementation ended up delightfully simple.

-Peff
