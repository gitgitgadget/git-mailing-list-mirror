Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E011F461
	for <e@80x24.org>; Sun, 19 May 2019 00:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfESAQb (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 20:16:31 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:27964 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfESAQb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 20:16:31 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id S9V4hKZNFgI7iS9V4h7gWa; Sun, 19 May 2019 01:16:28 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=lGCZnOgpvP3S5SwHdzkA:9 a=_jtj6KiAp7Vol7I_:21
 a=zDwSShyCcyjOfNMN:21 a=QEXdDO2ut3YA:10
Subject: Re: Finer timestamps and serialization in git
To:     esr@thyrsus.com, Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org, 'Derrick Stolee' <stolee@gmail.com>
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <20190515234034.GB124956@thyrsus.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <b4b151ba-ab43-445f-6e49-ee8e28b30859@iee.org>
Date:   Sun, 19 May 2019 01:16:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515234034.GB124956@thyrsus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfAMw6xRaBvssVsVkIB9A1tYNuWUPFhlnMLG75ckeT1rIqbD8W5Zsmdpb7sQQ3pnAbYV3MbDMD2YtdbBfPKKw3g2l34Twd3JhzAx8b8rbXLOq5uQ4s20a
 5jRivDCSoB6ysSYy2aRNGcR/OE8JBZpP0PTVOvgj7lFs9ggH+JglfoYCw2aUPO6EH1ndQ6G6XMFhnls56dJOJSgPnMDSkJMXpBTkL/8g5AV/olPqngKpJ44H
 Bshgba6gx3jfKSshq7TXAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/05/2019 00:40, Eric S. Raymond wrote:
> Jason Pyeron <jpyeron@pdinc.us>:
>> If we take the below example:
>>
>> committer Name <user@domain> 1557948240 -0400
>>
>> and we follow the rule that:
>>
>> 1. any trailing zero after the decimal point MUST be omitted
>> 2. if there are no digits after the decimal point, it MUST be omitted
>>
>> This would allow:
>>
>> committer Name <user@domain> 1557948240 -0400
>> committer Name <user@domain> 1557948240.12 -0400
>>
>> but the following are never allowed:
>>
>> committer Name <user@domain> 1557948240. -0400
>> committer Name <user@domain> 1557948240.000000 -0400
>>
>> By following these rules, all previous commits' hash are unchanged. Future commits made on the top of the second will look like old commit formats. Commits coming from "older" tools will produce valid and mergeable objects. The loss precision has frustrated us several times as well.
> Yes, that's almost exactly what I came up with.  I was concerned with upward
> compatibility in fast-export streams, which reposurgeon ingests and emits.
>
> But I don't quite understand your claim that there's no format
> breakage here, unless you're implying to me that timestamps are already
> stored in the git file system as variable-length strings.  Do they
> really never get translated into time_t?  Good news if so.
Maybe just take some of the object ID bits as being the fractional time 
timestamp. They are effectively random, so should do a reasonable job of 
distinguishing commits in a repeatable manner, even with full round 
tripping via older git versions (as long as the sha1 replicates...)

As I understand it the commit timestamp is actually free text within the 
commit object (try `git cat-file -p <commit_object>), so the issue is 
whether the particular git version is ready to accept the additional 
'dot' factional time notation (future versions could be extended, but I 
think old ones would reject them if I understand the test up thread - 
which would compromise backward compatibility and round tripping).
--
Philip
