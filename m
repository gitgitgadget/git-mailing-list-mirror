Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F07C6FA82
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 04:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIQEOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 00:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIQEN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 00:13:59 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23D796A8
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 21:13:58 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-333a4a5d495so281389877b3.10
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 21:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3sHX9RU0jnCD9p62+u5w1NiyZzZ5rHE4cEbnLQEU+bI=;
        b=CJldIbzH9bXkRAGCReGnNyBPydmD1Jn2b4qQIvW2m+X8on05QMHbZxGZgSaVYM5CFA
         qe/dxzEN44rTejUV7r3ME83EfJlgrRQTwj/iehj9YdQHw+Pg0S4mDtSgWAE3q2zkISBp
         Wjy14UVdf9umK1upLNxYhBxlAO2xc20WnPkXEQfH0xAgEy5R/YPN5I0sUDFhF9EX28x4
         X656qdxIuw9Pl2Q2b2qMkhk5d75YBkmvqJuyToyM1mbAmniWKIvDgu/bNl6e59+yZx/L
         GlMSjbVIpp7qQ5O+uJDnYxKg8mvdIPQqgInNUxvjFbTbu/aoFHOhO5UPYB7GV82wj1v5
         LkOQ==
X-Gm-Message-State: ACrzQf0jQL/efRoiq7BfVREQl/XHe9M0hPApX/f1WY0mV+N3Yv/+H0dZ
        hTWDbp/HHP8ZSIBSq4GxeGrkcQZRbbS4AFh+tBM=
X-Google-Smtp-Source: AMsMyM7Q00WDSOdGUQgNiMc6Q+4fq8XeBww4PcEDOCtRHQNZs/dqYRa9IarvrMxeroaHh/oeHawsj2LVnD7nZVFHpjY=
X-Received: by 2002:a0d:d345:0:b0:349:f274:a0f with SMTP id
 v66-20020a0dd345000000b00349f2740a0fmr6776424ywd.13.1663388037713; Fri, 16
 Sep 2022 21:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
 <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com> <b535649722826d7317061da7d8b0cf3d6e2a51ff.1663377141.git.gitgitgadget@gmail.com>
In-Reply-To: <b535649722826d7317061da7d8b0cf3d6e2a51ff.1663377141.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Sep 2022 00:13:45 -0400
Message-ID: <CAPig+cScMtqKg2Ke8XK2FQ+XSeLRof0mvKk_uGPFC6eriUOdDw@mail.gmail.com>
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

This file probably wants a final line terminator.
