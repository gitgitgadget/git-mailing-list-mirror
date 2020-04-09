Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB93C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5324120A8B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 11:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwFVMN0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDIL4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:56:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34046 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIL4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 07:56:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so2484713qtp.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SN4CunUGem6axQCrTqT5Psu02fF9SaNhoCNSVMiPqH4=;
        b=WwFVMN0gWdzchR5/LUQlTJUwzkyyqHc+Uk6s8rnRvMROgc0tdgW7mcem//dz0cBofm
         bW9joFlnZcJKXxeI1bTelmJ4zPAR55PBhJ6QP/Iyi89OY/Y2tGwBqvyRaqv5L1M0Xbjv
         CdSUlr1uK1iBWrvI3aAeawF90F2/Qul/NNsadn+2iVrAEs3+lkukvUYaT9BGZhaaUji0
         7nEGV3BYQiN//vEuMOpd7tQx4uU0EXKDxqJv9BtgRLJbpg/65aXecAQqCMK3G6lRURks
         uasz1jvB246ur6qBUZY9Z1pcV2xkwleX9OhXBVKaQwrWypyk9iVcXdrJ5/L2HP8gowri
         1ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SN4CunUGem6axQCrTqT5Psu02fF9SaNhoCNSVMiPqH4=;
        b=P0WvJiBO5sAgAqL1XWkZIfAJUbWWJKMJv7uELRdppV1oIaHa7tz9S2mkRDhQwITubS
         woG7bFBpoudllAhzt2+LpSzDETaZttPbtEV5/7NJSUhJ6/Z3L00H21DTkHgCQ9UkmNRN
         MeLqw+T6tU5Jfk3ZUDhgfYggx1DIIstwIDzHhNMn3ibv/YgOmpH9kHro0xH+uCq/jYxf
         YHMLrPp/D5OEQnKszLcGtkMkGh42w22nqHow3AEI8U5m3yBMzfX2WYqIXz2CRos2NSMj
         nx/9keUCg8FQGUo271uST2CKq5TvQURnPnndQIvKfWlpYX8V04ORcoFSpBssTmEcxab0
         vIsg==
X-Gm-Message-State: AGi0PuY5EyLJDSqWOwXBD9krTL8i+H5ijZ4aHnJZfXaimBJfvM1+hHXa
        jCceKKLRXwEGxqT4KxS26d8=
X-Google-Smtp-Source: APiQypIzDz6+cNBKU5UiyKV8Yq5o5lp4F+ntAhr/mTIP576qUuuywLRoQSFNemwWSuQ/937ayqoHDg==
X-Received: by 2002:ac8:6919:: with SMTP id e25mr11747671qtr.151.1586433405971;
        Thu, 09 Apr 2020 04:56:45 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f13sm21607095qti.47.2020.04.09.04.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 04:56:45 -0700 (PDT)
Subject: Re: [PATCH] bloom: ignore renames when computing changed paths
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
 <20200408223111.GC3468797@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <72fa2e30-b841-9600-ae2c-21a269817f1c@gmail.com>
Date:   Thu, 9 Apr 2020 07:56:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200408223111.GC3468797@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/2020 6:31 PM, Jeff King wrote:
> On Wed, Apr 08, 2020 at 04:38:27PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The changed-path Bloom filters record an entry in the filter for
>> every path that was changed. This includes every add and delete,
>> regardless of whther a rename was detected. Detecting renames
>> causes significant performance issues, but also will trigger
>> downloading missing blobs in partial clone.
>>
>> The simple fix is to disable rename detection when computing a
>> changed-path Bloom filter.
> 
> Yes, we should be doing as simple a tree-diff as possible.
> 
> I wonder if this might actually be fixing a potential bug, too. The loop
> below this code only looks at the "two" half of each queued diff pair.
> With renames enabled, we might see the source path only in the "one"
> half of the rename pair.
> 
> However, this seems to work already. If I do:
> 
>   echo content >file
>   git add file
>   git commit -m added
>   echo change >file
>   git commit -am changed
>   git mv file other
>   git commit -am 'rename away'
>   git mv other file
>   git commit -am 'rename back'
>   git rm file
>   git commit -am removed
> 
>   git commit-graph write --reachable --changed-paths
>   git log --oneline -- file | cat
> 
> then I see all of the commits. Instrumenting Git like:
> 
> diff --git a/bloom.c b/bloom.c
> index c5b461d1cf..fb2a758e1d 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -207,6 +207,10 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  		for (i = 0; i < diff_queued_diff.nr; i++) {
>  			const char *path = diff_queued_diff.queue[i]->two->path;
>  
> +			warning("queuing touched %c path %s for %s",
> +				diff_queued_diff.queue[i]->status,
> +				path, oid_to_hex(&c->object.oid));
> +
>  			/*
>  			* Add each leading directory of the changed file, i.e. for
>  			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
> 
> results in:
> 
>   warning: queuing touched A path file for 2346d88b0cb4bca11c38ee545d007a7a14ca472a
>   warning: queuing touched M path file for 991cd7f0696ae29fea738ca1b8340c90dae4b201
>   warning: queuing touched D path file for d3642c9fb27459ea09f6c967a1e6ad119e265d6f
>   warning: queuing touched A path other for d3642c9fb27459ea09f6c967a1e6ad119e265d6f
>   warning: queuing touched A path file for bc908eb29e562d97ebb8cf718e41b69d3aa1d834
>   warning: queuing touched D path other for bc908eb29e562d97ebb8cf718e41b69d3aa1d834
>   warning: queuing touched D path file for 7433b46bd6aa170ab17a651c10658a5b0c10ba4f
> 
> So we really aren't detecting renames in the first place! And indeed,
> checking diffopt.detect_rename shows that it is unset. So I'm curious if
> there is a case where that would not be true. I _think_ it would only be
> true in a program which ran init_diff_ui_defaults(), but never in
> git-commit-graph.

So our issue was really that the partial clone prefetch logic was just
overly aggressive.

> Even if it does nothing in practice, I'm not at all opposed to having it
> in there as an explicit documentation of our expectations/requirements
> for the loop below. But it's probably worth saying so in the commit
> message.

I will update the message and send a v2. I'll fix the typo that Philip pointed
out, too.

Thanks,
-Stolee

