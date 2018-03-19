Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC88E1F42D
	for <e@80x24.org>; Mon, 19 Mar 2018 09:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeCSJkg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 05:40:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:54325 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932316AbeCSJke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 05:40:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E7DF43F4003;
        Mon, 19 Mar 2018 05:40:33 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B35723F4002;
        Mon, 19 Mar 2018 05:40:33 -0400 (EDT)
Subject: Re: [PATCH 04/36] t/helper: merge test-lazy-init-name-hash into
 test-tool
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180317075421.22032-5-pclouds@gmail.com>
 <CAPig+cTSqxLTDoq3xGAmf1xCyCX0jvwyoSL5GApgaNg5PVPGGg@mail.gmail.com>
 <CACsJy8CeXZJashmh+sLykRR4Mm_EwnASMVyB-4ztEcfQXU7MXw@mail.gmail.com>
 <CAPig+cRGpD1_U5PgO=-1wrsiyWqY4GmE3tWNdgCnuAh7PUjvHg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <edbc7234-ee60-6f3e-ae09-94721e4b5faa@jeffhostetler.com>
Date:   Mon, 19 Mar 2018 05:40:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRGpD1_U5PgO=-1wrsiyWqY4GmE3tWNdgCnuAh7PUjvHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/18/2018 4:47 AM, Eric Sunshine wrote:
> On Sun, Mar 18, 2018 at 4:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Mar 18, 2018 at 3:11 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sat, Mar 17, 2018 at 3:53 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>>> -extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
>>>> +extern int lazy_init_name_hash_for_testing(struct index_state *istate, int try_threaded);
>>>
>>> I get why you renamed this since the "main" function in the test
>>> program wants to be called 'test_lazy_init_name_hash'...
>>>
>>>> diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
>>>> @@ -9,6 +10,9 @@ static int perf;
>>>> +static int (*init_name_hash)(struct index_state *istate, int try_threaded) =
>>>> +       lazy_init_name_hash_for_testing;
>>>> +
>>>> @@ -33,9 +37,9 @@ static void dump_run(void)
>>>>          if (single) {
>>>> -               test_lazy_init_name_hash(&the_index, 0);
>>>> +               init_name_hash(&the_index, 0);
>>>
>>> ... but I'm having trouble understanding why this indirection through
>>> 'init_name_hash' is used rather than just calling
>>> lazy_init_name_hash_for_testing() directly. Am I missing something
>>> obvious or is 'init_name_hash' just an unneeded artifact of an earlier
>>> iteration before the rename in cache.{c,h}?
>>
>> Nope. It just feels too long to me and because we're already in the
>> test I don't feel the need to repeat _for_testing everywhere. If it's
>> confusing, I'll remove init_name_hash.
> 
> Without an explanatory in-code comment, I'd guess that someone coming
> across this in the future will also stumble over it just like I did in
> the review.

I agree with Eric, this indirection seems unnecessary and confusing.
Generally, when I see function pointers initialized like that, I
think that there are plans for additional providers/drivers for that
functionality, but I don't see that here.  And it seems odd.

> 
> What if, instead, you rename test_lazy_init_name_hash() to
> lazy_init_name_hash_test(), shifting 'test' from the front to the back
> of the name? That way, the name remains the same length at the call
> sites in the test helper, and you don't have to introduce the
> confusing, otherwise unneeded 'init_name_hash'.
> 

I see 2 problems.
1. The test function in name-hash.c that needs access to private data.
     I'm not a fan of the "_for_testing" suffix, but I'm open.  I might
     either leave it as is, or make it a "TEST_" or "test__" prefix (as
     a guide for people used to languages with namespaces.

2. The new name for cmd_main().  There's no real need why it needs to
    be "test_*", right?   Your cmds[] maps the command line string to a
    function, but it could be anything.  That is, "cmd_main()" could be
    renamed "cmd__lazy_init_name_hash()".  Then you can conceptually
    reserve the "cmd__" prefix throughout t/helper for each test handler.

Just a thought,
Thanks,
Jeff

