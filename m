Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799ADC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460FF64F84
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhBBW2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:28:35 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:37512 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhBBW1k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 17:27:40 -0500
Received: by mail-ej1-f42.google.com with SMTP id jj19so4774298ejc.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 14:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCJuqOvzFerKShnGucKDL9uMpFfvNtWig2KPvBdMLPk=;
        b=KSlwb9vdVkGdpTaeD5X1XY4BWcIaym98me3K3MnTwm/zQ1cMoes6Xc2qShdZr1cvFg
         9PxaGZFo4W237g/cyXcGmOATt33HYU0Uj2vvm/35ROA4v7LwKZLpSQRuNIzbDyk6u1Kt
         qOSUktmFtNJFGtYcas9BcoP9obVfC979QM7tKmgr0H2HPdyJ8CAfu47sAd4ddPQaxKNG
         4Q9+uK5K0o9srx2ia+hfID3W4uzWMUGMC72vkbzEyOlza8m8WAOP4ZYsYFnNjAqBw62t
         oO3PRLjg2cPCj1/MUhlxhtTy901RxwkN03by/O5q5L2L5T3ENpImyjajs2zhYtUSahA3
         E4YQ==
X-Gm-Message-State: AOAM53141a8Tk4fAepKR+RiiYuu3DUQOhjXaXYt+rGTMnJAp3LS134mm
        cE43BN5A0c5NAviSWe719xxdyBsU0bISEplqMT5bez9xOkHmLw==
X-Google-Smtp-Source: ABdhPJyKzs1nPi2M+fuA5T42gifFRxatSGYROctxgRvV2wxZELmwxECLO/+7LsoSYm48AsXQqMJLfpYCSvNOO3WRggw=
X-Received: by 2002:a17:907:1b10:: with SMTP id mp16mr173433ejc.482.1612304819168;
 Tue, 02 Feb 2021 14:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20210202200301.44282-1-me@yadavpratyush.com>
In-Reply-To: <20210202200301.44282-1-me@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Feb 2021 17:26:48 -0500
Message-ID: <CAPig+cT+n3=o9AVyK6FUQ=88aqdnoCfSAxmAO0Xe9S84a9RBqw@mail.gmail.com>
Subject: Re: [PATCH] git-gui: remove lines starting with the comment character
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 3:07 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> The comment character is specified by the config variable
> 'core.commentchar'. Any lines starting with this character is considered
> a comment and should not be included in the final commit message.
>
> Teach git-gui to filter out lines in the commit message that start with
> the comment character. If the config is not set, '#' is taken as the
> default.

Thanks. This shortcoming has bugged me for a long time. A few comments below...

> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> @@ -209,6 +209,28 @@ You must stage at least 1 file before you can commit.
>         set msg [string trim [$ui_comm get 1.0 end]]
>         regsub -all -line {[ \t\r]+$} $msg {} msg
> +
> +       # Remove lines starting with the comment character.
> +       set comment_char [get_config core.commentchar]
> +       if {[string length $comment_char] > 1} {
> +               error_popup [mc "core.commitchar should only be one character."]
> +               unlock_index
> +               return
> +       }
> +
> +       if {$comment_char eq {}} {
> +               set comment_char "#"
> +       }
> +
> +       # If the comment character is not alphabetical, then we need to escape it
> +       # with a backslash to make sure it is not interpreted as a special character
> +       # in the regex.
> +       if {![string is alpha $comment_char]} {
> +               set comment_char "\\$comment_char"
> +       }
> +
> +       regsub -all -line "$comment_char.*(\\n|\\Z)" $msg {} msg

This regular expression is too loose. It will incorrectly change:

    line one
    line # two
    # line three
    line four

into:

    line one
    line
    line four

You could fix it by anchoring the start of the match while being
careful not to lose the newline at the start of line. Perhaps like
this:

    regsub -all -line "(^|\\A)$comment_char.*(\\n|\\Z)" $msg {} msg

However, an even better approach than doing this manipulation manually
might be to pass the commit message through `git stripspace
--strip-comments` which will do the exact normalization that Git
itself does. That way, you don't have to worry about weird corner
cases. Also, using git-stripspace may allow you to get rid of the
existing `trim` and `regsub` which precede the new code you added.
