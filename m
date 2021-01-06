Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1220C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E0022EBD
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbhAFG4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 01:56:11 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44550 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbhAFG4L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 01:56:11 -0500
Received: by mail-ed1-f43.google.com with SMTP id p22so3373591edu.11
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 22:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8C0oefwUHGXm1FIu+H3phimyMdzTDrTh4oYoAHMiwlI=;
        b=uPQGT9v18gzk+VcAZgiYTVkt7hkiqYjnuk7z6b/gc5RUWhZX0E4RpqUbDKbFi5LSNu
         gKDc9EXRr2VXdveagTtaq+4l5khP8L92bRnHg+M+Yd1NhgJv4f9lWk0MiO+cR71WxPUB
         DeykZwPhFKFrFC3NbTSLTIk4W04YmcYzEJdtkAgwlK9arnljK62LTVhVDoawFG+eZBfg
         2riIY8Wr2VcZ8lY7zsDfLYaFnQqCEpjuPkv4c4EKEj9ApzuoDtJ5UhBmgfKx/cOJVWML
         6acxEz/p+w/o/m/QE4XGI6JEt3Mgltt/SDQYgYjl/StHY4vODCfdj9R4mYMT9niOTm/C
         3ptw==
X-Gm-Message-State: AOAM533P6MmiKIn/0K1MP3b57eTJUsoKWcBrx0erO79X0wShEkpEtery
        vOv9HjGGBExhQ3ceiQMl2Ab0J+JLqCrFd5sti5aO5S8buuUppg==
X-Google-Smtp-Source: ABdhPJxBViiuFLwdZkmhNryC5aDuUEqcBAASyUQtzbeJeXM38COnt26bdymUPl2bE4JsNBetGyjEedKfta0EkOXvGx0=
X-Received: by 2002:a50:a692:: with SMTP id e18mr2941495edc.233.1609916129298;
 Tue, 05 Jan 2021 22:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-2-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-2-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 01:55:18 -0500
Message-ID: <CAPig+cT0hkrDBptLXNjgdzA+QMx-uGcqOLezJJ5ASGnjGTZtng@mail.gmail.com>
Subject: Re: [PATCH 1/7] worktree: move should_prune_worktree() to worktree.c
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> diff --git a/worktree.h b/worktree.h
> @@ -73,6 +73,16 @@ int is_main_worktree(const struct worktree *wt);
> +/*
> + * Return true if worktree entry should be pruned, along with the reason for
> + * pruning. Otherwise, return false and the worktree's path, or NULL if it
> + * cannot be determined. Caller is responsible for freeing returned path.
> + */
> +int should_prune_worktree(const char *id,
> +                         struct strbuf *reason,
> +                         char **wtpath,
> +                         timestamp_t expire);

A few more comments...

It would be good to update the documentation to explain what `expire`
is since it's not necessarily obvious. The documentation could also be
tweaked to say that the worktree's path is returned in `wtpath` rather
than saying only that it is returned. If you choose to make these
changes, they should be probably done in a separate patch from the
patch which moves the code. This is a very minor issue, not
necessarily worth a re-roll.

Now that this is a public function, it might make sense for `wtpath`
to be optional; if the caller is not interested in it, then NULL would
be passed in for this argument. The implementation of
should_prune_worktree() would need to be updated to check that
`wtpath` is not NULL before assigning to it. This change, too, would
be done in a separate patch. However, this is just a "would be nice to
have" item, not at all required, and I don't think it should be added
to this series since it's not needed by anything in this series, thus
would just be noise (wasting your time and reviewer time). It's just
something we can keep in mind for the future.
