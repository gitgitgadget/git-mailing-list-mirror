Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2339AC433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CD12074F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGZWyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:54:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50621 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGZWyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 18:54:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id c80so12462181wme.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 15:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSnhO3iQDgbaQNT6Y7smmSuu08J4dCwxegRZwcbNSq0=;
        b=h4wFgepAzT/ZnN8WBWFikyK8qSJuyrJ4eSCRI+5XZ1wjb4vkXdymvIvcKYwxAr5Bby
         ag9HzgiojeacrxFE1bvcJZf/pSFlhenZp38JqNDCRJ90GcWXmz3WZd3rPUF5VTF8u3Vf
         jhIdgsFdhsS4UW9yeDPsfZEg5eyMFWMHsTQ9T9ttu5Nfdx1iddWYWK1dMRYA/l2mr34a
         g4cKStnSMWLbeCm6e29dll+M/hkKkglm0+ZBVWkw0oLjRh5wjyx3SAKFGIhsaYAxZ5J4
         HMc1FALHTocWYpBaHS4fbDP2r4i16AiugUZ3nLp02w+liycHcZ3+23PsHK0VN0jsHuWr
         5Vig==
X-Gm-Message-State: AOAM532oCs9tOr0DtulO2h7rYVGSNHb+O4GkHhdZrknkU2ZgeRt/MWzZ
        zfEn8rFbt6gI5oNgZgdLMJFPfZH/9z/cRdLgxfblrlbcEZU=
X-Google-Smtp-Source: ABdhPJzfnBWQjf5a3YhhUjgiyJQNARmYQ+/2WUEjMs13hb/wZZsgQSmtw9tlrllafR60vmpMNOieri2vtIjQcN86lEU=
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr1452555wmh.177.1595804061696;
 Sun, 26 Jul 2020 15:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-13-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-13-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 18:54:10 -0400
Message-ID: <CAPig+cQcK9t6fo7xZc03VCpdSfVmP+5NKjZgvshkLP74B6-ysQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/39] t7201: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Adjust the test so that it computes variables for object IDs instead of
> using hard-coded hashes.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> @@ -230,9 +230,10 @@ test_expect_success 'switch to another branch while carrying a deletion' '
>  test_expect_success 'checkout to detach HEAD (with advice declined)' '
>         git config advice.detachedHead false &&
> +       rev=$(git rev-parse --short renamer^) &&
>         git checkout -f renamer && git clean -f &&
>         git checkout renamer^ 2>messages &&
> -       test_i18ngrep "HEAD is now at 7329388" messages &&
> +       test_i18ngrep "HEAD is now at $rev" messages &&

This test computes (and uses) the value 'rev'...

> @@ -250,7 +251,7 @@ test_expect_success 'checkout to detach HEAD' '
>         GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
> -       grep "HEAD is now at 7329388" messages &&
> +       grep "HEAD is now at $rev" messages &&

... and then this separate test re-uses that value, which
unnecessarily couples these tests tightly. How about instead just
re-computing the value of 'rev' in the second test, which will make it
easier to run individual tests while skipping others.
