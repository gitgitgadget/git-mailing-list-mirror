Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF9C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354285AbhLBARn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:17:43 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:54824 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354273AbhLBAQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:16:42 -0500
Received: by mail-pj1-f47.google.com with SMTP id np3so19239820pjb.4
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 16:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LH5fwqcSuYbKjwGrJegrfeEJmKl6NWBawyIvB+7ip5Q=;
        b=O1pCRtmPKnvu2YBLI1hCRnkFLakboeCNV6ZE2RM4xhXvuBX90f2hD/l2zO5OUkANST
         8tpxuaD7xGKoWV1QoHGQgsSo21ETT0DEhOcUrd6522Es19tbH9mOYBw7JYIiJzXh5V92
         lKgyI/XETBPSfm2sWlMC75kiz125dIagC9Wyn42d2XfATNXxgOiWvcRip0eh0hrE/2/z
         AVj7H8eeSheuhWTf17E0NqOGfpNRbx+/UgRLmKweFI7/hK1sKduvY9c36LBiHSRsWn2F
         gM8reELt/igCaQ6BsWSo1V+3acPXSlD3Gt9FK6pJHGVnJbmBQ32P0tB3vd1Ck+wcMMJo
         nDmQ==
X-Gm-Message-State: AOAM530C2m2+ykSdEIfvZdRIJxNXmyPKVEbQjQH9utVIIEQX4BYI0fQ6
        0RoOLK2Fh2CEh4EHsDqgFgLmpKcFOmDbTF9QBcIebpDMtpl1rw==
X-Google-Smtp-Source: ABdhPJxIuVWQQd+/GlGXfuOgQaO4Jyw5WVYgLxOg4CpHo68vwM1+zvwkdCVrGmKfDlw1WjG1mUwZPWCXAng3Y7iygNk=
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr1927834pjb.236.1638404000765;
 Wed, 01 Dec 2021 16:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-5-andersk@mit.edu>
 <CAPig+cSNP-RBmsWWfT690-shFUCZ3J0X+FBiNjCqg=AkoBMBqQ@mail.gmail.com> <f8262c3b-2ca5-4920-1379-41ff29b37d9f@mit.edu>
In-Reply-To: <f8262c3b-2ca5-4920-1379-41ff29b37d9f@mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 19:13:09 -0500
Message-ID: <CAPig+cRX94vMLkW=dAKncPTuuk0Opaj+8-Yqe-qFD1b7mrZ89A@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] worktree: simplify find_shared_symref() memory
 ownership model
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 6:48 PM Anders Kaseorg <andersk@mit.edu> wrote:
> On 12/1/21 15:10, Eric Sunshine wrote:
> > As far as I can see, this code only cares whether find_shared_symref()
> > returned a result; it doesn't actually consult the returned worktree
> > at all, thus it semantically considers `worktree` as a boolean, not as
> > a `struct worktree`.
>
> No, the update_worktree(new_oid->hash, worktree) call uses it in a
> non-boolean way, so we do need to keep it around.

Okay, I missed that call to update_worktree() in the "noise" of all
those other changes, but looking at the code a bit more carefully, it
seems as if we might still be able to drop all the noise changes
anyhow by hoisting ownership of `worktrees` up a level or two. In
particular, both execute_commands_atomic() and
execute_commands_non_atomic() are calling update() in a loop, and
update() is calling get_worktrees() / free_worktrees() each time it is
called within those loops, which seems unnecessarily expensive.

If we instead hoist ownership of `worktrees` up to execute_commands()
-- which calls execute_commands_atomic() or
execute_commands_non_atomic() -- then we can get by with retrieving
the worktrees just once, and all those noise changes in update() can
be dropped since it will no longer be responsible for allocating or
freeing `worktrees`. For instance:

    static void execute_commands(...)
    {
        struct worktree **worktrees;
        ...
        worktrees = get_worktrees();
         if (use_atomic)
            execute_commands_atomic(commands, si, worktrees);
        else
            execute_commands_non_atomic(commands, si, worktrees);
        free_worktrees(worktrees);
        ...
    }

and then execute_commands_atomic() and execute_commands_non_atomic()
can pass `worktrees` along to update().
