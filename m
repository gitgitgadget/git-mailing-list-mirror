Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD1A1FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 07:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbcLEH0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 02:26:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:51598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbcLEH0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 02:26:16 -0500
Received: (qmail 874 invoked by uid 109); 5 Dec 2016 07:26:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 07:26:15 +0000
Received: (qmail 2391 invoked by uid 111); 5 Dec 2016 07:26:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 02:26:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 02:26:14 -0500
Date:   Mon, 5 Dec 2016 02:26:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jack Bates <bk874k@nottheoilrig.com>, git@vger.kernel.org,
        Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH] diff: fix up SHA-1 abbreviations outside of repository
Message-ID: <20161205072614.zg6yglqnznna65vf@sigill.intra.peff.net>
References: <20161204194747.7100-1-jack@nottheoilrig.com>
 <xmqqr35m6dwt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr35m6dwt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 04, 2016 at 11:19:46PM -0800, Junio C Hamano wrote:

> > -	if (no_index)
> > +	if (no_index) {
> >  		/* If this is a no-index diff, just run it and exit there. */
> > +		startup_info->have_repository = 0;
> >  		diff_no_index(&rev, argc, argv);
> > +	}
> 
> This kind of change makes me nervous (partly because I am not seeing
> the whole code but only this part of the patch).
> 
> Some code may react to "have_repository" being zero and do the right
> thing (which I think is what you are using from your previous "we
> did one of the three cases" change here), but the codepath that led
> to "have_repository" being set to non-zero previously must have done
> a lot more than just flipping that field to non-zero, and setting
> zero to this field alone would not "undo" what it did.

I _think_ it's OK because the only substantive change would be the
chdir() to the top of the working tree. But that information is carried
through by revs->prefix, which we act on regardless of the value of
startup_info->have_repository when we call prefix_filename().

I agree that it may be an accident waiting to happen, though, as soon as
some buried sub-function needs to care about the distinction.

> I wonder if we're better off if we made sure that diff_no_index()
> works the same way regardless of the value of "have_repository"
> field?

If you mean adding a diffopt flag like "just abbreviate everything to
FALLBACK_DEFAULT_ABBREV even if we're in a repository", and then setting
that in diff_no_index(), I agree that is a lot cleaner.

I'm still not 100% convinced that it's actually the correct behavior,
but at least doing a more contained version wouldn't take away other
functionality like reading config.

-Peff
