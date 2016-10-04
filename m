Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6D01F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 06:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbcJDGqC (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:46:02 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:54106 "EHLO
        5.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbcJDGqC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:46:02 -0400
X-Greylist: delayed 4616 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Oct 2016 02:46:01 EDT
Received: from player692.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 89202261E8
        for <git@vger.kernel.org>; Tue,  4 Oct 2016 07:28:57 +0200 (CEST)
Received: from [192.168.1.10] (89-166-15-32.bb.dnainternet.fi [89.166.15.32])
        (Authenticated sender: kevin@bracey.fi)
        by player692.ha.ovh.net (Postfix) with ESMTPSA id F067860006B;
        Tue,  4 Oct 2016 07:28:55 +0200 (CEST)
Message-ID: <57F33E12.4020900@bracey.fi>
Date:   Tue, 04 Oct 2016 08:28:50 +0300
From:   Kevin Bracey <kevin@bracey.fi>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
MIME-Version: 1.0
To:     GIT Mailing-list <git@vger.kernel.org>
CC:     =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/3] add QSORT
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de> <xmqqponmcp07.fsf@gitster.mtv.corp.google.com> <83398160-555f-adab-6b1e-3283c533b5ff@web.de> <57F290DC.5080303@bracey.fi> <9ff725eb-3536-638b-1ec0-ff9130478abc@web.de>
In-Reply-To: <9ff725eb-3536-638b-1ec0-ff9130478abc@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4474607706328633565
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelvddrvdeigdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/2016 01:00, René Scharfe wrote:
> Am 03.10.2016 um 19:09 schrieb Kevin Bracey:
>> As such, NULL checks can still be elided even with your change. If you
>> effectively change your example to:
>>
>>     if (nmemb > 1)
>>         qsort(array, nmemb, size, cmp);
>>     if (!array)
>>         printf("array is NULL\n");
>>
>> array may only be checked for NULL if nmemb <= 1. You can see GCC doing
>> that in the compiler explorer - it effectively turns that into "else
>> if".
>
> We don't support array == NULL together with nmemb > 1, so a segfault 
> is to be expected in such cases, and thus NULL checks can be removed 
> safely.
>
Possibly true in practice.

But technically wrong by the C standard - behaviour is undefined if the 
qsort pointer is invalid. You can't formally expect the defined 
behaviour of a segfault when sending NULL into qsort. (Hell, maybe the 
qsort has its own NULL check and silently returns! cf printf - some 
printfs will segfault when passed NULL, some print "(null)"). I've 
worked on systems that don't fault reads to NULL, only writes, so those 
might not segfault there, if NULL appeared sorted...

And obviously there's the language lawyer favourite possibility of the 
call causing nasal flying monkeys or whatever.

So if it's not a program error for array to be NULL and nmemb to be zero 
in your code, and you want a diagnostic for array=NULL, nmemb non-zero, 
I think you should put that diagnostic into sane_qsort as an assert or 
something, not rely on qsort's undefined behaviour being a segfault.

     sane_qsort(blah)
     {
          if (nmemb >= 1) {
              assert(array);
              qsort(array, nmemb, ...);
          }
     }

Can't invoke undefined behaviour from NULL without triggering the 
assert. (Could still have other invalid pointers, of course).

Usually I am on the side of "no NULL checks", as I make the assumption 
that we will get a segfault as soon as NULL pointers are used, and those 
are generally easy to diagnose. But seeing a compiler invoking this sort 
of new trickery due to invoking undefined behaviour is making me more 
nervous about doing so...

>> To make that check really work, you have to do:
>>
>>     if (array)
>>         qsort(array, nmemb, size, cmp);
>>     else
>>         printf("array is NULL\n");
>>
>> So maybe your "sane_qsort" should be checking array, not nmemb.
>
> It would be safe, but arguably too much so, because non-empty arrays 
> with NULL wouldn't segfault anymore, and thus become harder to 
> identify as the programming errors they are.
Well, you get the print. Although I guess you're worrying about the 
second if being real code, not a debugging check.

I must say, this is quite a courageous new optimisation from GCC. It 
strikes me as finding a language lawyer loophole that seems to have been 
intended for something else (mapping library functions directly onto 
CISCy CPU intrinsics), and using it to invent a whole new optimisation 
that seems more likely to trigger bugs than optimise any significant 
amount of code in a desirable way.

Doubly weird as there's no (standard) language support for this. I don't 
know how you'd define "my_qsort" that triggered the same optimisations.

I've seen similar 
library-knowledge-without-any-way-to-reproduce-in-user-code 
optimisations like "malloc returns a new pointer that doesn't alias with 
anything existing" (and no way to reproduce the optimisation with 
my_malloc_wrapper). But those seemed to have a clear performance 
benefit, without any obvious traps. Doubtful about this one.

Kevin

