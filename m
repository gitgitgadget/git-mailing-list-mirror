Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7D1C433EF
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214A9610A4
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 13:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhJJNzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 09:55:35 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:17620 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhJJNze (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 09:55:34 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4HS3L36RZqz5tl9;
        Sun, 10 Oct 2021 15:53:31 +0200 (CEST)
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Krzysztof_=c5=bbelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net> <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5eca71b7-e4df-92a1-35bf-5a99550e558e@kdbg.org>
Date:   Sun, 10 Oct 2021 15:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.10.21 um 04:36 schrieb Jeff King:
> On Sat, Oct 09, 2021 at 02:58:10AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> I ran into this while testing the grep coloring patch[1] (but it's
>> unrelated). Before this commit e.g.:
>>
>>     LC_ALL=C ~/g/git/git -P -c i18n.commitEncoding=ascii log --author=Ævar -100|wc -l
>>     28333
>>
>> So ~3k lines for my last 100 commits, but then:
>>
>>     $ LC_ALL=C ~/g/git/git -P -c i18n.commitEncoding=ascii log --author=Ævar -100 2>&1|grep -c ^warning
>>     299
>>
>> At first I thought it was spewing warnings for every failed re-encoded
>> line in some cases, because I get hundreds at a time sometimes, but it's
>> because stderr and stdout I/O buffering is different (a common
>> case). Adding a "fflush(stderr)" "fixes" that.
> 
> I don't think the buffering is the issue. By default stderr flushes on
> lines, and we flush commits after showing them. If you take away "-P"
> (or look at the combined 2>&1 output in order), you'll see that they are
> grouped.
> 
> Now one thing you might notice is that there may be multiple warnings
> between output commits. But that's because we really are re-encoding
> each of those intermediate commits to do your --author grep. And if that
> re-encoding fails, we may well be producing the wrong output, because
> the matching won't be correct (in your case, presumably the correct
> output should be _nothing_, because Æ is not an ascii character).

I don't understand why i18n.commitEncoding plays a role here. Isn't it
an instruction "when you make a commit, mark the commit message having
this encoding". But grep does not make a commit.

If this were i18n.logOuputEncoding it would make much more sense.

Have I misunderstood the meaning of the two options?

-- Hannes
