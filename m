Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C095D1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 21:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBIVyx (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 16:54:53 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:32486 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfBIVyw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 16:54:52 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43xm6x4y7dz5tlB;
        Sat,  9 Feb 2019 22:54:49 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1C2EF1EA9;
        Sat,  9 Feb 2019 22:54:49 +0100 (CET)
Subject: Re: [Fix v2] t5562: remove dependency on /dev/zero
To:     Junio C Hamano <gitster@pobox.com>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20190208220751.9936-1-randall.s.becker@rogers.com>
 <f01141d4-e77e-24ba-2354-e7aebc2c3c57@kdbg.org>
 <xmqqwom8izu1.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8da682c1-aad2-ab83-9e46-6b7d4a6c68bd@kdbg.org>
Date:   Sat, 9 Feb 2019 22:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqwom8izu1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.19 um 19:25 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> How many bytes are needed here? yes() in test-lib.sh generates only 99
>> 'y', if I am not mistaken.
> 
> I think we will not use "yes" in the end for this topic, which makes
> this comment totally irrelevant to the thread, but I wonder why we
> have the limit of 99 there?  It cannot be "we do not want to worry
> about sigpipe" affecting the end result of the test (after all the
> reader may stop reading from after reading just one, and the status
> of the upstream process that would die with sigpipe is lost anyway).
> 
> It turns out it is about sigpipe ;-) but in somewhat a different
> way.  To prevent others from wasting their time wondering about
> this, probably we want to have something like the attached?

That would certainly be helpful!

-- Hannes

> 
>  t/README      | 9 +++++++++
>  t/test-lib.sh | 6 +++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/t/README b/t/README
> index 1326fd7505..f4e1a82657 100644
> --- a/t/README
> +++ b/t/README
> @@ -927,6 +927,15 @@ library for your script to use.
>     test_oid_init or test_oid_cache.  Providing an unknown key is an
>     error.
>  
> + - yes [<string>]
> +
> +   This is often seen in modern UNIX but some platforms lack it, so
> +   the test harness overrides the platform implementation with a
> +   more limited one.  Use this only when feeding a handful lines of
> +   output to the downstream---unlike the real version, it generates
> +   only up to 99 lines.
> +
> +
>  Prerequisites
>  -------------
>  
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 42b1a0aa7f..541a37f4c0 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1313,7 +1313,11 @@ then
>  	fi
>  fi
>  
> -# Provide an implementation of the 'yes' utility
> +# Provide an implementation of the 'yes' utility; the upper bound
> +# limit is there to help Windows that cannot stop this loop from
> +# wasting cycles when the downstream stops reading, so do not be
> +# tempted to turn it into an infinite loop. cf. 6129c930 ("test-lib:
> +# limit the output of the yes utility", 2016-02-02)
>  yes () {
>  	if test $# = 0
>  	then
> 

