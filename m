Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BCE01F731
	for <e@80x24.org>; Thu,  1 Aug 2019 17:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfHARYU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 13:24:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:64810 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfHARYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 13:24:20 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 467893F40DA;
        Thu,  1 Aug 2019 13:24:19 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:9bc:1dec:170a:44ce] (unknown [IPv6:2001:4898:a800:1010:baf1:1dec:170a:44ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E598B3F40D9;
        Thu,  1 Aug 2019 13:24:18 -0400 (EDT)
Subject: Re: [PATCH v2 1/1] config: work around bug with includeif:onbranch
 and early config
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.300.git.gitgitgadget@gmail.com>
 <pull.300.v2.git.gitgitgadget@gmail.com>
 <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
 <20190731220204.GA1933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1908010004130.21907@tvgsbejvaqbjf.bet>
 <20190731231257.GB1933@sigill.intra.peff.net>
 <20190801004928.GA6351@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7f4257d3-5ae0-3a83-84f1-bee83682fa36@jeffhostetler.com>
Date:   Thu, 1 Aug 2019 13:24:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801004928.GA6351@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/31/2019 8:49 PM, Jeff King wrote:
> On Wed, Jul 31, 2019 at 07:12:57PM -0400, Jeff King wrote:
> 
>> Hrm. But common-main calls initialize_the_repository(), which points it
>> at &the_repo. And I can't find any other assignments. So how does it
>> become NULL? And is every caller of have_git_dir() at risk of
>> segfaulting?
>>
>> Ah, I see. I think it is that trace2 reads the configuration very early.
>> I think we ought to do this:
>>
>> diff --git a/common-main.c b/common-main.c
>> index 582a7b1886..89fd415e55 100644
>> --- a/common-main.c
>> +++ b/common-main.c
>> @@ -39,14 +39,14 @@ int main(int argc, const char **argv)
>>   
>>   	git_resolve_executable_dir(argv[0]);
>>   
>> +	initialize_the_repository();
>> +
>>   	trace2_initialize();
>>   	trace2_cmd_start(argv);
>>   	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
>>   
>>   	git_setup_gettext();
>>   
>> -	initialize_the_repository();
>> -
>>   	attr_start();
>>   
>>   	result = cmd_main(argc, argv);
> 
> By the way, I wondered why trace2's existing config reading did not
> cause us to segfault because of this. It is because it invented the
> "very early config" function which always ignores some config sources
> (working around this problem, but also making it weirdly unlike most
> other config).

Yes, I added the "very early config" to try to work around some of
the chicken-n-egg problems.  I can't say that I was completely happy
with having to do that.  I haven't had time to play with your patch
suggestion here, but I think it would be fine to do if it will help
with the original problem.

In [1] I added code to just start the clock in isolation (rather than
being part of the trace2_initialize() -- which does all the config
loading and subsystem initialization).  So it is OK to let the
trace2_initialize() run a little later.  (Part of the reason for that
split was to allow git_resolve_executable_dir() to run first, since
that data was needed to find the location of the system config relative
to the exe path (sigh).)

[1] a089724958a trace2: refactor setting process starting time


So, as you suggested in your previous response, something like
this would/should be fine.

$ git diff
diff --git a/common-main.c b/common-main.c
index 582a7b1886..71e21dd20a 100644
--- a/common-main.c
+++ b/common-main.c
@@ -39,16 +39,16 @@ int main(int argc, const char **argv)

         git_resolve_executable_dir(argv[0]);

-       trace2_initialize();
-       trace2_cmd_start(argv);
-       trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
-
         git_setup_gettext();

         initialize_the_repository();

         attr_start();

+       trace2_initialize();
+       trace2_cmd_start(argv);
+       trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
+
         result = cmd_main(argc, argv);

         trace2_cmd_exit(result);

