Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E112F1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbcIAVNK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:13:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:36760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757039AbcIAVIu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:08:50 -0400
Received: (qmail 25788 invoked by uid 109); 1 Sep 2016 20:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 20:08:41 +0000
Received: (qmail 18542 invoked by uid 111); 1 Sep 2016 20:08:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 16:08:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2016 16:08:37 -0400
Date:   Thu, 1 Sep 2016 16:08:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] squelch some "gcc -O3 -Wmaybe-uninitialized" warnings
Message-ID: <20160901200837.jbuoay7lf4r7f67x@sigill.intra.peff.net>
References: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net>
 <xmqqvaygzpbe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaygzpbe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 12:55:01PM -0700, Junio C Hamano wrote:

> Interesting.  Here is for "gcc -Os" on top to appease gcc 4.8.4 that
> I probably am NOT going to apply.  These are all false positives.
> 
> The ones on config.c is the most curious as these two "ret" needs a
> false initialization, but the one that comes after them
> git_config_ulong() that has the same code structure does not get any
> warning, which made absolutely no sense to me.

Yeah, I'd agree that is really odd. I wondered if perhaps the signedness
of the argument mattered (e.g., if we were somehow provoking undefined
behavior which caused the compiler to make some assumption), but I just
don't see it.

>  builtin/update-index.c | 2 +-
>  config.c               | 4 ++--
>  diff.c                 | 2 +-
>  fast-import.c          | 1 +
>  4 files changed, 5 insertions(+), 4 deletions(-)

FWIW, all but the fast-import one have gone away in gcc 6.2.0 (using
-Os).

For that one:

> diff --git a/fast-import.c b/fast-import.c
> index bf53ac9..abc4519 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1377,6 +1377,7 @@ static const char *get_mode(const char *str, uint16_t *modep)
>  	unsigned char c;
>  	uint16_t mode = 0;
>  
> +	*modep = 0;
>  	while ((c = *str++) != ' ') {
>  		if (c < '0' || c > '7')
>  			return NULL;

The complaint actually comes from the caller, who doesn't realize that
modep will be set.

It pretty clearly seems to be a false positive, but I don't understand
it. If get_mode() is not inlined (or otherwise examined when considering
the caller), then it presumably should be treated as a block box that we
assume sets "modep".  And if it is inlined, then it's pretty obvious
that "modep" is initialized in any code path that does not return NULL,
and we have:

	p = get_mode(p, &mode);
	if (!p)
		die("Corrupt mode: %s", command_buf.buf);

in the caller (and "die" is marked as NORETURN). So it seems like a
pretty easy case to get right, and one that the compiler presumably gets
right elsewhere (otherwise we'd have a lot more of these false
positives).

Weird.

-Peff
