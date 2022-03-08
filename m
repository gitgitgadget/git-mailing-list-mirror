Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E64C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 06:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiCHGr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 01:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCHGr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 01:47:58 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5A1DA7D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 22:47:02 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4KCQq768mGz5tlG;
        Tue,  8 Mar 2022 07:46:59 +0100 (CET)
Message-ID: <504f9f0d-a1ab-5ce7-d744-9398b0e7e68a@kdbg.org>
Date:   Tue, 8 Mar 2022 07:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [GSoC][PATCH 1/1] Add a diff driver for JavaScript languages.
Content-Language: en-US
To:     xing-zhi jiang <a97410985new@gmail.com>
Cc:     git@vger.kernel.org
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220304130854.857746-2-a97410985new@gmail.com>
 <79bd770e-74f1-edf8-884b-c0f916732ce0@kdbg.org>
 <CAN_FRNK-FD+4_Nf_VdmU1N+TBapQ7ZnWo5Bn8M9YDWWhMfBypg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAN_FRNK-FD+4_Nf_VdmU1N+TBapQ7ZnWo5Bn8M9YDWWhMfBypg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.03.22 um 16:10 schrieb xing-zhi jiang:
> On Sat, 5 Mar 2022 at 18:16, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 04.03.22 um 14:08 schrieb xing zhi jiang:
>>> diff --git a/t/t4018/javascript-function-in-class-2 b/t/t4018/javascript-function-in-class-2
>>> new file mode 100644
>>> index 0000000000..402c4aecc3
>>> --- /dev/null
>>> +++ b/t/t4018/javascript-function-in-class-2
>>> @@ -0,0 +1,11 @@
>>> +class Test {
>>> +  RIGHT(
>>> +      aaaaaaaaaa,
>>> +      bbbbbbbbbb,
>>> +      cccccccccc,
>>> +      dddddddddd
>>> +  ) {
>>> +    let a = 4;
>>> +    let b = ChangeMe;
>>> +  }
>>> +}
>>> \ No newline at end of file
>>
>> In the above two, we see class member functions. Is there a test case
>> where the function parameter is on the same line as the function name or
>> is that one of the difficult cases?
> I can't get what you mean, but the second Test case wants to make sure we
> can match the function with a long parameter list, and its parameters are
> formatted to multiline.

I meant a multi-line function call like so, where the first argument is
on the same line with the function name:

  RIGHT(aaaaaaaaaa,
      bbbbbbbbbb,
      cccccccccc,
      dddddddddd
  ) {
  ...

>>> diff --git a/userdiff.c b/userdiff.c
>>> index 8578cb0d12..a6a341e3c1 100644
>>> --- a/userdiff.c
>>> +++ b/userdiff.c
>>> @@ -168,6 +168,44 @@ PATTERNS("java",
>>>        "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>>>        "|[-+*/<>%&^|=!]="
>>>        "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>>> +
>>> +PATTERNS("javascript",
>>> +      /* don't match the expression may contain parenthesis, because it is not a function declaration */
>>> +      "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
>>
>> These will not match
>>
>>         }while (expr)
>>
>> note the absent blank before the keyword, but that is an acceptable
>> trade-off to keep things simple. Good.
>>
> I thought not to match with `}while (expr)` is OK because this rule is
> mainly to prevent matching too many
>  wrong things about the regex for 「the function in the class」.
> And before keywords maybe need blanks, because some javascript
> formatting style is using space
> instead of tab.

I don't recall why I emphasize the absent blank between '}' and "while".
I must have misread something. At any rate, the regex would not match,
either, if there is whitespace between the two, so, it is totally OK.

>> Can you not have
>>
>>         var f = foo=>{
>>
>> because I see that whitespace is required between the identifier and "=>"?
> It is my mistake. I should not match tab or space between identifier and =>.
> Thanks for pointing it out. I will fix it.
> 
>>> +      /* match exports for anonymous fucntion */
>>> +      "^[\t ]*(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
>>
>> Here, whitespace is not required. Is the above an oversight?
>>
>> BTW, can keyword "exports" be used for something other than functions?
>>
> 「Whitespace is not required」 is only referred to 「^[\t ]*(exports」?

No, I refer to the whitespace around "=>" that is not required here, but
was required in the previous expression.

> I
> would remove the [\t ]* before exports
> keyword because exports must be top-level.
> The exports keyword can be used for exporting many things, such as
> string. ex: exports.SimpleMessage = 'Hello world';
> , So I define a more precise regex for only matching anonymous functions.

Understood. "exports" is a keyword only in certain contexts. Since it
can be used as (or like?) a variable name, it cannot be used as match
that always identifies a function header.

-- Hannes
