Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9841BC433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595FA20795
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgJKG0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 02:26:45 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:41904 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgJKG0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 02:26:45 -0400
Received: by mail-ej1-f66.google.com with SMTP id x7so8678801eje.8
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 23:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzdV2GTdzxPUq/1JcznseA+3MGbqkWrPGIS1oGUfNzE=;
        b=OfKWnsGCM2WAka6Wps1Ba3D9+z1CiNAhV7s/ynSWC7CR8/oh9bb6HV2iQB0JFuHnAf
         DZULngc49s7F+OZmaVxfjrAQTHqFzxgZeMzwsreUzSrEy6VJglxFKbc9bNa9dz3VteKS
         NHtvO1BDPiSEFJoHvSAq/B914+bnB8bZcp7NdMZEvxe02MYfGc2umUuNCOWQwYSZu5Nq
         Z5W8Z7PE+RyCZ/TwHNdBwr5UL2WCfdNvDj+MCQ6UP/RQ2d32bbRXCZXPIcEHrcgds7j6
         93DvsRsoFmZQvsuG2i+od4JaEDEBvUL4SxssnMtVMgmrog68rqniOnIgmXcTp1g/Q4Sj
         AQjg==
X-Gm-Message-State: AOAM532Gk8ETpvfvjacXih5MQng50wtdP4XiyRfoRihyb7NseI/dxNP+
        s81ILU5jORjpepIJhDeZcxwZJD7Vpw3wuKysZFU=
X-Google-Smtp-Source: ABdhPJxJz/aeea1yh0r7FIZYh0/Qsu6OExxx7mmiphib5dx6QJSLHJuuyJARkJEwR/RJ6wAI50e80TQTQ5Q/s6UylKw=
X-Received: by 2002:a17:906:5f96:: with SMTP id a22mr22149194eju.168.1602397602558;
 Sat, 10 Oct 2020 23:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <20201010185521.23032-1-rafaeloliveira.cs@gmail.com> <20201010185521.23032-2-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20201010185521.23032-2-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Oct 2020 02:26:31 -0400
Message-ID: <CAPig+cTq5tz8m0bCJ3GtCa9yzOMNvd7j4fSJNwO9xjqkfK+YOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] worktree: teach `list` to annotate locked worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 10, 2020 at 2:56 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> The "git worktree list" shows the absolute path to the working tree,
> the commit that is checked out and the name of the branch. It is not
> immediately obvious which of the worktrees, if any, are locked.
>
> "git worktree remove" refuses to remove a locked worktree with
> an error message. If "git worktree list" told which worktrees
> are locked in its output, the user would not even attempt to
> remove such a worktree or would know how to use
> `git worktree remove -f -f <path>`

I would drop "how" from "would know how to" so it instead reads "would
know to" since seeing the `locked` annotation only lets the user know
that removal must be forced; the `locked` annotation doesn't teach the
user _how_ to remove the worktree using force. But, perhaps, my
original suggestion[1], which did not use "how", was confusing. Maybe
it could be worded instead:

    ... not even attempt to remove such a worktree, or would
    realize that `git worktree remove -f -f <path>` is required.

Anyhow, this is a very minor nit about the commit message; not
necessarily worth a re-roll. More comments below...

[1]: https://lore.kernel.org/git/CAPig+cQHDuWy1vc_ngXbMQZQ=a9fd6S5_cCU-2sb_+Te5aEOhw@mail.gmail.com/

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -97,7 +97,8 @@ list::
>  List details of each working tree.  The main working tree is listed first,
>  followed by each of the linked working trees.  The output details include
>  whether the working tree is bare, the revision currently checked out, and the
> -branch currently checked out (or "detached HEAD" if none).
> +branch currently checked out (or "detached HEAD" if none). For a locked
> +worktree the `locked` annotation is also shown.

I might have dropped the "and" in the final context line and instead
written this as:

    ... branch currently checked out (or "detached HEAD" if none),
    and "locked" if the worktree is locked.

But not worth a re-roll.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -676,8 +676,11 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
>                 } else
>                         strbuf_addstr(&sb, "(error)");
>
> +       if (!is_main_worktree(wt) && worktree_lock_reason(wt))
> +               strbuf_addstr(&sb, " locked");

I was going to ask if "locked" should be localizable like this:

    strbuf_addf(&sb, " %s", _("locked"));

but I see that none of the other words ("bare", "detached", "error")
in this function are localizable, so this is fine as-is.

However, all of the other human-consumable text emitted by "git
worktree" is localizable, so making these strings localizable, as
well, is something that can be added to a To-Do list. Note that I'm
talking only about human-consumable "git worktree list" output, not
porcelain format. Also, I'm not suggesting you tackle it, and it's
certainly not something that this patch or patch series needs to do;
just something which someone can tackle in the future.

> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -61,6 +61,16 @@ test_expect_success '"list" all worktrees --porcelain' '
> +test_expect_success '"list" all worktress with locked annotation' '
> +       test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
> +       git worktree add --detach locked master &&
> +       git worktree add --detach unlocked master &&
> +       git worktree lock locked &&
> +       git worktree list >out &&
> +       grep "/locked *[0-9a-f].* locked" out &&
> +       ! grep "/unlocked *[0-9a-f].* locked" out
> +'

These grep invocations are a bit loose, thus concern me a little bit.

First, in Junio's original example of using grep[2], he had two spaces
after the path component, not one as you have here. The two spaces in
the regex ensure that there is at least one space separating `/locked`
and `/unlocked` from the OID hex string, whereas with just one space
in the regex, as is done here, the space following the path component
is entirely optional (thus is a less desirable regex).

Second, because these regexes are not anchored, they could match with
a false-positive if the person's TRASH_DIRECTORY path is something
like `/home/proj/unlocked dead locked/git/t/...`. If you anchor the
pattern with `$`, then this problem goes away:

    grep "/locked  *[0-9a-f].* locked$" out &&
    ! grep "/unlocked  *[0-9a-f].* locked$" out

Third, this is checking only that the first character following the
path component is a hex digit but then accepts _anything_ before
"locked". The regex can be tightened to allow only hex digits:

    grep "/locked  *[0-9a-f][0-9a-f]* locked$" out &&
    ! grep "/unlocked  *[0-9a-f][0-9a-f]* locked$" out

[2]: https://lore.kernel.org/git/xmqq3631lg8f.fsf@gitster.c.googlers.com/
