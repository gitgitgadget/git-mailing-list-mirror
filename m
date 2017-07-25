Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7F91F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbdGYUZ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:25:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:48778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751950AbdGYUZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:25:53 -0400
Received: (qmail 12011 invoked by uid 109); 25 Jul 2017 20:25:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 20:25:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20946 invoked by uid 111); 25 Jul 2017 20:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 16:26:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jul 2017 16:25:51 -0400
Date:   Tue, 25 Jul 2017 16:25:51 -0400
From:   Jeff King <peff@peff.net>
To:     Raman Gupta <rocketraman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict
 resolution
Message-ID: <20170725202550.zasszwoq5z2jhj66@sigill.intra.peff.net>
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
 <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
 <1d07fa3b-cd3f-42fd-87c1-0627de7c04f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d07fa3b-cd3f-42fd-87c1-0627de7c04f2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 03:54:32PM -0400, Raman Gupta wrote:

> > That said, I'm far from an expert on how rerere works. Junio might have
> > ideas on how we could handle this better. But I do note that for
> > repeated integration runs (like we do for topics in git.git, as they get
> > merged to "pu", then "next", then "master"), he keeps non-conflict
> > fixups in a separate commit which gets squashed into the merge
> > automatically. See
> > 
> >   https://github.com/git/git/blob/todo/Reintegrate#L185-L191
> 
> Seems relatively simple to me, at least conceptually.
> 
> 1) Store the state of the index after the merge.
> 
> 2) After conflict resolution is complete (i.e. user executes "git
> commit"), diff index @ step 1 with commit.
> 
> 3) Assume that all changes in that diff are related to conflict
> resolution (as they should be), and save that diff to the rerere cache.
> 
> I could be missing something fundamental here though...

That describes the "save" step. How do we do the apply step? We later do
a merge and see that there are some conflicts. We compute a hash for
each conflict, and see if it has a resolution in the database.

But how do we decide which hashes to look up for the parts that are
outside of a conflict?

In theory you want those fixups to "ride along" with the other
conflicts. But which fixups ride along with which conflicts? You really
want some way to uniquely identify a particular merge. But of course you
can't use the content, because the whole point of rerere is that you're
doing a _similar_ merge in another context. And that's why Reintegrate
ties it to the branch being merged. That gives us the unique identifier.
But rerere normally does not concern itself with that.

I think you could mark the fixups as potential ride-alongs for each
conflict that's resolved. And then when we apply a resolution, tell the
user "by the way, you might want these fixups, too" (or maybe even try
to apply them automatically). That will suggest fixups that may not be
relevant anymore, but if the next "save" includes a particular
resolution but _not_ a potential fixup, then that fixup can be culled
from its list.

There's still a corner case that doesn't handle, though: you might need
fixups even if you have no conflicts at all.

So we may be stumbling towards an answer, but it still sounds kind of
hacky and fragile.

> > As far as I know, something like the Reintegrate script above is the
> > state of the art. IMHO it would be useful if something similar were
> > integrated into rerere, but I'm not sure exactly how it would know when
> > to trigger.
> 
> I've seen the Reintegrate script before. It is very specific to the
> git.git workflow. I think it makes sense to expose this particular
> capability in git proper, given that rerere itself is exposed. Plus
> that could actually simplify the Reintegrate script a bit.

Right, sorry if I wasn't clear; my "something similar" meant only the
fixup-applying lines I linked to.

> > But I don't think even then you can ever trust rerere fully.
> > Fundamentally you're applying some changes from one merge into another
> > context. There may be new sites that also need fixing up, and the tool
> > has no way to know. So you should treat a rerere-helped merge as any
> > other merge: assume it's a good starting point but use other tools (like
> > the compiler or automated tests) to confirm that the result is sensible.
> 
> While I agree that every case cannot be handled, and this type of
> validation is still necessary, I believe git should cover the cases
> which it is proper and possible to cover.

Yes, I agree that some help is usually better than none (although we
need to be careful that any improvement is honest about its limitations
for any given case, and doesn't end up tricking the user into a false
sense of security).

-Peff
