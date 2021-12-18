Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060EBC433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhLRQI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 11:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhLRQI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 11:08:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511AC061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 08:08:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso5799498pjl.3
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=F9HvXNyRNvD6zTB1s7YWzIJCEx6e5oYGxTtLAEnahxg=;
        b=qnC8tQiMqLZzV5B+XREQCOa1Q3jNm/LXAHvstIMekeWJfs+sek1vPAF+MDibi/s5Eg
         +9vlTiVQivU7+X/saqMrackGhYS4kwquYxLToX5O7xrPNqeAP780TzHF2tBbXAjolH1D
         PkwSKAg0l70bohAcYG0iAGv69er3inhBQix2QMLDTlXk4qpSgcuV3TM271cHYAenYZn8
         2NUFbnDUpKbB3h84K/uhCW5uPUJawJlMqY1KAUTteCcbnDFFAXuaCcvF0uHR8BBm0hX1
         zsQiaPvARPeYeDMdLjK3REWj/mSh6dQNw/DaWW0Dx4raWxomwnvo640sYrqTYg1tq3be
         YemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F9HvXNyRNvD6zTB1s7YWzIJCEx6e5oYGxTtLAEnahxg=;
        b=6rRq7/tFEJNrZc+6Fo3ODXxi2BDUSt8b8vlKNEA3ij8EzurKCluyxJFf/9yBT3sg5Y
         nCNZdNI2UHIkJWRJyuTXldYpO8JN5wYs8QA1sZjMtix4szCorfbAc+u+31hyIAYGIuf9
         15kjxkgtX6BUKaBItiFOEwoKyJySjACzWksfoZ6IFV9daiVjKi/8pI9ob4cED8GfaDdl
         kxq684PrslYUc2ZB7+M7dHys91zTPBSMBqdlJxqKRcoEAzIPxVdzRBaHJyPBh9WY14+B
         526jhMYwW2uX6iurSOZhmkIdPd4NFlJCGxVvib5y/6Vxfdc+jLO3sDG5i+lMLvEsY6M8
         i80Q==
X-Gm-Message-State: AOAM5331yz1t8FJA8Phcg9sClqx0putRn2t2TXmjkFyiKYoZDUbhd9qm
        uCxjDAbNRN8T2Y9NQ1YIETSWDbCRlHecK8OKL9+Eg6MMqZg=
X-Google-Smtp-Source: ABdhPJxUhEKlVrn9ECz1ceWKhWcUYxuDpuIEWQlpmePyICE3nwQVkZ01HnYcAliwSSkFcfMtDiaB1Pq2iFeJH+Y2fEo=
X-Received: by 2002:a17:902:e2d2:b0:148:a9d9:125e with SMTP id
 l18-20020a170902e2d200b00148a9d9125emr3348346plc.138.1639843737065; Sat, 18
 Dec 2021 08:08:57 -0800 (PST)
MIME-Version: 1.0
From:   Sean Allred <allred.sean@gmail.com>
Date:   Sat, 18 Dec 2021 10:08:45 -0600
Message-ID: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
Subject: Custom subcommand help handlers
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've got a custom subcommand I'm distributing in my company to
integrate with our bug-tracker. It's a pretty robust utility and has
its own help function, but running `git foo --help` doesn't pass
--help to my git-foo utility. I asked a question[1] about this
scenario on the Windows fork and they directed me upstream.

It sounds like `git foo --help` is internally consumed as `git help
foo`, which forwards requests to info/man/web handlers per config.
Being on Windows and knowing my peers as I do, the vast majority of my
users won't be familiar with info or man. The HTML documentation used
by the web handler is in a Git4Win-controlled installation directory
that I'd really rather not touch/maintain. I really just want `git foo
--help` to call `git-foo --help`.

What's the best way to go about this?

In the event the best next step is to start a patch, does it sound
reasonable to simply not perform this `git foo --help` -> `git help
foo` transformation for non-builtins? Or, while I don't relish the
idea, would some kind of config option be needed?

Best,
Sean Allred

[1]: https://github.com/git-for-windows/git/discussions/3553
