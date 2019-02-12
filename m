Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F771F453
	for <e@80x24.org>; Tue, 12 Feb 2019 03:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBLDc1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 22:32:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37445 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfBLDc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 22:32:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id m9so7891357qkl.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 19:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7rXjkbYTNX4agMoP7yoCqt2G2OM25+a3Y1eO3S1PAQ=;
        b=qu1D8x6BgRO5pyJnUD8ejfS5siHrlSKpA1hUKIi3vCWuc1all2k/kRHkPZ6+xRQxRh
         HpDWfanFnw/f5CNMB3FRc202tq5IizV5aYSrW6RICMCBU2iMnrS9no9OszFSEWyMMHTl
         1zhkpO7heCLvaIwKGHRSgpO+BzdTD4OVWW9F4Xn3bgJu8jhjCuuOM4kc5yvtJ3kx+Stm
         2tAMgL7UPnxTTPCqsYdC2GEjl/Stw3Jz3X7ZLT4dQbwnjdgqxxAbx4iPpNdfr4RVukfQ
         tdA9lznqKyIeU2tawC+GVoRizlLhn13irjflOL9wbgkBzQUZl6vmFUiwCurZMPIVe29A
         tqcw==
X-Gm-Message-State: AHQUAuaMF3TqqhAIDYCAgTs2VFVe6tnANF31dxJkxgmdIISru6bn0avj
        kAmc3Q687xa0cAkyhaM+jCprTcdIbDkK6wZD7JDiOA==
X-Google-Smtp-Source: AHgI3IZzzNoCSZp4EXjk80iwH3xkm1rMXCK7dusgOskn++F8LoaoKOY3nWWJrBliNW3wSAQWAioW4s5EYTkC+hW2/Tc=
X-Received: by 2002:a37:404f:: with SMTP id n76mr1156288qka.26.1549942345916;
 Mon, 11 Feb 2019 19:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-11-sandals@crustytoothpaste.net>
In-Reply-To: <20190212012256.1005924-11-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Feb 2019 22:32:15 -0500
Message-ID: <CAPig+cS3i2FWf6mFmpPpctyJJbx4xdHgWXrveRUkjMHct5SbJg@mail.gmail.com>
Subject: Re: [PATCH 10/31] object-store: rename and expand packed_git's sha1 member
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
> This member is used to represent the pack checksum of the pack in
> question.  Expand this member to be GIT_MAX_RAWSZ bytes in length so it
> works with longer hashes and rename it to be "hash" instead of "sha1".
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> @@ -689,7 +689,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
>         while (pl) {
>                 printf("%s\n%s\n",
> -                      sha1_pack_index_name(pl->pack->sha1),
> +                      sha1_pack_index_name(pl->pack->hash),

I guess there is no oid_pack_index_name() function yet?

> diff --git a/http-walker.c b/http-walker.c
> @@ -434,7 +434,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
>         if (walker->get_verbosely) {
>                 fprintf(stderr, "Getting pack %s\n",
> -                       sha1_to_hex(target->sha1));
> +                       sha1_to_hex(target->hash));

Should this have become oid_to_hex()?

>                 fprintf(stderr, " which contains %s\n",
>                         sha1_to_hex(sha1));

The patch isn't touching this sha1 yet, so this is okay(?).

> diff --git a/http.c b/http.c
> @@ -2262,10 +2262,10 @@ struct http_pack_request *new_http_pack_request(
>         strbuf_addf(&buf, "objects/pack/pack-%s.pack",
> -               sha1_to_hex(target->sha1));
> +               sha1_to_hex(target->hash));

oid_to_hex()?

> @@ -2289,7 +2289,8 @@ struct http_pack_request *new_http_pack_request(
>                         fprintf(stderr,
>                                 "Resuming fetch of pack %s at byte %"PRIuMAX"\n",
> -                               sha1_to_hex(target->sha1), (uintmax_t)prev_posn);
> +                               sha1_to_hex(target->hash),

oid_to_hex()?

> diff --git a/packfile.c b/packfile.c
> @@ -722,8 +722,8 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
>         if (path_len < the_hash_algo->hexsz ||
> -           get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->sha1))
> -               hashclr(p->sha1);
> +           get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
> +               hashclr(p->hash);

get_oid_hex()?
