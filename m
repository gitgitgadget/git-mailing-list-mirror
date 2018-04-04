Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA23E1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 18:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDDSWp (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 14:22:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:53418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751284AbeDDSWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 14:22:45 -0400
Received: (qmail 15358 invoked by uid 109); 4 Apr 2018 18:22:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 18:22:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6722 invoked by uid 111); 4 Apr 2018 18:23:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 14:23:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 14:22:42 -0400
Date:   Wed, 4 Apr 2018 14:22:42 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@gmail.com,
        larsxschneider@gmail.com, bmwill@google.com
Subject: Re: [PATCH 7/6] ref-filter: use generation number for --contains
Message-ID: <20180404182242.GA9055@sigill.intra.peff.net>
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404154554.140716-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 11:45:53AM -0400, Derrick Stolee wrote:

> @@ -1615,8 +1619,20 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  					      struct contains_cache *cache)
>  {
>  	struct contains_stack contains_stack = { 0, 0, NULL };
> -	enum contains_result result = contains_test(candidate, want, cache);
> +	enum contains_result result;
> +	uint32_t cutoff = GENERATION_NUMBER_UNDEF;
> +	const struct commit_list *p;
> +
> +	for (p = want; p; p = p->next) {
> +		struct commit *c = p->item;
> +		parse_commit_or_die(c);
> +		if (c->generation < cutoff)
> +			cutoff = c->generation;
> +	}
> +	if (cutoff == GENERATION_NUMBER_UNDEF)
> +		cutoff = GENERATION_NUMBER_NONE;

Hmm, on reflection, I'm not sure if this is right in the face of
multiple "want" commits, only some of which have generation numbers.  We
probably want to disable the cutoff if _any_ "want" commit doesn't have
a number.

There's also an obvious corner case where this won't kick in, and you'd
really like it to: recently added commits. E.g,. if I do this:

  git gc ;# imagine this writes generation numbers
  git pull
  git tag --contains HEAD

then HEAD isn't going to have a generation number. But this is the case
where we have the most to gain, since we could throw away all of the
ancient tags immediately upon seeing that their generation numbers are
way less than that of HEAD.

I wonder to what degree it's worth traversing to come up with a
generation number for the "want" commits. If we walked, say, 50 commits
to do it, you'd probably save a lot of work (since the alternative is
walking thousands of commits until you realize that some ancient "v1.0"
tag is not useful).

I'd actually go so far as to say that any amount of traversal is
generally going to be worth it to come up with the correct generation
cutoff here. You can come up with pathological cases where you only have
one really recent tag or something, but in practice every repository
where performance is a concern is going to end up with refs much further
back than it would take to reach the cutoff condition.

-Peff
