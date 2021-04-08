Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5916C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C2460FE6
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhDHQpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:45:07 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:44901 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhDHQpG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 12:45:06 -0400
Received: by mail-ej1-f47.google.com with SMTP id e14so4143164ejz.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 09:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMVEaBX3Q5UvFPV78Y84VL9vhzE32DjwE+oWsb9xaVo=;
        b=r3InvrCzgrfAsuZi3mR/AHl6aICdTMIRWQQVb3PJ7s0PSbYtytqy9+EWdvFQhH45rH
         qUPQjgowCff8gC0Lk3beRUk/VuZcBy0U2aZmNFKCkzpuxo9zZE93C4LikDNtkkg3L/TZ
         xhMDcRkSdB+JlrzIoIpk2YyFFYxdJ21U4EWPXdMlkryBVAv0Y2ouVmklA/Lgdu0pK/vU
         +HzuKJlr4PpKkrw2Y7l+t5NPKl41yWUE11Ti0I3Cz17P5uIw0nQkacOwhLh0U5FRXn9f
         +XvWyG6H0MvwsWP/GytDObf20NI/0M/TQA/yKT45n4p9W2i+QY3qskMT2bVkTl3VYDhm
         Zm6g==
X-Gm-Message-State: AOAM532xDb8GBY51ygsIlfNrmkCWLYYr7q/jWOXkhwzvj6PzN7lo3lIX
        FG6g0DGMbMgotvws0/hR0r/h1Eub3w9X2EBDYwQ=
X-Google-Smtp-Source: ABdhPJzTPwylwk1tbwbR1lx4uAkIGpzbUpLv3oln65aySocsNl4wo7fzBIVWm47zXMtd4jNqaHfolsRn8Ut6e0jeBAs=
X-Received: by 2002:a17:906:cc4d:: with SMTP id mm13mr11819258ejb.138.1617900292572;
 Thu, 08 Apr 2021 09:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
In-Reply-To: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Apr 2021 12:44:41 -0400
Message-ID: <CAPig+cT=xbftpV+k941ikkZR0RvQsXL6XA0Oono2_sDHsb5TTA@mail.gmail.com>
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 8, 2021 at 10:18 AM Patrick Steinhardt <ps@pks.im> wrote:
> While it's already possible to stop git from reading the system config
> via GIT_CONFIG_NOSYSTEM, doing the same for global config files requires
> the user to unset both HOME and XDG_CONFIG_HOME. This is an awkward
> interface and may even pose a problem e.g. when git hooks rely on these
> variables to be present.
>
> Introduce a new GIT_CONFIG_NOGLOBAL envvar, which is the simple
> equivalent to GIT_CONFIG_NOSYSTEM. If set to true, git will skip reading
> both `~/.gitconfig` and `$XDG_CONFIG_HOME/git/config`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> @@ -670,13 +670,21 @@ for further details.
> +`GIT_CONFIG_NOGLOBAL`::
> +       Whether to skip reading settings from the system-wide `~/.gitconfig`
> +       and `$XDG_CONFIG_HOME/git/config` files.  This environment variable can
> +       be used along with `$GIT_CONFIG_NOSYSTEM` to create a predictable
> +       environment for a picky script, or you can set it temporarily to avoid
> +       using a buggy global config file while waiting for someone with
> +       sufficient permissions to fix it.

Not necessarily a new problem since you mostly copied the new text
from GIT_CONFIG_NOSYSTEM, but this doesn't tell the reader what value
to assign to this variable. As currently written, I would end up
having to consult the source code to figure out how to use this
variable, which makes the documentation less useful than it should be.
Perhaps it could be rewritten something like:

    If set to any value, suppress reading global configuration
    from `~/.gitconfig` and `$XDG_CONFIG_HOME/git/config`
    files. This environment variable...

The bit about waiting for someone to fix a buggy ~/.gitconfig is
somewhat questionable; it might make sense to drop everything after
"picky script".

>  `GIT_CONFIG_NOSYSTEM`::
>         Whether to skip reading settings from the system-wide
>         `$(prefix)/etc/gitconfig` file.  This environment variable can
> -       be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
> -       predictable environment for a picky script, or you can set it
> -       temporarily to avoid using a buggy `/etc/gitconfig` file while
> -       waiting for someone with sufficient permissions to fix it.
> +       be used along with `$GIT_CONFIG_NOGLOBAL` to create a predictable
> +       environment for a picky script, or you can set it temporarily to avoid
> +       using a buggy `/etc/gitconfig` file while waiting for someone with
> +       sufficient permissions to fix it.

This suffers the same problem of not telling the reader what value to
assign. A similar rewrite could improve it, as well.
