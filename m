Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC4C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B895920734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHJV1M convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Aug 2020 17:27:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgHJV1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so9505541wrs.11
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KuRgMnSuo/FcZzL91TlJ4rtkAv9UytlNoSB9d1zgLSQ=;
        b=d1Ls7jmJN4SKrhgQyJlOMJwBq9I2ZD4keC4Z8DRq+jJQI8IiWqOdQTFF5uwZ3mJKhA
         cjI0LAYWQxQuOFoTlaJAKGMRz0iEXgiBHShqJSiu48GvEmfy1xg9LRKhB6HLlQGRWwaS
         0zqWucXRto0FoqJzMwAOVnjJ8Z/bebuAjxnRYde+74nbxn3wZqO2CjVmyABr8ZZAwoQj
         zuWJVDVpQTDDBgaZuSFx75ZBzHBeR1fpAU1nSK/yxSFrr5JqeUt60UXl/uG4HDUF+N5z
         7xIWUcnYL4AqkYNtm/GlrdgC2amvaXUg7dVuynvMUwn3aGGJeHbyeWmMeyduusClJJs0
         16Pg==
X-Gm-Message-State: AOAM532MoXlsADXF+LFuKzv5KlNzjeAzV8b5EjwUSQKOAAITZ/BPF6qz
        uw5PFbOu4G+N/p1dWgHyNfZ0/Bs1Vrua9/xYJ1g=
X-Google-Smtp-Source: ABdhPJySYWEkRRJgGIHYoY0WuZ4qkUKJqAklkLqXaXb8K9COC/1VTpUORjQyOFr8upqagdGxEYWol5KgkJepfKpEuZw=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr28147165wrs.226.1597094829888;
 Mon, 10 Aug 2020 14:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200810194748.1483784-1-martin.agren@gmail.com>
In-Reply-To: <20200810194748.1483784-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Aug 2020 17:26:59 -0400
Message-ID: <CAPig+cTsxAW=s1iXcK_-Kn+xiSNCm_u_o_Q2xm-0+a_v4qc5_w@mail.gmail.com>
Subject: Re: [PATCH] progress: don't dereference before checking for NULL
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 3:48 PM Martin Ågren <martin.agren@gmail.com> wrote:
> In `stop_progress()`, we're careful to check that `p_progress` is
> non-NULL before we dereference it, but by then we have already
> dereferenced it when calling `finish_if_sparse(*p_progress)`. And, for
> what it's worth, we'll go on to blindly dereference it again inside
> `stop_progress_msg()`.
>
> We could return early if we get a NULL-pointer, but let's go one step
> further and BUG instead. The progress API handles NULL just fine, but
> that's the NULL-ness of `*p_progress`, e.g., when running with
> `--no-progress`. If `p_progress` is NULL, chances are that's a mistake.
> For symmetry, let's do the same check in `stop_progress_msg()`, too.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/progress.c b/progress.c
> @@ -319,9 +319,12 @@ static void finish_if_sparse(struct progress *progress)
>  void stop_progress(struct progress **p_progress)
>  {
> +       if (!p_progress)
> +               BUG("don't provide NULL to stop_progress");
> +
>         finish_if_sparse(*p_progress);

I'm wondering what this really buys us over simply crashing due to the
NULL dereference (aside from the slightly more informative diagnostic
message). Either way, it's going to crash, as it should because
passing NULL is indeed a programmer error for these two functions. I'm
pretty sure that it is more common in this project simply to allow a
programmer error like this simply to crash on its own rather than
adding code to make it crash explicitly.

> -       if (p_progress && *p_progress) {
> +       if (*p_progress) {

In other words, I think the entire patch can be reduced to just this
change here (and a simplified commit message).
