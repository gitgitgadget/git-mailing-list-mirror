Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5143AC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ABA2220B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgKQW4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:56:45 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44717 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgKQW4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 17:56:44 -0500
Received: by mail-ej1-f67.google.com with SMTP id y17so26123634ejh.11
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 14:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gifsoKaoHSnljqINSttDH9XRvqCiSdCsnDGhk5YbX7g=;
        b=X4jngWW+6maZoPMfPPV/BcI5TpJkBHSuuvcklQkAKvLc6MPMSssKfOEIewVSxx4JL8
         CtUWWyPPBvtVRHGA3dkQfkppWNOYk/ueL9rb8WARR8LHJaTAED4V22fLqhc8DKOrZGuf
         m6NbrpxCFvTqKSMHMmAkeYwjLPsmL6RPnTOGJJDlkw0AIq+y0a5jy8MjqmwtfDDigTO1
         tTkJ69mB/n5zvJXWzFKeuvyA1XTwNZoEGDH1TjgTJDEEaNO2WXcN1QNklZ35h7dXgxfV
         dRzqv2DE7dJjLsdniksF8/1NAg+4bwQf2dgc0hsoSYQpAWaZoeMOjk/WSXpOfRtxK/5D
         jdsg==
X-Gm-Message-State: AOAM533C5Y7lmuTceZN4XNCTDYPx7S8GyX7Kbp7RkQRI6pgEH8x7k5n5
        mqGT7B1IlS9zTUrItluxxkeD0bfMNmlDOnMb/po=
X-Google-Smtp-Source: ABdhPJzMEbdJv3JRErIm83jLBH/wfVSOOufqP1wEQdu6+pKcg/uFGP05Caiqf9hmQLmR2e5Fm6C2tKcKV4kdU99sdd8=
X-Received: by 2002:a17:906:4944:: with SMTP id f4mr21199062ejt.231.1605653802498;
 Tue, 17 Nov 2020 14:56:42 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmtzvikwi.fsf@gitster.c.googlers.com> <20201117213551.2539438-1-aclopte@gmail.com>
 <20201117213551.2539438-3-aclopte@gmail.com>
In-Reply-To: <20201117213551.2539438-3-aclopte@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Nov 2020 17:56:31 -0500
Message-ID: <CAPig+cR3XRWYmRTETWfEMSdg+Ri-L0LZzhNMavg4FCkDC19qdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] range-diff: ignore context-only changes
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 4:38 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
> range-diff compares matching commits by comparing their patches against
> each other. When two patches only differ in their context lines, that
> difference would still show up in range-diff's output.
>
> This commit uses diff's new -I/--ignore-matching-lines regex logic to ignore
> diff hunks that only consist of changes to context lines in the input diffs.
>
> Thanks to the previous commit, lines like "## file => renamed-file ##"
> are not considered context lines because they no longer have a leading space.
>
> This gives some extra @@ lines because we now always calculate
> two diffs: one for the patch metadata, like the commit message,
> and another one for the actual file changes.
> This is because the former contains lines with leading spaces that are not
> context lines, so we never want to ignore them.
> ---

Signed-off-by: is missing from all of your patches.

Just a few lightweight style-related review comments below (I didn't
read the patch any deeper than that)...

> diff --git a/range-diff.c b/range-diff.c
> @@ -363,6 +363,31 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
> +static int are_diffs_equivalent(const char *a_diff, const char *b_diff) {
> +       for (
> +               const char
> +                       *a_eol = strchr(a_diff, '\n'),
> +                       *b_eol = strchr(b_diff, '\n');
> +               (a_eol = strchr(a_diff, '\n')) &&
> +               (b_eol = strchr(b_diff, '\n'));
> +               a_diff = a_eol + 1, b_diff = b_eol + 1
> +       ) {

This project doesn't yet declare variable as part of 'for', so:

    const char *a_eol = ...;
    const char *b_eol = ...;
    for ( ; (a_eol = ...) & (b_eol = ...); a_diff = ..., b_diff = ...) {

> +               if (!!a_eol != !!b_eol)
> +                       return 0;
> +
> +               // Ignore context lines.
> +               if (a_diff[0] == ' ' && b_diff[0] == ' ')
> +                       continue;

Avoid //-style comments. Use /* comments */ instead.

> +               size_t a_len = a_eol - a_diff;
> +               size_t b_len = b_eol - b_diff;

This project doesn't yet allow mixing declarations and code. Instead
place the declarations at the top of the scope:

    for (...) {
        size_t a_len;
        size_t b_len;
        ...
        a_len = ...;
        b_len = ...;

> @@ -390,8 +415,10 @@ static void output_pair_header(struct diff_options *diffopt,
> -       } else if (strcmp(a_util->patch, b_util->patch)) {
> -               color = color_commit;
> +       } else if (a_util->diff_offset != b_util->diff_offset
> +                  || strncmp(a_util->patch, b_util->patch, a_util->diff_offset)
> +                  || !are_diffs_equivalent(a_util->diff, b_util->diff)) {
> +               color = color_commit;

Style on this project is to break line after || operator rather than before:

    if (... ||
        ... ||
        ...) {

> @@ -467,6 +494,14 @@ static void output(struct string_list *a, struct string_list *b,
> +       regex_t regex;
> +       if (regcomp(&regex, "^ ", REG_EXTENDED | REG_NEWLINE))
> +               BUG("invalid regex");
> +       ALLOC_GROW(diffopt->ignore_regex, diffopt->ignore_regex_nr + 1,
> +                  diffopt->ignore_regex_alloc);
> +       diffopt->ignore_regex[diffopt->ignore_regex_nr] = &regex;
> +       size_t ignoring_context_only_changes = diffopt->ignore_regex_nr + 1;

Should you be calling regfree(&regex) at the end of the function?
