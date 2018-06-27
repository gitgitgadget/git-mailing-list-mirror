Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0C71F597
	for <e@80x24.org>; Wed, 27 Jun 2018 06:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeF0G1i (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 02:27:38 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:1704 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeF0G1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 02:27:37 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41FtHq6Phfz5tlM;
        Wed, 27 Jun 2018 08:27:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1487A3B5;
        Wed, 27 Jun 2018 08:27:35 +0200 (CEST)
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com>
 <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net>
 <CAPig+cRvgsu-6f+mzjGVDWTVhFrhLY5MsNxEQBJYckKDpeaMAg@mail.gmail.com>
 <20180626210100.GA3682@sigill.intra.peff.net>
 <CABPp-BHgPgkgQj7i3rZtdbinVZvqH35uGraUK9doL-E8Y5QuSQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <67110b53-690c-abd4-9988-33278ee8c413@kdbg.org>
Date:   Wed, 27 Jun 2018 08:27:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHgPgkgQj7i3rZtdbinVZvqH35uGraUK9doL-E8Y5QuSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.2018 um 04:15 schrieb Elijah Newren:
> On Tue, Jun 26, 2018 at 2:01 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Jun 26, 2018 at 04:46:18PM -0400, Eric Sunshine wrote:
> 
>>> Some of these dangers can be de-thoothed during the linting phase by
>>> defining do-nothing shell functions:
>>>
>>>      cp () { :; }
>>>      mv () { :; }
>>>      ln () { :; }
>>>
>>> That, at least, makes the scariest case ("rm") much less so.
>>
>> Now that's an interesting idea. We can't catch every dangerous action
>> (notably ">" would be hard to override), but it should be pretty cheap
>> to cover some obvious ones.
>>
>> -Peff
> 
> Crazy idea: maybe we could defang it a little more thoroughly with
> something like the following (apologies in advance if gmail whitespace
> damages this):
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 28315706be..7fda08a90a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -675,7 +675,7 @@ test_run_ () {
>                  trace=
>                  # 117 is magic because it is unlikely to match the exit
>                  # code of other programs
> -               if test "OK-117" != "$(test_eval_ "(exit 117) &&
> $1${LF}${LF}echo OK-\$?" 3>&1)"
> +               if test "OK-117" != "$(test_eval_ "cd() { return 0; }
> && PATH=/dev/null && export PATH && (exit 117) && $1${LF}${LF}echo
> OK-\$?" 3>&1)"
>                  then
>                          error "bug in the test script: broken &&-chain
> or run-away HERE-DOC: $1"
>                  fi

I'd define all these functions as { return 1; } because we want to stop 
any && chain as early as possible (and with an exit code that is not the 
sentinel value).

-- Hannes
