Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5F11FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 20:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbcFXUwg (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:52:36 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:34536 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbcFXUwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 16:52:36 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rbrB94N72z5tl9;
	Fri, 24 Jun 2016 22:52:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 5916C29B1;
	Fri, 24 Jun 2016 22:52:32 +0200 (CEST)
Subject: Re: [PATCH 1/4] tests: factor portable signal check out of t0005
To:	Jeff King <peff@peff.net>
References: <20160624193924.GA6282@sigill.intra.peff.net>
 <20160624194357.GA6441@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <576D9D90.3070605@kdbg.org>
Date:	Fri, 24 Jun 2016 22:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160624194357.GA6441@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 24.06.2016 um 21:43 schrieb Jeff King:
> In POSIX shells, a program which exits due to a signal
> generally has an exit code of 128 plus the signal number.
> However, some platforms do other things. ksh uses 256 plus
> the signal number, and on Windows, all signals are just "3".

That's not true, see below.

> I didn't get into the weirdness of SIGPIPE on Windows here, but I think
> this is probably a first step toward handling it better. E.g., it may be
> that test_match_signal should respect 128 (or even any code) when we are
> checking for SIGPIPE.

The Windows behavior is most closely described as having signal(SIGPIPE, 
SIG_IGN) at the very beginning of the program.

> +# Returns true if the numeric exit code in "$2" represents the expected signal
> +# in "$1". Signals should be given numerically.
> +test_match_signal () {
> +	if test "$2" = "$((128 + $1))"
> +	then
> +		# POSIX
> +		return 0
> +	elif test "$2" = "$((256 + $1))"
> +	then
> +		# ksh
> +		return 0
> +	elif test "$2" = "3"; then
> +		# Windows

You meant well here, but this is close to pointless as a general check. 
We check for this exit code in t0005 because there program termination 
happens via raise(), which on Window just calls exit(3). This exit code 
is not an indication that something related to SIGPIPE (or any signal) 
happened.

IMO there is too much danger to trigger a false positive if exit code 3 
is treated special in this generality.

> +		return 0
> +	fi
> +	return 1
> +}

-- Hannes

