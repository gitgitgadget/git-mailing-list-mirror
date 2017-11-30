Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C4E20A40
	for <e@80x24.org>; Thu, 30 Nov 2017 06:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdK3GWI (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 01:22:08 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:56434 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdK3GWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 01:22:06 -0500
Received: from [192.168.178.21] (xd93220e4.dyn.telefonica.de [217.50.32.228])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 647D5140CBE;
        Thu, 30 Nov 2017 07:22:04 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 217.50.32.228) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
Subject: Re: [PATCH] git-prompt: fix reading files with windows line endings
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20171128201818.4132-1-rabel@robertabel.eu>
 <20171128201818.4132-2-rabel@robertabel.eu>
 <alpine.DEB.2.21.1.1711291519290.6482@virtualbox>
 <d57e4cb9-b0b4-314e-370a-e0db58a2a7da@robertabel.eu>
 <alpine.DEB.2.21.1.1711300100320.6482@virtualbox>
From:   Robert Abel <rabel@robertabel.eu>
Message-ID: <cacbf41e-3b4a-99e2-a0e0-50bb4cd9e152@robertabel.eu>
Date:   Thu, 30 Nov 2017 07:22:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711300100320.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20171130062204.15216.73326@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 30 Nov 2017 01:21, Johannes Schindelin wrote:
> On Wed, 29 Nov 2017, Robert Abel wrote:
>> This means that it should be okay to just do
>>
>>> test -r "$f" && IFS=" \t\r\n" read "$@" < "$f"
> 
> I am afraid that this won't work: when I call

I managed to trick myself with that one, yes...
Apparently I had already converted my HEAD back to Unix line endings.

However, I noticed that the behavior of read is apparently
ambiguous for the last (or a single) variable:

From POSIX.1-2008:
> If there are fewer vars than fields, the last var shall be set to a
> value comprising the following elements:
> - The field that corresponds to the last var in the normal assignment
>   sequence described above
> - The delimiter(s) that follow the field corresponding to the last var
> - The remaining fields and their delimiters, with trailing IFS white
>   space ignored

I read that last "ignored" as "trailing IFS white space shall not be
appended". Apparently, people implementing read read it as "trailing
IFS while space shall not be processed further"

Thus, the behavior for trailing IFS white space is different in
case of one or two variables:

    printf '123 456\r\n' | while IFS=$' \t\r\n' read foo bar
    do
        printf 'foo: %s' "$foo" | hexdump -C
        printf 'bar: %s' "$bar" | hexdump -C
    done

This works as expected trimming the trailing \r:
    00000000  66 6f 6f 3a 20 31 32 33                           |foo: 123|
    00000008
    00000000  62 61 72 3a 20 34 35 36                           |bar: 456|
    00000008

While doing the same just reading a single variable

    printf '123 456\r\n' | while IFS=$' \t\r\n' read foo
    do
        printf 'foo: %s' "$foo" | hexdump -C
        printf 'bar: %s' "$bar" | hexdump -C
    done

prints

    00000000  66 6f 6f 3a 20 31 32 33  20 34 35 36 0d           |foo:
123 456.|
    0000000d
    00000000  62 61 72 3a 20                                    |bar: |
    00000005

Notice the 0d at the end of foo, which didn't get trimmed.

So reading a dummy variable along with the actual content variable
works for git-prompt:

    __git_eread ()
    {
        local f="$1"
        local dummy
        shift
        test -r "$f" && IFS=$'\r\n' read "$@" dummy < "$f"
    }

I feel like this would be the most readable solution thus far.

Regards,

Robert
