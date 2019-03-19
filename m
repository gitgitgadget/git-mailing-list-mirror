Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B1920248
	for <e@80x24.org>; Tue, 19 Mar 2019 16:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCSQnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 12:43:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54398 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfCSQnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 12:43:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so17751706wmj.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 09:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PG93EVjaFD57i+bT/7PoUMCX216p9KFTee+1LPzuMc=;
        b=TwxKx1m4mzmPjLxdHrvxOxg0Zi58szELXmzfrb5C32ZYiojXmA0+3dN7hUvRZ0FHGK
         8i3p6bsWRGgTVThYcSDgZXipc9zITgdRZfdO09MZkQLYwLQkw/EC0lHHbx3ABxABPzvN
         5+CbOpVa0VXTrVRM+JXPAzt1MLaj2OYPn3AfGcgYPvNZdSOg00SUpd6KDG2/PnKZ1tYb
         18znPQrcYlvhMA3vs4ABM4Lb0Ew9ObvMqBz9zh2REATllBkL2RhGewbJwtTv/KrnOWNy
         6BGXZlbtaomySRMzF/9wQNaQjjG3nxkOyqHm4onHaOWnZ0OkIGnvgVFtCQlOtbifvBcP
         m44g==
X-Gm-Message-State: APjAAAVMDPUUx+81T3NnMCb1wsO+US89fhVb6fBf+OoaL/3O2M2uwzmH
        Mik/jwJ2rpUua1jHbT9woW22evAu5yzkoKJAaTI=
X-Google-Smtp-Source: APXvYqwnXi+w5gDm07O8TrjqOvhzpX5zchooR4L+LEl5wZVRetRU0kP8vxuCl/vIXUD4dV5yuJTcGDfvzkINLyLzcIU=
X-Received: by 2002:a1c:e185:: with SMTP id y127mr3170819wmg.76.1553013785198;
 Tue, 19 Mar 2019 09:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.166.git.gitgitgadget@gmail.com> <pull.166.v2.git.gitgitgadget@gmail.com>
 <e1da1f84a85165703e3b6be4a240bd36d62b4b01.1553006268.git.gitgitgadget@gmail.com>
In-Reply-To: <e1da1f84a85165703e3b6be4a240bd36d62b4b01.1553006268.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Mar 2019 12:42:54 -0400
Message-ID: <CAPig+cTC0AmJyU7D=f9VAGOOwJpk+aMe95MDqiiCqMdU5-kk+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] progress: add sparse mode to force 100% complete message
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 19, 2019 at 10:37 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add new start_sparse_progress() and start_delayed_sparse_progress()
> constructors and "sparse" flag to struct progress.
>
> Teach stop_progress() to force a 100% complete progress message before
> printing the final "done" message when "sparse" is set.
>
> Calling display_progress() for every item in a large set can
> be expensive.  If callers try to filter this for performance
> reasons, such as emitting every k-th item, progress would
> not reach 100% unless they made a final call to display_progress()
> with the item count before calling stop_progress().
>
> Now this is automatic when "sparse" is set.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
> diff --git a/progress.c b/progress.c
> +/*
> + * Here "sparse" means that the caller might use some sampling criteria to
> + * decide when to call display_progress() rather than calling it for every
> + * integer value in[0 .. total).  In particular, the caller might not call
> + * display_progress() for the last value in the range.
> + *
> + * When "sparse" is set, stop_progress() will automatically force the done
> + * message to show 100%.
> + */
> +static void finish_if_sparse(struct progress **p_progress)
> +{
> +       struct progress *progress = *p_progress;
> +
> +       if (progress &&
> +           progress->sparse &&
> +           progress->last_value != progress->total)
> +               display_progress(progress, progress->total);
>  }

There's no reason for this function to take a 'struct progress **'
rather than the simpler 'struct progress *', and doing so just
confuses the reader.

>  void stop_progress(struct progress **p_progress)
>  {
> +       finish_if_sparse(p_progress);
> +
>         stop_progress_msg(p_progress, _("done"));
>  }

Rather than adding a new "sparse" mode, I wonder if this entire
concept can be boiled down to a single new function:

    void finish_progress(struct progress **p_progress, const char *msg)
    {
        struct progress *progress = *p_progress;
        if (progress && progress->last_value != progress->total)
            display_progress(progress, progress->total);
        if (msg)
            stop_progress_msg(p_progress, msg);
        else
            stop_progress(p_progress);
    }

without having to make any other changes to the implementation or add
a new field to the structure. It would mean, though, that the caller
would have to remember to invoke finish_progress() rather than
stop_progress(). Which leads one to wonder why this functionality is
needed at all since it's easy enough for a caller to make the one
extra call to simulate this:

    /* client code */
    if (progress)
        display_progress(progress, progress->total);
    stop_progress(&progress);
