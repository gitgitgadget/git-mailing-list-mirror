Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B4820189
	for <e@80x24.org>; Mon, 20 Jun 2016 00:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbcFTAUR (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 20:20:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:57090 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751379AbcFTAUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 20:20:16 -0400
Received: (qmail 19353 invoked by uid 102); 20 Jun 2016 00:13:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 20:13:35 -0400
Received: (qmail 11459 invoked by uid 107); 20 Jun 2016 00:13:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 20:13:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Jun 2016 20:13:32 -0400
Date:	Sun, 19 Jun 2016 20:13:32 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>,
	Vadim Eisenberg <VADIME@il.ibm.com>, git@vger.kernel.org
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a
 submodule
Message-ID: <20160620001332.GA10101@sigill.intra.peff.net>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net>
 <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 01:51:56PM -0700, Junio C Hamano wrote:

> Yup, something like this on top of d22eb04 to be merged before
> v2.9.1 for the maintenance track would be necessary.
> 
> -- >8 --
> Subject: clone: do not let --depth imply --shallow-submodules
> 
> In v2.9.0, we prematurely flipped the default to force cloning
> submodules shallowly, when the superproject is getting cloned
> shallowly.  This is likely to fail when the upstream repositories
> submodules are cloned from a repository that is not prepared to
> serve histories that ends at a commit that is not at the tip of a
> branch, and we know the world is not yet ready.
> 
> Use a safer default to clone the submodules fully, unless the user
> tells us that she knows that the upstream repository of the
> submodules are willing to cooperate with "--shallow-submodules"
> option.

Yeah, this looks good. To minor comments:

> @@ -730,8 +730,7 @@ static int checkout(void)
>  		struct argv_array args = ARGV_ARRAY_INIT;
>  		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
>  
> -		if (option_shallow_submodules == 1
> -		    || (option_shallow_submodules == -1 && option_depth))
> +		if (option_shallow_submodules == 1)
>  			argv_array_push(&args, "--depth=1");

I hadn't paid much attention to this topic originally, but was surprised
that "--depth 10" in the clone implies "--depth 1" in the submodule.
This is not really related to your patch (in fact, your patch makes the
logic go away). But maybe something to consider if it's ever resurrected
(or possibly if somebody runs "--shallow-submodules --depth 5" we should
pass --depth=1; I dunno).

> -test_expect_success 'shallow clone implies shallow submodule' '
> +test_expect_success 'shallow clone does not imply shallow submodule' '
>  	test_when_finished "rm -rf super_clone" &&
> -	git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
> +	git clone --recurse-submodules --depth 2 --shallow-submodules "file://$pwd/." super_clone &&
>  	(
>  		cd super_clone &&
>  		git log --oneline >lines &&

We are not really testing "does not imply" here, but "passing
--shallow-submodules works". The "does not imply" test would be cloning
without the option and checking that the resulting submodules are not
shallow.

-Peff
