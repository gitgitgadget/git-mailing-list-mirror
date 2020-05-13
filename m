Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12AC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C83A2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgEMPpG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 13 May 2020 11:45:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34205 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgEMPpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 11:45:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id y3so28519wrt.1
        for <git@vger.kernel.org>; Wed, 13 May 2020 08:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qYghwHU8Z2Bq3b+IIuhRAVBL1EplRTF2JZwJs2Qm4Jg=;
        b=r3hyU3ki3eCLp+x352byHvScMdsl771TS8D4Tw6TLe9MfY0rZnkpg5JdmpDdc8yzXS
         04hDkw/HaerU6pKZ1dC9avDsSVZzLd/CeDwfKeLuHKIbwChNZr7BZEvb99NocjvnueUu
         9qSDpGlbhV2T63JzNDkVG5u0OIbUY7tybubb3dNZfa6FsLz9PWRiJkxFHjHeeN0HDI6B
         23vvBnRQyxqjJ4paCHqE55Mw9uXlIlKKWQbTEXf4Zr4DxF7YjjZymNUy4+9fpPXTsLbP
         bwlTZqfSemU2uF5F60kS3PnaVONDu9oN6muWOFgy3IXBRqJoy2zWalr97s5J+8b9JGQl
         kFCQ==
X-Gm-Message-State: AGi0PuaYeiYXN7VAvcN3vK7USmjcQ+gHLfkdYzyfHi1Yue1ALrVDAh+8
        jXILdNTEcZwEc2dbPrIksSTGXocPJt3kS5wPlEkLoBDk
X-Google-Smtp-Source: APiQypK46rucM1oitOs2pnjXHuy2aBLuDhhQ9yin1JNT/mXNTYxfwT40+iU9WyRghfXyCRadO9dE0LKSwHbPLaC0Qv4=
X-Received: by 2002:a5d:6401:: with SMTP id z1mr33735055wru.226.1589384704239;
 Wed, 13 May 2020 08:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200513111636.30818-1-carenas@gmail.com>
In-Reply-To: <20200513111636.30818-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 May 2020 11:44:53 -0400
Message-ID: <CAPig+cTUc2-ddWQ+oww5Ez7_N9qKgCuErk8OuOgPkXNrACdppw@mail.gmail.com>
Subject: Re: [PATCH] t4210: detect REG_ILLSEQ dynamically
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Ed Maste <emaste@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 7:17 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> 7187c7bbb8 (t4210: skip i18n tests that don't work on FreeBSD, 2019-11-27)
> adds a REG_ILLSEQ prerequisite to avoid failures from the tests added with
> 4e2443b181 (log tests: test regex backends in "--encode=<enc>" tests,
> 2019-06-28), but hardcodes it to be only enabled for FreeBSD.
>
> Instead of hardcoding the affected platform, add a test using test-tool to
> make sure it can be dynamically detected in other affected systems (like
> DragonFlyBSD or macOS), and while at it, enhance the tool so it can report
> better on the cause of failure and be silent when needed.
> [...]
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
> @@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
>  {
> -       int flags = 0;
> +       int ret, opt_s = 0, flags = 0;
> [...]
> +       if (!strcmp(argv[1], "--silent")) {
> +               opt_s++;

Nit: When reading the declaration of 'opt_s', I found the name
inscrutable; it was only upon reading the actual code, that I
understood that it reflected whether --silent had been used. How about
giving it a more easily-understood name, such as 'silent'?

> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> @@ -56,21 +56,29 @@ test_expect_success !MINGW 'log --grep does not find non-reencoded values (latin
> +test_have_prereq GETTEXT_LOCALE &&
> +! LC_ALL=$is_IS_locale test-tool regex --silent $latin1_e $latin1_e EXTENDED &&
> +test_set_prereq REGEX_ILLSEQ

Nit: Is there precedent for formatting the code like this? At first
glance, I read these as three distinct statements rather than one
large composite statement. I wonder if indenting the continuation
lines would make this more easily-digested.

>  for engine in fixed basic extended perl
>  do
> +       ireq=
>         prereq=
> +       case $engine in
> +       basic|extended)
> +               ireq=!REGEX_ILLSEQ,
> +               ;;
> +       perl)
> +               prereq=PCRE
> +               ;;
> +       esac

Why do you introduce a new variable 'ireq' here considering that...

> +       test_expect_success !MINGW,GETTEXT_LOCALE,$ireq$prereq "-c grep.patternType=$engine log --grep searches in log output encoding (latin1 + locale)" "
> +       test_expect_success !MINGW,GETTEXT_LOCALE,$ireq$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "

...it is always used alongside 'prereq'? It seems that you could just
assign "!REGEX_ILLSEQ" to 'prereq' without need for 'ireq'. (And
'ireq' is a rather inscrutable name -- I have trouble figuring out
what it means.)

>                 LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> @@ -1454,12 +1454,6 @@ case $uname_s in
> -FreeBSD)
> -       test_set_prereq REGEX_ILLSEQ
> -       test_set_prereq POSIXPERM
> -       test_set_prereq BSLASHPSPEC
> -       test_set_prereq EXECKEEPSPID
> -       ;;

The commit message explains why you remove the 'REGEX_ILLSEQ', but why
are all the other lines removed, as well? Such removal seems unrelated
to the stated purpose of this patch.
