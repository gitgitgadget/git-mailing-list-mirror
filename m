Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC1C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC561166
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhJFOVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhJFOVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 10:21:36 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77FC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 07:19:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j10so1946154qvl.13
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9j7pZ1engRYL/eImd9FbHgIbSNgjXaWwSadaPEM4W88=;
        b=ptStLEvImo+GPgAhO8ef5Tspmdpyqly3Ad8MBK7m2D/2ijpfDVAn/rywUlKPHRSn2j
         hn1/e/fm8qNrdxOD7Qk4XxfKRGMF+PuT7WWOZBL0Q7VYkipQsDNpmVPBDPmBJO03BAyc
         5+13LK1h3rZllaI90HYH6mxz/A8+q4Zm9cv3sStu9kSh+E/JDXV6EzeJdipciiaNDQFZ
         KMH2HXklqFIULkQcN/pMu9qOKdkPc4Hccff3E0QqA+N5rg1UCiQaMtlEDBp6Xoppczt+
         uGLOLg4x1QEOAZDu35gKw8aUWy/sOdfgEAzIdUGGsr9DB0TGeTDOp5G+Jd4bmsT2KYVI
         0lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9j7pZ1engRYL/eImd9FbHgIbSNgjXaWwSadaPEM4W88=;
        b=ucOb56BpEaX5u7fumWMb1O56d6DYg7tTswR44o9VClFV3LBa8PPYyo96Gm28aivfyM
         2aHyx11y2NbCodynsjdcsNzX1kVYspKMB047554iwQP6U+mo4Y1AD51cpJQ+7YvsTVe4
         1e4gIfuBWDUdnILBVDgoINkEpMfD/tHfJ1DxLhQW4IffxqpFdwnukLlpG7TkwzoFzn/f
         HxKFvHomJwhrM+c9RzBn2UuUIejgzzjGf32DIjbCIhraLzCkEAm56ZO0zxZaZoXjB1tw
         M+POgOa3C8Vuu3zRwePO40IPl6YyoSTqjyJt01aVdYh5tTHvUEx2a4R78q3DRfaBQo+E
         79zA==
X-Gm-Message-State: AOAM532h/o6L6qhszNU7Q5eTYQ5TYCA4/HJpx6PBAz1/PBOIhMT/LsCG
        9KSQ0Iakm6278OND8SEsnHo=
X-Google-Smtp-Source: ABdhPJwDpKjO7mlRjqQiMSGWEFmmFeUVybY6Cc39a8AgFhfBXRL21SOPBL/XbbQFDKuJSQSOQ2PsAA==
X-Received: by 2002:a05:6214:a87:: with SMTP id ev7mr2779596qvb.13.1633529983314;
        Wed, 06 Oct 2021 07:19:43 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:3543:be32:db94:2235])
        by smtp.gmail.com with ESMTPSA id x6sm12413034qts.79.2021.10.06.07.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 07:19:42 -0700 (PDT)
Subject: Re: [PATCH] [RFC] sparse index: fix use-after-free bug in
 cache_tree_verify()
To:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        vdye@github.com
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <2b1f0e56-5bb4-7f41-5a1e-d8a21096084a@gmail.com>
 <cfd6f82d-01c3-d6be-a535-76255e599c89@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <96320021-66dc-966f-2222-25d308247596@gmail.com>
Date:   Wed, 6 Oct 2021 10:19:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cfd6f82d-01c3-d6be-a535-76255e599c89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/21 10:01 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 06/10/2021 12:20, Derrick Stolee wrote:
>> In particular, prime_cache_tree_rec() does not stop at the sparse-checkout
>> cone, so the cache tree is the full size at that point.
>>
>> When the verify_one() method reaches these nodes that are outside of the
>> cone, index_name_pos() triggers the index expansion in a way that the
>> cache-tree that is restricted to the sparse-checkout cone does not.
>>
>> Hopefully that helps clear up _why_ this happens.
> 
> It does thanks - we end up with a full cache tree but a sparse index

That's a short-and-sweet way to describe it.

>> There is a remaining issue that "git rebase --apply" will be a lot slower
>> than "git rebase --merge" because of this construction of a cache-tree
>> that is much larger than necessary.
>>
>> I will make note of this as a potential improvement for the future.
> 
> I think I'm going to remove the call to prime_cache_tree(). Correct me if I'm wrong but as I understand it unpack_trees() updates the cache tree so the call to prime_cache_tree() is not needed (I think it was copied from builtin/rebase.c which does need to call prime_cache_tree() if it has updated a few paths rather than the whole top-level tree). In any case I've just noticed that one of Victoria's patches[1] looks like it fixes prime_cache_tree() with a sparse index.
> 
> [1] https://lore.kernel.org/git/78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com/

Of course it does! I'm losing track of all the ongoing work in
the sparse index as I've been distracted and out of it for a
while. It's in good hands.

Thanks,
-Stolee
