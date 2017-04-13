Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1881720960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755584AbdDMTMm (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:12:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:33148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755537AbdDMTMk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:12:40 -0400
Received: (qmail 31874 invoked by uid 109); 13 Apr 2017 19:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 19:12:40 +0000
Received: (qmail 26522 invoked by uid 111); 13 Apr 2017 19:13:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 15:13:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Apr 2017 15:12:36 -0400
Date:   Thu, 13 Apr 2017 15:12:36 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
Message-ID: <20170413191236.3usecfgkjujhblo6@sigill.intra.peff.net>
References: <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net>
 <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
 <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net>
 <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net>
 <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
 <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net>
 <CAM0VKjmK0ib+sjf0sMPeiK7DrwHq1dJ58ZhDdp6HZsuQdb-eRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjmK0ib+sjf0sMPeiK7DrwHq1dJ58ZhDdp6HZsuQdb-eRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 09:03:26PM +0200, SZEDER Gábor wrote:

> > Yeah, I had a similar thought. I can't think of any reason why it would
> > trigger a false positive, as long as we account for test-failure and the
> > --debug flag properly. I don't think we can just drop the "-f" from the
> > final "rm", because it may be overriding funny permissions left by
> > tests.
> 
> FWIW, I used the following rather simple change during stress-testing
> these patches (barring white-space damage):
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 13b569682..d7fa15a69 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -763,7 +763,7 @@ test_done () {
> 
>                 test -d "$remove_trash" &&
>                 cd "$(dirname "$remove_trash")" &&
> -               rm -rf "$(basename "$remove_trash")"
> +               rm -rf "$(basename "$remove_trash")" || exit 1

Oh, right. I thought "-f" would cause it to exit 0 even if some items
failed to be removed, but that only applies to ENOENT. So I think that
is probably a good change. I agree it's not a true error, but just a
sign of something fishy, but I don't think it hurts to have extra lint
checks.

Replacing it the "exit 1" with a "die" that has a message is probably a
good idea, though.

-Peff
