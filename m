Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64425C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0CE64DFF
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBOUaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 15:30:06 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47638 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229627AbhBOUaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 15:30:03 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id A4BA51B286;
        Mon, 15 Feb 2021 21:29:41 +0100 (CET)
Subject: Re: [PATCH v2 12/27] userdiff tests: rewrite hunk header test
 infrastructure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-13-avarab@gmail.com>
 <0f70d5e4-cf35-1e67-be02-2baf3036d471@kdbg.org>
 <87ft1xayee.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <68c44555-7469-2afc-a0cf-50e8368a31f9@kdbg.org>
Date:   Mon, 15 Feb 2021 21:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87ft1xayee.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 21:06 schrieb Ævar Arnfjörð Bjarmason:
> On Mon, Feb 15 2021, Johannes Sixt wrote:
>> Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
>>> +test_diff_funcname 'bash: bashism style compact' \
>>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>>> +function RIGHT {
>>> +EOF_HUNK
>>> +function RIGHT {
>>> +    function InvalidSyntax{
>>> +        :
>>> +        echo 'ChangeMe'
>>> +    }
>>> +}
>>> +EOF_TEST
>>> +
>>> +test_diff_funcname 'bash: bashism style function' \
>>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>>> +function RIGHT {
>>> +EOF_HUNK
>>> +function RIGHT {
>>> +    :
>>> +    echo 'ChangeMe'
>>> +}
>>> +EOF_TEST
>>> [...]
>>
>> That is not my dream of "simple". But I'm not a userdiff author
>> anymore, so...
>>
>> I don't know, yet, where this is heading to what the advantage is. At
>> any rate,[...]
> 
> I originally started writing this because I noticed I could break the
> userdiff.c patterns and still have all tests pass, i.e. if you screw up
> the capture grouping you can go from:
>      
>      @@ -2,3 +2,3 @@ function        RIGHT   (       )       {
>      @@ -2,3 +2,3 @@ RIGHT   (       )
> 
> to:
>      
>      @@ -2,3 +2,3 @@ function        RIGHT   (       )       {
>      @@ -2,3 +2,3 @@          RIGHT  (       )
>      
> And we wouldn't care because we just "grep 'RIGHT'". In this case we
> really care about the difference between "^[ \t]*(.*)$" and a broken
> "^([ \t]*.*)$" so not having the tests structurally hide the difference
> makes sense.

But why care? The second version is not wrong. If it's not pretty, the 
pattern author will notice soon enough. I regard avoiding the regression 
you cite less important than the simplicity of adding new test cases.

> 
>> [...] "trivial to add new tests" was also the case when each test case
>> was in its own file[...]
> 
> "trivial to add new tests by adding new optional parameters to the
> function". I.e. aside from the s/grep/test_cmp/ change in 09/27 the
> existing tests were OK if you wanted to test exactly what they expected,
> and no more.

I did not understand what you meant with "new optional parameters" and I 
still do not and why it is desirable.

> 
> I think it just makes sense to have a test helper function instead and
> little bit of boilerplate, as seen e.g. in 14/27 and later in the series
> we can add new test modes and set per-test config without needing the
> top-level dispatch loop to be aware of it.
> 
>> [...] Without the boilerplate!
> 
> I realize that's a matter of taste, i.e. when to come up with some
> custom format v.s. writng a function.
> 
> FWIW as someone who didn't author the format I've come across it N times
> over the years and each time ended up being more confused than when
> reading any custom test function we have.
> 
> For those you can usually just look at the definition/arguments, whereas
> this always required a careful read of t4018-diff-funcname.sh.
> 
> I also find it easier to have one ~160 line file in my editor than ~150
> lines spread over 15 files, as in the recent addition of bash support in
> 2ff6c34612 (userdiff: support Bash, 2020-10-22).

I wouldn't mind having all test cases in a single file. But then it 
should be one file in the language that is being tested, not shell 
script with foreign text between the lines. Adding test cases should be 
easy for authors; they should not have to be proficient in shell 
scripting (and knwo about 130 lines of CodingGuidelines).

-- Hannes
