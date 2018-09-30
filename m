Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C6D1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 04:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeI3Kh3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 30 Sep 2018 06:37:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40060 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeI3Kh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 06:37:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id e9-v6so10735058qtp.7
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 21:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R4ejg1FzeAWrqwqtUV+LSwT3yNsUQWSiqqfkmwZ+JGg=;
        b=bNpUYyJEKognr5qU3SawvRJoXeFbSoqhUSAgEVzm862Jxq47jbIYiPeyoL/qPGPvno
         fAabVncRm4+KcQ/I5qZ29iVzlTDtbkqCFyMJROE1ogA0pOrQuUz/5g/VxOAGHJi0oq/I
         5Q7kKC0h/BwXr2i6DFET5nI3IxjE2q14V0ivrPqATg0gUzgspWSCaAm0EWwCuILfj9aq
         4ZtncH74oivH+nbjdrugMiodfyfMtqBLC8rKBAaPc6O5QgLvqmpyB9u1a3tZBqI83e3e
         4kabTzb1ntetv7BksytJza6d7yiuYQfp3W2asCU6WY1d8bdHv1Hj7nJI86AGAzBDCMSU
         CDaw==
X-Gm-Message-State: ABuFfoj2RpDLQfjR8pk9k0YbnQ0ydKebkEXs4MOsD16kiAF+v3NGA8eH
        WOdQ9hHITmi0z9fqJo1xeJlsSc2QVGX/Xbn1wl0KCw==
X-Google-Smtp-Source: ACcGV60on+lM5JH4Oh6Yvc6l/8pc9/2G1c8a5+M79/tvErzM4jan43egyj4WZFP8u0a9Emj7kPP7J+2NYhfSCSBw+I4=
X-Received: by 2002:ac8:764c:: with SMTP id i12-v6mr4078968qtr.250.1538280369949;
 Sat, 29 Sep 2018 21:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <20180929153005.10599-1-pclouds@gmail.com>
 <20180929153005.10599-2-pclouds@gmail.com>
In-Reply-To: <20180929153005.10599-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 00:05:59 -0400
Message-ID: <CAPig+cSTvewR51Vj-4MKGJKVzqFMhf4nz5yy_PdFP+EF6qMKrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t1300: extract and use test_cmp_config()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 11:30 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> In many config-related tests it's common to check if a config variable
> has expected value and we want to print the differences when the test
> fails. Doing it the normal way is three lines of shell code. Let's add
> a function do to all this (and a little more).
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -747,6 +747,30 @@ test_cmp() {
> +# similar to test_cmp but $2 is a config key instead of actual value
> +# it can also accept -C to read from a different repo, e.g.

Minor: maybe say that "-C <dir>" changes to <dir> for the git-config invocation.

> +#     test_cmp_config -C xyz foo core.bar
> +#
> +# is sort of equivalent of
> +#
> +#     test "foo" = "$(git -C xyz core.bar)"

Should be: $(git -C xyz config core.bar)

> +test_cmp_config() {
> +       if [ "$1" = "-C" ]
> +       then

Style:

    if test "$1" = "-C"
    then
        ...

> +               shift &&
> +               GD="-C $1" &&
> +               shift
> +       else
> +               GD=
> +       fi &&
> +       echo "$1" >expected &&

If $1 starts with a hyphen, 'echo' might try interpreting it as an
option. Use printf instead:

    printf "%s\n" "$1" &&

> +       shift &&
> +       git $GD config "$@" >actual &&
> +       test_cmp expected actual

Please choose names other than "actual" and "expected" since those are
likely to clobber files of the same name which the test has set up
itself. (Or, at the very least, document that this function clobbers
those files -- but using better filenames is preferable.)

> +}
