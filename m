Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D10C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 07:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D4D2371F
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 07:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgLQHgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 02:36:08 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:23147 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgLQHgG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 02:36:06 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4CxP0q06g8z5tlD;
        Thu, 17 Dec 2020 08:35:22 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CB38449B3;
        Thu, 17 Dec 2020 08:35:21 +0100 (CET)
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
Date:   Thu, 17 Dec 2020 08:35:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.20 um 06:41 schrieb Felipe Contreras:
> Seth House wrote:
>> I appreciate Felipe getting the discussion started.
>>
>> On Wed, Dec 16, 2020 at 02:24:23PM -0800, Junio C Hamano wrote:
>>> If there is none, then what is the benefit of doing the same thing
>>> without running 3 checkout-index?
>>
>> I wasn't aware of this plubming when I wrote the initial shell-script
>> version of the technique. This is a much better approach (even *if*
>> there's a negligible performance penalty). This nicely avoids
>> UNIX/Windows line-ending surprises, and instead leans on
>> already-configured Git defaults for those. Plus the non-text files
>> benefit you mentioned is also huge.
> 
> I think you misunderstood.
> 
> This command:
> 
>   git checkout-index --stage 2 --temp -- poem.txt
> 
> Will give you *exactly* the same output as LOCAL.
> 
> The context is "git mergetool", not the mergetool itself.
> 
>>> as I understand "mergetool" is handed an
>>> already conflicted state and asked to resolve it, it would not be
>>> possible without at least looking at the stage #1 to recover the
>>> base for folks who do not use diff3 style.
>>
>> I feel strongly that LOCAL, REMOTE, and BASE should be left intact for
>> this reason, Also because they aid readers in understanding the
>> pre-conflicts versions of the file.
>>
>> Rather mergetools (that support it) should be given the stage 1-3
>> versions of the file in addition to the usual, unmodified, above three.
>> Then each tool can decide whether or how to show each. Some graphical
>> tools might be able to make effective use of all five (six?).
> 
> Except as you stated in your blog post, not a *single* tool does this
> correctly using LOCAL, REMOTE, and BASE.
> 
>  * Araxis: a mess of changes
>  * Beyond Compare: a mess of changes
>  * DiffMerge: a mess of changes
>  * kdiff3: a mess of changes
>  * Meld: a mess of changes
>  * Sublime Merge: displays unnecessary changes
>  * SmartGit: ignores the other files
>  * Fork: displays unnecessary changes
>  * P4Merge: displays unnecessary changes
>  * IntelliJ: a mess of changes
>  * Tortoise Merge: uncertain
>  * tkdiff: displays unnecessary changes
>  * vimdiff: so, so wrong
>  * vimdiff2: displays unnecessary changes
>  * diffconflicts: RIGHT!
> 
> So all tools would benefit from the patch (except yours).
> 
> Which tool would be negatively affected?

Where's WinMerge in your list? I'm mostly using WinMerge these days, and
it can do what your patch does all by itself. It does not require the
proposed post-processing of stages in order to show only the real
conflicts. I would say that this is a hint that post-processing should
be moved to the tool drivers, and should not be done at the proposed level.

I don't know, though, whether your patch would have a negative effect
for WinMerge.

-- Hannes
