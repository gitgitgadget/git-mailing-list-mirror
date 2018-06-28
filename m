Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55AE1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966717AbeF1Oho (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:37:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:58276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966506AbeF1Ohl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:37:41 -0400
Received: (qmail 14540 invoked by uid 109); 28 Jun 2018 14:37:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 14:37:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20350 invoked by uid 111); 28 Jun 2018 14:38:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 10:38:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 10:37:39 -0400
Date:   Thu, 28 Jun 2018 10:37:39 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180628143738.GC16657@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com>
 <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net>
 <CAPig+cRvgsu-6f+mzjGVDWTVhFrhLY5MsNxEQBJYckKDpeaMAg@mail.gmail.com>
 <20180626210100.GA3682@sigill.intra.peff.net>
 <CABPp-BHgPgkgQj7i3rZtdbinVZvqH35uGraUK9doL-E8Y5QuSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHgPgkgQj7i3rZtdbinVZvqH35uGraUK9doL-E8Y5QuSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 07:15:45PM -0700, Elijah Newren wrote:

> Crazy idea: maybe we could defang it a little more thoroughly with
> something like the following (apologies in advance if gmail whitespace
> damages this):
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 28315706be..7fda08a90a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -675,7 +675,7 @@ test_run_ () {
>                 trace=
>                 # 117 is magic because it is unlikely to match the exit
>                 # code of other programs
> -               if test "OK-117" != "$(test_eval_ "(exit 117) &&
> $1${LF}${LF}echo OK-\$?" 3>&1)"
> +               if test "OK-117" != "$(test_eval_ "cd() { return 0; }
> && PATH=/dev/null && export PATH && (exit 117) && $1${LF}${LF}echo
> OK-\$?" 3>&1)"

Clever. We'd still run shell builtins, which is why you need the cd()
above. There may be others, but at least it narrows things down. Unless
the shell is busybox or something, and implements everything as a
builtin. :)

I agree on the point elsewhere of returning non-zero (and the items
missing from PATH should do that, which is good).

-Peff
