Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7557C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbhKVM6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhKVM6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:58:52 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAC2C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 04:55:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so76429755edc.6
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 04:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+xS2HnUe0DAwmPHmnqOyTu3ZAApUCsGzgMNjScoZKI=;
        b=Biy/L6ywYF48rLHqM6/RKfd0ATHKemp+cwh8WyWQnNWh59hMY1yLeRkOtdsf7ZauTk
         jXdRB4M7TP8J4e9gwab3i8B/p8MDhsFvyDEQ8Ir6XAc9BT32GvxgopbqrsQIHC2eI1nd
         TQr5ZqRH+QLk3AYH+BZpaVL1BvQSBcjnOqMuhBJ6lqHPx4Wi5i+d5v7KhAXiztR6INUp
         VNRGrZBZVWp6fQLUZe2kahzKDnLdeEzJ/tBbMwiV3iuYiqquGZ+M2e4XBECjUD1v1Vqb
         phaY3TPQ9j1q0gF8yIrF3HH4qCGeQ3GyGshvWp/5Yb3+QN6+Oikq30CZzV+UhtcZx2I2
         akCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+xS2HnUe0DAwmPHmnqOyTu3ZAApUCsGzgMNjScoZKI=;
        b=1VnHQNZQq5e8R9LTNqUpH2/6uE6AmREsl2V28FgqBi6hK3VpKasW6sPTmt3w8BWaj5
         9x39iANKQOwF5l6N7ceApJ+imsnOe5Fs+ND5Vk1v47dcn//ALVFqjK/wzoWlErEvEBQV
         ghy/VqbXUdm3kWQRPs76Ay4gIrk5jY3WqxQVkOQmqaGLrUCXI2bBQKLxmNtCbmzDAYn/
         SY47/Pt5n73IYFttnMv+rOOohKjaaaGD+OnxdDZkouwIBAjv0EP/djzjo7l4oWQ/vSBE
         r8Y6bpbz5kxd8mZ01qlCSKCYNyHQOt7xDkQQlBPVhQLaC7FIJWQI2Tq9yOLndPObXCEW
         KODg==
X-Gm-Message-State: AOAM5322d0LtrHEVsbabUrkzqr4FWx26FkrtVtIFr+baeJR8NYaaSXY0
        x8/fGSwqcFfJSWHDxzOwxTnL7sHz/3AZ8rCGWYw=
X-Google-Smtp-Source: ABdhPJwHu719C/BOvcdeIbLFMD04awtnGFIUAkluctXMdYlx/tfxE25tUKc3r1n7HI2C5+3vy+AIOvwMEiiPAxFOLYg=
X-Received: by 2002:a17:906:4488:: with SMTP id y8mr39711856ejo.175.1637585744803;
 Mon, 22 Nov 2021 04:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20211118164940.8818-1-jack@suse.cz>
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 22 Nov 2021 13:55:33 +0100
Message-ID: <CAP8UFD0fhKxmuXT40oVj-m6nfkgH+=0isf+vo6bcXW4YbkTEkg@mail.gmail.com>
Subject: Re: Stochastic bisection support
To:     Jan Kara <jack@suse.cz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Nov 18, 2021 at 9:33 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> In some cases regressions (or generally changes) we are trying to bisect have
> probabilistic nature. This can for example happen for hard to trigger race
> condition where it is difficult to distinguish working state from just not
> hitting the race or it can happen for performance regressions where it is
> sometimes difficult to distinguish random workload fluctuations from the
> regression we are looking for. With standard bisection the only option we have
> is to repeatedly test suggested bisection point until we are sure enough which
> way to go. This leads to rather long bisection times and still a single wrong
> decision whether a commit is good to bad renders the whole bisection useless.
>
> Stochastic bisection tries to address these problems. When deciding whether a
> commit is good or bad, you can also specify your confidence in the decision.
> For performance tests you can usually directly infer this confidence from the
> distance of your current result from good/bad values, for hard to reproduce
> races you are usually 100% confident for bad commits, for good commits you need
> to somehow estimate your confidence based on past experience with reproducing
> the issue. The stochastic bisection algorithm then uses these test results
> and confidences to suggest next commit to try, tracking for each commit the
> probability the commit is the bad one given current test results. Once some
> commit reaches high enough probability (set when starting bisection) of being
> the bad one, we stop bisecting and annouce this commit.

The following project is based on Bayesian Search Theory and might be
interesting if you haven't looked at it:

https://github.com/Ealdwulf/BBChop

Best,
Christian.



















> Example:
>
> Consider an example of a stochastic bisection of the following commits:
>
> A--B--C--D-----F-----H--------K
>  \     \  \-E-/     /        /
>   \     \--------G-/        /
>    \------------------I--J-/
>
> And suppose commit I is the bad one. Let's start bisection with:
>
> # We ask bisection for 90% confidence in the identified commit being bad
> git bisect start --confidence 0.9 %K %A
>
> # Bisection tells us to test %F. Let's assume test went well and we trust
> # our test results on 70%. So:
> git bisect good --confidence 0.7
>
> # Bisection tells us to test %H. Again same result:
> git bisect good --confidence 0.7
>
> # Bisection tells us to test %J. The test should fail for %J (remember %I is
> # the bad commit) but let's assume the test is falsely positive. So:
> git bisect good --confidence 0.7
>
> # We are asked to test %H second time. Assume correct result so:
> git bisect good --confidence 0.7
>
> # We are asked to test %J second time. Assume correct result so:
> git bisect bad --confidence 0.7
>
> # We are asked to test %J again. Assume correct result so:
> git bisect bad --confidence 0.7
>
> # And %J once more. Assume false positive so:
> git bisect good --confidence 0.7
>
> # And %J once more. Assume correct result so:
> git bisect bad --confidence 0.7
>
> # And %J again. Assume correct result so:
> git bisect bad --confidence 0.7
>
> # And now we are asked to test %I. Assume correct result so:
> git bisect bad --confidence 0.7
>
> # We are asked to test %I second time. Assume false positive so:
> git bisect good --confidence 0.7
>
> # And %I once again. Assume correct result so:
> git bisect bad --confidence 0.7
>
> # And %I once again. Assume correct result so:
> git bisect bad --confidence 0.7
>
> # And %I once again. Assume correct result so:
> git bisect bad --confidence 0.7
>
> And now git tells us %I is the bad commit with desired confidence. We can see
> the bisection was able to identify the bad commit although there were three
> false positive tests (out of total 14 tests).
>
> ------
>
> This patch set implements stochastic bisection for git. The first part of the
> series improves some tests so that they accept other valid decisions for
> bisection points. This is needed because to make it easier to share some logic
> between normal and stochastic bisection, I needed to slightly change some bits
> for normal bisection and then since commit weights will be computed in a
> somewhat different order, also chosen bisection points are sometimes different.
>
> The second part of the series then implements stochastic bisection itself.
> Note that I didn't integrate any tests for stochastic bisection into 'make
> test' run yet (so far I did only manual tests) and I still need to update
> manpages etc. I plan to do that but I've decided to post the series now to get
> some early feedback.
>
>                                                                 Honza
>
> PS: Please leave me in CC for replies. I'm not subscribed to the git mailing
> list.
