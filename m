Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43FE1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 11:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeJGS4H (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 14:56:07 -0400
Received: from s019.cyon.net ([149.126.4.28]:44288 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbeJGS4G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 14:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=r74mlhi4ZZs+Kzf25oPBzmzam1WiLgHZ/1pRBfu20M8=; b=uIr+dX2UpJHfeCrwR7UwRyTmx8
        b1IjKSUT0TaGej4VsoT6DSP0GvL8eQjse8Kfju7D9F8YoCVNrRYGpOHITq+E4pXhU0ubp2KG9P8ll
        6OgUZqt9PjJQ/5NG3hJYoHYRZ+1koO2iKmwtFeg0so7UYKF/ErWj/YzuPJn/nCZ3OhN4HT6REtNFg
        iYGqSHm1mDknEZEzsulpYPWsikHEQu8/oNDkZvPzmuXzyciO5Bd7TXhnUtyGe6odf9aUSTOqzZ8zR
        TNKDyczOya4UkCCLJho7TryIUf62rCR3JzXs8I23+v0LcPptDTQNy0twbMiA1/xz9NyH2APgDUhLA
        iNfCsMjg==;
Received: from [10.20.10.230] (port=41370 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1g97YV-00BxEV-Fz; Sun, 07 Oct 2018 13:49:05 +0200
Subject: Re: [PATCH v3] coccicheck: process every source file at once
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <4f705fbc-e1a3-8e27-02ed-39a5c3dcfdcc@drbeat.li>
Message-ID: <7aa8efab-66f6-e2a5-9196-6d68872e5e34@drbeat.li>
Date:   Sun, 7 Oct 2018 13:49:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4f705fbc-e1a3-8e27-02ed-39a5c3dcfdcc@drbeat.li>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.10.18 13:36, Beat Bolli wrote:
> On 02.10.18 22:18, Jacob Keller wrote:
>> On Tue, Oct 2, 2018 at 1:07 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>>
>>> From: Jacob Keller <jacob.keller@gmail.com>
>>>
>>> make coccicheck is used in order to apply coccinelle semantic patches,
>>> and see if any of the transformations found within contrib/coccinelle/
>>> can be applied to the current code base.
>>>
>>> Pass every file to a single invocation of spatch, instead of running
>>> spatch once per source file.
>>>
>>> This reduces the time required to run make coccicheck by a significant
>>> amount of time:
>>>
>>> Prior timing of make coccicheck
>>>   real    6m14.090s
>>>   user    25m2.606s
>>>   sys     1m22.919s
>>>
>>> New timing of make coccicheck
>>>   real    1m36.580s
>>>   user    7m55.933s
>>>   sys     0m18.219s
>>>
>>> This is nearly a 4x decrease in the time required to run make
>>> coccicheck. This is due to the overhead of restarting spatch for every
>>> file. By processing all files at once, we can amortize this startup cost
>>> across the total number of files, rather than paying it once per file.
>>>
>>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>>> ---
>>
>> Forgot to add what changed. I dropped the subshell and "||" bit around
>> invoking spatch.
>>
>> Thanks,
>> Jake
>>
>>
>>>  Makefile | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index df1df9db78da..da692ece9e12 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -2715,10 +2715,8 @@ endif
>>>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>>>         @echo '    ' SPATCH $<; \
>>>         ret=0; \
>>> -       for f in $(COCCI_SOURCES); do \
>>> -               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
>>> -                       { ret=$$?; break; }; \
>>> -       done >$@+ 2>$@.log; \
>>> +       $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) >$@+ 2>$@.log; \
>>> +       ret=$$?; \
>>>         if test $$ret != 0; \
>>>         then \
>>>                 cat $@.log; \
>>> --
>>> 2.18.0.219.gaf81d287a9da
>>>
> 
> Wouldn't the following be even simpler?
> 
> diff --git a/Makefile b/Makefile
> index 5c8307b7c479..a37b2724d526 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2701,12 +2701,7 @@ endif
> 
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>         @echo '    ' SPATCH $<; \
> -       ret=0; \
> -       for f in $(COCCI_SOURCES); do \
> -               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> -                       { ret=$$?; break; }; \
> -       done >$@+ 2>$@.log; \
> -       if test $$ret != 0; \
> +       if ! $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) 
>> $@+ 2>$@.log; \

The "If !" and the output redirection should be on one line,
obviously... Sorry about this.

Beat
