Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C57A1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 11:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJGSnf (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 14:43:35 -0400
Received: from [195.159.176.226] ([195.159.176.226]:34320 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJGSnf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 14:43:35 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1g97KK-0000tX-BO
        for git@vger.kernel.org; Sun, 07 Oct 2018 13:34:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Date:   Sun, 7 Oct 2018 13:36:27 +0200
Message-ID: <4f705fbc-e1a3-8e27-02ed-39a5c3dcfdcc@drbeat.li>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.2.1
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
In-Reply-To: <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.10.18 22:18, Jacob Keller wrote:
> On Tue, Oct 2, 2018 at 1:07 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> make coccicheck is used in order to apply coccinelle semantic patches,
>> and see if any of the transformations found within contrib/coccinelle/
>> can be applied to the current code base.
>>
>> Pass every file to a single invocation of spatch, instead of running
>> spatch once per source file.
>>
>> This reduces the time required to run make coccicheck by a significant
>> amount of time:
>>
>> Prior timing of make coccicheck
>>   real    6m14.090s
>>   user    25m2.606s
>>   sys     1m22.919s
>>
>> New timing of make coccicheck
>>   real    1m36.580s
>>   user    7m55.933s
>>   sys     0m18.219s
>>
>> This is nearly a 4x decrease in the time required to run make
>> coccicheck. This is due to the overhead of restarting spatch for every
>> file. By processing all files at once, we can amortize this startup cost
>> across the total number of files, rather than paying it once per file.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
> 
> Forgot to add what changed. I dropped the subshell and "||" bit around
> invoking spatch.
> 
> Thanks,
> Jake
> 
> 
>>  Makefile | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index df1df9db78da..da692ece9e12 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2715,10 +2715,8 @@ endif
>>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>>         @echo '    ' SPATCH $<; \
>>         ret=0; \
>> -       for f in $(COCCI_SOURCES); do \
>> -               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
>> -                       { ret=$$?; break; }; \
>> -       done >$@+ 2>$@.log; \
>> +       $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) >$@+ 2>$@.log; \
>> +       ret=$$?; \
>>         if test $$ret != 0; \
>>         then \
>>                 cat $@.log; \
>> --
>> 2.18.0.219.gaf81d287a9da
>>

Wouldn't the following be even simpler?

diff --git a/Makefile b/Makefile
index 5c8307b7c479..a37b2724d526 100644
--- a/Makefile
+++ b/Makefile
@@ -2701,12 +2701,7 @@ endif

 %.cocci.patch: %.cocci $(COCCI_SOURCES)
        @echo '    ' SPATCH $<; \
-       ret=0; \
-       for f in $(COCCI_SOURCES); do \
-               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
-                       { ret=$$?; break; }; \
-       done >$@+ 2>$@.log; \
-       if test $$ret != 0; \
+       if ! $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS)
>$@+ 2>$@.log; \
        then \
                cat $@.log; \
                exit 1; \

Cheers,
Beat

