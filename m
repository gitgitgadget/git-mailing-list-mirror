Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F129C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216706190A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEKSqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:46:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:13938 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKSqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:46:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4F9FD3F40D9;
        Tue, 11 May 2021 14:44:53 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2D6B83F40B7;
        Tue, 11 May 2021 14:44:53 -0400 (EDT)
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
Date:   Tue, 11 May 2021 14:44:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/7/21 8:56 AM, Bagas Sanjaya wrote:
> Hi,
> 
> I have a copy of Gitea application repository [1] on my local Git
> server on my computer. I was playing with partial clones using that
> repository as remote.
> 
> I began with blobless clone the repo by:
> 
> $ git clone https://<myhost>/bagas/gitea.git gitea --filter=blob:none
> 
> Then I tried to fetch missing objects. First, I gathered list of them:
> 
> $ git rev-list --objects --all --missing=print | grep -o -P '^\?\K\w+' > 
> .git/missing.list
> 
> I had asked how to properly fetch objects from the list above before on
> this list, and brian m. carlson (CC'ed) suggested [2] that I should
> use xargs:
> 
> $ xargs git fetch origin < .git/missing.list
> 
> I expected that I received all missing objects. However, the error message
> I got was something like below, repeated:
> 
>> remote: ...<skipped>
>> Receiving objects: 100% (64/64), 154.49 KiB | 2.97 MiB/s, done.
>> remote: ...<skipped>
>> Receiving objects: 100% (37/37), 168.35 KiB | 4.95 MiB/s, done.
>> Resolving deltas: 100% (5/5), done.
>> Resolving deltas: 100% (49/49), completed with 47 local objects.
>> fatal: bad revision 'd5e9cd36ab21839af3d116eff3221c53f6ca7fd6'
>> error: https://<myhost>/bagas/gitea.git did not send all necessary 
>> objects
> 
> Then I repeated the object list gathering and fetching above, and the error
> still occured. Even I tried fetching only one of problematic object above
> and still errored.
> 
> When I inspected that object with `git cat-file -p` from my other, full
> clone version (which I used for submitting changes upstream), the object
> is properly displayed (in this case as source code in Go).
> 
> Note that I have uploadpack.allowfilter=true config on the server.
> 
> Am I missing something?
> 
> [1]: https://github.com/go-gitea/gitea
> [2]: 
> https://lore.kernel.org/git/YD7bczBsIR5rkqfc@camp.crustytoothpaste.net/
> 

I'm not sure why you're getting that error, but you might
also try enabling `uploadpack.allowAnySHA1InWant`
(or one of the other "allow*SHS1InWant" values) and see if
that helps.

https://git-scm.com/docs/git-config#Documentation/git-config.txt-uploadpackallowAnySHA1InWant

Jeff
