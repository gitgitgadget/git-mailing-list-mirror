Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B185F1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeHHWJU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:09:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:46456 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbeHHWJT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:09:19 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 03D553F4865;
        Wed,  8 Aug 2018 15:48:08 -0400 (EDT)
Received: from [192.168.1.6] (30.sub-174-229-135.myvzw.com [174.229.135.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 741993F481D;
        Wed,  8 Aug 2018 15:48:06 -0400 (EDT)
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive
 filesystems
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de
References: <20180730152756.15012-1-pclouds@gmail.com>
 <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
Date:   Wed, 8 Aug 2018 15:48:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/7/2018 3:31 PM, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
>>   One nice thing about this is we don't need platform specific code for
>>   detecting the duplicate entries. I think ce_match_stat() works even
>>   on Windows. And it's now equally expensive on all platforms :D
> 
> ce_match_stat() may not be a very good measure to see if two paths
> refer to the same file, though.  After a fresh checkout, I would not
> be surprised if two completely unrelated paths have the same size
> and have same mtime/ctime.  In its original use case, i.e. "I have
> one specific path in mind and took a snapshot of its metadata
> earlier.  Is it still the same, or has it been touched?", that may
> be sufficient to detect that the path has been _modified_, but
> without reliable inum, it may be a poor measure to say two paths
> refer to the same.

I agree with Junio on this one.  The mtime values are sloppy at best.
On FAT file systems, they have 2 second resolution.  Even NTFS IIRC
has only 100ns resolution, so we might get a lot of false matches
using this technique, right?

It might be better to build an equivalence-class hash-map for the
colliding entries.  Compute a "normalized" version of the pathname
(such as convert to lowercase, strip final-dots/spaces, strip the
digits following tilda of a shortname, and etc for the MAC's UTF-isms).
Then when you rescan the index entries to find the matches, apply the
equivalence operator on the pathname and do the hashmap lookup.
When you find a match, you have a "potential" collider pair (I say
potential only because of the ambiguity of shortnames).  Then we
can use inum/file-index/whatever to see if they actually collide.


Jeff
