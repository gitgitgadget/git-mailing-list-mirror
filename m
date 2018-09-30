Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BDC1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 05:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeI3L5i convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 30 Sep 2018 07:57:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33358 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeI3L5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:57:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id 84-v6so6297366qkf.0
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 22:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dc1FciTJBykTUzX7rtaZ9+BG46dF7wmQ3aYW5SoP9xg=;
        b=R1b0iwnHSe8NbUE950GmbO5ckFiQWMX80X+t57yClH4FbIREjG/FNHYjoFIqulv2nv
         y4x5Ip/v6g7RH+II6mrOEg4nca8uzcyJE85FsgRLbYuxxdQZ/aTuOgX/176pGxeTm5Pf
         DI6GnEBYfIozdimcdYzoh21wIr9KP/z3hyqkB029uv5tdxjt04P81tWwk9OHEhsIyzgN
         YH7xfOyEq4Ov60gnCO/j4MdPZaKf2Qgik7UCtqAO5wFkKqbyvC8gUYQb866Pch3Nsnlc
         5T1S0Ndm6UdaI+QetkdBNmhhyr99VOtUsL0zidNL1mwTSRxLP+Z1/ga4ZWinBcojnqng
         kLeA==
X-Gm-Message-State: ABuFfoh0IuymmpiXtXzhpoWGM2IJVpqnLIA/jNbuxUjK4/j9qbpk6hsE
        cEzKx5yRsWV7mj418WogXjJ1BqiXORoywfvJPyo=
X-Google-Smtp-Source: ACcGV61iUFm1ZBrtK3NkP70V2sDO0jMinyPxqtjSv4N9LyK3+B8dCsu4+Klm4IarFVruWGVYp99uK0CtMiOlH8dfmw4=
X-Received: by 2002:a37:9f90:: with SMTP id i138-v6mr4177659qke.152.1538285165952;
 Sat, 29 Sep 2018 22:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180929191029.13994-1-pclouds@gmail.com>
 <20180929191029.13994-6-pclouds@gmail.com>
In-Reply-To: <20180929191029.13994-6-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 01:25:54 -0400
Message-ID: <CAPig+cRb=xC09z8AS=4uV9J_YDzGB3ni0RX1FT3AD+VoAu=hGg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] revision.c: better error reporting on ref from
 different worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 3:11 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Make use of the new ref aliases to pass refs from another worktree
> around and access them from the current ref store instead. This does
> not change any functionality, but when a problem arises, we would like
> the reported messages to mention full ref aliases, like this:
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -487,6 +487,28 @@ int submodule_uses_worktrees(const char *path)
> +void strbuf_worktree_ref(const struct worktree *wt,
> +                        struct strbuf *sb,
> +                        const char *refname)
> +{
> +       if (wt && !wt->is_current) {
> +               if (is_main_worktree(wt))
> +                       strbuf_addstr(sb, "main/");

I think this needs to be "main-worktree/", doesn't it?

> +               else
> +                       strbuf_addf(sb, "worktrees/%s/", wt->id);
> +       }
> +       strbuf_addstr(sb, refname);
> +}
> diff --git a/worktree.h b/worktree.h
> @@ -108,4 +108,18 @@ extern const char *worktree_git_path(const struct worktree *wt,
> +/*
> + * Return a refname suitable for access from the current ref
> + * store. The result may be destroyed at the next call.

s/may/will/
