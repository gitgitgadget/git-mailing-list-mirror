Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED61C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E4B60EE9
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhJKUGN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 11 Oct 2021 16:06:13 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41861 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhJKUGK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:06:10 -0400
Received: by mail-ed1-f53.google.com with SMTP id a25so56213527edx.8
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y6ECREt0eExhnsyPCsSjUxatWDRmk+8E/9I9JfMFANc=;
        b=BKK1AXTKHfMC4y71w6ebUDCkyH0QrWevVzqUoKffQ4hMQ03xZZBQ6YcyvreLYat11J
         u1qadZVeIPmbbSvRGnYfvKVMMCWUisnMDuoy+nvp6oyJpWV2g1SGv+v98FDIgt5kYvZe
         8vfK2IHPBDA9qq36NpGFkmMmp8WYYQfhgppdckpMUYRURoI733SWPHzV6FKR4Hg1NI/3
         H2H7Gry+Jkr7ohO8z6QfGXQnJOBC6iTY1cV/T0N3o+kbTvkfF3rxWj0IK9PJ0Fh1sLVV
         JU+CchqodAocHev6iWOdfH6c8Hu9T9UdRfuPye3YXzINS/SLZmuwweYV5Kdz++7GHEks
         z9/Q==
X-Gm-Message-State: AOAM530IWNY8UiAQX+Yaep9X4zje+jzTWhCSFjs5iKL492Zc3/bPgxmZ
        8GkBLTuX7jV5fsBoQGticKj80rtLJEUimmsj1FOx89cTFNPGVQ==
X-Google-Smtp-Source: ABdhPJzY2/ULbWxXdR0oQWhamK+BvLqtwIG0uxZyD6xSo/h8dQ4YBQYDkqqfGePLraR4ioiPGgZBX6zt1937smuUgF4=
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr43078965edb.55.1633982648594;
 Mon, 11 Oct 2021 13:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211011114723.204-1-carenas@gmail.com> <20211011195550.3355-1-carenas@gmail.com>
In-Reply-To: <20211011195550.3355-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Oct 2021 16:03:57 -0400
Message-ID: <CAPig+cQi_baTaV+Z=UJcrwS+C1dYnQ6bKEA-Bcim2VUOu8VGJA@mail.gmail.com>
Subject: Re: [PATCH] gitk: avoid hardcoded 40 character length for oid
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Rostislav Krasny <rosti.bsd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 3:56 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Current git could return ids larger than 40 characters if using
> SHA-256.
>
> Detect if the current repository does and set the oid_size to 64
> instead, but fallback to 40 for backward compatibility.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/gitk b/gitk
> @@ -12338,6 +12347,18 @@ catch {
> +if {![catch {exec git config --get extensions.objectformat} oid_type]
> +    && $oid_type eq "sha256" } {
> +    set oid_size 64
> +} else {
> +    set oid_type "sha1"
> +    set oid_size 40
> +}

Should this be using:

    git rev-parse --show-object-format

rather than `git-config`?
