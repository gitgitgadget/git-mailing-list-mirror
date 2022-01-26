Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65875C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 07:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiAZHR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbiAZHR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 02:17:56 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38AFC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 23:17:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so18603634ljh.8
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 23:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubwUL8Ji1nOAKn3g8AL43I50gokbKjzGiih03oor6T8=;
        b=lBD/IHyD0p19uLDtVT6szS13bY/E2tc1KFF81UFuhDVukdIFp4MOjvVfvDbV+2NQs4
         UlKpTx+2cEH+6jJpbPpz5KAaTW6zLy9PpuY30i8bYBLJTdnnnjRfX7+GHVUu12Oy4ESY
         QMsukRT+rUhvClLtZYP14ygmhJRECGtkbN27cu4v06KiWUPEuFaduOhEPgqaqIUq5Z8e
         lHGPloOVCaAdd32dClKUGJ90QSf9UZ0VrNymv07J26mjUfiIagEb/LDmq1dG0ciWD8D8
         rP+/WV1IlwaNBnviE6BQsebOEL4bQG/sUSHdhGc5bsF0D/6wIcezA1PRJdOhjr7XtQIA
         mt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubwUL8Ji1nOAKn3g8AL43I50gokbKjzGiih03oor6T8=;
        b=YOTjtEOSOGRTVjWQ328NDOp8TY4Rz/znddpwb0AQIMMmSWRJ7qeM71CT+heh3hB22w
         CB14aFK1wH0s6nXTmVFz08mvnM/gnGMWz2gHH1dktbErwYlVaWFzCLA//1vvjCnAZmvi
         hxGAjx8c0R0LcwXFaqMmYCv+3zehYVd5DzXcBmv6wh+VVFvyHl18usUi8gUaqitnCtTs
         mZj5wWF97/fitTBRoDmjHHZjjz54pDw8Pqu5EZz6ltnwnRp+kLRlHDZ3RyYKR0lHje13
         lvmW7V4aWl1y4A3RKGEuqiqMQ+rqExfQ3rxGjNdG9W8ZM+LLbGsgP2pzLEbsJOJ/SmgD
         L5rg==
X-Gm-Message-State: AOAM5309KLVSUka/LjqhOuQeQVC1aSBA+TC9th2TlALuzlf2SGWpQKwV
        IS1Nq9G3hzgjUCijWFr0O1boBjFw2R7V/GDVPlw=
X-Google-Smtp-Source: ABdhPJxRdA8d0DdMqoOmcLHNxAtmUaBfKRSUX7ovF1YVGD0j4rjowHP66yAaKfMbsDeVVJ4D1jBFuSZNshx3AdlRJ7k=
X-Received: by 2002:a05:651c:4d4:: with SMTP id e20mr17129600lji.195.1643181473803;
 Tue, 25 Jan 2022 23:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
In-Reply-To: <20220125095445.1796938-1-robin.jarry@6wind.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 26 Jan 2022 15:17:42 +0800
Message-ID: <CANYiYbGRK0eshjUJoPH0yWT1tVLoerOMC6CY6tAMrwAh7T+y1g@mail.gmail.com>
Subject: Re: [PATCH] receive-pack: interrupt pre-receive when client disconnects
To:     Robin Jarry <robin.jarry@6wind.com>
Cc:     Git List <git@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Robin Jarry <robin@jarry.cc>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 12:09 AM Robin Jarry <robin.jarry@6wind.com> wrote:
>
> When hitting ctrl-c on the client while a remote pre-receive hook is
> running, receive-pack is not killed by SIGPIPE because the signal is
> ignored. This is a side effect of commit ec7dbd145bd8 ("receive-pack:
> allow hooks to ignore its standard input stream").
>
> The pre-receive hook itself is not interrupted and does not receive any
> error since its stdout is a pipe which is read in an async thread and
> output back to the client socket in a side band channel.
>
> After the pre-receive has exited the SIGPIPE default handler is restored
> and if the hook did not report any error, objects are migrated from
> temporary to permanent storage.

We used to ignore the SIGPIPE signal when calling "pre-receive" hook,
so we could tolerant a buggy "pre-receive" implementation which didn't
consume all the input from "receive-pack". On the other side, "ctrl-c"
from the client side will terminate "receive-pack", only if we do not
ignore the SIGPIPE signal when running "pre-receive".

Wouldn't this be much simpler: add a new configuration variable
"receive.loosePreReceiveImplementation", and only ignore SIGPIPE when
"receive-pack" turns off the config variable?

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9f4a0b816cf9..0f41fe8c6a85 100644
> @@ -522,10 +540,24 @@ static int copy_to_sideband(int in, int out, void *arg)
>                  * Either we're not looking for a NUL signal, or we didn't see
>                  * it yet; just pass along the data.
>                  */
> -               send_sideband(1, 2, data, sz, use_sideband);
> +               if (proc && proc->pid > 0) {
> +                       if (send_sideband2(1, 2, data, sz, use_sideband) < 0)
> +                               goto error;
> +               } else
> +                       send_sideband(1, 2, data, sz, use_sideband);
>         }
>         close(in);
>         return 0;
> +error:
> +       close(in);
> +       if (proc && proc->pid > 0) {
> +               /*
> +                * SIGPIPE would be more relevant but we want to make sure that
> +                * the hook does not ignore the signal.
> +                */
> +               kill(proc->pid, SIGKILL);
> +       }
> +       return -1;
>  }

Kill the "pre-receive" process, so the calling of
"finish_command(&proc)" at the end of "run_and_feed_hook()" will
terminate "receive-pack".

> diff --git a/sideband.c b/sideband.c
> index 85bddfdcd4f5..27f8d653eb24 100644
> --- a/sideband.c
> +++ b/sideband.c
> +static int send_sideband_priv(int fd, int band, const char *data, ssize_t sz,
> +                             int packet_max, int ignore_errors)
>  {
>         const char *p = data;
>
> @@ -265,13 +279,24 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
>                 if (0 <= band) {
>                         xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
>                         hdr[4] = band;
> -                       write_or_die(fd, hdr, 5);
> +                       if (ignore_errors)

"ignore_errors" or "die_on_errors"?

> +                               write_or_die(fd, hdr, 5);
> +                       else if (write_in_full(fd, hdr, 5) < 0)
> +                               return -1;

--
Jiang Xin
