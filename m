Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15081F453
	for <e@80x24.org>; Tue,  6 Nov 2018 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbeKGBn5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389204AbeKGBn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:43:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34E84356CD;
        Tue,  6 Nov 2018 16:18:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-95.rdu2.redhat.com [10.10.120.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2933A179F8;
        Tue,  6 Nov 2018 16:17:59 +0000 (UTC)
Subject: Re: [PATCH] format-patch: respect --stat when explicitly specified
To:     Duy Nguyen <pclouds@gmail.com>, leif.lindholm@linaro.org
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
 <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <0171b18f-0732-48fa-b4be-efbc9ba22f85@redhat.com>
Date:   Tue, 6 Nov 2018 17:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 06 Nov 2018 16:18:01 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/18 16:56, Duy Nguyen wrote:
> On Tue, Nov 6, 2018 at 11:48 AM Leif Lindholm <leif.lindholm@linaro.org> wrote:
>>
>> Commit 43662b23abbd
>> ("format-patch: keep cover-letter diffstat wrapped in 72 columns") made
>> format-patch keep the diffstat to within 72 characters. However, it does
>> this even when --stat is explicitly set on the command line.
>>
>> Make it possible to explicitly override the new mechanism, using --stat,
>> matching the functionality before this change. This also matches the
>> output in the case of non-cover-letter files.
>>
>> Cc: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> Cc: Junio C Hamano <gitster@pobox.com>
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
>> ---
>>
>> Note:
>> In TianoCore we have LotsOfGloriousFilesNamedInReallyLongCamelCase, so
>> our official submission guidelines specify the use of --stat.
>>
>>  builtin/log.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 061d4fd86..07e6ae2c1 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1009,7 +1009,8 @@ static void show_diffstat(struct rev_info *rev,
>>
>>         memcpy(&opts, &rev->diffopt, sizeof(opts));
>>         opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
>> -       opts.stat_width = MAIL_DEFAULT_WRAP;
>> +       if (rev->diffopt.stat_width == -1)
> 
> I don't think we get -1 here when stat_width is not defined. The
> "undefined" value is zero but I'm pretty sure we get MAIL_DEFAULT_WRAP
> in here unless you specify --stat.
> 
> So I think you can just drop the below assignment. But if you want to
> be on the safe side, check for zero stat_width instead of -1 and set
> MAIL_DEFAULT_WRAP.

Looks like I'll have to test v2 then...

> 
>> +               opts.stat_width = MAIL_DEFAULT_WRAP;
> 
> How about a test to make sure this will not be broken in future?

Oh, looks like I won't have to test this patch at all! ;)

(Just kidding, I'll test the next iteration.)

Thanks,
Laszlo

> 
>>
>>         diff_setup_done(&opts);
>>
>> --
>> 2.11.0

