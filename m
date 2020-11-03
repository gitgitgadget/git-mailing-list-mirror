Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26CC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890D020870
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKCS5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:57:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:46516 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCS5M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:57:12 -0500
Received: (qmail 6892 invoked by uid 109); 3 Nov 2020 18:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 18:57:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3590 invoked by uid 111); 3 Nov 2020 18:57:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 13:57:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 13:57:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
Message-ID: <20201103185711.GA461461@coredump.intra.peff.net>
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <20201102144321.GA3962443@coredump.intra.peff.net>
 <20201103101553.GH24813@szeder.dev>
 <20201103182102.GA459792@coredump.intra.peff.net>
 <xmqq361qs31a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq361qs31a.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 03, 2020 at 10:34:09AM -0800, Junio C Hamano wrote:

> > On our side, I don't think it would be _wrong_ to catch and disallow the
> > combination. But it may be nicer to them if we continue to quietly
> > ignore --follow and the pathspec in that case, for working with older
> > versions. (OTOH, if I understand correctly they're segfaulting every
> > time VS Code is used with v2.29 now, so they may have to accept it as an
> > urgent fix anyway).
> 
> So something like this won't harm VS Code more than we currently do,
> while telling users what is wrong with their command line?

Yeah, I was wondering if we'd want the patch you sent, or if we should
turn those die() calls into warning() and disable the flags up front.

> We may still want the "silently disable follow" at low-level
> protection, but that does not give feedback why the end-user option
> is silently ignored, so...

I'd be just as happy to leave it out, if we think it isn't triggerable.
The segfault would let people know we missed a spot. ;)

> diff --git c/builtin/log.c w/builtin/log.c
> index 9f939e6cdf..8811084f02 100644
> --- c/builtin/log.c
> +++ w/builtin/log.c
> @@ -206,6 +206,13 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	if (argc > 1)
>  		die(_("unrecognized argument: %s"), argv[1]);
>  
> +	if (rev->line_level_traverse) {
> +		if (rev->diffopt.filter)
> +			die(_("-L<range>:<file> cannot be used with pathspec"));

Should this be checking rev->diffopt.pathspec.nr?

I could well believe that --diff-filter=A does not work with "-L"
either, but that is a separate story.

-Peff
