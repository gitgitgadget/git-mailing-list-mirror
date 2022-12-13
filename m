Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C95C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 10:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiLMKhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 05:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiLMKhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 05:37:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04AE01F
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 02:37:33 -0800 (PST)
Received: from [192.168.1.90] (unknown [86.123.78.117])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A55F6602AB2;
        Tue, 13 Dec 2022 10:37:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670927852;
        bh=Js+X8ZxJ+SGWwUkOOAue0Mghzmv6PwEY6/+tUrafBGQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MYT/U69IcRo0Q6r7ZV84Q4OZaTeO5Qr2MSYiUyjqZ4ph7NYUhAQ74K+Vk5DKQjHGo
         NA+hOwYn/FVsK9Rka+DuOopiIOtiOeK3Oth93kYxzGfUvEpR7QDNyBkobeUumw1SjH
         /nIt6m6/CTWcvv1ZHdVLe9+kB2H0jPOa9OQLiUNZyujSE5bRkv6bfHE75WhLyKFAHW
         79oVKqLwVoNjygdI1oxK3kXpk9vb0xHPqbCh/JduzsWuC+/JH4cwd7j79HAk180jox
         K8qUBHa+hYI1QpU2nDO3TUMlpmrRNkf0+XqRATnDWxl52EbcMRC4wxM0kjzHxKw46V
         mtQZRx9wq7dTQ==
Message-ID: <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com>
Date:   Tue, 13 Dec 2022 12:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/1] rebase --onto detection of already applied
 commits
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
 <xmqqlencqhxy.fsf@gitster.g>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <xmqqlencqhxy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/13/22 02:13, Junio C Hamano wrote:
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com> writes:
> 
>> Let's consider the following operation:
>>
>>    git rebase --onto new-base upstream feature
>>
>> where 'feature' contains a few commits on top of 'upstream' which need to be
>> rebased onto 'new-base'.
> 
> Isn't it what "git rebase new-base feature" for?  "My 'feature'
> forked from where 'new-base' came from but they updated 'new-base'
> so I do not know if some of what I had in my 'feature' is in
> theirs. Please forward port what is still left in 'feature' on top
> of updated 'new-base' that I just got from them".

I should have highlighted that 'feature' contains a bunch of commits 
that must not be rebased on top of 'new-base', but only the ones in the 
'upstream..feature' range need to be considered.

> The primary reason why we have an explicit "--onto" is so that
> "rebase" is used just like
> 
> 	git checkout --detach new-base
> 	git cherry-pick upstream..feature
> 	git checkout -B feature
> 
> to deal with a different situation, i.e. "My 'feature' forked from
> 'upstream', and I have a commit 'new-base'.  Just transplant the
> whole thing on top of it", without having to worry about "what is
> already in new-base?" at all.  After all, 'new-base' may not have
> ANY ancestry relationship with the 'upstream', so "inspect commits
> in the range upstream..new-base to exclude those that are the same
> as the ones in upstream..feature" is not a well defined operation.
> 

Thanks for clarifying the intended use case of '--onto'. I have wrongly 
assumed it could be used as a more flexible rebase alternative, allowing 
one to limit the range of commits to be considered for rebasing on top 
of a given base, without losing the feature of detecting the already 
applied commits.

Currently '--onto' works as if the user provided the 
'--reapply-cherry-picks' flag, so maybe a possible improvement of this 
patch could be to handle '--no-reapply-cherry-picks' to explicitly 
enable the detection.

Would this be an acceptable extension?

Thanks,
Cristian
