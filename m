Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFE91F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937147AbeE2VEs (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:04:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S937043AbeE2VEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:04:37 -0400
Received: (qmail 2664 invoked by uid 109); 29 May 2018 21:04:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 21:04:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30699 invoked by uid 111); 29 May 2018 21:04:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 17:04:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 17:04:35 -0400
Date:   Tue, 29 May 2018 17:04:35 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Kevin Bracey <kevin@bracey.fi>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Weird revision walk behaviour
Message-ID: <20180529210434.GA3857@sigill.intra.peff.net>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
 <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
 <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
 <20180528220651.20287-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180528220651.20287-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 12:06:51AM +0200, SZEDER Gábor wrote:

> diff --git a/revision.c b/revision.c
> index 4e0e193e57..0ddd2c1e8a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -605,7 +605,7 @@ static inline int limiting_can_increase_treesame(const struct rev_info *revs)
>  
>  static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  {
> -	struct commit_list **pp, *parent;
> +	struct commit_list **pp, *parent, *treesame_parents = NULL;
>  	struct treesame_state *ts = NULL;
>  	int relevant_change = 0, irrelevant_change = 0;
>  	int relevant_parents, nth_parent;
> @@ -672,6 +672,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  		switch (rev_compare_tree(revs, p, commit)) {
>  		case REV_TREE_SAME:
>  			if (!revs->simplify_history || !relevant_commit(p)) {
> +				struct commit_list *tp;
>  				/* Even if a merge with an uninteresting
>  				 * side branch brought the entire change
>  				 * we are interested in, we do not want
> @@ -680,6 +681,13 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  				 */
>  				if (ts)
>  					ts->treesame[nth_parent] = 1;
> +				/* But we note it for potential later
> +				 * simplification
> +				 */
> +				tp = treesame_parents;
> +				treesame_parents = xmalloc(sizeof(*treesame_parents));
> +				treesame_parents->item = p;
> +				treesame_parents->next = tp;
>  				continue;
>  			}

We hit this "if" if !relevant_commit(p), which I think is what we want.
But we'd also hit it if !revs->simplify_history. Would we want to avoid
doing the simplification in that case?

I guess later we do:

> @@ -716,6 +724,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  		die("bad tree compare for commit %s", oid_to_hex(&commit->object.oid));
>  	}
>  
> +	if (relevant_parents == 0 && revs->simplify_history &&
> +	    treesame_parents) {
> +		commit->parents = treesame_parents;
> +		commit->object.flags |= TREESAME;
> +		return;
> +	} else
> +		free_commit_list(treesame_parents);
> +

...which blocks the !simplify_history case from triggering. But then we
could avoid the allocation above in that case, I think (though I agree
with Kevin's later email that we may not need it at all).

Do we even need to do the parent rewriting here? By definition those
parents aren't interesting, and we're TREESAME to whatever is in
treesame_parents. So conceptually it seems like we just need a flag "I
found a treesame parent", but we only convert that into a TREESAME flag
if there are no relevant parents.

I wouldn't be surprised, though, if some code path really cares whether
we've simplified to a single uninteresting parent here, versus
simplifying to a root commit (I admit that the simplification code is
one of the areas of Git I'm least familiar with).

-Peff
