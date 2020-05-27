Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F2AC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC0920787
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgE0Gmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 02:42:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:57096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0Gmp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 02:42:45 -0400
Received: (qmail 19953 invoked by uid 109); 27 May 2020 06:42:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 06:42:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 300 invoked by uid 111); 27 May 2020 06:42:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 02:42:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 02:42:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] checkout: improve error messages for -b with extra
 argument
Message-ID: <20200527064244.GB4005121@coredump.intra.peff.net>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
 <c5e797b8-4b80-f9fa-e746-95f7f39e74f8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e797b8-4b80-f9fa-e746-95f7f39e74f8@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 24, 2020 at 09:23:00AM +0200, René Scharfe wrote:

> When we try to create a branch "foo" based on "origin/master" and give
> git commit -b an extra unsupported argument "bar", it confusingly
> reports:
> 
>    $ git checkout -b foo origin/master bar
>    fatal: 'bar' is not a commit and a branch 'foo' cannot be created from it
> 
>    $ git checkout --track -b foo origin/master bar
>    fatal: 'bar' is not a commit and a branch 'foo' cannot be created from it
> 
> That's wrong, because it very well understands that "origin/master" is
> supposed to be the start point for the new branch and not "bar".  Check
> if we got a commit and show more fitting messages in that case instead:
> 
>    $ git checkout -b foo origin/master bar
>    fatal: Cannot update paths and switch to branch 'foo' at the same time.
> 
>    $ git checkout --track -b foo origin/master bar
>    fatal: '--track' cannot be used with updating paths

Well explained.

> Original-patch-by: Jeff King <peff@peff.net>

If you want to count my hackery as a patch, sure...:)

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e9d111bb83..24336e1017 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1689,7 +1689,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  		 * Try to give more helpful suggestion.
>  		 * new_branch && argc > 1 will be caught later.
>  		 */
> -		if (opts->new_branch && argc == 1)
> +		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
>  			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
>  				argv[0], opts->new_branch);

And the fix itself looks obviously correct. We fall through to the other
error clauses, which you can't really see in the context, but your tests
verify it.

Thanks.

-Peff
