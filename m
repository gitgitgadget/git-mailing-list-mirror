Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2DC43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 04:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9B120829
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 04:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIMEuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 00:50:16 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43715 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgIMEuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 00:50:12 -0400
Received: by mail-ed1-f54.google.com with SMTP id n13so14336800edo.10
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 21:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtkqVkxYGJOivGh0bZaAzDo8g6dKWXpZis2cfb4FeqI=;
        b=HLg5yB7vOuAfhoi7pWwDPMkOAVv2tr1r8MFFBVAJ/MhFiyskLU8rS+cUfIPX97eAzZ
         CVsnB33HS2csMfPGSmSWp3et2ZuM8eaBHmyt3Yq2frSftpGz4dvJqoQn0fQA3Vo9yuJi
         q6Ey0zIGUOBzixYHFOO/2rpG3oJ9Azwl0HlYUeolr2cct8z4hqjyOLCjKAtetkpqgsOM
         CPyR1nCav+QTVBklKJUrGVCGGU6ZPG1bpZ/gpDIMV2vQn37/mjyB4gdzr+2ipwxzcEvP
         /pFpVjrDF8D9SePwGT9+wJEBMUlOXobXUKwAB6L9Y5Q87oP3zC6uacHTCju77lsKY1EK
         LvcQ==
X-Gm-Message-State: AOAM531IAdiUYcB6KjwMatLqjlBnQa89WJA/LEjwSIpq99UKVEeoYE4T
        HS176fOnkFUV6VoXbzXhyYJeNuSEU1cmWPsnk00=
X-Google-Smtp-Source: ABdhPJysNHZ23AdWwQ5SbcemEKZEHz7dQ8bwTJfTHX9YkPmsFRCY+MMWvI1l6Uqkc3/YO303KLJMULzAUynoLa0yH6Q=
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr11303733edo.181.1599972610600;
 Sat, 12 Sep 2020 21:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <3b57a5b2-a34e-de95-38c7-9bc6923a8eba@yandex.ru>
In-Reply-To: <3b57a5b2-a34e-de95-38c7-9bc6923a8eba@yandex.ru>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Sep 2020 00:49:59 -0400
Message-ID: <CAPig+cRqkzPzNX8UN4OcgEOOKbtZRLCjNNiZsOVkGBy0pvsEkQ@mail.gmail.com>
Subject: Re: Worktrees attached to bare repo don't work
To:     Lobachevksiy Vitaliy <numzer0@yandex.ru>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 12, 2020 at 4:01 PM Lobachevksiy Vitaliy <numzer0@yandex.ru> wrote:
> I have a bare repository and several worktrees attached to it. That was
> working fine until recent update. Now when I try virtually any git
> command like `git status` in any attached worktree, or even in a new
> one, it prints `fatal: this operation must be run in a work tree`.
> The workaround is simply `git config --worktree --add core.bare false`
> in each worktree.

This is happening because you have apparently set the configuration
variable extensions.worktreeConfig to true. As far as I can tell by
reading the "Configuration File" section of the "git worktree"
documentation and by consulting the commit[1] which introduced
extensions.worktreeConfig, this is working as intended. According to
the "git worktree" documentation, configuration core.bare is no longer
specially filtered out when inside a worktree once
extensions.worktreeConfig is enabled, so you need to move the
core.bare=true setting out of the bare.git/config and into
bare.git/config.worktree to prevent the worktrees from seeing that
setting. Once that's done, you don't need the per-worktree
core.bare=false setting you've been using as a workaround.

[1]: https://lore.kernel.org/git/20181021140228.24941-3-pclouds@gmail.com/
