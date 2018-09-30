Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580231F453
	for <e@80x24.org>; Sun, 30 Sep 2018 05:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeI3MIG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 30 Sep 2018 08:08:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33248 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeI3MIG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 08:08:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id i10-v6so10882643qtp.0
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 22:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gsKg4mZDGvf2hj3MmPZ49ccBNokVePdx+WgdIPjI8ak=;
        b=SFXTEk0hUlB4EkMp7Js3HlJ/1BQSD+L5XIhp/oAv4Ne+JoJj5d6PYGcAV9/y0CowQ6
         8eYAnh1YRsnPzlGcKrWLQ1m5Mw2IHJwRr8M/ImxXEkTUS/xRo3rKlYn8w2Vx0aCZSlEl
         RqPruSSB8lf9SehvgnfzobpRikv0faHiSgzLn7CbHtif3tpoY25NKe8PQWxK/miAkhOp
         X01+4lriz0qPQgBvmnGW4MzxCP9UFxktbWbdWzv5zk61AOKA79asMC51TuexuS1FwZ/e
         Fl23inXVST99MNSFZ61QDXDfrmKH/xuaRpNfTK55T+/u/KhFbWbzczzKKDceValHEq76
         gx4A==
X-Gm-Message-State: ABuFfogadYgO4C/j+C+9oOeXaz6Zib/yCDGWV0utwHFGsTzE0vfwcjud
        oOKRHVruotzc/Ko99j5pFfLWjsZnzfAhXBlgddI=
X-Google-Smtp-Source: ACcGV62fodYdJUilq16i8PapY6SV1qpFn9WiwgR3Xr8ClDghcF9Yjk9E60oALQOxYW+p7r8fjD1XaEEaMtN7I+n1yOQ=
X-Received: by 2002:a0c:9de1:: with SMTP id p33-v6mr463487qvf.82.1538285792322;
 Sat, 29 Sep 2018 22:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180929191029.13994-1-pclouds@gmail.com>
 <20180929191029.13994-9-pclouds@gmail.com>
In-Reply-To: <20180929191029.13994-9-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 01:36:21 -0400
Message-ID: <CAPig+cQBiXRvzf6skmmyVap-6fLEbmVRGNBQqD4H-HfAPampjA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] reflog expire: cover reflog from all worktrees
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
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
> @@ -72,6 +72,11 @@ Options for `expire`
> +--single-worktree::
> +       By default when `--all` is specified, reflogs from all working
> +       trees are processed. This option limits the processing to reflogs
> +       from the current working tree only.

Bikeshedding: I wonder if this should be named "--this-worktree" or
"--this-worktree-only" or if it should somehow be orthogonal to --all
rather than modifying it. (Genuine questions. I don't have the
answers.)

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> @@ -577,10 +585,18 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>         if (do_all) {
>                 struct collect_reflog_cb collected;
> +               struct worktree **worktrees, **p;
>                 int i;
>
>                 memset(&collected, 0, sizeof(collected));
> -               for_each_reflog(collect_reflog, &collected);
> +               worktrees = get_worktrees(0);
> +               for (p = worktrees; *p; p++) {
> +                       if (!all_worktrees && !(*p)->is_current)
> +                               continue;
> +                       collected.wt = *p;
> +                       for_each_reflog(collect_reflog, &collected);
> +               }
> +               free_worktrees(worktrees);

Should this have a test in the test suite?
