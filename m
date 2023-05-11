Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B8C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbjEKUZd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 11 May 2023 16:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbjEKUZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 16:25:26 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656649F9
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:25:08 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-61aecee26feso41280546d6.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683836707; x=1686428707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONLQMC/uVNfa88ftR/CeWHFxcDnmaDIJS4A1Rj7s1TQ=;
        b=O1695eAbqRnQ2W5AbGN6Coqm6DBk2i7AzyFK17sIbjs2yPGvPFxRTgYjcGVKDQ5+7b
         W1VsP1u6CLI8QzqcaZxEI72X7gYw9E09hPUvDU3+LtZXwHyslynJmrHBH7sIk5tPXzEK
         cT9VJjxGACYc0AdPGi4hgYMTlZ0JtVu/QJV2t9ZAOdpt+uGkuruB2zMFcdtUmH5KmY5p
         6jEzPhlfEM1+Q8eDSDZ3vT6b0Azedhis1UHFAFTymdBMYZJLFHwpzRCRRjOU8+zmBOR7
         ez8pkRsZvSdVhAKGHaX7kKUm++HrCDclxhd78cUgNXVNUsdFt9C4aVjHUgx04RViLI3d
         8CcQ==
X-Gm-Message-State: AC+VfDxSH2nwaHR1P/68YznrR71GP7K5wePmdbRtEh0Br1k/NHiuIfZt
        IWxepVsNaidqPOHf6La25HwN7we4zZ/1e8kz/Uo=
X-Google-Smtp-Source: ACHHUZ7SVXIjsMXs1cdp8DkhiTcxpqv1be/bSpHwH99L0sbz6OXhRVyHht6XTehU3yvtyfy2VRfrguumngJJ6vsuFCk=
X-Received: by 2002:a05:6214:21a1:b0:61b:5bb0:a236 with SMTP id
 t1-20020a05621421a100b0061b5bb0a236mr30600386qvc.48.1683836706914; Thu, 11
 May 2023 13:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com> <20230511194822.1493798-7-calvinwan@google.com>
In-Reply-To: <20230511194822.1493798-7-calvinwan@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 May 2023 16:24:56 -0400
Message-ID: <CAPig+cR-m45q0Y9YUnRPRzny0Q=sa4dPWCjxwHBN84VMtEsxzA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] strbuf: remove global variable
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 3:48 PM Calvin Wan <calvinwan@google.com> wrote:
> As a library that only interacts with other primitives, strbuf should
> not utilize the comment_line_char global variable within its
> functions. Therefore, add an additional parameter for functions that use
> comment_line_char and refactor callers to pass it in instead.
> strbuf_stripspace() removes the skip_comments boolean and checks if
> comment_line_char is a non-NULL character to determine whether to skip
> comments or not.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
> diff --git a/strbuf.c b/strbuf.c
> @@ -1051,10 +1052,10 @@ static size_t cleanup(char *line, size_t len)
> - * Enable skip_comments to skip every line starting with comment
> - * character.
> + * Pass a non-NULL comment_line_char to skip every line starting
> + * with it

When speaking of a character, we normally spell this NUL rather than
NULL (which is how we spell a null pointer).

The end-of-sentence period got lost in the rewrite.

Probably not worth a reroll on its own.

> @@ -1067,7 +1068,8 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
> -               if (skip_comments && len && sb->buf[i] == comment_line_char) {
> +               if (comment_line_char != '\0' && len &&
> +                   sb->buf[i] == comment_line_char) {

In this code-base, it is more common to say:

    if (comment_line_char && len && ...

rather than:

    if (comment_line_char != '\0' && len && ...

Probably not worth a reroll.

> diff --git a/strbuf.h b/strbuf.h
> @@ -544,10 +545,12 @@ int strbuf_getcwd(struct strbuf *sb);
>  /**
> - * Strip whitespace from a buffer. The second parameter controls if
> - * comments are considered contents to be removed or not.
> + * Strip whitespace from a buffer. The second parameter is the comment
> + * character that determines whether a line is a comment or not. If the
> + * second parameter is a non-NULL character, comments are considered
> + * contents to be removed.
>   */
> -void strbuf_stripspace(struct strbuf *buf, int skip_comments);
> +void strbuf_stripspace(struct strbuf *buf, char comment_line_char);

Ditto regarding NUL vs. NULL.

Rather than saying "the second parameter", readers would have an
easier time if you just spelled it out directly (i.e.
"comment_line_char").

The phrase "comments are considered contents to be removed" made sense
before the rewrite, but sounds a bit awkward after the rewrite.
Perhaps rewrite it something like this:

    Strip whitespace from a buffer. If comment_line_char is non-NUL,
    then lines beginning with that character are considered comments,
    thus removed.

May not be worth a reroll.
