Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D003C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 08:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhLKIHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 03:07:02 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:46707 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhLKIHC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 03:07:02 -0500
Received: by mail-pf1-f176.google.com with SMTP id o4so10420249pfp.13
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 00:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWGVUJEdA1Dg1t080HGEv+q0QCbq0jBl6gk5BaZDkCs=;
        b=XhR9nwbCeEpkLPY92xZ5SdZu+TV54042CCLlPPvKkf5FzewdL1YvoptTZIDFraR8rL
         7mAIUC/2fWufZn2Tg7d9YUSxwAXiy0BvvL8FgV9CvWzDYWdzDUSyk2wtCg3fAoMV/PMW
         qdJyDv66QBQUVafmsTELL8/12jigKpke2Y3qQDQYigbpKvcP5Z549smN/Xe5eVBm5xbF
         gU8Gunsv3eRIfNhfEiBnPQEKLnh+02Q0rSHeL0Yx7HaaDWnBDEGgTYZa2Kqs1BzsBBZx
         UY5u8RTid8KixHYRGz8p8Cwzni81/Mid9QVE6TKeSXRJXR/FVTYQT9FDnnVO8tmqzQ1Q
         Af7w==
X-Gm-Message-State: AOAM530XlfGImopOUwcCmz8XKYrKhli45k4MrnkvIFN0jZN1kvT+SqjQ
        ODkKrfJBqhFlZNHUbM5RUYcCtYP/20vn+CWF1QRYjQBPd+5pXw==
X-Google-Smtp-Source: ABdhPJwZJgMt66YzLtXSt/dBwZ4ABeLVbdYeGrDbbCOjOwSdKqo/NPUOqZEIkTjWYReOl+FflHNHiri6kMaxlk5/pRw=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr22680151pfh.67.1639210022030; Sat, 11
 Dec 2021 00:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-18-sunshine@sunshineco.com> <20211210095303.xx3fxxtp5ww3s24x@fs>
In-Reply-To: <20211210095303.xx3fxxtp5ww3s24x@fs>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Dec 2021 03:06:51 -0500
Message-ID: <CAPig+cQ7y+DqOTbtdtPJ6=pgwE-zZnE=E+ixvNkHaTMWEXjRew@mail.gmail.com>
Subject: Re: [PATCH 17/19] t4000-t4999: detect and signal failure within loop
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 4:53 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> On 09.12.2021 00:11, Eric Sunshine wrote:
> >-      for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
> >+      for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i" || return 1; done >x &&
>
> I understand why the `|| return` in loops makes sense. But for these very
> simple ones just using `echo` I'll probably be confused if a linter starts
> to complain about them (probably depending on how specific the lint error
> will be).

I understand your concern and had second thoughts about flagging this
sort of thing since there are so many loops which obviously shouldn't
fail, thus inserting `|| return 1` in them is just busy work to pacify
a linter which isn't smart enough to distinguish the important cases
from the unimportant ones. As such, I had some trouble justifying (to
myself) that this linter complaint is really a good idea, but
eventually convinced myself that it's worthwhile in the long run for
the same reasons I mentioned in my response to another patch in this
series. Namely, (1) there are good number of cases in which the loop
body is populated with "real" commands which could fail, so we really
do want to be told about missing `|| return 1` in general, and (2)
it's easier to have a single simple rule which we can point test
authors at ("end all loop bodies with `|| return 1` (or `|| exit 1` in
a subshell)") rather than complex rules laying out cases when you must
or need not use `|| return 1`.
