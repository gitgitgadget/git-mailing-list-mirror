Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E0B1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 19:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeHSXG6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 19:06:58 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38147 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeHSXG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 19:06:58 -0400
Received: by mail-qt0-f196.google.com with SMTP id x7-v6so4833246qtk.5
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 12:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcAcLFeHpRANAnVazYbiIlLkNT1Lw/1G7Cikyj8eJhQ=;
        b=qVgTtsD+LtUJn6safiNznKmbe+mMuftE+oMPmaagCIww5CMcYtEa4KbnKs50EXOyn3
         q7Y0H6b7TGzV+hlGiSHr3O33OYODD7cbAjmnKwo2Y70M+c/Os//er6cDbsCSv8zpBgeW
         h+tGabrdJw5SkXKrybsQh8i9pzaBqFmTye71ibOZf+tSBiW5P4BznTu6dJwmH/swZJnc
         SWx1elZ1MCSdrR/UT+P/mj8bRq+aFUa60pckusMK9RRim64/wpIXzTg5idCEOcwFYQXj
         JYK6KfdKhyfk7JQv0OQdFx/aOVp5aIoCyTxpp77zJGf5vmnkQZqo4WyO23lkDSQt5Z/q
         xvzw==
X-Gm-Message-State: AOUpUlG0LElke1kecHzhLOhHOaEZu6esR6vTrcDO7ZGqlhK5bKSltl/X
        VmCcn2YOUo/JmzbhZPRAdq+t+1wK9yVLaJ949Yk=
X-Google-Smtp-Source: AA+uWPzFaE0S5LjVkwGN5lJQBi4lqmeO6FgFRG5D10z4WntU11a8hs0SzNoHiAvyc7ZBHVxasZpVvhpm4MVbco3M/H8=
X-Received: by 2002:ac8:3872:: with SMTP id r47-v6mr41664754qtb.69.1534708460415;
 Sun, 19 Aug 2018 12:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180819175351.449973-1-sandals@crustytoothpaste.net> <20180819175351.449973-3-sandals@crustytoothpaste.net>
In-Reply-To: <20180819175351.449973-3-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Aug 2018 15:54:09 -0400
Message-ID: <CAPig+cTmSN3CGGW0ws2K-CHrvVon4W+iFS_MdTxSY-TP6OUh1Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] t0000: use hash translation table
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> If the hash we're using is 32 bytes in size, attempting to insert a
> 20-byte object name won't work.  Since these are synthesized objects
> that are almost all zeros, look them up in a translation table.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> @@ -1007,12 +1007,13 @@ test_expect_success SHA1 'validate object ID for a known tree' '
>  test_expect_success 'put invalid objects into the index' '
>         rm -f .git/index &&
> -       [...]
> +       suffix=$(echo $ZERO_OID | sed -e "s/^.//") &&

What's this "suffix" thing for? I don't see it used anywhere.

> +       cat >badobjects <<-EOF &&
> +       100644 blob $(test_oid 001)     dir/file1
> +       100644 blob $(test_oid 002)     dir/file2
> +       100644 blob $(test_oid 003)     dir/file3
> +       100644 blob $(test_oid 004)     dir/file4
> +       100644 blob $(test_oid 005)     dir/file5

So, test_oid() knows about these keys because the patch 1/11 loaded
them via test_oid_cache(). Are the keys in oid-info/hash-info and
oid-info/oid going to be needed by multiple scripts? If so, I'm
wondering if it would make more sense to have test-lib-functions.sh
load them instead of expecting each script to do so. Another
possibility is to have a test_oid_init() function in
test-lib-functions.sh which both loads that low-level information and
initializes the hash algorithm.

>         EOF
>         git update-index --index-info <badobjects
>  '
