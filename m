Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3EDC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 17:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhLMRFq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Dec 2021 12:05:46 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:46020 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhLMRFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 12:05:45 -0500
Received: by mail-pf1-f170.google.com with SMTP id x131so15439236pfc.12
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 09:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d1kjEozlTIEXajLpJ/JjN8uMciw0gEXdeX6aV/OAMUg=;
        b=R02dXY0KOBEYe4fwjgw4kzumnKwiGsedrW/d/2wN2VTLYUSNnpD37eApr0nyLoeVsZ
         BdyLMaDNVPDwJx8fsdNtdTZMpDJ6geI60lzqUbHPOVwnXlMRQTxpc/2RLVgOfmu312OU
         XoSLHxITrcYDOBenEjJYY6sZesz4KT6qVVJ0VlUQWITc9LFon7A9FSOKXJRZ1g3B9Klt
         kiJA9WhYyRi6yJIptMoFQa8e4XQMTZ1gAioInU3G852QQqfXPUMwFvERsULGLqzCR/qy
         EkEuY0Tr3iTZkqaNdB7G8SRxKABiUBWrZhQHSoQXtukeIx9BJ8/sg0tYViHVPPngAKEa
         b+NA==
X-Gm-Message-State: AOAM532Gw5dFZKwY5qHPeRzgvS8GNtuxe5p87lf+MKBdLrX8b/VqENXh
        cG4pMdpuZEm28QSy6OrkkePQU7BOfQrGkfnAp4RHJ1h9v7nOrA==
X-Google-Smtp-Source: ABdhPJwFhiYyl6MY7g7T0ec61rNmzxhMWgnvc9WulfDMwYhQ3yGWH+0Mda4Q3NCOI/jNSXPMlmQK5sPgQG5LI2O8Ep8=
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id
 j9-20020a056a00234900b004a80d87e8admr34278511pfj.15.1639415145104; Mon, 13
 Dec 2021 09:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com> <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs> <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
 <211213.86tufc8oop.gmgdl@evledraar.gmail.com>
In-Reply-To: <211213.86tufc8oop.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 12:05:34 -0500
Message-ID: <CAPig+cR5Q2q=wdXuVBeP52=pAfvh6_4z__g-0JUGWq_7uor_Hg@mail.gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 11:17 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 13 2021, Eric Sunshine wrote:
> > On Mon, Dec 13, 2021 at 10:43 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> >> I have no idea what is going on here: `<$< |` ?
> >
> > Ya, that line-noise is an unfortunate combination of shell and
> > Makefile gobbledygook. The `$<` is effectively the source file (the
> > file being passed into chainlint.sed), and the rest of it is just
> > normal shell. `<` is redirection (using the source file `$<` as
> > stdin), and `|` is the pipe operator (sending the output of
> > chainlint.sed to another `sed`), and capturing it all via shell `>`
> > redirection in `$@` which is the Makefile variable for the target
> > file.
>
> To add to that;
> https://www.gnu.org/software/make/manual/html_node/Rules.html#Rules and
> other relevant parts of the GNU make manual are very helpful here.

And the Makefile variables $< and $@, in particular, are documented here:
https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

> I don't really care about the details of whether it's invoked once or N
> times, although I think the N times with proper dependencies tends to
> give you better error messages, but maybe you'll be changing it
> significantly enough that the current map between chainlint files and
> approximately what sort of thing they check won't be there anymore.
>
> In any case, I'd think that a rule that used $< now (i.e. 1=1 file->out
> prereq) would be better for the current state, and could just be changed
> to use one of $^ or $+ later.
>
> I.e. you can declare a "check.done" that depends on {1..10}.todo, and
> get a list of all of those {1..10}.todo files if one changes, or just
> the ones whose mtime is newer than a "check.done".
>
> The reason I looked at this to begin with is that it takes it ~100-150ms
> to run now, which adds up if you're e.g. using "make test T=<glob>" in
> "git rebase -i --exec".

Regarding this last point, one idea I strongly considered (and have
not rejected) is to stop making `check-chainlin` a dependency of
`test` and `prove`. Unlike most of the test suite, in which a change
to any part of the Git source code could potentially cause any test to
fail -- thus, it is important to run the full test suite for any
source code change -- the `check-chainlint` target is completely
isolated from everything else; it only checks whether `chainlint`
itself functions correctly. The only time it really makes sense to run
`check-chainlint` is when chainlint itself is changed in order to
verify that it still functions as expected. Considering how
infrequently (i.e. never) chainlint is modified, it seems somewhat
silly for every `make test` or `make prove` invoked by anybody
anywhere to repeatedly and forever validate chainlint[*]. Instead, it
could be the responsibility of the person modifying chainlint to run
the `check-chainlint` self-tests.

[*]: There is at least one exception. Various implementations of `sed`
could behave differently, thus impacting the behavior of
chainlint.sed. This is not just a theoretical concern. I did all the
development of this series on macOS, where everything worked as
intended. Shortly before sending the series to the list, I subjected
it to other platforms via CI and found that it failed on Linux due to
minor behavioral differences in `sed` on Linux (though, very oddly, it
worked just fine on Windows). I might not have caught this problem if
`check-chainlint` had not been run automatically by `make test`.
