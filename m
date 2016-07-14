Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB882019E
	for <e@80x24.org>; Thu, 14 Jul 2016 20:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbcGNUO2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:14:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:44929 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751397AbcGNUO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:14:26 -0400
Received: (qmail 13632 invoked by uid 102); 14 Jul 2016 20:14:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 16:14:26 -0400
Received: (qmail 8697 invoked by uid 107); 14 Jul 2016 20:14:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 16:14:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 16:14:23 -0400
Date:	Thu, 14 Jul 2016 16:14:23 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160714201423.GB18372@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <20160714182108.GB16497@sigill.intra.peff.net>
 <xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
 <xmqqoa60oulk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa60oulk.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 01:03:35PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > OK, how about this on top of a replacement for js/t0006-for-v2.9.2
> > that I'll send out as a reply to this message?
> 
> which is this one, which is largely from your $gmane/299310.

Mostly OK, but two minor nits:

> diff --git a/help.c b/help.c
> index 19328ea..0cea240 100644
> --- a/help.c
> +++ b/help.c
> @@ -419,6 +419,13 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  	 * with external projects that rely on the output of "git version".
>  	 */
>  	printf("git version %s\n", git_version_string);
> +	while (*++argv) {
> +		if (!strcmp(*argv, "--build-options")) {
> +			printf("sizeof-unsigned-long: %d",
> +			       (int)sizeof(unsigned long));
> +			/* maybe also save and output GIT-BUILD_OPTIONS? */
> +		}

That comment was mostly for explaining my mindset in the discussion. If
we're going to keep it, maybe mark it with a TODO or XXX or something?

> +test_lazy_prereq 64BIT '
> +	test 8 -le "$(build_option sizeof-unsigned-long)"
> +'

As mentioned in my previous email, I wonder if this should be UL64 or
something.

As noted earlier in the thread, t0006 actually cares most directly about
LONG_MAX, but I think it's probably OK to assume it is directly related
to "unsigned long". Also, even if we got past that initial "strtol", I
suspect "unsigned long" _would_ come into play anyway, as that is our
internal representation.

-Peff
