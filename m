Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E82C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4C9613FA
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbhDUXrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:47:02 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43804 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbhDUXrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:47:00 -0400
Received: by mail-ed1-f47.google.com with SMTP id e7so51201865edu.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 16:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mG6lS7FTLFkKIiJyfUROEsCMXRNNpinCwmjXgGtrg28=;
        b=O8lCog8cNRcMCbon9oSbKO9DMPEW5Ep+dHLqMNZg7/ENhuu2IH6moOkkDNrP9bHdzR
         YlCgUeVvdCZij90vuKW/FaQRFQ8tPjtKsqCyWf1+rcqFupeATIysi5O3ycNAx2PiDLiy
         zEFPWewYTnJ+iM73I5uOV9oJnWsi/JJVJTJcvRCL+LsuUQWwWIuv7HCU1qx9NIRAe5h+
         IE6OWVfk7emaujsYYFB2jsgoAzxQJpSkxpTav/tY2jD142GexED0DgPPT1i4MKgNeyhW
         XddI+eLZL3A6lAEd48QBfNVBdLBqTgawNyWxxOV8SyONT7QLZ1tn/BucZFa4BKIRMQaZ
         z9cA==
X-Gm-Message-State: AOAM533X2VmXyTFdnshHoGGXdb5X+NDpsLIHiA9gBddNPNHFY4VxDfqT
        fpPD5DgpmzdlyJGkl9YAdUG9RRWpQBKUuudsRYNDejaHTj0TZQ==
X-Google-Smtp-Source: ABdhPJzPGNqQNEi4jTkVptgSy6ygHhRpf5EFaWEoiEpQ0Rdv97jTGDWoGjZkOcdvxBkF/L3T8xyk8epn0eoAUOEw67Q=
X-Received: by 2002:a05:6402:488:: with SMTP id k8mr476526edv.233.1619048785507;
 Wed, 21 Apr 2021 16:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.934.git.1618770806366.gitgitgadget@gmail.com> <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
In-Reply-To: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Apr 2021 19:46:14 -0400
Message-ID: <CAPig+cT=xeLn9KNHz7hiNWo0QTfc1zZ1X-czJ4n503RRhBA0XQ@mail.gmail.com>
Subject: Re: [PATCH v2] git-merge: move primary point before parenthetical
To:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 7:22 PM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Usually, it is easier to read a message if it makes its primary
> point first, before giving a parenthetical note.
>
> Before:
> ` (nothing to squash)Already up to date.
> `
>
> After:
> `Already up to date (nothing to squash).
> `

Thanks. This makes perfect sense and fixes what clearly seems to be a
case of swapped arguments to printf(). While the intent of the patch
is quite desirable, I do have some concerns about the actual
changes...

> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
> diff --git a/builtin/merge.c b/builtin/merge.c
> @@ -383,7 +383,7 @@ static void restore_state(const struct object_id *head,
>  static void finish_up_to_date(const char *msg)
>  {
>         if (verbosity >= 0)
> -               printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
> +               printf(msg, squash ? _(" (nothing to squash)") : "");
>         remove_merge_branch_state(the_repository);
>  }
> @@ -1482,7 +1482,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> -               finish_up_to_date(_("Already up to date."));
> +               finish_up_to_date(_("Already up to date%s.\n"));
> @@ -1566,7 +1566,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> -                       finish_up_to_date(_("Already up to date. Yeeah!"));
> +                       finish_up_to_date(_("Already up to date%s. Yeeah!\n"));

I see why you changed the calling convention, making it the
responsibility of the caller to supply the "%s" so that the "(nothing
to squash)" annotation gets inserted before the period at the end of
"Already up to date". However, this makes things confusing for people
translating the text to other languages since they won't have enough
context to understand what gets interpolated in place of "%s".

In fact (not a fault of your patch), this sort of "sentence Lego" was
already a bit difficult on translators because they couldn't see the
entire context of "Already up to date" and "(nothing to squash)"
together, thus could only translate them individually which may have
led to inferior translations in some languages.

Ideally, for the sake of translators, we want to give them as much
context as possible, such as the entire "Already up to date (nothing
to squash)". So, keeping translators and context in mind, and asking
if we really need to that rather odd "Yeeah!", an alternative way to
resolve this problem would be like this:

    static void finish_up_to_date()
    {
        if (verbosity >= 0) {
            if (squash)
                puts(_("Already up to date (nothing to squash)."));
            else
                puts(_("Already up to date."));
        }
        remove_merge_branch_state(the_repository);
    }

And then the callers reduce simply to:

    finish_up_to_date();
