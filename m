Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A891F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394878AbfJQRwl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 17 Oct 2019 13:52:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38703 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfJQRwl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:52:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id o15so2934480wru.5
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H3iPwXabJawTiD0TxmATpW1mXB3SrfybQSNjXiT/Uyc=;
        b=btEVEckkUdJOGzbsWN0AecukFbrzmkIjoYuA45RKhJ8JASJ7TLSCszPKCz1ZWqQlbP
         HzgkbTQQ/XkxhQP6tLyxNKMhxS3qlu3nH58Hd9hpXjR2Fq54kF8Vql+jCz3VJbhuN2Uu
         44LKJLRCoiZIcod8+YNIhIN0pt5P8c0Nrt96Prm8bdlQkPXVo2culNxR4tEF3JEAcuXZ
         L2Ru9aRQJHKIOnWzc9NNmveXtcwwGTpd25BSCNwupfGUkr+JVygfk8xhAD26N1RZWt/U
         wYvfjPGmN70O4qe89Ght8J/jB7Kd/RWruCcSFcdRBK5dlMtEqz0+s6IYxATI0zU7mXa7
         Nuzg==
X-Gm-Message-State: APjAAAWljWoZ9J8IR5hzI5XKjbGX6+AsTnY6+khDSTL/Y/uWUjX7dcD+
        ZFqL/cd7dy+KXSsE934h9GWoac61LFhPojqoBxg=
X-Google-Smtp-Source: APXvYqx2hBCwSJpa0VC3WQqeekOq+2LB5eQ9+KWABewZj3UbHwdGj0EObUr2Bqfw0vUa/eINtfDqXS8BgzDGzCraE1Y=
X-Received: by 2002:adf:f010:: with SMTP id j16mr4203782wro.317.1571334758804;
 Thu, 17 Oct 2019 10:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173501.3198-1-szeder.dev@gmail.com> <20191017173501.3198-4-szeder.dev@gmail.com>
In-Reply-To: <20191017173501.3198-4-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 13:52:27 -0400
Message-ID: <CAPig+cTLCTPtUWHKVBQEaP9GkrmrnHPwfef8KnktOSqYQY-jPA@mail.gmail.com>
Subject: Re: [PATCH 3/6] completion: return the index of found word from __git_find_on_cmdline()
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 1:35 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> When using the __git_find_on_cmdline() helper function so far we've
> only been interested in which one of a set of words appear on the
> command line.  To complete options for some of 'git worktree's
> subcommands in the following patches we'll need not only that, but the
> index of that word on the command line as well.
>
> Extend __git_find_on_cmdline() to optionally show the index of the
> found word on the command line (IOW in the $words array) when the
> '--show-idx' option is given.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> @@ -1069,18 +1069,32 @@ __git_aliased_command ()
>  # Check whether one of the given words is present on the command line,
>  # and print the first word found.
> +#
> +# Usage: __git_find_on_cmdline [<option>]... "<wordlist>"
> +# --show-idx: Optionally show the index of the found word in the $words array.
>  __git_find_on_cmdline ()
>  {
> -       local word c=1
> +       local word c=1 show_idx
> +
> +       while test $# -gt 1; do
> +               case "$1" in
> +               --show-idx)     show_idx=y ;;
> +               *)              return 1 ;;

Should this emit an error message to aid a person debugging a test
which fails on a call to __git_find_on_cmdline()? For instance:

    echo "unrecognized option/argument: $1" >&2
    return 1
    ;;

or something...

> +               esac
> +               shift
> +       done
>         local wordlist="$1"
>
>         while [ $c -lt $cword ]; do
>                 for word in $wordlist; do
>                         if [ "$word" = "${words[c]}" ]; then
> -                               echo "$word"
> +                               if [ -n "$show_idx" ]; then
> +                                       echo "$c $word"
> +                               else
> +                                       echo "$word"
> +                               fi
>                                 return
>                         fi
>                 done
