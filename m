Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E146C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52DD2310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbhAFJAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:00:24 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41730 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAFJAX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 04:00:23 -0500
Received: by mail-ed1-f42.google.com with SMTP id i24so3702391edj.8
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpsfKmJg9bwwI/YJsTlQ2k+0wGkSIqWApQSxjkQ8t5k=;
        b=pfdpdKHFzb03fqcjmESuubfymYKwpUgSOUQZXv1Redb1K59Fp6i7b7L3kGCvlSaydY
         WmNLUspiAGjWBUTFUWpI2618TY043766R7wxeDgPaRr+ADUs+qJFqUVbgPyvM+9oJyDI
         GTXkQAHihPTR7UwoqZjw65JGpWeH/0rfQxGLv7Sp6NaYO5wH8KRFCqdBYGB0Rr62yBoT
         SwA9Wa56ZZeWX0oXnlWJODqpva98SHzg/INAsZK39/ZrCKhQEm1tvcOEL6QW4eJHKLwD
         AfBkRfyIPa3tkJJQSU62Ja9qv3h9EmJAKxOvIXjR7Zab72uJ1iPsVdgocsjlt0QQkywn
         45tA==
X-Gm-Message-State: AOAM532Jhbz24MedOeUPzXxWynrzRH5XEowhn1bs5BtFJLmnVCKsWMqL
        5MeeZM6hExiC4UF/YOhiEsTD8kE4uJu1+kcw8nw=
X-Google-Smtp-Source: ABdhPJzsoqQQQy0XCgzYmAP8fEgBjxuQCbueT6lO7HZZzX7/5znPAoHUsLFC/LsHcGEExf0kuL4hAayG9AYRk3iwpPQ=
X-Received: by 2002:a50:a692:: with SMTP id e18mr3253605edc.233.1609923581526;
 Wed, 06 Jan 2021 00:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-6-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-6-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 03:59:30 -0500
Message-ID: <CAPig+cSH6PKt8YvDJhMBvzvePYLqbf70uVV8TERoMj+kfxJRHQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] worktree: `list` escape lock reason in --porcelain
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> "git worktree list" porcelain format shows one attribute per line, each
> attribute is listed with a label and value separated by a single space.
> If any worktree is locked, a "locked" attribute is listed followed by the
> reason, if available, otherwise only "locked" is shown.
>
> In case the lock reason contains newline characters (i.e: LF or CRLF)
> this will cause the format to break as each line should correspond to
> one attribute. This leads to unwanted behavior, specially as the
> porcelain is intended to be machine-readable. To address this shortcoming
> let's teach "git worktree list" to escape any newline character before
> outputting the locked reason for porcelain format.

s/specially/especially/

> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -567,6 +567,24 @@ static int add(int ac, const char **av, const char *prefix)
> +static char *worktree_escape_reason(char *reason)
> +{
> +       struct strbuf escaped = STRBUF_INIT;
> +       char *r;
> +
> +       for (r = reason; *r; r++) {
> +               if (*r == '\r' && *(r + 1) && *(r + 1) == '\n') {

The `*(r +1)` in the middle of the condition is redundant. The same
case is already handled by the `*(r + 1) == '\n'` which follows it
since EOL ('\0') won't match '\n'.

> +                       strbuf_addstr(&escaped, "\\r\\n");
> +                       r++;
> +               } else if (*r == '\n')
> +                       strbuf_addstr(&escaped, "\\n");
> +               else
> +                       strbuf_addch(&escaped, *r);
> +       }
> +
> +       return strbuf_detach(&escaped, NULL);
> +}

As Phillip already mentioned upstream, we can use one of the functions
from quote.c rather than rolling out own here. quote_c_style(), as
Phillip suggested, is almost certainly the best choice for a couple
reasons. First, when called with CQUOTE_NODQ, it adds quotes around
the string if there are any characters which need to be escaped, but
doesn't quote the string if it contains no special characters. This
makes the output more nicely readable in the typical case when there
are no special characters, and makes it possible to distinguish the
case Phillip pointed out between literal two characters "\n" in a
string and '\n' representing a newline. Second, consumers of our
porcelain are already used to consuming strings produced by
quote_c_style().

> @@ -580,9 +598,11 @@ static void show_worktree_porcelain(struct worktree *wt)
>                 if (worktree_lock_reason(wt)) {
> -                       if (*wt->lock_reason)
> -                               printf("locked %s\n", wt->lock_reason);
> -                       else
> +                       if (*wt->lock_reason) {
> +                               char *reason = worktree_escape_reason(wt->lock_reason);
> +                               printf("locked %s\n", reason);
> +                               free(reason);
> +                       } else

It would be preferable to fold this change directly into the preceding
patch, thus eliminating this patch altogether. That way this patch
series doesn't introduce a state in which the behavior is knowingly
"broken", but instead is correct from the start. Also, since you can
use the existing quote_c_style(), the change made by this patch
becomes tiny, thus is easily folded into the earlier patch.
