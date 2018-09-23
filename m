Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F021F453
	for <e@80x24.org>; Sun, 23 Sep 2018 08:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeIWOW3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 10:22:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42411 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeIWOW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 10:22:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id z8-v6so5905622qto.9
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 01:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rXnoPPlDC5dNhZZ1uUBjp4TL/eGT3ssUsNr8DMazKEw=;
        b=Mm2WZim7T1WFaOGtgGP2t7awU1xQM3fD7qMQVDph5jDNNzg4NaoAsNtMCcQr9foBim
         fuFqGsUwZwRjmQ2wNPO9ditEK6L+YSC4POBpLfDl3CWItJzsoUuRf/RMtyMguKQ7K/b0
         sSKIqPlHJ24tI8xQpdkqzWFpREbgyhtjP//IHi+3m8STtNWNG9bNirq1GJ/AO2GR6ZMw
         XBOaYkH+Cn0VeA6tRBYsXiihZpL5ZX+z28YKWJ7QAa/TqCDIobRairDBTf+L0ajyg4Rq
         I9NiwgGG1/4EOUYr/0tRArf+PSmBgNUsjGKwtbPM2jJm4K50yO2cVJJoemY7t9H31S59
         uygA==
X-Gm-Message-State: ABuFfogljJP38TC5ouyksBg9ueQP8YTC4UBrO1WGmAXkhADWkCrmYAzx
        gJVG28WaRQjTMz8KwROl3p+my75wN5XUoMUaeCh17qup
X-Google-Smtp-Source: ANB0VdZ/LjpE3EOEBf0Liixo5h7JsnGSjpHyfMe/6kRiLGzcpqw4rePUNMcy4vaDYwrBGjshzmDS1vyigWblaCCsoJ8=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr3606215qtd.101.1537691149610;
 Sun, 23 Sep 2018 01:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-6-pclouds@gmail.com>
In-Reply-To: <20180922180500.4689-6-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Sep 2018 04:25:39 -0400
Message-ID: <CAPig+cTZpgU_n78wG4W0PDvM7Xdr3-1DoHz4d25XBFUmUy7a+A@mail.gmail.com>
Subject: Re: [PATCH 5/8] revision.c: better error reporting on ref from
 different worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 2:05 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Make use of the new ref aliases to pass refs from another worktree
> around and access them from the current ref store instead. This does
> not change any functionality, but when a problem shows up, we would
> report something like

From this description, I had a hard time grasping that the first
example output is the desired one. Not necessarily worth a re-roll,
but had it said instead something like this:

    ...but when a problem arises, we would like the reported
    messages to mention full ref aliases, like this:

it would have been more obvious.

More below...

>     fatal: bad object worktrees/ztemp/HEAD
>     warning: reflog of 'main/HEAD' references pruned commits
>
> instead of
>
>     fatal: bad object HEAD
>     warning: reflog of 'HEAD' references pruned commits
>
> which does not really tell where the refs are from.
>
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
> +               else
> +                       strbuf_addf(sb, "worktrees/%s/", wt->id);
> +       }
> +       strbuf_addstr(sb, refname);
> +}

Seeing this use worktree->id to construct "worktrees/<id>/<refname>"
makes me wonder how the user is going to know the ID of a worktree in
order to specify such refs in the first place. For example, how is the
user going to know the <id> in "git rev-parse worktrees/<id>/HEAD"? I
don't think we print the worktree ID anywhere, do we? Certainly, "git
worktree list" doesn't show it, and "git worktree add" stopped showing
it as of 2c27002a0a (worktree: improve message when creating a new
worktree, 2018-04-24).

> diff --git a/worktree.h b/worktree.h
> @@ -108,4 +108,18 @@ extern const char *worktree_git_path(const struct worktree *wt,
> +/*
> + * Return a refname suitable for access from the current ref
> + * store. The result may be destroyed at the next call.
> + */

If you re-roll, perhaps: s/may/will/
