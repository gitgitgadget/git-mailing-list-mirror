Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2947C1F424
	for <e@80x24.org>; Wed, 18 Apr 2018 10:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeDRKTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 06:19:34 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:63127 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRKTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 06:19:33 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 8kBWfgzWyLjjA8kBWfWLfw; Wed, 18 Apr 2018 11:19:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524046771;
        bh=/zUyAupkEbFw+vkgz74rKa40Wb1KNYQbdBjLC/Qtu+Y=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gythmMb9zQ+kikbu3TGBfSr95Zcsqusco1byUbg0Cj/ZL9MMTbT6kbwlDGzvpN24Q
         vffdqDYAu3VPs6lw6YqGSfG2vpRj3EftA6zDRhunEs2hACc5dD7qUK1A+7WwENn41m
         mjTXnvgUBFAtg1G1LRueEbPzB3xV0ty9uId3RM5A=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=tpnkV0ELXTw4iS4BGD4A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
 <xmqq7ep817bq.fsf@gitster-ct.c.googlers.com>
 <06c5bd54-f1b0-7fe5-6aa8-870e0ae4487d@kdbg.org>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <808c222a-c566-3654-4082-cc0e04a4ad20@talktalk.net>
Date:   Wed, 18 Apr 2018 11:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <06c5bd54-f1b0-7fe5-6aa8-870e0ae4487d@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIlwPKIMl5/28GW8XQ/J48QKoj+UILA6L8ByiKLPuyIDrapJXmaGLtzOgmLsR+ZNv66/K+Sij5xSi/ktBrXmeiWwiHd0qBiNKJqWu23uIPDKkl/duzLX
 knQRReheplsSzdBypkfPwDSVXa7QzZjRhtZI/Ybcz+xr/5UkhVfGLK/xlBKkzmcKk9sOabzfOfCBcTQDnLV4n6/xtpaFcjJTQhXuB6ix8lXfFq5EdX/Flzjg
 XHbswq+2J8g/vfFJ3xFtGAqLVFthvX9QDR5dkrdHzTc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/04/18 06:56, Johannes Sixt wrote:
> 
> Am 15.04.2018 um 23:35 schrieb Junio C Hamano:
>> Ah, do you mean we have an internal sequence like this, when "rebase
>> --continue" wants to conclude an edit/reword?
> 
> Yes, it's only 'reword' that is affected, because then subsequent picks
> are processed by the original process.
> 
>>   - we figure out the committer ident, which grabs a timestamp and
>>     cache it;
>>
>>   - we spawn "commit" to conclude the stopped step, letting it record
>>     its beginning time (which is a bit older than the above) or its
>>     ending time (which is much older due to human typing speed);
> 
> Younger in both cases, of course. According to my tests, we seem to pick
> the beginning time, because the first 'reword'ed commit typically has
> the same timestamp as the preceding picks. Later 'reword'ed commits have
> noticably younger timestamps.
> 
>>   - subsequent "picks" are made in the same process, and share the
>>     timestamp we grabbed in the first step, which is older than the
>>     second one.
>>
>> I guess we'd want a mechanism to tell ident.c layer "discard the
>> cached one, as we are no longer in the same automated sequence", and
>> use that whenever we spawn an editor (or otherwise go interactive).
> 
> Frankly, I think that this caching is overengineered (or prematurly
> optimized). If the design requires that different callers of datestamp()
> must see the same time, then the design is broken. In a fixed design,
> there would be a single call of datestamp() in advance, and then the
> timestamp, which then obviously is a very important piece of data, would
> be passed along as required.

I'm inclined to agree, though it creates complications if we're going to
keep giving commits the same author and committer dates when neither is
explicitly specified.

Best Wishes

Phillip

> 
> -- Hannes

