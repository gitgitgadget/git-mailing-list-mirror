Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5501F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHMSwx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Aug 2019 14:52:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34240 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHMSwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:52:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id e8so1671709wme.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gXds0uVLlXeJYc5bRR1M4tCRxEJbEj4Tzvo+9HE6bPc=;
        b=EmfVaQMQjECCtsuenRS+LVhn+MEIQ2J1cXU0IF3tdnUzcuBSSakIuNL5HpAHpeJswF
         N2eK8XhSebbjZ/6dtM8a3Fbdkkg4tOv1q4s8hrAGxkj/QPrT8RfVXM7gAupWHpNKMrqY
         57a7aExJSL6OAL+cQXHShJGVCWIcJSxQH7jvz6nrlvWH+VL2dQHPMlxLJD/HLWqYPOxi
         roW1yaUmRjqkuILZC8EfdOmexw2/hDlN+hZVXOqbd/WiJ90/+DjO9x2jarGZa1ApS2pE
         BEi8abw3BJHWun1YuC7dj3jN0VyOH9WcjI28xFb9c1sWU2TO42MsEDJ5hjeGrYaaQdVJ
         2ohw==
X-Gm-Message-State: APjAAAVXxfANPlf6w/uFNIwVfrIwAzlfrASbYtQNj4BkW3RTPpJ4BbE3
        ohmZh/MQzK7J8RvLzLaSC2ohU2dQ7cDI+dq9O/A=
X-Google-Smtp-Source: APXvYqzkpb0+DeGdrD3gY+X5tpXU3WQ/Fq1mHV4YBum40rw76vx7gxZP6OPHX6vRn/cSVBu9TvGoKYd1/018ll9nQAs=
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr256793wma.53.1565722371491;
 Tue, 13 Aug 2019 11:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190813180244.28641-1-szeder.dev@gmail.com>
In-Reply-To: <20190813180244.28641-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Aug 2019 14:52:39 -0400
Message-ID: <CAPig+cSDxBFhnJSmH+WzNZBjY4O0OczazZ7EOqn1P=zgL+ec4g@mail.gmail.com>
Subject: Re: [PATCH] worktree remove: clarify error message on dirty worktree
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 13, 2019 at 2:04 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> To avoid data loss, 'git worktree remove' refuses to delete a worktree
> if it's dirty or contains untracked files.  However, the error message
> only mentions that the worktree "is dirty", even if the worktree in
> question is in fact clean, but contains untracked files:
> [...]
> Clarify this error message to say that the worktree "contains modified
> or untracked files".
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -880,7 +880,7 @@ static void check_clean_worktree(struct worktree *wt,
>         ret = xread(cp.out, buf, sizeof(buf));
>         if (ret)
> -               die(_("'%s' is dirty, use --force to delete it"),
> +               die(_("'%s' contains modified or untracked files, use --force to delete it"),
>                     original_path);

Makes sense. This is a different type of "dirtiness" than, say, "git
rebase --interactive" which cares about unstaged changes but generally
doesn't mind untracked files. So, it deserves an error message which
mentions untracked files explicitly.

We could actually parse the output of "git status --porcelain" (which
is invoked just above this spot) and provide a more specific error
message ("...contains modified files" or "...contains untracked
files") but that's probably not worth the effort.

Anyhow, for what it's worth:
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
