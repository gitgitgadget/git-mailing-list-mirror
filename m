Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEEAE1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 16:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeHQTw5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 15:52:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:58824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727560AbeHQTw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 15:52:57 -0400
Received: (qmail 31851 invoked by uid 109); 17 Aug 2018 16:48:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 16:48:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25712 invoked by uid 111); 17 Aug 2018 16:48:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 12:48:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 12:48:50 -0400
Date:   Fri, 17 Aug 2018 12:48:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Syncing HEAD
Message-ID: <20180817164850.GA7789@sigill.intra.peff.net>
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
 <20180814210616.GA32367@sigill.intra.peff.net>
 <20180814214723.GA667@sigill.intra.peff.net>
 <xmqq6009c5ys.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq6009c5ys.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 09:28:59AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So all of this really implies to me that you want to be able to say
> > "take this symref on the other side and update this one on the local
> > side". I.e., some way to tell a refspec "don't update the value, update
> > the symref destination". ...
> > ...
> >   git fetch origin ~HEAD:refs/remotes/origin/HEAD
> 
> We need to be a bit careful here.
> 
> You can define the meaning of the above sanely if you know that
> refmap refs/heads/*:refs/remotes/origin/* is in effect for the
> remote to read "My HEAD points at refs/heads/frotz" and interpret it
> as "In order to match, I need to make my refs/remotes/origin/HEAD to
> point at refs/remotes/origin/frotz".

Good point. I was thinking too much about the symlink itself and not its
destination. You need some way of mapping that destination, as well.

For Christian's case, it is really the "refs/*:refs/*" mapping that he
would want to emulate (because he'd be doing ~HEAD:HEAD). In some cases,
like that one, you could infer the mapping from the HEAD:HEAD itself (X
on the remote becomes X locally). But that does not work for the
refs/remotes case. You might infer from "~HEAD:refs/remotes/origin/HEAD"
that "X becomes refs/remotes/origin/X", but it is actually "refs/heads/X
becomes ...".

So yeah, this really does need pairing with the overall ref mapping.

I think that's doable even for the example I gave above, because we
could find those refspecs in the config. But:

  git fetch git://... ~HEAD:HEAD

does not have that information. We may or may not have fetched the
pointed-to ref previously.

What if this _required_ that the symref destination from the other side
also be something that we are fetching, and was otherwise an error? That
would avoid any config trickery. It does mean that "git fetch origin
~HEAD:HEAD" does not work.  But I think you'd generally want to pair it
with a fetch anyway. I.e., Either two configured refspecs, or if a
one-off fetch from a URL, fetching the branches and the symref at the
same time.

I suppose the one case it would not support is "I want to fetch HEAD as
a symref and whatever branch it points to, but I do not yet know what
that branch is". Or, I suppose, "I do not want to update any branches,
but just update my notion of HEAD" (i.e., what "remote set-head -a"
currently does).

> Also, what should the above form of "git fetch" write in FETCH_HEAD?
> Should "git pull origin ~HEAD:refs/remotes/origin/HEAD" run the fetch
> and then merge it (which may have value of refs/remotes/origin/frotz)
> to the current branch?  Should the underlying fetch be also fetching
> the frotz branch from them at the same time, or do we attempt to merge
> a possibly stale 'frotz' (which might not even have been there, the
> last time we fetched from them)?

I'd be tempted to say that a symref fetch writes nothing into FETCH_HEAD
at all. Which would make a bare "git pull origin ~HEAD" an error. I'm
sure there are cases it _could_ do something useful, but there are so
many where it doesn't make sense.

-Peff
