Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310821F461
	for <e@80x24.org>; Tue, 14 May 2019 17:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfENR7A (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 13:59:00 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:40028 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfENR67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 13:58:59 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 453QRN4bJKz5tlF;
        Tue, 14 May 2019 19:58:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 34EAD2084;
        Tue, 14 May 2019 19:58:55 +0200 (CEST)
Subject: Re: [PATCH v2 3/7] rebase: add support for multiple hooks
To:     Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-4-sandals@crustytoothpaste.net>
 <CACsJy8CnCoMK7ahjRotKfiC2ic-U0hdhKuQAeF-TtVt8N+bU2Q@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <68ebbf52-3925-901d-b4c1-c6144c7f60b7@kdbg.org>
Date:   Tue, 14 May 2019 19:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CnCoMK7ahjRotKfiC2ic-U0hdhKuQAeF-TtVt8N+bU2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.05.19 um 14:56 schrieb Duy Nguyen:
> On Tue, May 14, 2019 at 7:24 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 912d9821b1..340eacbd44 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -441,24 +441,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
>>   */
>>  static int run_post_rewrite_hook(const struct am_state *state)
>>  {
>> -       struct child_process cp = CHILD_PROCESS_INIT;
>> -       const char *hook = find_hook("post-rewrite");
>> -       int ret;
>> -
>> -       if (!hook)
>> -               return 0;
>> -
>> -       argv_array_push(&cp.args, hook);
>> -       argv_array_push(&cp.args, "rebase");
>> -
>> -       cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
>> -       cp.stdout_to_stderr = 1;
>> -       cp.trace2_hook_name = "post-rewrite";
>> -
>> -       ret = run_command(&cp);
>> -
>> -       close(cp.in);
> 
> In the old code, we close cp.in...
> 
>> +int post_rewrite_rebase_hook(const char *name, const char *path, void *input)
>> +{
>> +       struct child_process child = CHILD_PROCESS_INIT;
>> +
>> +       child.in = open(input, O_RDONLY);
>> +       child.stdout_to_stderr = 1;
>> +       child.trace2_hook_name = "post-rewrite";
> 
>> +       argv_array_push(&child.args, path);
>> +       argv_array_push(&child.args, "rebase");
>> +       return run_command(&child);
> 
> ... but in the new one we don't. Smells fd leaking to me.

IIRC, run_command always closes the fds that it receives (even on error
paths). Therefore, the old code is incorrect and should not call
close(cp.in).

-- Hannes
