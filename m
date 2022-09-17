Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A99ECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 06:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIQGaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 02:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIQG35 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 02:29:57 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E801AD8B
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 23:29:56 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 125so14248400ybt.12
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 23:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DNiU6RPrOOcBUoTfckihQuiaKH666tpg6v9/weFT31s=;
        b=j5qp2uNmsNSLhGr6Aj/tAkMsGQH/n3ZkJDvYU4DgT8W96NiCZqYI5vNjZoOsR1c91g
         DGGIpafh0dvQCpzXqwSRFXiY16kRfKOjZ7i29U4fc7h51/1XlNRcKOA7U61+FJtQBZDA
         6W9iSD5PSSKL2c51EtNIptQXRK4BgToWxnbBrauU0s25X2WZTBerxW/c9qP/GfOlDtoP
         aHjspc+aWQDb9s7zgBZogyiINmEvWJ/TNVZSt4VybooLLObsyzB/Vc0YnnQ80gUGGhLI
         tWmgmjEgLDL25MrdXMTU22Jui/oTauv77N3qAhN/ALlOcvDzTlX8O8okwvqouDVqX2Lg
         a68g==
X-Gm-Message-State: ACrzQf1E380v5MGNfQ4mswi/hTLgthOq6z6Rgh8CnSOr8FPEHdwQvDeT
        5cq49FolF8npVlHQPCbSrx4lsWztx2zOGmnEJDE=
X-Google-Smtp-Source: AMsMyM5KkeoYLKtEh6u1ZhcR+2YWSezzYdvShNxbWZlj7urtJXLHUAjTHcPSCT6yYIKWAYURguCBgQ+zM6KQdxl7UtU=
X-Received: by 2002:a25:4645:0:b0:695:b0c8:2817 with SMTP id
 t66-20020a254645000000b00695b0c82817mr7441562yba.211.1663396194844; Fri, 16
 Sep 2022 23:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
 <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com> <b535649722826d7317061da7d8b0cf3d6e2a51ff.1663377141.git.gitgitgadget@gmail.com>
In-Reply-To: <b535649722826d7317061da7d8b0cf3d6e2a51ff.1663377141.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Sep 2022 02:29:44 -0400
Message-ID: <CAPig+cTRNfewL01GOVTjFLaFq-vGgdeV2OX6Bn+StGrgb1JVMA@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] fsmonitor: relocate socket file if .git directory
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

On Fri, Sep 16, 2022 at 9:12 PM Eric DeCosta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> If the .git directory is on a remote file system, create the socket
> file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
> diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
> @@ -0,0 +1,46 @@
> +static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
> +
> +const char *fsmonitor_ipc__get_path(struct repository *r)
> +{
> +       static const char *ipc_path;
> +       SHA_CTX sha1ctx;
> +       char *sock_dir;
> +       struct strbuf ipc_file = STRBUF_INIT;
> +       unsigned char hash[SHA_DIGEST_LENGTH];
> +
> +       if (ipc_path)
> +               return ipc_path;
> +
> +       ipc_path = fsmonitor_ipc__get_default_path();
> +
> +       /* By default the socket file is created in the .git directory */
> +       if (fsmonitor__is_fs_remote(ipc_path) < 1)
> +               return ipc_path;
> +
> +       SHA1_Init(&sha1ctx);
> +       SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> +       SHA1_Final(hash, &sha1ctx);
> +
> +       repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
> +
> +       /* Create the socket file in either socketDir or $HOME */
> +       if (sock_dir && *sock_dir)
> +               strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> +                                       sock_dir, hash_to_hex(hash));
> +       else
> +               strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));

A couple comments...

In my mind, the directory specified by `fsmonitor.socketdir` is likely
to be dedicated to this purpose (i.e. housing Git administrative
junk). As such, it feels somewhat odd for the socket file to be
hidden; I would instead expect the socket name to be non-hidden (say,
"git-fsmonitor-daemon-{hash}.ipc") rather than hidden
(".git-fsmonitor-*"). The directory specified by `fsmonitor.socketdir`
may or may not be hidden (i.e. start with a dot), but that's the
user's decision. For the $HOME case, it almost feels cleaner to create
a hidden directory (say, "$HOME/.git-fsmonitor") in which to house the
socket files ("git-fsmonitor-daemon-{hash}.ipc"). Anyhow, this comment
is quite subjective; perhaps not actionable.

What happens if either $HOME or `fsmonitor.socketdir` are
network-mounted? Should this code be checking for that case? If they
are network-mounted, should it error out? At minimum, I would think a
warning is warranted in order to save users the headache of wondering
why fsmonitor isn't working correctly.

> +       ipc_path = interpolate_path(ipc_file.buf, 1);
> +       if (!ipc_path)
> +               die(_("Invalid path: %s"), ipc_file.buf);
> +
> +       strbuf_release(&ipc_file);

`sock_dir` is being leaked, isn't it?

> +       return ipc_path;
> +}
> diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
> @@ -0,0 +1,9 @@
> +const char *fsmonitor_ipc__get_path(struct repository *r) {
> +       static char *ret;
> +       if (!ret)
> +               ret = git_pathdup("fsmonitor--daemon.ipc");
> +       return ret;
> +}
> \ No newline at end of file

Mentioned already.
