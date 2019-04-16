Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8EF20248
	for <e@80x24.org>; Tue, 16 Apr 2019 21:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfDPVsp (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 17:48:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:60392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728140AbfDPVsp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 17:48:45 -0400
Received: (qmail 10125 invoked by uid 109); 16 Apr 2019 21:48:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 16 Apr 2019 21:48:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15421 invoked by uid 111); 16 Apr 2019 21:49:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Apr 2019 17:49:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2019 17:48:43 -0400
Date:   Tue, 16 Apr 2019 17:48:43 -0400
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/1] Fix %(push:track) in ref-filter
Message-ID: <20190416214842.GA21429@sigill.intra.peff.net>
References: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
 <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
 <20190415220108.GD28128@sigill.intra.peff.net>
 <20190416123944.vtoremaitywtmkhj@mithrim>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416123944.vtoremaitywtmkhj@mithrim>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 16, 2019 at 02:39:45PM +0200, Damien Robert wrote:

> > Or perhaps it argues for just giving access to the more generic stat_*
> > function, and letting callers pass in a flag for push vs upstream (and
> > either leaving stat_tracking_info() as a wrapper, or just updating its
> > few callers).
> 
> So I went ahead with modifying `stat_tracking_info` to accept a 'for_push'
> flag, and updated the few callers. This means that `stat_compare_info` is
> only used by `stat_tracking_info` so I could reinline it, but I guess it
> could still be useful latter.

Reading this paragraph, my gut reaction was to say that it should stay
as a single function. But actually looking at the code, I think it is a
bit nicer to separate out "compare these two branches" from "figure out
which branches to compare".

The name "compare_info" is a bit vague. Perhaps "stat_branch_pair" or
something would be more descriptive.

> > Also, since this is an internal helper function for the file, we should
> > mark it as static.
> 
> Yes. In fact in the first version of the patch I would call
> `stat_compare_info` directly in `ref_filter.c` so I needed to export it in
> `remote.h`, and then when I changed the patch I forgot to make it static.

Heh. I wondered if that might have been the reason.

> > Thanks for working on this.
> 
> You are welcome. What's the standard way to acknowledge your help in
> the Foo-By: trailers? I did not put a Reviewed-By: because you reviewed the
> previous patch, not the current one :)

Right, Reviewed-by wouldn't be quite right. As Christian noted,
Helped-by can be used for this (but I am also fine without credit;
suggestions are a normal part of review).

Overall the patch looks good to me. I have a few extremely minor nits:

> Subject: [v2 PATCH 1/1] Fix %(push:track) in ref-filter

We'd usually say "area: do something" here, and it's nice to stay
consistent so that reading --oneline output is easy. And it's nice if we
can avoid vague terms like "fix". Maybe:

 ref-filter: use correct branch for %(push:track)

or something?

> This bug was not detected in t/t6300-for-each-ref.sh because in the test
> for push:track, both the upstream and the push branches were behind by 1
> from the local branch. Change the test so that the upstream branch is
> behind by 1 while the push branch is ahead by 1. This allows us to test
> that %(push:track) refer to the correct branch.

s/refer/&s/

> This change the expected value of some following tests (by introducing
> new references), so update them too.

s/change/&s/

>  	if (abf != AHEAD_BEHIND_FULL)
> -		BUG("stat_tracking_info: invalid abf '%d'", abf);
> +		BUG("stat_compare_info: invalid abf '%d'", abf);

If we do the name change I mentioned above, don't forger this line. :)

> +int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
> +		       const char **upstream_name, int for_push,
> +		       enum ahead_behind_flags abf)
> +{

Is it worth changing "upstream_name" since it sometimes is now not
%(upstream)?

> @@ -1977,7 +2003,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  	char *base;
>  	int upstream_is_gone = 0;
>  
> -	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, abf);
> +	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);

I was tempted to suggest doing this refactor as a separate patch, so
that we'd see less noise in the diff. But in fact half of the callers
we'd have to touch are ones that would be modified to use for_push
anyway. So I think it makes sense to just keep it all together as a
single unit.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> [...]
> @@ -594,6 +603,7 @@ $(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
>  $(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
>  EOF
>  
> +
>  test_expect_success 'Verify sort with multiple keys' '
>  	git for-each-ref --format="%(objectname) %(taggeremail) %(refname)" --sort=objectname --sort=taggeremail \
>  		refs/tags/bogo refs/tags/master > actual &&

Leftover stray whitespace?

For any one of those nits I'd probably say it was not worth a re-roll
(and the maintainer could adjust them when he picks up the patch).  But
there are just enough that it's probably worth making his life easier
with a v3.

You can put my Reviewed-by on it, too. :)

-Peff
