Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31121F453
	for <e@80x24.org>; Tue, 12 Feb 2019 03:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBLDoZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 22:44:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45444 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBLDoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 22:44:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so7860771qka.12
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 19:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0j/jmVDcMGJMkstUOafQGE0liRWOqA4nRb/uRhDA/oM=;
        b=aufzqv7J//XOQ+3G87R3u79KVJBc1MyhRERmilaE24YUKMV53QVQ/C57p60obNrfzN
         ea+CaZsNK6AhmKrlsk1LqjZpACxqdy7kZ6Tj2C51z+bSrWS+MEfd7rNluRDS5oWApG2Y
         rk7QcaLh4y0MK9I0jCEfELyQK5BenwVBWW3adQVm/bJLOaoWeW63SQeWSSjViRRvPNGX
         p/tJFr/yCimTmz4k5pQU2sBAH0FZVuhdHUqJgbfRm3smrV1KMeynvfm8nCokXirwExCk
         9YsOUURr8hJz3rsl/VM3ZweB/lzHaIUAIJZ8+OO59dEDrvE4geH4J6jNesVuW6kishPZ
         hAZA==
X-Gm-Message-State: AHQUAuaWyUkQIc+qPwQdHO1iOJ8kUQAWZPvCzpEL3KNYVbXC9PZ8FHKH
        YBijxxhzdrcsKB8+wttpEcn3u7qGb9hxJ5ZhpS4=
X-Google-Smtp-Source: AHgI3IZlN7rHb0Wlx825TXORz5/q5AM0lQWcQQ4xyUyC8sjoYOKuXihkWhpoyauhaCQPlCHexl7IxciAF7nu1z80UyM=
X-Received: by 2002:a37:404f:: with SMTP id n76mr1181075qka.26.1549943063343;
 Mon, 11 Feb 2019 19:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-13-sandals@crustytoothpaste.net>
In-Reply-To: <20190212012256.1005924-13-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Feb 2019 22:44:12 -0500
Message-ID: <CAPig+cQivuPjDztK30QO0xKx1Tx+nYDPzTvgXvi9WVyRX5-aRQ@mail.gmail.com>
Subject: Re: [PATCH 12/31] fast-import: make hash-size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 8:23 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Replace several uses of GIT_SHA1_HEXSZ and 40-based constants with
> references to the_hash_algo.  Update the note handling code here to
> compute path sizes based on GIT_MAX_RAWSZ as well.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/fast-import.c b/fast-import.c
> @@ -2047,7 +2047,8 @@ static uintmax_t do_change_note_fanout(
> -       char realpath[60];
> +       char realpath[GIT_MAX_RAWSZ * 3];

I wonder if the fixed multiplier deserves a comment explaining that
this is reserving enough space for a hex representation with '/'
between each digit pair plus NUL. Which leads to the next question: Is
there is GIT_MAX_HEXSZ constant? If so, this might be more clearly
represented (or not) by taking advantage of that value.

Also, there are a number of hardcoded 60's in the code earlier in this
file, such as:

    if ((max_packsize && (pack_size + 60 + len) > max_packsize)
        || (pack_size + 60 + len) < pack_size)
        cycle_packfile();

Is that just a coincidence or is it related to the 60 characters
allocated for 'realpath'?

> @@ -2405,7 +2406,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
>                 char *buf = read_object_with_reference(&commit_oid,
>                                                        commit_type, &size,
>                                                        &commit_oid);
> -               if (!buf || size < 46)
> +               if (!buf || size < the_hash_algo->hexsz)

What exactly did the 46 represent and how does it relate to 'hexsz'?
Stated differently, why didn't this become:

    the_hash_algo->hexsz + 6'

?

> @@ -2456,7 +2457,7 @@ static void file_change_deleteall(struct branch *b)
>  static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
>  {
> -       if (!buf || size < GIT_SHA1_HEXSZ + 6)
> +       if (!buf || size < the_hash_algo->hexsz + 6)

...as it seems to have here...

> @@ -2555,7 +2556,7 @@ static struct hash_list *parse_merge(unsigned int *count)
> -                       if (!buf || size < 46)
> +                       if (!buf || size < the_hash_algo->hexsz)

...but not here.
