Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40ED20969
	for <e@80x24.org>; Thu, 30 Mar 2017 19:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934665AbdC3T6Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 15:58:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:54370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934524AbdC3T6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 15:58:24 -0400
Received: (qmail 26420 invoked by uid 109); 30 Mar 2017 19:58:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 19:58:22 +0000
Received: (qmail 2142 invoked by uid 111); 30 Mar 2017 19:58:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 15:58:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 15:58:20 -0400
Date:   Thu, 30 Mar 2017 15:58:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
Message-ID: <20170330195820.kexvl44x7ncthlcx@sigill.intra.peff.net>
References: <20170328190732.59486-1-git@jeffhostetler.com>
 <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
 <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
 <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
 <xmqqtw6a35qc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw6a35qc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 12:49:15PM -0700, Junio C Hamano wrote:

> Notable suggested changes I have in this one are:
> 
>  * I stole the numbers from the cover letter of v2 and added them at
>    the end of the log message.

Yeah, good.

>  * As the checksum is not a useless relic, but is an integrity
>    check, I dropped the "ancient relic" from the proposed log
>    message.  It is just that the modern disks are reliable enough to
>    make it worthwhile to think about a trade-off this patch makes
>    between performance and integrity.

Yeah, I'd agree this is more of a tradeoff than a cleanup.

>  * As it is customary, the configuration variable starts as an opt
>    in feature.  In a few releases, perhaps we can flip the default,
>    but we do not do so from day one.

I think this is so user-invisible that it doesn't really matter much,
but I'm OK with taking it slow.

>  * Updated the code around the call to config-get-bool to avoid
>    asking the same question twice.

A few comments on that below.

>  * Added minimum documentation.

Yep, looks good.

> By the way, are we sure we have something that validates the
> checksum regardless of the configuration setting?  If not, we may
> want to tweak this further so that we can force the validation from
> "git fsck" or something.  I am not going to do that myself, but it
> may be necessary before this graduates to 'master'.

Yes, I'd agree this shouldn't graduate without the matching change to
teach fsck to flip the switch back.

> +	static int do_checksum = -1;
> [...]
> +	if (do_checksum < 0) {
> +		/*
> +		 * Since we run very early in command startup, git_config()
> +		 * may not have been called yet and the various "core_*"
> +		 * global variables haven't been set.  So look it up
> +		 * explicitly.
> +		 */
> +		git_config_get_bool("core.checksumindex", &do_checksum);
> +		if (do_checksum < 0)
> +			do_checksum = 0; /* default to false */
> +	}
> +	if (!do_checksum)
> +		return 0;

This is basically introducing a new caching layer, but there's no way to
invalidate it (if, say, we looked at the config once and then we knew
that the config changed).  I think it's probably OK, because the main
reason for the config to change is reading it before/after repository
setup. But since this is index code, it shouldn't be called at all
before repository setup.

Still, I'm not sure the extra layer of cache is all that valuable. It
should be a single hash lookup in the config cache (in an operation that
otherwise reads the entire index).

-Peff
