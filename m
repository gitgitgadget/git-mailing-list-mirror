Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C6C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 11:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhLVLm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 06:42:57 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:29108 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhLVLm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 06:42:56 -0500
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1n001K-0007sk-W5; Wed, 22 Dec 2021 12:42:59 +0100
Message-ID: <5a74b0bc-d713-e8bf-5952-dbaaf5d886e7@syntevo.com>
Date:   Wed, 22 Dec 2021 12:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Should update-index --refresh force writing the index in case of
 racy timestamps?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
References: <d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com>
 <Ybz9ruQ/uOfFbn3W@camp.crustytoothpaste.net> <xmqqee6a22rj.fsf@gitster.g>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
In-Reply-To: <xmqqee6a22rj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/12/2021 01:08, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> On 2021-12-17 at 10:44:32, Marc Strapetz wrote:
>>> For one of my Git-LFS test repositories, switching between branches quite
>>> often results in lots of racy index timestamps. Subsequent calls to "git
>>> update-index --refresh" or "git status" will invoke the "lfs" filter over
>>> and over again, just to figure out that all entries are still up-to-date.
>>> Hence, the index will never be rewritten and racy timestamps will remain.
>>>
>>> To break out of this state, it seems favorable to write the index if any
>>> racy timestamp is detected. We will be able to provide a patch if this
>>> change sounds reasonable.
>>
>> Sure, this sounds reasonable, especially if, as you mentioned, git
>> status already does this.  We might as well make the plumbing commands
>> as functional as the porcelain commands.
> 
> Given that "update-index --refresh" is a way to say "we know
> something changed to make cached stat information dirty even for
> otherwise clean paths and we want our 'diff-files' and other
> plumbing command to start relying on the cached stat information
> again, so please do as much I/O as you need", I agree that it should
> do as thourough job as necessary.

Thanks! I have now submitted a pull request via gitgitgadget.

I had some problems to understand what the correct place to set 
active_cache_changed is and have decided to keep it as close as possible 
to refresh_cache(): unresolve_callback() and reupdate_callback() may 
reset active_cache_changed in case of errors. On the other hand, 
active_cache_changed may be set again later for a preferred_index_format 
change and for read_from_stdin (as part of update_one()), so in the end 
the callbacks may be overruled and the index may finally be written. I'm 
not sure whether these combinations can actually occur and whether this 
might cause any troubles. I just wanted to point out.

-Marc
