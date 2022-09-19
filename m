Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE34ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIST6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIST6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:58:11 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD1F43E54
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:58:10 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id e187so326366ybh.10
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=y6OXTO1OSuIGyMRdF2UULdbqedGlC0Y5Iw5PTZJL8CA=;
        b=2475ehPv3FviFQAnblSyXhs1vpYZLGh7vwK38rLRrWXHwJblSWtt2SHqs6viHl4CVW
         yGnVZi637CZmAp/zyR5gd2jyehbDi9V0aOwQEiCn3x2qgaGXW1DGhYi/ypMKyINpqnAq
         1JaJw6/fp+PWVwGGOfHtevjpdLGqLOkE7mNWHDKHb6X0mWjldPhN1YmVJhlgy52n0RvJ
         60gkEm2LnJZYX3IgILy7w+Y2g8kPxLeB9HNBY1z6OxxXJTgJ/kCVl9s/jucZqWypTpxC
         5rk/ygoGL3zcZ1vUVbid+DSKfH1YYRMLqFGmu0qJA6KC3tqYHYL63QfE5mdQu5vnrABr
         WFrA==
X-Gm-Message-State: ACrzQf1mOS7aJN3RJaQwhLf0JcNbFtUHH0OI0wlsEfe020LFVx8I0ijs
        1g78vhfspIwnw0K4iSSsviHWblZ9QvmdnyZr70ZkEmZI67sHy9U9
X-Google-Smtp-Source: AMsMyM5v+xLGKnCHCxl5INUMcJHy8TUMDVe1FUIWaReEdcDiGPuIykheDi7ynQeA9S/La7H2WFCl5MO/fpYjFcZaPMs=
X-Received: by 2002:a25:d91:0:b0:6b4:2f1c:4b26 with SMTP id
 139-20020a250d91000000b006b42f1c4b26mr3326647ybn.211.1663617489886; Mon, 19
 Sep 2022 12:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
 <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com> <68709d788d531805d9328e16f53381fcd8d7bd5e.1663616277.git.gitgitgadget@gmail.com>
In-Reply-To: <68709d788d531805d9328e16f53381fcd8d7bd5e.1663616277.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Sep 2022 15:57:58 -0400
Message-ID: <CAPig+cRzbXJ+npc29bXi4Jtmp9O+vhRF2wJQX6y4QFDVnzAkBg@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] fsmonitor: relocate socket file if .git directory
 is remote
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 3:38 PM Eric DeCosta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> If the .git directory is on a remote file system, create the socket
> file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
> diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
> @@ -0,0 +1,48 @@
> +const char *fsmonitor_ipc__get_path(struct repository *r)
> +{
> +       char *sock_dir;
> +
> +       repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
> +
> +       /* Create the socket file in either socketDir or $HOME */
> +       if (sock_dir && *sock_dir) {
> +               strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> +                                       sock_dir, hash_to_hex(hash));
> +               free(sock_dir);
> +       } else {
> +               strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
> +       }

This is still leaking `sock_dir`, isn't it, if
repo_config_get_string() returns it as a zero-length string?

Probably want to move free() below the entire conditional.

> diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
> @@ -0,0 +1,9 @@
> +#include "config.h"
> +#include "fsmonitor-ipc.h"
> +
> +const char *fsmonitor_ipc__get_path(struct repository *r) {
> +       static char *ret;
> +       if (!ret)
> +               ret = git_pathdup("fsmonitor--daemon.ipc");
> +       return ret;
> +}
> \ No newline at end of file

Still an incomplete line.
