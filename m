Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4A7C433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 02:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhLKCJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 21:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhLKCJk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 21:09:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1997EC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:06:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v1so35662640edx.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cJ0s3X4uAnJ9siMACN/R8av9ehCvBnRcvuhcdesXAH4=;
        b=CqP0AY89Oe3+UHBT0+dFAZ5heKkossfgyqecvO+Ihhx2xHp459q2vyysmGy8mkyzrj
         nsqLE2DB/vy6ZucWlInH1dw4zzKhDV+6/Co0W4GrW6BemdpQBUEhteS4WjCEUBqzKBhu
         muHGHWQ7S9zoTV7IbPQDCe3Ua4hqmQkmgFXlI5Gqfcp31gDioQBDzSfz+bXgPsvhCB9r
         TwZTurQ0/Z/P41APffM7fDJ+k88cgUkru5PRGta1qokIpLs8fzh5w05cKFr5UimlseTt
         ILqhbAA7/waInVikR38XDeefPZjC+TYPhuAa3M9S4j1v6mB/kIRbwhpIbcuq1cmND/SC
         c4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cJ0s3X4uAnJ9siMACN/R8av9ehCvBnRcvuhcdesXAH4=;
        b=fOseASpJnUCwB69dKLjsvQgFmVsF5VH6XycmsxivrOn4tOWHQYbSdv3GR87A60LPmE
         e8nxLiiEzxAKhDGBPmdoGKOfk1oKzbVxbixAzgZdiOlxXVfip4bphD62gFVpszJchst7
         aRTVpDB2DC9z34B6BxJY8IWb0MD2ovSMKicgR8LkEpL2Nmq+2rgFaAAEQzN3925KLdUw
         JFpeY1h6lNlnc/u97RkCleGM814jzfdZYbgI15aLYBqoPkPaWzKJgiXp2vhChap+aB18
         5Vr1sNjHhRfpUnWCbxJ1/nhmeYl+kRwDmy0FzmbaZ3A2rzZEn8ztQTKl11FX4EC2ZGXl
         D1GA==
X-Gm-Message-State: AOAM531EMdCOOiAMOUMEoKJ2F4EaJVKXrS1M2D4SGRComnSNb22lLccI
        xh/3p3it59REFY3WST6cqq3dYNGsJ+pgilX2TM+l+4m7ubNmww==
X-Google-Smtp-Source: ABdhPJy7PwJDbngHPJM7n2557eHE5UNt75cqUAqIcVf4R6bQI9RWo0mM98diNtGs5TFxSyQYWyOqYzbSpPR7YFnzWcA=
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr29691615ejc.328.1639188362342;
 Fri, 10 Dec 2021 18:06:02 -0800 (PST)
MIME-Version: 1.0
References: <xmqqwnsvw5xi.fsf@gitster.g> <20210728031437.14257-1-jerry@skydio.com>
In-Reply-To: <20210728031437.14257-1-jerry@skydio.com>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 10 Dec 2021 18:05:51 -0800
Message-ID: <CAMKO5CvETNfab9KLU0DDchvdM7JEJupifyKKPbWwz4QqiqcqPg@mail.gmail.com>
Subject: Re: [PATCH V2] git-apply: silence errors for success cases
To:     git@vger.kernel.org, gitster@pobox.com,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 8:14 PM Jerry Zhang <jerry@skydio.com> wrote:
>
> Certain invocations of "git apply --3way"
> will print error messages even though git
> is able to fall back on apply_fragments and
> apply the patch successfully with a return
> value of 0. To fix, return early from
> try_threeway() in the following cases:
>
> When the patch is a rename and no lines have
> changed. In this case, "git diff" doesn't
> record the blob info, so 3way is neither
> possible nor necessary.
>
> When the patch is an addition and there is
> no add/add conflict, i.e. direct_to_threeway
> is false. In this case, threeway will fail
> since the preimage is not in cache, but isn't
> necessary anyway since there is no conflict.
>
> Only error messaging is affected and other
> behavior does not change.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V1->V2: rebase onto master and rerun tests
>
> I think I addressed previous comments. What
> are the next steps for this patch?
>
>  apply.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index 44bc31d6eb..fb321c707b 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3560,7 +3560,9 @@ static int try_threeway(struct apply_state *state,
>
>         /* No point falling back to 3-way merge in these cases */
>         if (patch->is_delete ||
> -           S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
> +           S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode) ||
> +           (patch->is_new && !patch->direct_to_threeway) ||
> +           (patch->is_rename && !patch->lines_added && !patch->lines_deleted))
>                 return -1;
>
>         /* Preimage the patch was prepared for */
> --
> 2.32.0.1314.g6ed4fcc4cc
>
Any updates on this patch? I had addressed the previous comment in this
thread in a different patch "apply: adjust messages to account for
--3way changes"
that was already merged in a while ago.

I originally intended this to mainly fix print message behavior, but
while testing
I found that it also fixed a separately reported issue from this thread:
https://www.spinics.net/lists/git/msg421481.html.

I probably owe an update / refresher on why I originally submitted these
features in the first place. I've written a tool for branchless / patch stack
based code review and development w/github. The core of this is a mechanism
that can cherry-pick commits without touching the cache or working tree
by using "git apply --cached --3way" with a custom index file. We've been
using this internally with a custom built git for a while now and gotten pretty
good feedback. We'd like to open source this tool soon, and it'd be nice
if our open-source users (eventually) don't need to build git themselves :).
