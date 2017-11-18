Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509E7202A0
	for <e@80x24.org>; Sat, 18 Nov 2017 11:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424186AbdKRL1h (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 06:27:37 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:54673 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424183AbdKRL1f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 06:27:35 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id G1HYeSM0Wpb8rG1HYeyXIC; Sat, 18 Nov 2017 11:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511004453;
        bh=20mckJpMqDACbHu7W/1Apl4ZvYiA4ibam4ak1st+xzk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=krglx3s5nps/jbrOOHFjzA0+9Qe/VS/IisCX2bg8+3SQYCXZzBpGB11OFAVcmJVzH
         nVhYdoJQpRDJ1uJ5+YIWAyX2rmVvryM3bfAOlNEyfNxh1ufGnohgGvp0WJ22PIwvRG
         zB8dy5iKvgdmDsbIU1czH8dDbnlxGog7NlcQLgJ4=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=2m3lvUFcvLo_0xxW1XQA:9 a=4Jm_EJeHNPkaKl0-:21 a=Fwg3fkPENNh7eGT1:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] config: avoid "write_in_full(fd, buf, len) != len"
 pattern
To:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20171115124043.17147-1-phillip.wood@talktalk.net>
 <20171117220633.6yoovfgpbr3rsykr@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6f1cf9ac-42e4-76b2-6936-4646a5cb574c@talktalk.net>
Date:   Sat, 18 Nov 2017 11:27:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171117220633.6yoovfgpbr3rsykr@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGKsUXe0umSQZmb8LVHm+Z49fsUbrqX/u6mhI9n/fe0T1amlWzYapJNX4mdcXyN6xgBxsxOzWKCgqi2YqANOWiUm5aAM4rK9HbEbGJG8dJybLcsZ9q7f
 6jTmftGTx20GENhEHT5Ys7rwJE/v0vDlt7bdkw+1ZdmDZVT0mwfJMpjUcSWBpufT50VNjStFMe8Fi/4giyzcu+pyIWd/kazmH7yLB0H5TbxRaLEUYh3Kg8m6
 SbxMNUsYVE5Z46pikDw9YA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/11/17 22:06, Jeff King wrote:
> On Wed, Nov 15, 2017 at 12:40:43PM +0000, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> As explained in commit 06f46f237 (avoid "write_in_full(fd, buf, len)
>> != len" pattern, 2017–09–13) the return value of write_in_full() is
>> either -1 or the requested number of bytes. As such comparing the
>> return value to an unsigned value such as strbuf.len will fail to
>> catch errors. Change the code to use the preferred '< 0' check.
> 
> Thanks for catching this. I wondered at first how I missed these obvious
> cases, but the answer is that they were added after my commit. :)
> 
> There's one more case in write_section() that uses "==". That's not
> actually wrong, but I wonder if we'd want to make it "< 0" for
> consistency.

Yes, I noticed that but didn't get round to looking at it properly the
other day. Rene's fix looks good to me.

Best Wishes

Phillip
