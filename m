Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56CE1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 16:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfBTQz6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 11:55:58 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40410 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTQz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 11:55:58 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so27946026qta.7
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 08:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BD7/M9NEUtZqwvCOvwPE+BuuYvr8qp+yBc/ZUvEsois=;
        b=cfH0ow0ZKDURqr2ZRt1sEm54/d9dn4vVj7rOlmWRguZ1WAlc+bKkK4/MypW+3dPEcL
         lphgB4lEXFg+hoqWqsqJznzlZ71hIAdgBHYx8R+HKNosuBCMIovO5D3XZ0V25ub2QxqS
         1QXVuP0TWbee/+qlpIhpkk8mcYIG3TgFH6lu84jrjt3l/DtTcG8R+H1IYAO7GCiMIToH
         PT5TW7JGD7SuyrUl+lP5N/diSS89gqykrMIyG1dFDXgQy/OBDCA+JAABOU9zxY0DY/fJ
         R9B0LFVkStvy1JgJmV48AQres41BxIOBKngXfoUPDJ5fwjln8ahFASgNnBoU1sPico8c
         8Rnw==
X-Gm-Message-State: AHQUAuZc/gT8SeWaq7fMWXHHxKW0oEp26NWcUg/QY+yGz792QY97LZGT
        lAh+C72VW0OQRw1fV+5TpS/zZmEG9PL0WfFstvM=
X-Google-Smtp-Source: AHgI3IZyUkTFdV4dlta8ksbsxLHxDjeQbk1popgkI1embGAqFKVjIoy7vIy0F47PD/ZkrCVkW9gPOXEhQSmNxa+M97U=
X-Received: by 2002:a0c:87b1:: with SMTP id 46mr16022480qvj.203.1550681757407;
 Wed, 20 Feb 2019 08:55:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <37df7fd81c3dee990bd7723f18c94713a0d842b6.1550679076.git.msuchanek@suse.de>
In-Reply-To: <37df7fd81c3dee990bd7723f18c94713a0d842b6.1550679076.git.msuchanek@suse.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 Feb 2019 11:55:46 -0500
Message-ID: <CAPig+cQZNOWvaa5H2PKOs149KvRtEYRzrdLvzvFRDo4Qxaecaw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] setup: don't fail if commondir reference is deleted.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 11:17 AM Michal Suchanek <msuchanek@suse.de> wrote:
> Apparently it can happen that stat() claims there is a commondir file but when
> trying to open the file it is missing.

Under what circumstances?

> Another even rarer issue is that the file might be zero size because another
> process initializing a worktree opened the file but has not written is content
> yet.

Based upon the explanation thus far, I'm having trouble understanding
under what circumstances these race conditions can arise. Are you
trying to invoke Git commands in a particular worktree even as the
worktree itself is being created?

Without this information being spelled out clearly, it is going to be
difficult for someone in the future to reason about why the code is
the way it is following this change.

> When any of this happnes git aborts failing to perform perfectly valid
> command because unrelated worktree is not yet fully initialized.

s/happnes/happens/

> Rather than testing if the file exists before reading it handle ENOENT
> and ENOTDIR.

One more comment below...

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> diff --git a/setup.c b/setup.c
> @@ -270,12 +270,20 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>  {
>         strbuf_addf(&path, "%s/commondir", gitdir);
> -       if (file_exists(path.buf)) {
> -               if (strbuf_read_file(&data, path.buf, 0) <= 0)
> +       ret = strbuf_read_file(&data, path.buf, 0);
> +       if (ret <= 0) {
> +               /*
> +                * if file is missing or zero size (just being written)
> +                * assume default, bail otherwise
> +                */
> +               if (ret && errno != ENOENT && errno != ENOTDIR)
>                         die_errno(_("failed to read %s"), path.buf);

It's not clear from the explanation given in the commit message if the
new behavior is indeed sensible. The original intent of the code, as I
understand it, is to validate "commondir", to ensure that it is not
somehow corrupt (such as the user editing it and making it empty).
Following this change, that particular validation no longer takes
place. But, more importantly, what does it mean to fall back to
"default" for this particular worktree? I'm having trouble
understanding how the new behavior can be correct or desirable. (Am I
missing something obvious?)

> +               strbuf_addstr(sb, gitdir);
> +               ret = 0;
> +       } else {
