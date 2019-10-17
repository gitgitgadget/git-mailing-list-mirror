Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3961F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395495AbfJQSIZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 17 Oct 2019 14:08:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45812 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395417AbfJQSIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 14:08:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so3387838wrm.12
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 11:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iNc97HD4gu2snya4IP4/iT49Hy81necaSBmlNpCEuik=;
        b=rn3ehKipxRt3vPJ7lCnTVzSJ/2KndDrnEd/Xwdex+e4sUeHnBwVeq0bS7eWeSfhc5j
         7vUQQnkfiFWhAkqXqrNEHQSQ91lNUIE320BJVSJ0xlW3pLcvMrx9Wp75LITM53hsvTRU
         d6mOtn7R8MCyKwze3hPu572/8ULe8H0/siqCpb5ofjfzOK6Eh2AbKsQqJAYLGK/DIPOo
         oDB0gs86tkJG+sSN/69WPvcwwx5D2Gw5Il0+gxdcQPppZfvGk+0tUr4z9chOsy7rOFWh
         RmyYG1FWIleE5gU7Wnij7+087TPVSbtd1Wg4bjdmM7DUCoBZG6Bpb5sTFt1bfyWLc15O
         RIwQ==
X-Gm-Message-State: APjAAAVxc/xXlm84sGevzVwkAVki3Gz/8FYWerN5+5nNIjOn1L51Zd2i
        aKUuX49jurjOXkN9/Rwd3nutxc9dkMWpKu16EwI=
X-Google-Smtp-Source: APXvYqz45vhFoYe5fkCGbC5Bkw/6JBVutXQ4FjcOHeIsf81vd0RR/c3l/4/XHEmS1uYOlSSbppfqKqsB+Jgy+IgqWSs=
X-Received: by 2002:a5d:430d:: with SMTP id h13mr4123203wrq.163.1571335703471;
 Thu, 17 Oct 2019 11:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173501.3198-1-szeder.dev@gmail.com> <20191017173501.3198-6-szeder.dev@gmail.com>
In-Reply-To: <20191017173501.3198-6-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 14:08:12 -0400
Message-ID: <CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com>
Subject: Re: [PATCH 5/6] completion: list existing working trees for 'git
 worktree' subcommands
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 1:35 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> Complete the paths of existing working trees for 'git worktree's
> 'move', 'remove', 'lock', and 'unlock' subcommands.
> [...]
> Arguably 'git worktree unlock <TAB>' should only complete locked
> working trees, but 'git worktree list --porcelain' doesn't indicate
> which working trees are locked.  So for now it will complete the paths
> of all existing working trees, including non-locked ones as well.

It is a long-standing To-Do[1] for "git worktree list [--porcelain]"
to indicate whether a worktree is locked, prunable, etc. Looking at
the implementation of builtin/worktree.c:show_worktree_porcelain(), it
should be easy enough to add. (Adding it for the non-porcelain case
would perhaps require more thinking and design since we might want a
--verbose option to trigger the extra information.)

[1]: https://public-inbox.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/

> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> @@ -2981,10 +2981,21 @@ _git_whatchanged ()
> +__git_complete_worktree_paths ()
> +{
> +       local IFS=$'\n'
> +       __gitcomp_nl "$(git worktree list --porcelain |
> +               sed -n -e '2,$ s/^worktree //p')"
> +}

I know that the commit message talks about it, but it might deserve an
in-code comment here (or a function-level comment) explaining why the
first line of "git worktree list --porcelain" output is thrown away
since it's not necessarily obvious to the casual reader.
