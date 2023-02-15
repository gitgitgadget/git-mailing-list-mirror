Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA1FC636D6
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 22:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBOWAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOWAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 17:00:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09547BDF0
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:00:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l2so164837wry.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEToGMvihj1D6kKpdQIq4Bpa9RqV0OpOfmzeDfNDCBQ=;
        b=pAlScQNlQuZCobVW5xe/UY3Fv9fMqwUejBSFO1pxdy35wj7wPCxjRseO7Xhqw9i5v+
         PA+4Tgjg731ba3H+4yjGg3usOwSoPIAPIGvihJ7Tz7D4jmv5nKNK+yg2aaj4QPK65RUS
         9pJOOFsJU+En7sXl5ws4vZ3YGD5DbxDMbyVfOVGzde/lcpnRvZU3CwlducLhhqhFxfPG
         sWIRKfxjr4/hgLxWGOSVBxs15YqnIIbzQkYZ8e8dCUYg4qPfO9svehpH6Znm2Pz3c5sX
         B+h3jbEUb+Zo0hQGqd7DPbYTq8TOD31b68/pfiTw5x/okyc5ckCNktHTXuU90PqwEgaB
         zINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEToGMvihj1D6kKpdQIq4Bpa9RqV0OpOfmzeDfNDCBQ=;
        b=51I11SmM5biVmIDfkyMDVLvUqJCplewv7f19mJyNEf4mg1gEIAvovJoZVL+s/2/dC6
         i67maZjpb/wPv2+Bb5KoKPL1aBrfpjkT6nHCcFKssGcLYklK4qGzjeu1i/7syLAMtPfQ
         U2+hItgmhUgfVqgroMv42U5/zXHoWGrJVWklgpCpmyOjKBkHSn8+2E8rIGlOl+OtP/H8
         DEyPXtd5E6LdJyjGYdZ8mtJfnORTVrA5R+4WXcF4oB5E3ZxxGbSULuwD2KqNbgtrGDaS
         uhK7wz09i8nat2tocSNQjIVHkttRhq/3M8zep7AtdJgMHpCh6n++pR4+EiVJ8oyQ3m4P
         BE6A==
X-Gm-Message-State: AO0yUKUwZ530sJ0wz81lQB09xNht4MI+bPVkNVGvxtV05uqG5FRCVmqV
        mb45oE/U/1geqObt2gEi34g=
X-Google-Smtp-Source: AK7set8ows9N3xXycOrp2zAO9i6Bw1+202WzjjH2kXCykHT4ja+LMg45bUfNY74fU7YMe33UGi6bAQ==
X-Received: by 2002:a5d:4090:0:b0:2c4:71d:244c with SMTP id o16-20020a5d4090000000b002c4071d244cmr2814498wrp.25.1676498447521;
        Wed, 15 Feb 2023 14:00:47 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b003dc41a9836esm3759352wms.43.2023.02.15.14.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 14:00:47 -0800 (PST)
Subject: Re: [PATCH v3 1/3] branch: avoid unnecessary worktrees traversals
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20230211041644.1848341-1-jonathantanmy@google.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <b9464970-1ba5-e2f3-58c6-145ca45b1095@gmail.com>
Date:   Wed, 15 Feb 2023 23:00:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230211041644.1848341-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10-feb-2023 20:16:44, Jonathan Tan wrote:

> > If we could know in advance if the renamed branch is not HEAD in any
> > worktree we could avoid calling "replace_each_worktree_head_symref()",
> > and so avoid that unnecessary second traversing.
> 
> When I first read this paragraph, I thought that the traversing involved
> was just a loop through an in-memory data structure, which is not that
> costly. It turns out that a travesal involves not only constructing
> said data structure but also reading from disk to get the necessary
> information, which indeed is very costly. I would include that in the
> commit message, but won't insist on that (perhaps it's clear to others
> what is meant by traversal).

Sorry, I should have included details about why it's costly.  I'll
include some in the message.

> 
> > Let's rename "reject_rebase_or_bisect_branch()" to a more meaningful
> > name "die_if_branch_is_being_rebased_or_bisected()" and make it return,
> > if it does not die(), if the specified branch is HEAD in any worktree.
> > Use this new information to avoid unnecessary calls to
> > "replace_each_worktree_head_symref()".
> 
> In later patches, I see that the return value can also indicate that a
> branch is an orphan, and that for the sake of code clarity, the calling
> function had to have a variable assignment of the form oldref_is_orphan
> = (oldref_is_head > 1). If this is so, it is probably better to have
> this function return something with names. So something like
> 
>   #define IS_HEAD 4
>   #define IS_ORPHAN 8

OK.  I'll use names.

>   int get_branch_usage_in_worktrees(...) {...}
> 
> and then the caller can use these constants whenever it needs to know
> what kind of branch this is.
> 
> I also see in patch 2 that we're changing what the user sees under
> certain inputs. That can be avoided if we move the dying to the caller,
> and have this function merely return when the branch is being rebased
> or bisected.
> 
>   #define IS_BISECTED 1
>   #define IS_REBASED 2
> 
> or something like that. I would prefer if user-visible behavior didn't
> change unnecessarily, and this does not seem like a necessary case.

OK.

> 
> Other than that, everything looks good.

Thanks for your review and suggestions!
