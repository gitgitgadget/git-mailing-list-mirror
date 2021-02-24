Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07935C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12C564E85
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhBXE7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:59:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:42692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233618AbhBXE7G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:59:06 -0500
Received: (qmail 29019 invoked by uid 109); 24 Feb 2021 04:58:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 04:58:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8929 invoked by uid 111); 24 Feb 2021 04:58:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 23:58:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 23:58:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Tilman Vogel <tilman.vogel@web.de>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: [PATCH] push: do not turn --delete '' into a matching push
Message-ID: <YDXc4XFwaOj/r3YK@coredump.intra.peff.net>
References: <xmqq4ki21ioz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ki21ioz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 03:13:32PM -0800, Junio C Hamano wrote:

> When we added a syntax sugar "git push remote --delete <ref>" to
> "git push" as a synonym to the canonical "git push remote :<ref>"
> syntax at f517f1f2 (builtin-push: add --delete as syntactic sugar
> for :foo, 2009-12-30), we weren't careful enough to make sure that
> <ref> is not empty.
> 
> Blindly rewriting "--delete <ref>" to ":<ref>" means that an empty
> string <ref> results in refspec ":", which is the syntax to ask for
> "matching" push that does not delete anything.
> 
> Worse yet, if there were matching refs that can be fast-forwarded,
> they would have been published prematurely, even if the user feels
> that they are not ready yet to be pushed out, which would be a real
> disaster.
> 
> Noticed-by: Tilman Vogel <tilman.vogel@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * So this time with an obvious test.  It is somewhat surprising
>    that this has been left unnoticed for the past 10 years.

Thanks, this looks like the obviously correct fix. I'm not too surprised
that nobody noticed. You have to add quoting to get an empty-string
argument in shell, and the non-delete case does notice and complain.

I did wonder if this was related to recent refactoring around the
refspec code (like negative refspecs), but I think this function is
independent of that anyway. Thanks for tracking down the original
culprit.

> diff --git a/builtin/push.c b/builtin/push.c
> index 03adb58602..194967ed79 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -115,7 +115,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
>  			else
>  				refspec_appendf(&rs, "refs/tags/%s", ref);
>  		} else if (deleterefs) {
> -			if (strchr(ref, ':'))
> +			if (strchr(ref, ':') || !*ref)
>  				die(_("--delete only accepts plain target ref names"));
>  			refspec_appendf(&rs, ":%s", ref);
>  		} else if (!strchr(ref, ':')) {

Just wondering if there are other similar bugs lurking:

  - could we see other strings that aren't empty, but also aren't plain
    target ref names? E.g., other punctuation like a "^" negative
    refspec? I guess that would produce ":^", which the refspec code
    will catch.

  - likewise, do any of these other else clauses blindly pass around an
    empty string? Yes, the final one does, but we catch it later in the
    refspec code.

So I think it really is this "blindly prepend a colon" part that is the
real bug. Anything else would create a nonsense refspec that will be
caught by the refspec code.

-Peff
