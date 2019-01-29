Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E5D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfA2Uxw (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:53:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44649 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2Uxw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 15:53:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so23840130qte.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 12:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f69hw/lA+q2XcZtozZ/WfD2hclyTMfRAHP5wQzHasyc=;
        b=juSnDn4lstFgGpBH6Wm6pY861szMi5rXtX03HD0lucHsN3zlkxXX3QRxqH7mQ1GZ8k
         AoOF4/4IXDPpo9gKOE2VTG99VeKPNjl+MXIEEKs6lHmZkhSzNx7/VpOn6pkk30+xOFAX
         ZREu5Zx0E7zUn5P5QWP0zPMxTMBB9/wPfnYept9DSBOlpXZ2x35Jdf0T9U3yXTgIZGel
         4yQdFoeAxy+GhUlxM9+xcRdsyGpNEtWzOJTCinkDzh6zkaPbGW2fd2BzYGDpiMWKqPPl
         GYpWOW+gyvaqt5Kpcss+2h2qv9OotfQKXVorcDoXjbNoa0pTokOGm+iBZcCgcjC+/h1f
         uqLA==
X-Gm-Message-State: AJcUukf2pbSY1l2uc8RezNrjJxF4cEkLoMN39eA8CukzYMHdUX+a16zE
        Be2me4pUVNyteYVFKrwWWl7MeIcyFIpx7I5vXsdr96Ol
X-Google-Smtp-Source: ALg8bN6R/jpjrmiN5KopPj4JSflbYlnfXnDQgXO8PehfpNtxCi6hElOMv7HeNI3p1mac5ZeajxJ9arymTsoIddOvwuM=
X-Received: by 2002:a0c:981b:: with SMTP id c27mr26855835qvd.184.1548795231439;
 Tue, 29 Jan 2019 12:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20190129051859.12830-1-koraktor@gmail.com> <20190129051859.12830-2-koraktor@gmail.com>
 <20190129131151.GB22211@sigill.intra.peff.net>
In-Reply-To: <20190129131151.GB22211@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 29 Jan 2019 15:53:40 -0500
Message-ID: <CAPig+cRUCmaiYqKG6ON==g1sFph-hz6nK5fTYc-9w2JaNFmdLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Setup working tree in describe
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Staudt <koraktor@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 8:12 AM Jeff King <peff@peff.net> wrote:
> On Tue, Jan 29, 2019 at 06:18:58AM +0100, Sebastian Staudt wrote:
> > This ensures the given working tree is used for --dirty.
>
> There's been a lot of digging and discussion on the list about what
> happens if we don't do this. Could we summarize it here?
>
> Perhaps:
>
>   We don't use NEED_WORK_TREE when running the git-describe builtin,
>   since you should be able to describe a commit even in a bare
>   repository. However, the --dirty flag does need a working tree. Since
>   we don't call setup_work_tree(), it uses whatever directory we happen
>   to be in. That's unlikely to match our index, meaning we'd say "dirty"
>   even when the real working tree is clean.
>
>   We can fix that by calling setup_work_tree() once we know that the
>   user has asked for --dirty.

I have not particularly been following this thread, but this proposed
commit message does an excellent job of summarizing and explaining the
issue and making the fix obvious (so, now I don't have to go back and
read the entire thread).

> > The implementation of --broken uses diff-index which calls
> > setup_work_tree() itself.
>
> If I hadn't just read the rest of the thread, I'd probably wonder why we
> are talking about --broken at all. Maybe:
>
>   The --broken option similarly needs a working tree. But because the
>   current implementation calls an external diff-index to do the work,
>   we don't have to bother setting up the working tree in the
>   git-describe process.

This rewrite left me slightly in the dark since I had to infer that
git-diff-index calls setup_work_tree() itself. Perhaps:

    ...an external diff-index to do the work, which itself calls
    setup_work_tree(), we don't have to bother...

But that's minor.
