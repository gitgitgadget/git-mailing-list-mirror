Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEF31F453
	for <e@80x24.org>; Fri,  1 Feb 2019 19:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfBATAm (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 14:00:42 -0500
Received: from mx-out1.startmail.com ([145.131.90.139]:39930 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfBATAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 14:00:41 -0500
Subject: Re: Broken interactive rebase text after some UTF-8 characters
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1549047639;
        bh=bZvzV+vWCfJpE4ZMmb3kFfMEI8XbJfymrRvBM5O1VIg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ll9+gDQHN2MgpaEe0m9Ix6I5YtMwqMaF2fjQ89YEJtcw1wQTLSaJU930XKCYKKhJ1
         7CCxpwCnKbZ2/fu5dqP3sNGc6Tkfy4y5kNH+IG7QDcy+yt4VfaI21RuCSL7aSBnVnC
         HArWP1Z065QQQ8ALHR3UxcFaHMhv2PNTJlwzTv/D+PuAx2dOmQ53UoC4p7x8GUIBFe
         1r7+/p+w6UC6Y0vCvaK8LwQVcc6AvR9HubqWX+MKpzFdlIxIltta5TC1eszLRhlit5
         y+3fe0oCMKDQn8oDBlgoZPgn5RlGeVh34BUSEmdFkWfdVnXeAYazwr7RkOXV8rx8U+
         vHlXzPT3nyqzQ==
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
 <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
 <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
 <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
 <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
 <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
 <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
 <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
 <nycvar.QRO.7.76.6.1902011530440.41@tvgsbejvaqbjf.bet>
 <eda7b1c4-5fd6-5440-8998-75eab9f73e47@startmail.com>
 <xmqqpnsbzaa6.fsf@gitster-ct.c.googlers.com>
From:   Michal Nowak <mnowak@startmail.com>
Message-ID: <7fe4edcd-f4ec-3ad5-a9ea-e4015e4afc37@startmail.com>
Date:   Fri, 1 Feb 2019 20:00:37 +0100
Mime-Version: 1.0
In-Reply-To: <xmqqpnsbzaa6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/01/19 06:30 PM, Junio C Hamano wrote:
> Michal Nowak <mnowak@startmail.com> writes:
> 
>>> You already have that example. Just take the UTF-8 text in your original
>>> bug report, put it into something like
>>>
>>> 	int main(int argc, char **argv)
>>> 	{
>>> 		char utf8[] = "... your text here...";
>>>
>>> 		printf("%.*s", (int)(sizeof(utf8) - 1), utf8);
>>>
>>> 		return 0;
>>> 	}
> 
> When replayed literally, this is not a very good test.
> 
>> {global} newman@lenovo:~ $ cat printf.c
>> #include <stdio.h>
>> //#include <gettext.h>
>> int main(int argc, char **argv) {
>>    char utf8[] = "Gergő Mihály Doma\n";
>>    printf("%.*s", (int)(sizeof(utf8) - 1), utf8);
>>    return 0;
>> }
> 
> And this is replaying it literally.
> 
> The current working suspicion in this thread is that the platform
> printf("%.*s", num, str) emits up to num "characters" starting at
> str, which is an incorrect implementation, as it should emit up to
> num "bytes".
> 
> Notice that the num in this case is the byte count of that utf8[]
> string.  That number is always larger than the number of "characters"
> for a string with multi-byte character(s) in it.  Let's say that the
> sample string has N "characters", and it is N+X "bytes" long, where
> X > 1.
> 
> If the suspicion is correct, i.e. the way the printf implementation
> is broken on this platform is that it shows up to num "characters",
> then the call is asking to show up to N+X "characters".  The buggy
> printf shows all the available N "characters", notices the string
> stops there, and finishes.  So you won't _see_ the bug with that
> test program.
> 
> Instead, use something like this.
> 
>          #include <stdio.h>
> 
>          int main(int ac, char **av)
>          {
>                  char utf8[] = "ふabc";
>                  printf("%.*s\n", 4, utf8);
>                  return 0;
>          }
> 
> With or without gettext or i18n, the output must end with 'a' followed
> by a newline, and you must not see 'b' nor 'c'.  Otherwise your printf
> is broken.
> 

The output ends with 'a' for me on OpenIndiana:

{global} newman@lenovo:~ $ gcc tp.c -o tp && ./tp
ふa

Though, I can reproduce the problem with Alban's test case the exact 
same way he wrote earlier today.

Michal
