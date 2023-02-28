Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A92FC7EE2E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 00:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjB1AMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjB1AMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 19:12:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895373C17
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:11:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bx12so4852257wrb.11
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677543114;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP7XrF0on/+ytvdHo1l4Rtfbi5vPk7NmyjMG5ny6Zwo=;
        b=Js5s/fLxQgQ6V8lQMcjBh0qT9BQa/mhq6LYBjX71CtvVlTfp/ud4wGJ6ARDX57zoVc
         FPgL53LvPm+qr3fW6Kxl0ux6zMB6EAyaxqxFDTFJLACNBiyaQTlP5cO0qHmIjIRr7rUT
         /aUZ4Fy8SLOsUX7PLWZ8AMEm3T40NqtVSRNOrnCxUtlOUomNe8APoU4FyTimc4OmIWEs
         c5kB/lbf8NIkPZTsNQcDR1WHb3dJe5jA5CYZxtaW4Tb2SMRbnr/538Ut/qQyPZrkXLEB
         qGUeF4Y2/zeoLOOoJpws0syBStTBjlOfWI9nQwYGym3yl2l1JuhB6Dh8F20UPJXGpnM9
         wGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677543114;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP7XrF0on/+ytvdHo1l4Rtfbi5vPk7NmyjMG5ny6Zwo=;
        b=CjWdsuwpQ94fESXhY5AOgUcpNK3HCshOeTA0s7dlxjatHA5MPaOkJ1fGMWkG4XlTRA
         qKuoKNzTHLhK3he9Mq8fSLxxc5CXf4olvL9iUGU95IgeniRRHdIJurieQwM8XLsLtGyG
         T1OM8GGevM3swLGNT+B4InlBafeEltQ7atdxhkC0SJjLB82Z4T7mD9iZMcDrKoze/z3F
         /PGOxX3BhMA4r0H0u1AY7/ubPTjy8nZ2xkVH/mTfd/JG/jcD86DU72CJqO8XyoF28EFu
         Y6ZNKPoicrO1oQEIPjqyvW8vBh9IQUpxxL1ThBl7F6G1i2azCZluQGYxxxMY/PmHx+I8
         ER/w==
X-Gm-Message-State: AO0yUKUU1Kp+PltIizW6hT6yFKTnqfuJzLTfEHeTnjiJW59/QNxjT45m
        R3DA5O963AiU9Atgq8832Bg=
X-Google-Smtp-Source: AK7set+CjjQTAiTzpUnZT8eLjE3SO5Fc5I4WaAkJQU79NgNf7MtgjZ3ddRgyqQxQYDqPB9iILTf3eQ==
X-Received: by 2002:a5d:6187:0:b0:2ca:e8c2:6d25 with SMTP id j7-20020a5d6187000000b002cae8c26d25mr692860wru.60.1677543113870;
        Mon, 27 Feb 2023 16:11:53 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4804000000b002c59c6abc10sm8218898wrq.115.2023.02.27.16.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:11:53 -0800 (PST)
Subject: Re: [PATCH v4 1/3] branch: avoid unnecessary worktrees traversals
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230227193012.2410973-1-jonathantanmy@google.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <dee6ca9e-af3b-bc79-a09c-6bc0f0245017@gmail.com>
Date:   Tue, 28 Feb 2023 01:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230227193012.2410973-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/2/23 20:30, Jonathan Tan wrote:
> Rubén Justo <rjusto@gmail.com> writes:
>> Reviewing this, I noticed I made a mistake here.  The original code
>> doesn't stop iterating whenever refs_create_symref() fails; it continues
>> trying to update the remaining worktrees.  When the iteration ends, if
>> any of the updates failed, then die().  Also, the error message "HEAD of
>> working tree %s is not updated" is lost.  
> 
> Ah yes, I noticed this too.

I'll re-roll with the fix in the next iteration.

Thank you for reading carefully.

> 
> Besides that, a reviewer, upon reading the commit message, might ask:
> why not take the worktrees as a parameter then, if we're so worried
> about performance? I think that the real reason for inlining is that the
> code being inlined needs to communicate more information to its calling
> function in subsequent patches; the performance improvement is only a
> beneficial side effect.
> 

Certainly, that's a way to see the modification within this series.
Actually, this modification wasn't present in v1, but once it was
introduced in v2, it made sense on its own: to eliminate the redundant
traversals of worktrees when renaming a branch, even if the branch isn't
HEAD in any worktree.

Therefore, I think the change can also be seen in another way: the
increased ease in the next modifications is a beneficial side effect
of this patch.
