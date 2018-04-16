Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E120A1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeDPUfg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 16 Apr 2018 16:35:36 -0400
Received: from mail.1eanda.com ([50.241.99.154]:50001 "EHLO mail.1eanda.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbeDPUff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 16:35:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.1eanda.com (Postfix) with ESMTP id 8BECA40242;
        Mon, 16 Apr 2018 16:35:34 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at mail.1eanda.com
Received: from mail.1eanda.com ([127.0.0.1])
        by localhost (mail.1eanda.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mk56H7Ht5tnn; Mon, 16 Apr 2018 16:35:33 -0400 (EDT)
Received: from [10.134.3.27] (50-241-99-157-static.hfc.comcastbusiness.net [50.241.99.157])
        (Authenticated sender: matt@1eanda.com)
        by mail.1eanda.com (Postfix) with ESMTPSA id CAA0D40213;
        Mon, 16 Apr 2018 16:35:32 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
From:   Matthew Coleman <matt@1eanda.com>
In-Reply-To: <CA+P7+xqVdhJ3PrGjQWcofHJV3E1UYWVHEXVt5yaV3Ycv1YvkTg@mail.gmail.com>
Date:   Mon, 16 Apr 2018 16:35:31 -0400
Cc:     Jakub Narebski <jnareb@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 545603731.093854-abaac147a2f82fcfaa47e45af3c46863
Content-Transfer-Encoding: 8BIT
Message-Id: <6A862FDA-1EBA-47BB-8C99-AB09DA91955D@1eanda.com>
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
 <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
 <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
 <86sh7xlxyp.fsf@gmail.com>
 <CA+P7+xqVdhJ3PrGjQWcofHJV3E1UYWVHEXVt5yaV3Ycv1YvkTg@mail.gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Disclaimer: I'm not a zsh user, so please correct anything I might have gotten wrong.

I created a .zshrc with the following contents:
autoload -Uz compinit
compinit
source /usr/local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

zsh doesn't have broken Unicode output in its `set` builtin, so it was not affected by the original issue. Applying the patch does not cause any change in behavior.

Since the commit only changes a file with "bash" in its name, but the conditional references zsh variables, I think it's worth mentioning something about it in the commit message.

I think the bash side of things is all set for this commit, but can a similar improvement be made (using a builtin instead of parsing set|sed) for zsh? Again, I'm not a zsh user, so some input from someone who's written zsh completion rules would be very helpful. Can any of the builtins mentioned in this zsh documentation be used instead of set|sed?
http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomputil-Module

> On Apr 16, 2018, at 2:23 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> 
> On Sat, Apr 14, 2018 at 6:27 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>> On Fri, Apr 13, 2018 at 11:44 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>>>> 
>>>>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
>>>>> builtin command, which lists the same variables, but without a
>>>>> pipeline and 'sed' it can do so with lower overhead.
>>>> 
>>>> What about ZSH?
>>> 
>>> Nothing, ZSH is unaffected by this patch.
>> 
>> All right, so for ZSH we would need LC_ALL=C trick, or come with some
>> equivalent of 'compgen -v __gitcomp_builtin_' for this shell.
>> 
>> Good patch, though it does not solve whole of the problem.
>> 
>> Best,
>> --
>> Jakub Narębski
> 
> Is ZSH actually affected by the broken set behavior, though?
> 
> Thanks,
> Jake

