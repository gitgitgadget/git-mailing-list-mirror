Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C49E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbeGaMSe (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:18:34 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42281 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaMSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:18:34 -0400
Received: by mail-yb0-f194.google.com with SMTP id c10-v6so5939291ybf.9
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 03:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wKxbAAkNU8OIapZpizYbBDZjvNpxYnGqT3C3UWDTHc=;
        b=sQcmEi8IZfz3ZvrBwsxF8AuFfX9P6Am+zmPNRiUgE98+T3z8hbmWc6mk1ZrJ7xYkyJ
         7/z7UFzp31f5D15xU6EYx1wU5eg8R5fH0WgykQKcRqEZRvupyssllRjgk5hDknpKlK6q
         m7D9YMwHHxhMxN7bJsh4nEWukvX9xb3BTJmDcqG4EPxhOXZdlbIlbyrXVhSLLLCFTWtZ
         OU/IHhOrii6pwNsMQFldyRsGtfJktEe1NeRpdNjfwcplFPYMm1qvMQQUMYaNPRjP+jb8
         tIcLpfm7bZ7NeXva87Mq30H7fgs+xUmtalPEuqaz5qKlapBQxhrqYjB/FJ58gQsP5Mq8
         rTbQ==
X-Gm-Message-State: AOUpUlE+2YcsgAyJrAds2uZ6mQ5vwxq2VIKe67riouRMcfkHQiTCvbeI
        fgI0wiH3WD88akjFMP70Nw6Lupi9UiXWsrVjNco=
X-Google-Smtp-Source: AAOMgpfXR5zGfSioouMMWzlVq4EdGDvAc16J+Z5pm1bcqu4LLrHderjvpG5rT6megG5SSHfajpyYWtZXvn0wlKXRecc=
X-Received: by 2002:a25:9b03:: with SMTP id y3-v6mr11070924ybn.194.1533033532604;
 Tue, 31 Jul 2018 03:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731073331.40007-5-sunshine@sunshineco.com> <71924f65-1890-0460-55a1-987354807c7d@talktalk.net>
In-Reply-To: <71924f65-1890-0460-55a1-987354807c7d@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 06:38:41 -0400
Message-ID: <CAPig+cShUNYTZ_fcqdNFAGtRipt8kwaufVuD5rXmgU6P73epeQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] sequencer: don't die() on bogus user-edited timestamp
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 6:02 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 31/07/18 08:33, Eric Sunshine wrote:
> > +     /* validate date since fmt_ident() will die() on bad value */
> > +     if (parse_date(val[2], &out)){
> > +             warning(_("invalid date format '%s' in '%s'"),
> > +                     val[2], rebase_path_author_script());
> > +             strbuf_release(&out);
> > +             return NULL;
> > +     }
>
> I think if you're going to do this then the caller needs to be changed
> to treat NULL as an error

I humbly disagree for the reasons outlined in my response[1] to your
review of 2/4. Summarized, this function already returns NULL in
several cases upon error, so the change made by this patch is
consistent with existing behavior (and certainly doesn't make the
situation worse). This patch series is about fixing the critical bugs
resulting in genuine commit object corruption; it's not about
re-engineering a case which was perhaps not thought through thoroughly
(changing commit data unexpectedly) but which does not genuinely
corrupt the commit object itself.

[1]: https://public-inbox.org/git/CAPig+cRu6fi_SG7LeTBjAWG8aoCT7LmSipDq2a9bPR0_Ae1pFg@mail.gmail.com/
