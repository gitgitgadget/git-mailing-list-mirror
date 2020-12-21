Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C792C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3795722B45
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgLUHVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 02:21:34 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37998 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUHVd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 02:21:33 -0500
Received: by mail-ed1-f51.google.com with SMTP id cw27so8628654edb.5
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVlIEc9eJzlm3CWxA6BaNmoJGp5acJlf6tGQ6Y663j4=;
        b=rVCZ0TERHwh+WXL0mjDFnXa5xt8c4tToY6oyok+aYCoKMFdzWVhwMNd2osReSZF8ky
         1uC4f6fl6c4ww4NysP4QhpCQ2QUGmBRadrzq8ZDMl/XJO9x4rxZvsgiGNrT1bOVRmXvi
         JuJJzPk6SOXAaY2RtxabTohfFUEXFV3rfh/MbcF4GWL4TQk2B4WAZCt/xXXsW0zg4ES1
         qi8/Mb2wtcANgC+dsrjco70wnC2Yj2PLfVnh6iCDyXuCQOXNeS1fBqcq95HNVckmHyOr
         LuOY6ZHKjertqrro6DLkht6/rmn1QCnKuRlZDabEG7KQUkcbChPZvcAjWeQXcoMkEJan
         8qfA==
X-Gm-Message-State: AOAM532Nhj4G4vFC8qOXettGtHx/upOCSJOnzUH232Y7UblJyJ740vzr
        GsvcUloX+iiPg51hpkHFvUwufCV7xgADkG3DdSA=
X-Google-Smtp-Source: ABdhPJw63k+j3tNGwt4FjXpYL9z+uJj/oSmPGZWpVeSPJOWI6AiVnRHrn7E4PfhCGAV3/tPVoD+ZqnQKuH7aWzLgcgI=
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr14529430edv.181.1608535251497;
 Sun, 20 Dec 2020 23:20:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
 <pull.820.v3.git.1608516320.gitgitgadget@gmail.com> <20cff2f5c59adb1076c845657aabed7ebbf0a6b5.1608516320.git.gitgitgadget@gmail.com>
In-Reply-To: <20cff2f5c59adb1076c845657aabed7ebbf0a6b5.1608516320.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Dec 2020 02:20:40 -0500
Message-ID: <CAPig+cStb8a7QW-TDit2mfodEQMcPQTsCB0eJX=BMZJzo-TmUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] negative-refspec: fix segfault on : refspec
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 20, 2020 at 9:05 PM Nipunn Koorapati via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The logic added to check for negative pathspec match by c0192df630
> (refspec: add support for negative refspecs, 2020-09-30) looks at
> refspec->src assuming it is never NULL, however when
> remote.origin.push is set to ":", then refspec->src is NULL,
> causing a segfault within strcmp
>
> Tell git to handle matching refspec by adding the needle to the
> set of positively matched refspecs, since matching ":" refspecs
> match anything as src.
>
> Added testing for matching refspec pushes fetch-negative-refspec

s/Added testing/Add test/

> both individually and in combination with a negative refspec
>
> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
> diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> @@ -186,4 +186,26 @@ test_expect_success "fetch --prune with negative refspec" '
> +test_expect_success "push with matching ':' refspec" '
> +       test_config -C two remote.one.push : &&
> +       # Fails w/ tip behind counterpart - but should not segfault
> +       test_must_fail git -C two push one
> +'

Nit: It is understood implicitly that Git should not segfault (or
indeed any software). That's also implied by use of test_must_fail()
which explicitly distinguishes expected failures from unexpected
failures (where segfault falls in the category of unexpected failure).
Therefore, it doesn't really add value to say "but should not
segfault" in the comment.

Same observation applies to the other similarly-worded comments in
this patch. Not alone worth a re-roll, but perhaps worth changing if
you do re-roll.
