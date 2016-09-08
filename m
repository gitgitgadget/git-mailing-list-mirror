Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B791F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936517AbcIHVhm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:37:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:40448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935667AbcIHVhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:37:42 -0400
Received: (qmail 20142 invoked by uid 109); 8 Sep 2016 21:37:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 21:37:41 +0000
Received: (qmail 18948 invoked by uid 111); 8 Sep 2016 21:37:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 17:37:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 17:37:38 -0400
Date:   Thu, 8 Sep 2016 17:37:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, =peartben@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] checkout: eliminate unnecessary merge for trivial
 checkout
Message-ID: <20160908213738.zgwgfy3nybkam3hk@sigill.intra.peff.net>
References: <20160908204431.14612-1-benpeart@microsoft.com>
 <xmqqh99qf5o7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh99qf5o7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 02:22:16PM -0700, Junio C Hamano wrote:

> > +	/*
> > +	 * Optimize the performance of checkout when the current and
> > +	 * new branch have the same OID and avoid the trivial merge.
> > +	 * For example, a "git checkout -b foo" just needs to create
> > +	 * the new ref and report the stats.
> > +	 */
> > +	if (!old.commit || !new->commit
> > +		|| oidcmp(&old.commit->object.oid, &new->commit->object.oid)
> > +		|| !opts->new_branch || opts->new_branch_force || opts->new_orphan_branch
> > +		|| opts->patch_mode || opts->merge || opts->force || opts->force_detach
> > +		|| opts->writeout_stage || !opts->overwrite_ignore
> > +		|| opts->ignore_skipworktree || opts->ignore_other_worktrees
> > +		|| opts->new_branch_log || opts->branch_exists || opts->prefix
> > +		|| opts->source_tree) {
> 
> ... this is a maintenance nightmare in that any new option we will
> add later will need to consider what this "optimization" is trying
> (not) to skip.  The first two lines (i.e. we need a real checkout if
> we cannot positively say that old and new commits are the same
> object) are clear, but no explanation was given for all the other
> random conditions this if condition checks.  What if opts->something
> was not listed (or "listed" for that matter) in the list above--it
> is totally unclear if it was missed by mistake (or "added by
> mistake") or deliberately excluded (or "deliberately added").
> 
> For example, why is opts->prefix there?  If
> 
> 	git checkout -b new-branch HEAD
> 
> should be able to omit the two-way merge, shouldn't
> 
> 	cd t && git checkout -b new-branch HEAD
> 
> also be able to?

I was just writing another reply, but I think our complaints may have
dovetailed.

My issue is that the condition above is an unreadable mass.  It would be
really nice to pull it out into a helper function, and then all of the
items could be split out and commented independently, like:

  static int needs_working_tree_merge(const struct checkout_opts *opts,
                                      const struct branch_info *old,
				      const struct branch_info *new)
  {
	/*
	 * We must do the merge if we are actually moving to a new
	 * commit.
	 */
	if (!old->commit || !new->commit ||
	    oidcmp(&old.commit->object.oid, &new->commit->object.oid))
		return 1;

	/* Option "foo" is not compatible because of... */
	if (opts->foo)
		return 1;

	... etc ...
  }

That still leaves your "what if opts->something is not listed" question
open, but at least it makes it easier to comment on it in the code.

-Peff

PS I didn't think hard on whether the conditions above make _sense_. My
   first goal would be to get more communication about them individually,
   and then we can evaluate them.

