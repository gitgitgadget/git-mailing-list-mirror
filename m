Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325581FAE2
	for <e@80x24.org>; Wed, 10 Jan 2018 17:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbeAJRyv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 12:54:51 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:19396 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbeAJRyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 12:54:50 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zGxVJ23YSz5tl9;
        Wed, 10 Jan 2018 18:54:48 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9799C211D;
        Wed, 10 Jan 2018 18:54:47 +0100 (CET)
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git v2.16.0-rc1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com, git-for-windows@googlegroups.com
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.76.6.1801101823420.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2727bfc6-d789-ee45-fb3b-95b7b21e4cba@kdbg.org>
Date:   Wed, 10 Jan 2018 18:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1801101823420.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.2018 um 18:37 schrieb Johannes Schindelin:
> On Tue, 9 Jan 2018, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
>>> index f1678851de9..470107248eb 100644
>>> --- a/t/t0021/rot13-filter.pl
>>> +++ b/t/t0021/rot13-filter.pl
>>> @@ -31,7 +31,22 @@
>>>   #
>>>   
>>>   use 5.008;
>>> -use lib (split(/:/, $ENV{GITPERLLIB}));
>>> +sub gitperllib {
>>> +...
>>> +	if ($ENV{GITPERLLIB} =~ /;/) {
>>> +		return split(/;/, $ENV{GITPERLLIB});
>>> +	}
>>> +	return split(/:/, $ENV{GITPERLLIB});
>>> +}
>>
>> This cannot be the whole story for a few reasons.
>>
>>   - In t/test-lib.sh we see this:
>>
>>     GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
>>     export GITPERLLIB
>>
>>     If this part wants to split with ';', then the joining needs to
>>     be done with ';' to match, no?
> 
> No.
> 
> It is a lot more complicated than that. As you know, on Linux there is
> this implicit assumption that path lists are colon-separated. As a
> consequence, Cygwin does the same (because it would be too hard to port
> all those Linux/Unix projects to stop assuming colon-separated path lists,
> right?)
> 
> This is what Cygwin's Bash does (and hence the MSYS2 Bash used by Git for
> Windows, too).
> 
> Then the MSYS2 Bash calls git.exe, which is *not* an MSYS2 program, hence
> the MSYS2 runtime knows that it has to convert the path lists to Windows
> paths separated by semicolons.
> 
> The next thing happening in our case is that the Perl script is called
> from git.exe. Now, the MSYS2 runtime (implicitly spun up by the MSYS2 Perl
> interpreter) does *not* convert those path lists back to Unix-like paths
> separated by colons.

But this is a bug in MSYS2, isn't it? The MSYS2 runtime should detect 
that it was not invoked by some other MSYS2 process. The MSYS2 startup 
sequence should assume in this case that the environment is 
Windows-style and convert to POSIX before it calls into perl's main().

> And that's why the Unix shell script can happily construct the
> colon-separated list, and the Perl script will *still* receive the
> semicolon-separated version of it.
> 
>>   - In addition to t0021, there are similar split with colon in 0202,
>>     9000 and 9700, yet I am getting the feeling that you observed the
>>     issue only in0021, to which I do not think of a good explanation
>>     why.
> 
> Here is the good explanation: t0021 relies on a Perl package that is not
> yet installed. t0202 relies on Git::I18N, of which there is a version
> installed in Git for Windows' SDK. (I do not bother to slow down the test
> runs by the Subversion tests, I always skip all of them, that's why t9*
> does not matter to me.)

t0202 and the t9* cases are different because perl is invoked by bash 
directly (AFAICS), without a non-MSYS2 process between them. There is no 
difference when the path conversion is omitted in this case by design or 
due to a bug.

-- Hannes
