Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9B5C64E8A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 03:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E168F20796
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 03:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgLAD7a convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Nov 2020 22:59:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43001 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgLAD73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 22:59:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id v22so992332edt.9
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 19:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8qBeA1N4Y2zZP8o5sEfXDnwL7+B4U5z7sqVbjs5Ua6w=;
        b=h0pVIWWk/By2pPs65eh9HBxJaHEv7POzrgGWNgXGQs2PrqG9kDWfD0/dTSJ1s1O5XZ
         wqBxkFjE1kjDm5HIjHrFL8zvOrwJiGnOa/It4VCRnKj081ihyNSKcPKYnNbB3Zevuagi
         4F1Kse1Cf9FB5r8CIWH/CBhsjJ0CgeObYjrH61yCrocVhsM8av4ZlVTNAPgNhBgwWI2/
         J/DLDTueRiPgqDKMs3cCNctl135xxrKcQt8cwmiKw4+7TvFaYmOqMZwZ15dIircxUNc7
         ggT62uhvGat5dT4JpS7IUtRLWnAyv6BGZCIoy3EIhcVPDtbKVYrAhdbm5kYa+eOEKKkd
         ilEA==
X-Gm-Message-State: AOAM530b/hOy9MCKvJvGZwCFigTMPqgzAQLVcQCzrUpexOf5Wd0ChoUr
        PycxF/5Zk1yoCdSIAZSlaLPfZ02DnyfJJhNg8uQ=
X-Google-Smtp-Source: ABdhPJxj+g7OBncIRr+8i92T4uee7aNLoqq1+Qw3WGl2SdY+PUSWAMPLZ35z0Jc2d5UJckXrE8yrKVtJvQmKutKAU0g=
X-Received: by 2002:a05:6402:17b5:: with SMTP id j21mr1089080edy.94.1606795127302;
 Mon, 30 Nov 2020 19:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20201130044224.12298-1-sunshine@sunshineco.com> <87blffjkne.fsf@evledraar.gmail.com>
In-Reply-To: <87blffjkne.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Nov 2020 22:58:36 -0500
Message-ID: <CAPig+cT-axeG3UrxaQR3c+r7dMZkjmS19C3cHRVzu5KSc72BOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] make macOS `git maintenance` test work on Windows
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 4:20 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> LGTM. FWIW I think your v1 is fine too, just meant to comment on the
> basis of "you could also do it like that". Having a C program call
> getuid() is fine, so is faking it. If you prefer the latter, cool.

I do like the simplicity of the latter, and I wasn't super happy about
introducing a new test-tool subcommand just to make this one test
pass, especially since `test-tool getuid` is so different from most
other subcommands which are typically added to give us access to some
internal element of Git otherwise not accessible to the test scripts.

> I did wonder "why not just call perl -e 'print $<' ?"  first. But then
> found (by reading the Perl source[1], didn't actually test this) that it
> fakes up UID=0 for everything on Windows.

I totally forgot about Perl's `$<`.

Under the Git for Windows SDK, Perl's `$<` returns a large positive
number. I suspect this differs from what you saw in the Perl source
code because the Windows-specific code you looked at does not come
into play in this case. For Git for Windows SDK, Perl is almost
certainly instead built in Unix-like mode, linking against the MSYS2
library for its POSIX-like emulation, thus the Windows-specific Perl
goop is not needed.

> I couldn't find any "is root?" in our tree that relies on Perl's $< in a
> bad way (the couuple of occurances seem innocuous), we have some "id -u"
> checks, but those also seem OK if it returned 0 on Windows (what does it
> return?). Seems the worst we'd do there is unintentionally skip some
> "skip this as root" tests.

Under Git for Windows SDK, `id -u` returns the same large positive
number as returned by Perl's `$<`, which makes sense since `id` is
also likely linked against the MSYS2 library.

As for getuid() in Git itself, that always returns 1. I see now that's
because 1 is hard-coded in Git's compat/mingw.h override of getuid().
So, an alternative would have been for the test to use `uid=1` on
MINGW, but I like the current approach better of having the test be
UID-agnostic.

> It's also my impression that just using $("$PERL_PATH" -e ...) is fine,
> and at least to my reading the Perl RX is more readable with look-behind
> assertions, but I'm biased by familiarity with it.

The `sed` version seems simpler and more straightforward to me,
whereas look-behind feels harder to reason about, but of course it's
all subjective and not terribly important. Either would be fine.

> Our PERL prereq & NO_PERL=YesPlease is just for "this may require a
> non-ancient Perl" & "don't install Perl for runtime stuff"
> respectively. Is that not the case and we'd like to avoid new perl
> invocations where possible?
>
> I don't really care either way (or, if your switch in this case was just
> a personal preference, also fine), but if we are trying to somewhat
> discourage perl use (and maybe eventually get rid of it entirely) that
> would be a useful t/README doc update.

Using `sed` was just a personal preference, partly because the `sed`
expression seems simpler to me, but mostly because Perl still feels
heavyweight to me compared to `sed`. It also may be that I'm just
old-school, preferring the small, sharp utilities (`sed`, `grep`,
`sort`, etc.), and only turning to Perl (or one of its ilk) when the
task demands a more general-purpose tool.

I haven't measured, but it's possible that Perl may indeed be
heavyweight on Windows in terms of startup time.

> I know Johannes (CC'd) has (this is from wetware memory) wanted to
> (understandably) not need to bother with Perl as part of GFW, but I
> can't remember if that's for a reason covered by NO_PERL=YesPlease,
> i.e. packaging it up, or whether it's also to not wanting to provide a
> perl for the test suite.

I _think_ that was for the NO_PERL=YesPlease case, but I expect Dscho
can answer more concretely.
