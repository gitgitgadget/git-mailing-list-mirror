Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740A71F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 14:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeKRBI7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 20:08:59 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:54606 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRBI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 20:08:59 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id O1x3g6HGopXFjO1x3gNzvr; Sat, 17 Nov 2018 14:52:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542466322;
        bh=jxxH8aqAtW2DSFChqMP2sv7aWtAP8m6Jldc1RYsuMwM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kQh2+BlRCoLjpoWBu57WtIkGbmTGTsXaNBaGZoYE7fhdRG6zzdTxT8ZLSRJyItHyz
         m+COftbmpZ3NfMcCD+f1x90C829ueXnlxT91LksUvyTKBQr8/KQAznLRcd+ypQ/Vmc
         EOmMzbAANzREawJQhjeopmVHXYwQYAxRVXIRRf3M=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=xD4Y-OwtGxLi57KrcwQA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 7/9] diff --color-moved-ws: optimize
 allow-indentation-change
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
 <20181116110356.12311-8-phillip.wood@talktalk.net>
 <CAGZ79ka4mHxtcwjfu3taipakUHtDXg6DjQu=nJun8Nm+snyo0g@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a7ca6eef-937c-ae97-bb79-5859a2849e64@talktalk.net>
Date:   Sat, 17 Nov 2018 14:52:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka4mHxtcwjfu3taipakUHtDXg6DjQu=nJun8Nm+snyo0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNJemRjaUBQzvPXB+gKAlTeii4shVZKzyVeafvZp9Hj+8xzicH6RgxSpWjO+KQ/4HPDpnMwCnmUQdRTfrTJrkIX6g8DHyVwz0udNMCG9OvxOJqvPpC/k
 5yL0eaqYL1f+qESvcBeH5RSrGtOaYO01T643ZD0Nh1nn8XVAP2fkicV+iniONCVf9cSyEWKPKIdA095+CDodQzNT83s4cNcvDSdxfIUqCZ20UlQTEy9PP5xu
 s43nk9YRM9gpyhkrYymlnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/11/2018 20:40, Stefan Beller wrote:
> On Fri, Nov 16, 2018 at 3:04 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When running
>>
>>    git diff --color-moved-ws=allow-indentation-change v2.18.0 v2.19.0
>>
>> cmp_in_block_with_wsd() is called 694908327 times. Of those 42.7%
>> return after comparing a and b. By comparing the lengths first we can
>> return early in all but 0.03% of those cases without dereferencing the
>> string pointers. The comparison between a and c fails in 6.8% of
>> calls, by comparing the lengths first we reject all the failing calls
>> without dereferencing the string pointers.
>>
>> This reduces the time to run the command above by by 42% from 14.6s to
>> 8.5s. This is still much slower than the normal --color-moved which
>> takes ~0.6-0.7s to run but is a significant improvement.
>>
>> The next commits will replace the current implementation with one that
>> works with mixed tabs and spaces in the indentation. I think it is
>> worth optimizing the current implementation first to enable a fair
>> comparison between the two implementations.
> 
> Up to here the series looks good and I think we could take it
> as a preparatory self-standing series.

Thanks for looking at these, I think it makes sense to split the series 
here, the commit message for this patch may want tweaking slightly if we 
do. (I did wonder about splitting it in two when I submitted it but took 
the easy way out.)

Best Wishes

Phillip
> 
> I'll read on.
> Thanks,
> Stefan
> 

