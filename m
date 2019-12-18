Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE8C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 16:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D24227BF
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 16:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLRQSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:18:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35754 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfLRQSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 11:18:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2570895wmb.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 08:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eijak3SEnJU6dVx5biF0j4N4rfHH8wLBOAL7TwgCQBo=;
        b=aPy6bUbcoZcR2KZyw1lg/PwIVrKMC+V9qHKnogucMPhbYO4puiex24BsuTX2QCQVHl
         xtX6ng5SeGVB1sHhfaozW6Cw5zJSprq3IkSuPlM3KO2HBImAYmQfQ4WcDra4hs66Ie/E
         U6mu1D4msna8RRdWxJMoy/3ter57wAn2p72H66Go7dXaQOTc6MP1XFCdzX5cnn5hYv73
         JC7DjKbAYEWW5N3CpJ3+ojLpA9Bb5luhy4as055/S3UxgqnxE7v8i5cn4cscmIHOKHtV
         qdO8T0SSdkmHIKuYNfz0GIT/3ysTYo3ZXMZQfW1Rr8xzQw2CPCXYWksnB/vslLFHTWpy
         rqow==
X-Gm-Message-State: APjAAAWaazYVRBx9L6s1PhN2B0+duyfJ1fIJUfZcD+xi4U5/ZRGBG1nd
        wx7d4oNudcpJL1QTUYLSuPuD81b/IAawJiLud6qIyz5dFgM=
X-Google-Smtp-Source: APXvYqzhIWv23koM6dcvXyoSy56Lrvvrp80i4NXll/Tyy4ltND+6AKhoMEv+P9Zwo3g4GzT29HRt5diDtfIo0OvWr54=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr4122593wma.84.1576685901876;
 Wed, 18 Dec 2019 08:18:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576111643.git.liu.denton@gmail.com> <96b908c91c19bc11da9f8d3b0d6e853517284540.1576111643.git.liu.denton@gmail.com>
In-Reply-To: <96b908c91c19bc11da9f8d3b0d6e853517284540.1576111643.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Dec 2019 11:18:10 -0500
Message-ID: <CAPig+cRVyfWceVZFgRuRyL-B3TMnX9fObC84t2LHsNoXm8TuqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] notes: break set_display_notes() into smaller functions
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 7:48 PM Denton Liu <liu.denton@gmail.com> wrote:
> In 8164c961e1 (format-patch: use --notes behavior for format.notes,
> 2019-12-09), we introduced set_display_notes() which was a monolithic
> function with three mutually exclusive branches. Break the function up
> into three small and simple functions that each are only responsible for
> one task.
> [...]
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/notes.c b/notes.c
> @@ -1045,28 +1045,31 @@ void init_display_notes(struct display_notes_opt *opt)
> +void disable_display_notes(struct display_notes_opt *opt, int *show_notes)
> +{
> +       opt->use_default_notes = -1;
> +       /* we have been strdup'ing ourselves, so trick
> +        * string_list into free()ing strings */

    /*
     * Multi-line comment
     * style.
     */

Though, apparently the formatting used here predates your changes; you
simply moved the code (and comment) around.

> +       opt->extra_notes_refs.strdup_strings = 1;
> +       string_list_clear(&opt->extra_notes_refs, 0);
> +       opt->extra_notes_refs.strdup_strings = 0;
> +       *show_notes = 0;
>  }
> diff --git a/notes.h b/notes.h
> @@ -266,14 +266,19 @@ struct display_notes_opt {
>  /*
> + * This family of functions enables or disables the display of notes. In
> + * particular, 'enable_default_display_notes' will display the default notes,
> + * 'enable_default_display_notes' will display the notes ref 'ref' and

s/enable_default_display_notes/enable_ref_display_notes/

> + * 'disable_display_notes' will disable notes, including those added by previous
> + * invocations of the 'enable_*_display_notes' functions.
> + *
> + * 'show_notes' is a points to a boolean which will be set to 1 if notes are

s/points/pointer/

> + * displayed, else 0. It must not be NULL.
>   */
