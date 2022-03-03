Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95986C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 20:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiCCUE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 15:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCCUEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 15:04:54 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750F41A614A
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 12:04:07 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4K8hl918SBz5tl9;
        Thu,  3 Mar 2022 21:04:05 +0100 (CET)
Message-ID: <c1298c9d-0f4a-40b8-b337-896f4d4777f3@kdbg.org>
Date:   Thu, 3 Mar 2022 21:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
Content-Language: en-US
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
 <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
 <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.03.22 um 12:41 schrieb Jaydeep Das:
> How about modifying the number match regex to:
> 
> `[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]` ?
> 
> The `[^a-zA-Z]` in the end would make sure to not match
> the `.F` in `X.Find`.

No, you cannot do that, because then in X.u+1 you have three tokens X
.u+ 1, which you do not want, either.

> Additionally, we can add another regex for matching just
> the method calls:
> 
> `[.][a-zA-Z()0-9]+`
> 
> Both of these changes would make word_regex match 2 tokens in
> X.Find() : X and .Find() (Here X can be any valid identifier name)

Well, you can do that. But I would not do that if it is allowed to have
a blank between the fullstop and a method name.

>> How many tokens will the word-regex find in the expression X.e+200UL?
>> .e+200UL is a single token. > It's most easily fixed by requiring a
>> digit before the fullstop. But if
>> floatingpoint numbers can begin with a fullstop, then we need a second
>> expression that requires a digit after a leading fullstop.
> 
> But that syntax would be wrong. I tried making a condition like you said,
> but it always ended up breaking something else(like breaking 2.e+200UL
> into 2, .e, + and 200UL)
> 
> Also, I realized I did a bit of mistake in the identifier regex.
> Both _abc and __abc are valid identifiers. _3432, __3232 are valid
> identifiers too.(not numbers)
> 
> The previous regex matched only one `_`, so in the next patch,
> I plan to implement the following regex:
> 
> Identifier: `([_]*[a-zA-Z]|[_]+[0-9]+)[a-zA-Z0-9_]*`

But then you can use the regex you had in the first round:

   [a-zA-Z_][a-zA-Z0-9_]*

> 
> Numbers: `[0-9_.]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]`
> (It makes sure that in X.Find, .F is not matched )
> 
> Additionally, An extra regex for method calls:
> 
> `[.][a-zA-Z()0-9]+`
> 
> What do you think?

Have a look at the regex in the cpp driver. I think we need something
like this:

  /* integers floatingpoint numbers */
  "|[0-9][0-9_.]*([Ee][*-]?[0-9]+)?[FfLl]*"
  /* floatingpoint numbers that begin with a decimal point */
  "|[.][0-9][0-9_]*([Ee][*-]?[0-9]+)?[FfLl]*"

Drop the second option if numbers such as .5 are invalid syntax in Kotlin.

-- Hannes
