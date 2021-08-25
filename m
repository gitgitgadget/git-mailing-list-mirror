Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C2C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035D76109E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhHYXuU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 25 Aug 2021 19:50:20 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:40502 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXuT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:50:19 -0400
Received: by mail-ej1-f51.google.com with SMTP id lc21so2023595ejc.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ulNtTNoG5TASQi2MBeTyQS6tuTw7ZnT3+tvGOm453bI=;
        b=oSGkJP6pgIy5Cp6fEsB9GHbWMSiFXNsCg//5I/48HmdsTeLQKrBPV9A17hxx7T7d5Y
         lBqt1zSdC46oWOq2roOUaXXFETRlKdFCa7bRk2STckKUkyujEY4SM+UGTiuw9me9rcJu
         n2pX9pca4FyOO7o/hkL3y2PTZqdiM8KTxPCrR0Zf2Z1QwcSeO0dW0SL3nlmZXTik3bVV
         JRMxS6GxOmMeRfqH8Ahqr/hYfGRihqESwr26cl1aX2dfmCCZxlAY5nxLyHyeXN4xvdHj
         86Pa1CKfcIYBGfSShq7ixuPEl565FsNP53LGagpTEoT+6v+qjNcf3lvrjWte2f6sfpaC
         /How==
X-Gm-Message-State: AOAM533LJorN5UfLxqeh5OHsdTam6phizX+Zn2IVo2TETOC/MVSChpaq
        zwYWv8hToROeDFxvOvW88LuOx1pOabZr6sL1FbWKklH9Q9lhUQ==
X-Google-Smtp-Source: ABdhPJwxjUlzK+juHIDLrTYzUTtz0KteByU2pvilIcBW8g8HLOqQ8TJM3Yi8HAU0fU6jz7h8SmJdqU78tW6xMqyCT7A=
X-Received: by 2002:a17:906:6808:: with SMTP id k8mr1266432ejr.138.1629935372454;
 Wed, 25 Aug 2021 16:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <87o8agp29o.fsf@evledraar.gmail.com> <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <patch-6.6-da003330800-20210825T231400Z-avarab@gmail.com>
In-Reply-To: <patch-6.6-da003330800-20210825T231400Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Aug 2021 19:49:21 -0400
Message-ID: <CAPig+cShVK1OChWP+BCx-_8wPV2BKwem8vHgTdYF2gAZX0pFUQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] tr2: log N parent process names on Linux
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 7:20 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> Extend the functionality added there to also log full parent chain on
> Linux. In 2f732bf15e6 it was claimed that "further ancestry info can
> be gathered with procfs, but it's unwieldy to do so.".
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
> @@ -4,27 +4,129 @@
> +/*
> + * We need more complex parsing instat_parent_pid() and

s/instat_parent_pid/in stat_parent_pid/

> + * parse_proc_stat() below than a dumb fscanf(). That's because while
> + * the statcomm field is surrounded by parentheses, the process itself
> + * is free to insert any arbitrary byte sequence its its name. That
> + * can include newlines, spaces, closing parentheses etc. See
> + * do_task_stat() in fs/proc/array.c in linux.git, this is in contrast
> + * with the escaped version of the name found in /proc/%d/status.
> + *
> + * So instead of using fscanf() we'll read N bytes from it, look for
> + * the first "(", and then the last ")", anything in-between is our
> + * process name.
> + *
> + * How much N do we need? On Linux /proc/sys/kernel/pid_max is 2^15 by
> + * default, but it can be raised set to values of up to 2^22. So
> + * that's 7 digits for a PID. We have 2 PIDs in the first four fields
> + * we're interested in, so 2 * 7 = 14.
> + *
> + * We then have 4 spaces between those four values, which brings us up
> + * to 18. Add the two parentheses and it's 20. The "state" is then one
> + * character (now at 21).
> + *
> + * Finally the maximum length of the "comm" name itself is 15
> + * characters, e.g. a setting of "123456789abcdefg" will be truncated
> + * to "123456789abcdef". See PR_SET_NAME in prctl(2). So all in all
> + * we'd need to read 21 + 15 = 36 bytes.
> + *
> + * Let's just read 2^6 (64) instead for good measure. If PID_MAX ever
> + * grows past 2^22 we'll be future-proof. We'll then anchor at the
> + * last ")" we find to locate the parent PID.
> + */
