Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B8D1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756435AbcIFSlr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:41:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:38965 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756400AbcIFSlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:41:46 -0400
Received: (qmail 24734 invoked by uid 109); 6 Sep 2016 18:41:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 18:41:46 +0000
Received: (qmail 28911 invoked by uid 111); 6 Sep 2016 18:41:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 14:41:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 14:41:43 -0400
Date:   Tue, 6 Sep 2016 14:41:43 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
Message-ID: <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
 <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609061613270.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609061613270.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2016 at 06:02:59PM +0200, Johannes Schindelin wrote:

> It will still be quite tricky, because we have to touch a function that is
> rather at the bottom of the food chain: diff_populate_filespec() is called
> from fill_textconv(), which in turn is called from pickaxe_match(), and
> only pickaxe_match() knows whether we want to call regexec() or not (it
> depends on its regexp parameter).
> 
> Adding a flag to diff_populate_filespec() sounds really reasonable until
> you see how many call sites fill_textconv() has.

I was thinking of something quite gross, like a global "switch to using
slower-but-safer NUL termination" flag (but I agree with Junio's point
elsewhere that we do not even know if it is "slower").

> > I thought that operated on the diff content itself, which would always
> > be in a heap buffer (which should be NUL terminated, but if it isn't,
> > that would be a separate fix from this).
> 
> That is true.
> 
> Except when preimage or postimage does not exist. In which case we call
> 
> 	regexec(regexp, two->ptr, 1, &regmatch, 0);
> 
> or the same with one->ptr. Note the notable absence of two->size.

Thanks, I forgot about that case.

> > [1] We do make the assumption elsewhere that git objects are
> >     NUL-terminated, but that is enforced by the object-reading code
> >     (with the exception of streamed blobs, but those are obviously dealt
> >     with separately anyway).
> 
> I know. I am the reason you introduced that, because I added code to
> fsck.c that assumes that tag/commit messages are NUL-terminated.

Sort of. I think it has been part of the design since e871b64
(unpack_sha1_file: zero-pad the unpacked object., 2005-05-25), though I
do recall that we missed a code path that did its allocation differently
(in index-pack, IIRC).

Anyway, that is neither here nor there for the diff code, which as you
noticed may operate on things besides git objects.

> So now for the better idea.
> 
> While I was researching the code for this reply, I hit upon one thing that
> I never knew existed, introduced in f96e567 (grep: use REG_STARTEND for
> all matching if available, 2010-05-22). Apparently, NetBSD introduced an
> extension to regexec() where you can specify buffer boundaries using
> REG_STARTEND. Which is pretty much what we need.

Yes, and compat/regex support this, too. My question is whether it is
portable. I see:

> diff --git a/diff.c b/diff.c
> index 534c12e..2c5a360 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -951,7 +951,13 @@ static int find_word_boundaries(mmfile_t *buffer,
> regex_t *word_regex,
>  {
>  	if (word_regex && *begin < buffer->size) {
>  		regmatch_t match[1];
> -		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
> 		0)) {
> +		int f = 0;
> +#ifdef REG_STARTEND
> +		match[0].rm_so = 0;
> +		match[0].rm_eo = *end - *begin;
> +		f = REG_STARTEND;
> +#endif
> +		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
> f)) {

What happens to those poor souls on systems without REG_STARTEND? Do
they get to keep segfaulting?

I think the solution is to push them into setting NO_REGEX. So looking
at this versus a "regexecn", it seems:

  - this lets people keep using their native regexec if it supports
    STARTEND

  - this is a bit more clunky to use at the callsites (though we could
    _create_ a portable regexecn wrapper that uses this technique on top
    of the native regex library)

But I much prefer this approach to copying the data just to add a NUL.

-Peff
