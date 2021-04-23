Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61082C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD9D61249
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbhDWVId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:08:33 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33517 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbhDWVIB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:08:01 -0400
Received: by mail-ed1-f53.google.com with SMTP id cq11so15254388edb.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzD7tOfXzrIp/NVtlsJzVV/FS83KB2tqD5Ws2kg+poo=;
        b=cG4y+c8O9XWRqIOBswV5l/NiZkEYB+HlMNGKgFbDjYqgmqN5in3KE6yU7qrQd7Yddv
         J//iVGDMpn8mf9K7K9935143U0hcOsxV3ENWASraY/lw/1kStE4q2uTInnT2xSTmKIjg
         aYTKtLfxdqSQyCj9GPpvILC1QG+88dqjYt68fI9kNOber0gBROZkHgCFEKtFD1L6Kavh
         rwy0QWsds5z9V9cQphPS0F3P+OUcPgWQU7s4L9SbJxuCK9j8Rbm7YfZs0KxsFOdiF0/P
         ReaUUOKzmnzTZDE+DEwzS2XXBTEkyeuQpCdk4nkMWRcaR13IpCcFKLJekUXT1pd8ap/j
         lv4w==
X-Gm-Message-State: AOAM530DgPzDiM1t/GrfFr7S0ys3Hi69jt58J4Dld2VqEf77w9y2zHiI
        eMdAJkyNsO12ogu/hWUJcnHT9D9LID98FJNjmPE=
X-Google-Smtp-Source: ABdhPJw4KrI8Led0oxKm2qGKu+UbN3rmTmBXLR+KWr7KcdI3driVypGNYfhGrt98rGx7mtm66hPnodEWuqnu0/Troao=
X-Received: by 2002:a05:6402:145:: with SMTP id s5mr6661008edu.221.1619212043007;
 Fri, 23 Apr 2021 14:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-25-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-25-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 17:07:12 -0400
Message-ID: <CAPig+cRaQnZ7DWYdU+efNpMgxdniXNQdF43TSFiaj6ezLELC_g@mail.gmail.com>
Subject: Re: [PATCH 24/30] subtree: don't let debug and progress output clash
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> Currently, debug output (triggered by passing '-d') and progress output
> stomp on eachother.  The debug output is just streamed as lines to

s/eachother/each other/

> stderr, and the progress output is sent to stderr as '%s\r'.  It is
> difficult to distinguish between the debug output and a progress line.
> When writing to a terminal the debug lines hide progress lines.
>
> So, when '-d' has been passed, spit out progress as 'progress: %s\n',
> instead of as '%s\r', so that it can be detected, and so that the debug
> lines don't overwrite the progress when written to a terminal.

Makes perfect sense when output is to a terminal, though might be
annoying for the person who redirects stderr to a file. Just idly
wondering if it makes sense to take that case into consideration...
(but maybe it doesn't matter much when someone is working at debugging
a problem).

> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> @@ -53,7 +53,12 @@ debug () {
>  progress () {
>         if test -z "$GIT_QUIET"
>         then
> -               printf "%s\r" "$*" >&2
> +               if test -n "$arg_debug"
> +               then
> +                       printf "progress: %s\n" "$*" >&2
> +               else
> +                       printf "%s\r" "$*" >&2
> +               fi
>         fi
>  }

Subjective (not necessarily worth changing): An `echo` would suffice
in place of `printf "...\n"`:

    echo "progress: $*" >&2

It _might_ be worthwhile to have an in-code comment here explaining
why progress() behaves differently in debug mode, especially if the
reader is confused about why one case explicitly emits "progress:" and
the other doesn't.
