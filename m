Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D52C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70369206E3
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgGZXwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:52:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGZXwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:52:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id f18so3619975wmc.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJ1+oj4AOazy0XJH+0CQR8bRdI5zT79t848HICu6q6g=;
        b=qSUwMgFDhcjp0poR5uSJhVh0SpSDigpFN/WZnL7hTICO1CVG4KfBEM5U7j8QU7jjNP
         BCVJUyQ0ClPc59D6Xrs7LruLZkhhhsdEzjA+uqM8/gra8yzJsHVyNryC//s6KCT5Kpz9
         IKX7P4S3rK+Oev6sO3bSlADA5xJ15j/gV+Q8fWkDrYz03sZmTob/RwTfbhZX9lGLYAO5
         n2usGJCIjcFmDQpmWinmTmHwbPcYF3KCeR+Z7jnu10KBaq4lJAd5nY75bkmZLQ/lMWKg
         fg5/z7prZEdoVZOq4WNAwBzxjbJfYjZgiiMuDTtpr4lhPmLRxvOyFBiUG35CrR08NLks
         upow==
X-Gm-Message-State: AOAM532Qffor/Jiz3+hb5vOsHaWprqle5PEW+on0x8eGA3eVC/VMBKU5
        NL08O99ytF+1HqQlyywPGi2Hwcqvujix8C5hpqFFox7nxi4=
X-Google-Smtp-Source: ABdhPJxU6QOmTMOJMfWp1klD9xBtUBkqUUkBkDyKvFlfK7g4pZtydUzLuxLVzMmkNbetfKQg8h87+Bgc3dqUcSVUbtw=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr9066902wmh.11.1595807531201;
 Sun, 26 Jul 2020 16:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-37-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-37-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:52:00 -0400
Message-ID: <CAPig+cSLQW=fMEY0o6WByeLxrnEkp751CObWOOsM1YuuiwUvoQ@mail.gmail.com>
Subject: Re: [PATCH v4 36/39] t: make SHA1 prerequisite depend on default hash
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Currently, the SHA1 prerequisite depends on the output of git
> hash-object.  However, in order for that to produce sane behavior, we
> must be in a repository.  If we are not, the default will remain SHA-1,
> and we'll produce wrong results if we're using SHA-256 for the testsuite
> but the test assertion starts when we're not in a repository.
>
> Check the environment variable we use for this purpose, leaving it to
> default to SHA-1 if none is specified.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> @@ -1689,7 +1689,8 @@ test_lazy_prereq CURL '
>  test_lazy_prereq SHA1 '
> +       test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
> +       { test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"; }
>  '

Do we even need to run git-hash-object if GIT_DEFAULT_HASH is defined?
That is, why not something like this instead?

    case "$GIT_DEFAULT_HASH" in
    sha1) true ;;
    "") test $(git hash-object /dev/null) =
            e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 ;;
    *) false ;;
    esac
