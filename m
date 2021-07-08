Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A9BC07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A462A61C17
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhGHKR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 06:17:56 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.108]:17791 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhGHKR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 06:17:56 -0400
Received: from [84.163.72.131] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1R3J-00032B-Vf; Thu, 08 Jul 2021 12:14:42 +0200
Subject: Re: What actually is a branch?
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
Date:   Thu, 8 Jul 2021 12:15:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e67389a4adc_306ac1208fd@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2021 05:39, Felipe Contreras wrote:
> 
> Yeap, the tails of branch_1 and branch_2 could be literally anywhere.
> 
> That information is not recoverable from the current data structures of
> git, thus the proposal to add a new one.

Ok, thanks for the all the explanation.

A word on the name "tail". IMHO really confusing. I get where it is 
coming from.
But a lot of people will know head and tail utilities from their shell. 
And "tail" is the one that shows lines on the end of the file to which 
new data is added. Which is "head" in git.

Also a tail is something that follows, but (except for rebase), the base 
point is fixed.


I think (despite my earlier comment) "base" is a better word.
It also goes along with "git rebase" which acts on the "base".


However wording around that topic probably still needs to be very careful.
"base" must be clearly distinguished from "start". Because "start" might 
imply that only commits from here on forward are contained, but that 
contradicts --contains which reports root to head.



 > Suppose branch_2 was created this way:
 >
 >   git switch --create branch_2 A
 >
 > Then commit B was created under branch_2. Then master was fast-forwarded
 > to branch_2, so you have:
 >
 >                  A => B master
 >                  ^    ^
 >   tail/branch_2 -+    +- head/branch_2
 >
 > Both branches have A, but only branch_2 has A as tail.


So base (tail) is the shared commit "A" on which branch_2 was created. 
(rather than the first commit made in branch_2 which is "B")

I can see how that is needed for "git rebase" so @{base} can be used for 
<upstream>.



What happens if branch_2 is rebased?
Will the base be set to the commit onto which the branch was rebased?

A => B => C => D => E master
            \ => F => G  foo (base = B)

foo was created on B, then fast forwarded to C, then diverged.


    git rebase --onto A  foo@{base}  foo

Now that foo diverges before B, having B as base for foo seems odd. 
(Also A will have C' as child, So the base really is A now)

    git rebase --onto E  foo@{base}  foo

In this case C is already contained in master, so it will be skipped.
If the base is moved, then foo@{base}..foo will no longer contain C. 
IMHO that is correct, because rebase skipped it.

The alternative if base = C would be kept, then foo@{base}..foo would 
contain D and E. And that seems wrong?




Will there be a way to manually repoint the base?

A => B => C => D master
       \ => E => F  foo
                 \ => G => H  bar (base = F)


If I do

   git rebase --onto master  bar@{base} bar

then the commits E and F will not be part of the rebase.
That is fine. I must handle them before.

But if I deleted foo (or for other reasons decide E and F should be 
handled if I rebase bar) can I make them to be included?
Something like

   git base --repoint B  bar

