Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA5CC677F1
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 05:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjAOEyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 23:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjAOEyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 23:54:09 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8602493FC
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 20:54:08 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id v23so22335647plo.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 20:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZiOqxh+nzPqSZSHyZSAsVTApDvph5cSod1GYasuogk=;
        b=1hW+tcXu7rLsHiOW865LO/UPCTNeaJTBUQwNJXeSq2KCiYDp/TxRlLjK/slWW+US1G
         DSV6nz2olzGqY3T1SxrCYLXAe+3iVfavhF9swSSibEPizrree2x2v1mepkpgJKw5YisI
         xZe/AUnBrPhZUrgsttwNok2ChUlg0VJoQFc9q+eXI3ixLpVosl+fNEro2w7/6nxAln82
         ia6iWXEy2gqrq/Ehgz8jLYG+Y2Ip9TnU4By71Pm4vetmUj33eijndgloZ/uK+JdRmeTZ
         PokYr9Owo2OIh/ATM/6SO427dbFaxuD9wAFkh/uHZxlyaF1f0UM6JY4GE4Z9qUlPzwTd
         jtWQ==
X-Gm-Message-State: AFqh2kpPBHxMRx7FCQZHYxWXNGH+pZ8QvsKHQNFWct7WRFtAerVzS/LB
        qYG07C0zagajZ3/pfGoOqbAYMeSwofL0UiO7eD/BoU7qpik=
X-Google-Smtp-Source: AMrXdXuRqw8Qg7tHUGD+SJV12U7B/LwmjKedUbOTP4kJ1LGUb6H/dadCq+mMu2mY0Rmugj2v3siJLCaHMTAPW+gcEUQ=
X-Received: by 2002:a17:902:bd48:b0:194:8707:7a3 with SMTP id
 b8-20020a170902bd4800b00194870707a3mr185439plx.36.1673758447895; Sat, 14 Jan
 2023 20:54:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673490953.git.dyroneteng@gmail.com> <f00a7596587bbf2d055dbf77a19506be1a6350fd.1673490953.git.dyroneteng@gmail.com>
In-Reply-To: <f00a7596587bbf2d055dbf77a19506be1a6350fd.1673490953.git.dyroneteng@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 14 Jan 2023 23:53:56 -0500
Message-ID: <CAPig+cQKJxJCwk1GWtQ=LNNA=z9tQxYUwn9CMcXE4R9g8eKU7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 9:48 PM Teng Long <dyroneteng@gmail.com> wrote:
> Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
> "strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
> needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
> "\n");" will do the "grow" for us.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -618,7 +618,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>                 char *prev_buf = read_object_file(note, &type, &size);
>
> -               strbuf_grow(&d.buf, size + 1);
>                 if (d.buf.len && prev_buf && size)
>                         strbuf_insertstr(&d.buf, 0, "\n");

Indeed, it's not clear why that was there in the first place. Digging
through history doesn't shed any light on it. It was introduced by
2347fae50b (builtin-notes: Add "append" subcommand for appending to
note objects, 2010-02-13)[1], but there's no explanation as to why it
was coded that way. Best guess may be that the author originally
inserted "\n" manually by direct manipulation of the strbuf rather
than employing a strbuf function, but then switched to strbuf_insert()
before submitting the series and forgot to remove the now-unnecessary
strbuf_grow().

[1]: https://lore.kernel.org/git/1266096518-2104-26-git-send-email-johan@herland.net/
