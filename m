Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E9C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 00:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiF3AF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 20:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF3AFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 20:05:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41F424F25
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:05:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r18so16494340edb.9
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWJ65tcf79NzW96nnp7OMwCSjMVod6hFsV3yGvi5qnc=;
        b=AT4BYzp74BvuqIlP271oN9NvpqYuiukPgxoLRGdNbabtvTya4tY9UoP/WdSwZC2gUI
         wEiO9Ohsmzi0vmu4EsIEPhIPtFFryDrkM5wJKsGxwW/Gom2DGAeNUzg0jy8G6I7u1TQk
         F6hg0rBKHzB+8yXHvoqTRPE0C9BhxiT3IAfFAtdYJYbtiGOaU57geHTV7O577DJXANn4
         RFt3dtDsIX8LcFikJ00FRChFOjTBUgcGflikYFXi6gk44kHtwzSZ1xUR6dfY50A4NYeJ
         Fo1ITdsux2YMcNDdaU2Q9jOvFmVIl8jW3ikuYXOM8jy+b+wzxj9qvfgMvJiUCB7wQkqS
         xnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWJ65tcf79NzW96nnp7OMwCSjMVod6hFsV3yGvi5qnc=;
        b=s7ONNFf0fpPeappUR4Z84LN+SaJ1aif4u9ChSEaZx3UWsOR5xd4Hphd1WklaOfQu+7
         K3okuVX6GqLYWiWXTKNsP3yeX42sDPZRPNP548+NwE2aC9eXx0HzM+2ldUdyzWLFHa+G
         nlgfPH/8EQwr+TT9OH6tA4frAr8mNHkiJAbLf2B0paHx2X68ognIAw/n7c6rc9yFUaE1
         mObwRdqMQUwc15HiaYDmwKQ6iEEtZb5QSXHhtarGbIXJenwH2t4pm5xASJi1XCzdrU6h
         OsS+aqZiwwrXWzMUCaq6uPYxuIVC3QXww11cRwRAbt3OkmJqqQf27vTrYS7+c2p/6ROR
         GU8A==
X-Gm-Message-State: AJIora/rFU9mg32/a0ePcyVpYU/yBvxbdtI2b/U4icpQeypvwr9x+8Rs
        uBDTTsXchu/dh1LICZa/sDVKrvCn8SEZdW2Yl9s=
X-Google-Smtp-Source: AGRyM1tyZaiQAZM/f3OUIVYa7VZnoRZd0f3y/lzsufG+I+f/DLRhslYoBQUshmF4dcyLkgj/M/os0N/fK9HC6cn2N3k=
X-Received: by 2002:a05:6402:2999:b0:434:edcc:f12c with SMTP id
 eq25-20020a056402299900b00434edccf12cmr7650267edb.96.1656547552382; Wed, 29
 Jun 2022 17:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220627184847.1361980-1-jonathantanmy@google.com> <20220627210406.2802452-1-calvinwan@google.com>
In-Reply-To: <20220627210406.2802452-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jun 2022 17:05:40 -0700
Message-ID: <CABPp-BGycqhbhYtM+kzB5zLSX0sZ_rwz_DagDkp4oJQbZgS-ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] merge-ort: shuffle the computation and cleanup of
 potential collisions
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 2:04 PM Calvin Wan <calvinwan@google.com> wrote:
>
> Jonathan Tan <jonathantanmy@google.com> writes:
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > @@ -2314,7 +2335,8 @@ static char *check_for_directory_rename(struct merge_options *opt,
> > >     }
> > >
> > >     new_path = handle_path_level_conflicts(opt, path, side_index,
> > > -                                          rename_info, collisions);
> > > +                                          rename_info,
> > > +                                          &collisions[side_index]);
> >
> > Is this a fix of a latent bug? handle_path_level_conflicts() is not
> > changed in this patch.
> >
>
> I don't think so. IIUC this is what's happening given the callstack:
>
> detect_and_process_renames()
>   - Now defines `struct strmap collisions[3];` and computes all
>     three collisions here
>   - Passes collisions into collect_renames()
> collect_renames()
>   - Originally defined as `struct strmap collisions;` and computed
>     collisions in here
>   - Now takes collisions as an argument
>   - Passes collisions into check_for_directory_rename()
> check_for_directory_rename()
>   - Collisions isn't used in this function at all except to pass into
>     handle_path_level_conflicts
> handle_path_level_conflicts()
>   - Expecting pointer to singular collisions, not an array so side_index
>     is now required

Sweet, thanks for answering for me.  This is exactly right.
