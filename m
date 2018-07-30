Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762E51F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbeG3UV7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:21:59 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41949 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbeG3UV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:21:58 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so5154267ybe.8
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5sZE1KETnUQ3lyXZ7nc+Bw8A2IZcaFw9FAXGCllhwQ=;
        b=ULxg52TDcij0OH6u+dhu7UWgf6qcyQYgszKMP8PoH+aKCxLqbTcPICTr6T8on0f9lM
         pigE0TSrbY6Dhb7XSoFJPxgjh9vHXbtMRNevHfDiNFPGVXOJdyuaCXOTvPNxNqW0S3fa
         2X74KvsNSrI3N0zG3tZRccKRKN0rpFliFHKT/lLU0JkQ8rWpE7tJkslmj2kn861ep2ez
         5HzMNgGY1BEY+UIVk5VQkO+iNj9CU/p1V75nZ4O5wsyfja29yMVy6Bz30xm2uCN5QCU4
         4UZGJEZ4yO2alZvgawD1trhcOD0r5r3qG/4cvbafvLM0Phoaj2sb8ySjm1gD4dVKxfpv
         NWTg==
X-Gm-Message-State: AOUpUlGZIe+rJlT2uxiH3FICdYj4emCmqXSSceZfr1PlUShnwHJy9gp/
        qTZjWI4HX9gA+nPnVy3xYkbLTu7/2HMZgY2Days=
X-Google-Smtp-Source: AAOMgpcw5bdJiuIyk0gojNjf2Laq9zMsxEsbS/2KQX+mfEkA9uwaMjd3wpQDIGY/rRSXFUUEeDjqccZhZUfJzH3/M64=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr443311ybd.497.1532976340071;
 Mon, 30 Jul 2018 11:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180730092929.71114-1-sunshine@sunshineco.com>
 <20180730092929.71114-3-sunshine@sunshineco.com> <f079bf7b-d627-20dc-cd93-dfa3496f6877@talktalk.net>
In-Reply-To: <f079bf7b-d627-20dc-cd93-dfa3496f6877@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 14:45:28 -0400
Message-ID: <CAPig+cQyWHSmww59qP8DTyCFpbB8HdL+cnANX8uSXVsuOviBCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sequencer: fix "rebase -i --root" corrupting author
 header timezone
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Akinori MUSHA <knu@idaemons.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 8:20 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 30/07/18 10:29, Eric Sunshine wrote:
> > When "git rebase -i --root" creates a new root commit, it corrupts the
> > "author" header's timezone by repeating the last digit:
> > [...]
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -654,6 +654,7 @@ static int write_author_script(const char *message)
> > +     strbuf_addch(&buf, '\'');
> > @@ -724,7 +725,11 @@ static const char *read_author_ident(struct strbuf *buf)
> > -             sq_dequote(in);
> > +             if (!sq_dequote(in)) {
> > +                     warning(_("bad quoting on %s value in '%s'"),
> > +                             keys[i], rebase_path_author_script());
> > +                     return NULL;
>
> I think we want to handle the broken author script properly rather than
> returning NULL. If we had a single function
> int read_author_script(const char **name, const char **author, const
> char **date)
> to read the author script that tried sq_dequote() and then fell back to
> code based on read_env_script() that handled the missing "'" at the end
> and also the bad quoting of "'" if sq_dequote() failed it would make it
> easier to fix the existing bugs, rather than having to fix
> read_author_ident() and read_env_script() separately. What do you think?

That makes sense as a long-term plan, however, I'm concerned with the
immediate problem that a released version of Git can (and did, in my
case) corrupt commit objects. So, in the short term, I think it makes
sense to get this minimal fix landed, and build the more "correctly
engineered" solution on top of it, without the pressure of worrying
about corruption spreading.
