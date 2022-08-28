Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBAFECAAA2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiH1Euy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 00:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Euw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 00:50:52 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD1E08D
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 21:50:51 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3376851fe13so125716867b3.6
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 21:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fHuaA8x8rTsvfBTnvIKGOywQlQclyYd+mJEkyefMoYU=;
        b=xSL6EXqH76xjiJkmcnd6iC/DLinsQgz8rBeVZaA83Nh+5txw9I05b68EOgII69Gzik
         g5M5Y/NJpWHFlAhTsurJowAlsHT/sCfOeLXB2Lv/jj3RTVTYfbbVLECQkh3YmRRAVpvg
         uUSgHxEdUIhPt9IKViFqAt9AT2nutkEP6xglkZh4BXMNtmmT00f1G58KVt2eC7LxJbQV
         +JptimKDwCx7Z7m6OqSdrDOzdlzOkNCUAvkEvhWFbO36x8ujqsj9gJD6NsUjw2fMdz0D
         oZ9/OZEqbJ5q/B+SPaJTwS0ytgP16K68qFpsADfYPtFTpdZrcrReVJXVDk5riCcdYptc
         K+Aw==
X-Gm-Message-State: ACgBeo3veges/f4e1rCcg377IRuZdBRe48XtS7md/kpzjectcthIinDU
        Up3Lr8XY5AJJbZ+vmfoii2gk9/J5Ay1jVWaYBeI=
X-Google-Smtp-Source: AA6agR4CbJDyya9bfxA0y5f4wsFPBQk1OhRw0VYKeWhSaGbJEQHMwjjpYmcOuk3qg64LWxnUjxS/+cgOboyEMBKoXDs=
X-Received: by 2002:a25:7393:0:b0:699:186f:76cf with SMTP id
 o141-20020a257393000000b00699186f76cfmr4912485ybc.54.1661662250296; Sat, 27
 Aug 2022 21:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
 <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
 <CABPp-BH-QzH-5MmvBwqncxr2VQQPfAk0oEYus2HMgdmpX3ppUg@mail.gmail.com>
In-Reply-To: <CABPp-BH-QzH-5MmvBwqncxr2VQQPfAk0oEYus2HMgdmpX3ppUg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Aug 2022 00:50:39 -0400
Message-ID: <CAPig+cTGJeNJCYT2gNP8AJoohptqOD_hr2nyy1vv=HUL2u-eXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] t: detect and signal failure within loop
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 11:05 PM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Aug 22, 2022 at 11:26 AM Eric Sunshine via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Failures within `for` and `while` loops can go unnoticed if not detected
> > and signaled manually since the loop itself does not abort when a
> > contained command fails, nor will a failure necessarily be detected when
> > the loop finishes since the loop returns the exit code of the last
> > command it ran on the final iteration, which may not be the command
> > which failed. Therefore, detect and signal failures manually within
> > loops using the idiom `|| return 1` (or `|| exit 1` within subshells).
> >
> > diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
> >                 for i in $(test_seq 1 10)
> >                 do
> > -                       >unrelated/$i
> > +                       >unrelated/$i || exit 1
> >                 done &&
>
> That's not something I'm likely ever going to remember to think of as
> capable of failing and needing this special care.  Is this a
> preliminary series before you send chainlint improvements that finds
> this kind of thing for us?  Or did you notice this some other way?

This could fail due to lack of space on the filesystem or "inode"
exhaustion (indeed, I've seen out-of-space failures when I've
underallocated the ramdisk on which I run tests). But there are some
cases of added `|| return` or `|| exit` in the original series[1]
which are just churn because the code inside the loop wouldn't /
couldn't / shouldn't fail. I wasn't happy about adding those simply to
pacify a not-smart-enough linter, but I eventually convinced myself
that the small amount of inconvenience of those pointless cases was
greatly outweighed by the vast number of cases in which adding `||
return` or `|| exit` was the correct thing to do since those cases
could genuinely have allowed errors in Git or in the tests themselves
to go unnoticed.

Yes, this is another preliminary series before sending the new
`chainlint` series, and it was the new linter which found these cases.

[1]: https://lore.kernel.org/git/20211209051115.52629-1-sunshine@sunshineco.com/

> Change is fine, of course, I'm just curious how it was found (and how
> I can avoid adding more of these that you'll need to later fix up).

Although the implementation of the new linter has been complete for
over a year, I finally found time to work on polishing the patch
series itself. I had hoped to get it submitted this past week, but
time constraints prevented it. So, the answer is that the new linter
(once I submit it and once Junio accepts it -- if he does) should help
you avoid introducing more such cases.
