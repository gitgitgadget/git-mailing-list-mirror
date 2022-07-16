Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A3C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 17:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiGPRkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPRke (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 13:40:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E2115D
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 10:40:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l23so14196273ejr.5
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nijPBNoVNgxkHO5DyJ8gy1T5AmwHpjuQu6LZ8ZjcxIc=;
        b=BlIE04d7FBNZBdUjrOyBXxJU3/LgXbBJ/IRG+5cqsSQHMsHt8uH/UXt9cL0hTZWs1P
         9+ccKoqeHpF48yBAT/GFYXIZM+a3LTrfRQpVRoz4B2FzOYXdFPhhGhipWJOn4YQF38mR
         2Dqldd3ch6BJ7FPvLJAN84xvPgsrs0lL6aNOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nijPBNoVNgxkHO5DyJ8gy1T5AmwHpjuQu6LZ8ZjcxIc=;
        b=ydS5UBrKu8y2vWD0+TeDE9fyTgB4d4C4DZ80p3+GomLSDGEVy7fwiBigZ4pNk/t+oP
         hWwo/ozeXOWbmL5dXYN9hrrVKFs0DsdYw3yPoKuEIM/JWpuvDOJlwpO9sQy6BzuK+bEc
         NFQPYR9Uv1fwxpUBSKOSDp6yASoWSCvuOB0zpvo51IxfPftQQBrqE3UQC41KqrtNtNcj
         MGcFJM4tNEk6L52L+ZEqPoKDxhcizDcHxqeh32iZ26p0bRF9lxYlOOqVD22b+MRBpi9W
         gzeuhEixdZ87f6YRGZqK1xsiYoP6TN3ix7jbf1CQinwNUywksXn5yeQqE1L2kz1rP9Yr
         PYFQ==
X-Gm-Message-State: AJIora9IcSffFLRbxPzDPWiAbEFRxnM/L92SS+FsoFJM4Pf/D+fCH1Jd
        XlDw6IvE0QPGjAElBkaRLmRt15ukpbqWRGlXQehewGwC/giTA6pO
X-Google-Smtp-Source: AGRyM1uLKiDvwagsbwPbDd78kS2WLXX1DkHy1zfY2uJMshHczJ0f+hIHAWZWpBPoIMd69S2MIO3CMB7KqF8ABjAWJYw=
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id
 nb7-20020a1709071c8700b006f029eacc01mr19531549ejc.671.1657993231857; Sat, 16
 Jul 2022 10:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1279.git.1657480594123.gitgitgadget@gmail.com> <xmqq5yk4r96l.fsf@gitster.g>
In-Reply-To: <xmqq5yk4r96l.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 16 Jul 2022 19:40:21 +0200
Message-ID: <CAPMMpoirWDBJn45dkWo8CRDU23G1mnyPDHcKq1eH1AtACEW9Rg@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: respect push.autosetupremote when evaluating @{push}
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 10:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

Thanks so much for looking at this, my apologies for the delayed response.

>
> > +     if (branch && (!branch->merge || !branch->merge[0])) {
> > +             repo_config_get_bool(the_repository,
> > +                                  "push.autosetupremote",
> > +                                  &autosetupremote);
> > +             if (autosetupremote)
> > +                     return tracking_for_push_dest(remote, branch->refname, err);
>
> Before the first push of the branch X where we are asking for
> X@{push}, i.e. there is not the corresponding branch over there yet
> and we do not have the remote-tracking branch for it yet, what does
> this function return?  If it continues to error out, then I think
> this patch may make sense, but ...

It does indeed still error out, because even though "git push" may
succeed (eg if "push.autosetupremote=true"), there simply isn't a
remote-tracking branch for it yet.

The only "point" of the patch is to address the edge-case where the
remote-tracking branch *does* exist, and git push *would* push to it,
on the basis of the new "push.autosetupremote=true" behavior.

In that very specific case, it's "wrong" to return an error just
because the tracking relationship doesn't exist yet.

>
> > +             {
> > +                     const char *up;
> > +                     up = default_missing_upstream(remote, branch, err);
> > +                     if (up)
> > +                             return up;
> > +                     return branch_get_upstream(branch, err);
>
> ... shouldn't the precedence order the other way around here ...

This is a bit convoluted, but I don't see how to make it more obvious.

The new "default_missing_upstream" function checks the *same
conditions* - it only "kicks in" if "branch_get_upstream()" would
return an error.

The reasons I can't add the new logic *after* or *in*
"branch_get_upstream()", and avoid this non-obviousness, are that:
* "branch_get_upstream()" raises an error, so recovering afterwards
seems non-trivial (to me at least - I haven't got my head around the
"idiom" yet)
* "branch_get_upstream()" is used in a a few other places for other
purposes, so I'm not comfortable modifying it for my purposes
* "branch_get_upstream()" is non-trivial, so I'm not comfortable
duplicating it / creating a new variant

I think I see one other approach that I could try and haven't attempted yet:
* Adding an extra parameter to "branch_get_upstream()" for new
behavior in these contexts

This might be easier to follow, even if it makes
"branch_get_upstream()" itself more complex.

There's probably some clean refactor that I'm failing to see.

>
> > +             }
> >       case PUSH_DEFAULT_UNSPECIFIED:
> >       case PUSH_DEFAULT_SIMPLE:
> >               {
> >                       const char *up, *cur;
> >
> > +                     up = default_missing_upstream(remote, branch, err);
> > +                     if (up)
> > +                             return up;
> > +
> >                       up = branch_get_upstream(branch, err);
> >                       if (!up)
> >                               return NULL;
>
> ... and here?  That is, if branch_get_upstream() finds an explicitly
> configured one, shouldn't we use that and fall back to the new
> "missing" code path only when there isn't an explicitly configured
> one?
>

Yep, same deal - by the time "branch_get_upstream()" has *not* found
one, it's returned an error, and I haven't understood the side-effects
of that in this project, if any.

Any advice on whether an already-prepared error can simply be
discarded would be welcome!
