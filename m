Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1B7C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 18:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjARSxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjARSxU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 13:53:20 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392E37560
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 10:53:19 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id b12so25211786pgj.6
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 10:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXTeBviOfZuSDX89NzNk9j87P0kfHFJPh7P7MQ8W8Bc=;
        b=cXPn9/yLUpk/vPoFDJYzV/A2w+tJd5Vd+GMhYZguJXBvTVdUi2YMqV0Q01xRREY5QQ
         Y0m0qsZhL0DWZLq5+EMjx8dMm/HckkjH7CWO/+0KGmaggdBsHSzYqwZTeHg2tXqEjmiN
         PzYptx8tbl08DEYFylSF2SCElYIF9yKUl/E5XDzWKWXZXIU9DK82TTI7z5JpYj2xLt0W
         dOHRJYSX9xqezw1p7OOPwRJT2MYGw1dGftvPjW2fi5BbHsBaGkfjg6Fw4UioSOAE631J
         Fsstc5j/SQ//zb3vTbt4PdsUjM6p1n1bz8il+igKmzKXYx9iiI4tJlsc+Fu4Zrii3MNq
         Oxeg==
X-Gm-Message-State: AFqh2kqg3WZrdGEwTwk0glXlz8IdEQRNFCXZPdnu6DJFp9bTAjKIRGsl
        co/k40DZgiJR3n5dvoWcQpbGAQf4Y3a4849TrFjaKfrTOiE=
X-Google-Smtp-Source: AMrXdXtp1sR1qmdDJ3p5NTJtNt7TFdhA9y8+jmwcIXvvA7nsSpfFWlGzM2YwBapip81Wc/GdTf5SY2LhBOAuWtAmulI=
X-Received: by 2002:a63:26c2:0:b0:477:96e2:9264 with SMTP id
 m185-20020a6326c2000000b0047796e29264mr536975pgm.422.1674067998581; Wed, 18
 Jan 2023 10:53:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1436.git.git.1673992498572.gitgitgadget@gmail.com> <xmqqr0vr6d80.fsf@gitster.g>
In-Reply-To: <xmqqr0vr6d80.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Jan 2023 13:53:07 -0500
Message-ID: <CAPig+cTrc7V+P6h039EsPwwRE4rw-qYGKHgGnGmp0TohfzHykA@mail.gmail.com>
Subject: Re: [PATCH] git: replace strbuf_addstr with strbuf_addch for all
 strings of length 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 11:14 AM Junio C Hamano <gitster@pobox.com> wrote:
> > From: Seija Kijin <doremylover123@gmail.com>
> > This helps reduce overhead of calculating the length
>
> > diff --git a/builtin/am.c b/builtin/am.c
> >       strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
> >       sq_quote_buf(&sb, state->author_name);
> > -     strbuf_addch(&sb, '\n');
> >
> > -     strbuf_addstr(&sb, "GIT_AUTHOR_EMAIL=");
> > +     strbuf_addstr(&sb, "\nGIT_AUTHOR_EMAIL=");
>
> This may reduce the number of lines, but markedly worsens the
> readability of the resulting code.  Each of the three-line blocks in
> the original used to be logically complete and independent unit, but
> now each of them depend on what the last block wants.

Very much agree with this and all your other review comments.

> > -             strbuf_addchars(dest, ' ', 2);
> > -             strbuf_addstr(dest, "From inner merge:");
> > +             strbuf_addstr(dest, "  From inner merge:");
> >               strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);
>
> Ditto, even though this is not as horrible as the change to builtin/am.c
> we saw earlier.

Additionally, if this literal string ever gets wrapped in `_(...)`,
then the above change is even more undesirable due to the extra burden
it places on translators.
