Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E181F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfKFEFY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:05:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:40106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725768AbfKFEFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:05:24 -0500
Received: (qmail 17676 invoked by uid 109); 6 Nov 2019 04:05:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 04:05:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19303 invoked by uid 111); 6 Nov 2019 04:08:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2019 23:08:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Nov 2019 23:05:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Davide Berardi <davide.berardi6@unibo.it>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] clone: Don't segfault on -b specifing a non-commit
Message-ID: <20191106040523.GB4307@sigill.intra.peff.net>
References: <20191101002432.GA49846@carpenter.lan>
 <20191103180716.GA72007@carpenter.lan>
 <20191105043749.GA27601@sigill.intra.peff.net>
 <xmqqbltpyeel.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbltpyeel.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 10:36:18AM +0900, Junio C Hamano wrote:

> >   - we could probably simplify this by just inlining it into
> >     update_head(). Something like:
> >
> >       if (our)
> >               tip = &our->old_oid;
> >       else if (remote)
> >               tip = &remote->old_oid;
> >
> >       if (!tip) {
> > 	      /*
> > 	       * We have no local branch requested with "-b", and the
> > 	       * remote HEAD is unborn. There's nothing to update HEAD
> > 	       * to, but this state is not an error.
> > 	       */
> >               return 0;
> >       }
> 
> I somehow had an impression that Davide was protecting against the
> case where tip->old_oid is null_oid (cloning from an empty repo?);
> NULL return from lookup_commit_reference_gently(null_oid) would not
> deserve a warning from this codepath, and should work just like the
> way it has worked before these changes.

I'm not sure if we need to worry about that case. Right now it would
just segfault, I think, which means it's not something that comes up
regularly (though whether the _best_ thing might be to consider a
non-error, I don't know without understanding why we'd see a null_oid in
the first place).

If we did want to handle it, though, I think it would be easy with the
setup I described; update_head() could check is_null_oid() itself.

-Peff
