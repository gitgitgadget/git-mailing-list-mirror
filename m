Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0E8C6FA82
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 07:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiICHvw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 3 Sep 2022 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiICHvv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 03:51:51 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA529AF88
        for <git@vger.kernel.org>; Sat,  3 Sep 2022 00:51:49 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id c9so6111056ybf.5
        for <git@vger.kernel.org>; Sat, 03 Sep 2022 00:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C+HjPmOSqlxur6866Ei9g5nbciHJ1wO5gkt72NmQK1k=;
        b=j3+plz4xk0i5k7eDKQiKKF95je5jKhmfxfC4sgCj5Oj+Oh6JbcD7jBERvyykUalvWJ
         YR9o+n60UdgLkyIoiCQj/24DnQy60HqoYwekFsgDp7r9d+RPrWuq+RRGpluVP/OxIZ52
         obC80OuIaHES6mJeDIB3ZfYVWCSclZEm02bSx/WhKixjIC+f3pqpp4juYREb4Si/c0ik
         mNaLBmMy5Ss7CSLdRQPxkTUWyaXh6x9gG46OjjWihVmQeHHi86sW2BYj8bkPx6R9+OJF
         c4SdCe1NDk+0iWOvXA87qob2u8U8Nq58gm++nImXJlBT3Fv6OeN4bLt0Mzd7Ys1kw8Sb
         cEnQ==
X-Gm-Message-State: ACgBeo0PQ+kqHUVlF/dlkqK0vPpzAznSPOCsfDZB6O6OyN3o7mfMOCsz
        a1PDaInPRnkFzYv+vrPnogkXZTQIdczdqMYAoa/AGbSGk4UuAQ==
X-Google-Smtp-Source: AA6agR5n4dN4aIz5KGU/A7GCqki5Wn9Rung+rs4XIDy4Bi49d411bpbXyDTXFd1UctF8AXJ6mwPVUau39pg7Vc0W9EA=
X-Received: by 2002:a5b:18d:0:b0:695:a9d7:44b5 with SMTP id
 r13-20020a5b018d000000b00695a9d744b5mr25090616ybl.549.1662191508670; Sat, 03
 Sep 2022 00:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <220901.86bkrzjm6e.gmgdl@evledraar.gmail.com>
In-Reply-To: <220901.86bkrzjm6e.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Sep 2022 03:51:37 -0400
Message-ID: <CAPig+cThSD12whinyLzhHH9qh+bR7W_AH8ea5GT6B=bd87f2RA@mail.gmail.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2022 at 8:47 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Sep 01 2022, Eric Sunshine via GitGitGadget wrote:
> > Although chainlint.pl has undergone a good deal of optimization during
> > its development -- increasing in speed significantly -- parsing and
> > validating 1050+ scripts and 16500+ tests via Perl is not exactly
> > instantaneous. However, perceived performance can be improved by taking
> > advantage of the fact that there is no interdependence between test
> > scripts or test definitions, thus parsing and validating can be done in
> > parallel. The number of available cores is determined automatically but
> > can be overridden via the --jobs option.
>
> Per your CL:
>
>         Ævar offered some sensible comments[2,3] about optimizing the Makefile rules
>         related to chainlint, but those optimizations are not tackled here for a few
>         reasons: (1) this series is already quite long, (2) I'd like to keep the
>         series focused on its primary goal of installing a new and improved linter,
>         (3) these patches do not make the Makefile situation any worse[4], and (4)
>         those optimizations can easily be done atop this series[5].
>
> I have been running with those t/Makefile changesg locally, but didn't
> submit them. FWIW that's here:
>
>         https://github.com/git/git/compare/master...avar:git:avar/t-Makefile-use-dependency-graph-for-check-chainlint

Thanks for the link. It's nice to see an actual implementation. I
think most of what you wrote in the commit message and the patch
itself are still meaningful following this series.

> > +my $script_queue = Thread::Queue->new();
> > +my $output_queue = Thread::Queue->new();
> > +
> > +my $mon = threads->create({'context' => 'void'}, \&monitor);
> > +threads->create({'context' => 'list'}, \&check_script, $_, \&next_script, \&emit) for 1..$jobs;
>
> Maybe I'm misunderstanding this whole thing, but this really seems like
> the wrong direction in an otherwise fantastic direction of a series.
>
> I.e. it's *great* that we can do chain-lint without needing to actually
> execute the *.sh file, this series adds a lint parser that can parse
> those *.sh "at rest".
>
> But in your 16/18 you then do:
>
>         +if test "${GIT_TEST_CHAIN_LINT:-1}" != 0
>         +then
>         +       "$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
>         +               BUG "lint error (see '?!...!? annotations above)"
>         +fi
>
> I may just be missing something here, but why not instead just borrow
> what I did for "lint-docs" in 8650c6298c1 (doc lint: make "lint-docs"
> non-.PHONY, 2021-10-15)?

I may be misunderstanding, but regarding patch [16/18], I think you
answered your own question at the end of your response when you
pointed out the drawback that you wouldn't get linting when running
the test script manually (i.e. `./t1234-test-stuff.sh`). Ensuring that
the linter is invoked when running a test script manually is important
(at least to me) since it's a frequent step when developing a new test
or modifying an existing test. [16/18] is present to ensure that we
still get that behavior.

> I.e. if we can run against t0001-init.sh or whatever *once* to see if it
> chain-lints OK then surely we could have a rule like:
>
>         t0001-init.sh.chainlint-ok: t0001-init.sh
>                 perl chainlint.pl $< >$@
>
> Then whenever you change t0001-init.sh we refresh that
> t0001-init.sh.chainlint-ok, if the chainlint.pl exits non-zero we'll
> fail to make it, and will unlink that t0001-init.sh.chainlint-ok.
>
> That way you wouldn't need any parallelism in the Perl script, because
> you'd have "make" take care of it, and the common case of re-testing
> where the speed matters would be that we woudln't need to run this at
> all, or would only re-run it for the test scripts that changed.

A couple comments regarding parallelism: (1) as mentioned in another
response, when developing the script, I had in mind that it might be
useful for other projects (i.e. `sharness`), thus should be able to
stand on its own without advanced Makefile support, and (2) process
creation on Microsoft Windows is _very_ expensive and slow, so on that
platform, being able to lint all tests in all script with a single
invocation is a big win over running the linter 1050+ times, once for
each test script.

That's not to discredit any of your points... I'm just conveying some
of my thought process.

> (Obviously a "real" implementation would want to create that ".ok" file
> in t/.build/chainlint" or whatever)
>
> A drawback is that you'd probably be slower on the initial run, as you'd
> spwn N chainlint.pl. You could use $? instead of $< to get around that,
> but that requires some re-structuring, and I've found it to generally
> not be worth it.

The $? trick might be something Windows folk would appreciate, and
even those of us in macOS land (at least those of us with old hardware
and OS).

> It would also have the drawback that a:
>
>         ./t0001-init.sh
>
> wouldn't run the chain-lint, but this would:
>
>         make T=t0001-init.sh
>
> But if want the former to work we could carry some
> "GIT_TEST_VIA_MAKEFILE" variable or whatever, and only run the
> test-via-test-lib.sh if it isn't set.

I may be misunderstanding, but isn't the GIT_TEST_CHAIN_LINT variable
useful for this already, as in [16/18]?

Regarding your observations as a whole, I think the extract from the
cover letter which you cited above is relevant to my response. I don't
disagree with your points about using the Makefile to optimize away
unnecessary invocations of the linter, or that doing so can be a
useful future direction. As mentioned in the cover letter, though, I
think that such optimizations are outside the scope of this series
which -- aside from installing an improved linter -- aims to maintain
the status quo; in particular, this series ensures that (1) tests get
linted as they are being written/modified when the developer runs the
script manually `./t1234-test-stuff.sh`, and (2) all tests get linted
upon `make test`.

(The other reason why I'd prefer to see such optimizations applied
atop this series is that I simply don't have the time these days to
devote to major changes of direction in this series, which I think
meets its stated goals without making the situation any worse or
making it any more difficult to apply the optimizations you describe.
And the new linter has been languishing on my computer for far too
long; the implementation has been complete for well over a year, but
it took me this long to finish polishing the patch series. I'd like to
see the new linter make it into the toolchest of other developers
since it can be beneficial; it has already found scores or hundreds[1]
of possible hiding places for bugs due to broken &&-chain or missing
`|| return`, and has sniffed out some actual broken tests[2,3].)

[1]: https://lore.kernel.org/git/20211209051115.52629-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/20211209051115.52629-3-sunshine@sunshineco.com/
[3]: https://lore.kernel.org/git/7b0784056f3cc0c96e9543ae44d0f5a7b0bf85fa.1661192802.git.gitgitgadget@gmail.com/
