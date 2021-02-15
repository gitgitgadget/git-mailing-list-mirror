Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E90C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 01:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370DB64E29
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 01:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBOBZH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 14 Feb 2021 20:25:07 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44420 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhBOBZG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 20:25:06 -0500
Received: by mail-ed1-f50.google.com with SMTP id g3so3796066edb.11
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 17:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vK/iBpazoFxc/s50yYKZ20lZwX+9Y3C9TddIssOGHMs=;
        b=jreO6k5wRKWrvCg46bVGuYXUVPmwKkZwGdkXPvmu4VIfSpvyglrpMvJaOQU3fBATzA
         Zcvax6HdgH4OZRfQY8h1PWh8FkBGpY+8KkNLL6nfU0CAnO03YzfZoiLcqwTGRERi5GyL
         fRCnqV/k9fJoTqYahnF2Wlj1BPJKV3TRbZ4eQNEvavx6NM7spoU9qYsLIftlBoK4+8BP
         775lHJ5OixOCJEjpuF5CotcvhClu0WTByqn9ynF/SwESpQjIKnflKmEm/fh62QDpkrsx
         5u4Y82bsUkpPb8Jk4WSeXtrOicje1PGS233GDKrFL8LwUcqhzL1if8lKUwbAL67P8r/Q
         rFOg==
X-Gm-Message-State: AOAM533TEFuVe9r7mELDri5YXoIZjA4hPBKoP4I/IbaIfBioJ6kWvwcg
        BMsu3PG01UHoZpfqGd/9H3KRmkbiwYteHj2eRme5Naz3
X-Google-Smtp-Source: ABdhPJyK09gwY8j7EpLRFIr3U3eC4qq9DSl0N9x2ClAGKCxdHmltkfjWcw4JSjJJrTafoXFcEUtMB9DdHpa+iorQRQQ=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr13358551edz.89.1613352264506;
 Sun, 14 Feb 2021 17:24:24 -0800 (PST)
MIME-Version: 1.0
References: <87tuqebj6m.fsf@evledraar.gmail.com> <20210215005236.11313-6-avarab@gmail.com>
In-Reply-To: <20210215005236.11313-6-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Feb 2021 20:24:13 -0500
Message-ID: <CAPig+cQbPkfh7f2VpeCitRwRMothYqUvUqQk0HiZnUGUpvWTvw@mail.gmail.com>
Subject: Re: [PATCH 05/20] userdiff tests: list builtin drivers via test-tool
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 14, 2021 at 7:56 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change the userdiff test to list the builtin drivers via the
> test-tool, using the new for_each_userdiff_driver() API function.
> [...]
> I only need the "list-builtin-drivers "argument here, but let's add
> "list-custom-drivers" and "list-drivers" too, just because it's easy.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
> @@ -0,0 +1,32 @@
> +static int userdiff_list_builtin_drivers_cb(struct userdiff_driver *driver,
> +                                           enum userdiff_driver_type type,
> +                                           void *priv)
> +{
> +       puts(driver->name);
> +       return 0;
> +}

Nit: The word "builtin" in the name of this callback function made me
search the patch for its cousin function which would be used for
custom drivers. It was only after reading on that I discovered that
this one function is used for both builtin and custom drivers. (Caught
me off guard, but not itself worth a re-roll.)

> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> @@ -8,6 +8,10 @@ test_description='Test custom diff function name patterns'
>  test_expect_success 'setup' '
> +       test-tool userdiff list-builtin-drivers >builtin-drivers &&
> +       test_file_not_empty builtin-drivers &&
> +       builtin_drivers=$(cat builtin-drivers) &&

Nit: I get why you are using test_file_not_empty() for its diagnostic
value, but it does confuse the reader a bit to see the file
"builtin-drivers" created for no particularly good reason. This could
easily have been:

    builtin_drivers=$(test-tool userdiff list-builtin-drivers) &&
    test -n "$builtin_drivers" &&

Subjective and not worth a re-roll.
