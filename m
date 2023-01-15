Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2735DC3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjAOWPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 17:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjAOWPp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 17:15:45 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEA31B54F
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 14:15:44 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id i65so16248557pfc.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 14:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgB/9gG3pYNwuZD+CLUV74YFLsho6pYfNOL/QNJDYgU=;
        b=oIee8R7IbXtV00uCfMdtOGdgzr7CSGO0exGstddW9FarfQpDDyNdh1c6nu9/F1y/3p
         qPKbcw3CIohbWCu1o2BWQN5MyxndAYNmaBuy5qTVRXJzeJ6BeUCWXjcwyokitLZEEI41
         ZN7M+5KT2oT13TlCIpQ+Euz/kLnUmKmZeH0b/RisF30ku1XlDuHMLmZKTi5zkNUdVeVe
         0O3Ikyn2ocr16qHjJwo8PwNB4tnaFcw7kad9EyhmfPdyVsq6NglP5P2wptBNyERuQKnc
         dr8gLduhiFsxbGvnyYWBUdynTcOgADnzSaDB1qSvMisKeHV10DZGAHzzbZT0TwqBUOxV
         VrxQ==
X-Gm-Message-State: AFqh2kpiUzxf2kzgXtTc1eBPM3THP5fR7bQV2RCycnnTyWO1+7WEEexB
        g6uBxjelMbpk/VbwSmMtgd3Atb3Fr1+8NSFzm+s=
X-Google-Smtp-Source: AMrXdXtyNsyJq8XWebIgctk5h45CetH3akTG9SEeTfA6qscfE/mv0Obkma9VFjNlt91Ccel7OkDfqNAH7AGaqHr3MbM=
X-Received: by 2002:a62:445:0:b0:58b:b7f5:8806 with SMTP id
 66-20020a620445000000b0058bb7f58806mr784812pfe.1.1673820943592; Sun, 15 Jan
 2023 14:15:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673490953.git.dyroneteng@gmail.com> <f7edbd0e508243ab55c13721a21b78bf50278a21.1673490953.git.dyroneteng@gmail.com>
In-Reply-To: <f7edbd0e508243ab55c13721a21b78bf50278a21.1673490953.git.dyroneteng@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Jan 2023 17:15:32 -0500
Message-ID: <CAPig+cSt+vkjYi7L0pnE9g8WrqotT3djefaGQiCLqph6PAr=Lg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] notes.c: introduce "--separator" option
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 9:48 PM Teng Long <dyroneteng@gmail.com> wrote:
> When appending to a given notes object and the appended note is not
> empty too, we will insert a blank line at first which separates the
> existing note and the appended one, which as the separator.
> [...]
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -24,6 +24,8 @@
> +static char *separator = "\n";

If you are initializing `separator` to "\n"...

> @@ -225,6 +227,43 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
> +static void insert_separator(struct strbuf *message)
> +{
> +       if (!separator)
> +               separator = "\n";

... then these lines are not needed (and are effectively dead-code).

> +       if (*separator == '\0')
> +               /* separator is empty; use as-is (no blank line) */
> +               return;
> +       else if (separator[strlen(separator) - 1] == '\n')
> +               /* user supplied newline; use as-is */
> +               insert = separator;
> +       else
> +               /* separator lacks newline; add it ourselves */
> +               insert = xstrfmt("%s%s", separator,"\n");
> +       strbuf_insertstr(message, 0, insert);
> +}

> git format-patch a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1  --thread -v 4 --output-directory=outgoing/git-notes-append/v4 --cover-letter  --range-diff 196e80358ediff --git a/t/t3301-notes.sh b/t/t3301-notes.sh

There's some weird malformation going on here... this should just be a
"diff --git ..." line.

> @@ -521,6 +521,65 @@ test_expect_success 'listing non-existing notes fails' '
> +test_expect_success 'append: specify an empty separator' '
> +       test_when_finished git notes remove HEAD &&
> +       cat >expect <<-\EOF &&
> +               notes-1
> +               notes-2
> +       EOF

Style nit: We don't normally give extra indentation to the body of the
here-doc. Instead:

    cat >expect <<-\EOF &&
    notes-1
    notes-2
    EOF

> +       git notes add -m "notes-1" &&
> +       git notes append --separator="" -m "notes-2" &&
> +       git notes show >actual &&
> +       test_cmp expect actual
> +
> +'

Style nit: drop the unnecessary blank line before the closing quote.

> +test_expect_success 'append: specify separatoro with line break' '

s/separatoro/separator/

> +       test_when_finished git notes remove HEAD &&
> +       cat >expect <<-\EOF &&
> +               notes-1
> +               -------
> +               notes-2
> +       EOF
> +
> +       git notes add -m "notes-1" &&
> +       separator=$(printf "%s\n" "-------") &&
> +       git notes append --separator="$separator" -m "notes-2" &&

It might be easier to drop the `separator` variable and write this simply as:

    git notes append --separator="-------$LF" -m "notes-2" &&

LF is defined in t/test-lib.sh as "\n".

> +       git notes show >actual &&
> +       test_cmp expect actual
> +'
