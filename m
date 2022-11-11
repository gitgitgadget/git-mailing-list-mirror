Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3DC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 16:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiKKQoh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 11 Nov 2022 11:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKQof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 11:44:35 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EC659B
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 08:44:34 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id bp12so2770351ilb.9
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 08:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYUtIDHyu+TdtNqRQzHNL5cCWO95zUd6dXYumWCxjBc=;
        b=e5zO8xoGScHsAnieVz40MIo1x2dQPObDeyq+sybO6OEaGUsYMoQnMZmOJHukcew10+
         nXcApK6GXvoIULliKAPZFAFngdMIt366unnKdDB9iXng+a/JTEu8hosrupl2vy2elJd7
         +XNPzrKSYhoJ8Onxnj1UM+YQ/m495ooTF20kYOknxSFiOPzpquzX0ciW+gQhRYTuNh33
         Ua3Yddmtm9clROvhaKv5r7mA8tTYerkQCxw6nUjAFXu/Xp7nRkrIdtA7z3Cdwk6R7Oqe
         M6t/rOpoDwzPFa5oA3vneoMEkTIEBzz/fNOvBSbg9QqYhM/qpd644T1FeQJvsUluuurE
         RCWQ==
X-Gm-Message-State: ANoB5pkq1I4rdVSrLqTy6TyLeGFd37k1YIe9thi8BdxnXTFjEXFkm4GY
        qMwOIuwR2gWH/gbRuKECpr0gJpeem+OWHxbX/8kfCEH5sm4=
X-Google-Smtp-Source: AA0mqf5unc3izV+eUU7Vp1PqSivz+NMgQplWqAoBnHmOypjjU/sa9Cf/AgbEsNrG/RPubYahM5zK2qL3K3dr03OOVAA=
X-Received: by 2002:a92:c749:0:b0:302:3a05:d570 with SMTP id
 y9-20020a92c749000000b003023a05d570mr1493036ilp.249.1668185073525; Fri, 11
 Nov 2022 08:44:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com> <de482cf9cf1c791418e4279523123580f330245b.1668152094.git.gitgitgadget@gmail.com>
 <221111.865yflo7p7.gmgdl@evledraar.gmail.com>
In-Reply-To: <221111.865yflo7p7.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 Nov 2022 11:44:22 -0500
Message-ID: <CAPig+cRwDeGyniiVGqmdMePgmR6GiYQOvNP+GUeT__zpuWV1Fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] chainlint: sidestep impoverished macOS "terminfo"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 10:02 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Nov 11 2022, Eric Sunshine via GitGitGadget wrote:
> > Sidestep this Apple problem by imbuing get_colors() with specific
> > knowledge of capabilities common to "xterm" and "nsterm", rather than
> > trusting "terminfo" to report them correctly. Although hard-coding such
> > knowledge is ugly, "xterm" support is nearly ubiquitous these days, and
> > Git itself sets precedence by assuming support for ANSI color codes. For
> > other terminal types, fall back to querying "terminfo" via `tput` as
> > usual.
>
> Doesn't test-lib.sh have the same problem then?

Generally speaking, yes, but in practice, no, not for this particular
case. I specifically wanted to use "dim" here in chainlint.pl, which
is (oddly) missing in Apple's terminfo. test-lib.sh just uses some
colors, bold, reverse, and "reset", all of which are present in
Apple's terminfo.

> This is somewhat of an aside, as we're hardcoding thees colors in
> t/chainlint.pl now, but I wondered when that was added (but I don't
> think I commented then) why it needed to be re-hardcoding the coloring
> we've got in test-lib.sh.
>
> I.e. if test-lib.sh is running it could we handle these cases, and just
> export a variable with the color info for "bold" or whatever in
> GIT_TEST_COLOR_BOLD, then pick that up?

When adding colorizing to chainlint.pl, one of my very first thoughts
was to somehow reuse the color information from test-lib.sh. That's
relatively easy in the case when the test script is being run
standalone because it has already "sourced" test-lib.sh before it runs
chainlint.pl, thus could pass the color information along to
chainlint.pl somehow. But the other case, when "make test" (or "make
test-chainlint", etc.) is used is harder because that's just the
Makefile running chainlint.pl directly, so test-lib.sh isn't involved
in the equation. It would probably be possible to make it work, but
the solutions seemed ugly and too invasive, especially for an initial
implementation of colorizing in chainlint.pl.

> I have a local semi-related patch which made much the same change to
> test-lib.sh itself, to support --color without going through whether
> tput thinks we support colors:
> https://github.com/avar/git/commit/c4914db758b
>
> I think this is fine for now if you don't want to poke more at it, but
> maybe this should all be eventually combined?

Peff also expressed such a sentiment[1][2][3]. I'm still somewhat
hesitant to make chainlint.pl dependent upon so much outside machinery
since it's still nicely standalone and _might_ be useful elsewhere.

> I also wonder to what extent this needs to be re-inventing
> Term::ANSIColor, which has shipped with Perl since 5.6, so we can use it
> without worrying about version compat, but that's another topic...

Gah, why didn't I know about this sooner?! (Note to self: hit self
over head.) Back when I was adding colorizing to chainlint.pl, I
searched around to determine if Perl had any built-in colorizing
support, but I completely overlooked this. I must have missed it
because I was focusing on "curses" since I thought I would need to
pull color codes directly from "curses", and Perl doesn't have a
standard (shipped) "curses" module. I even said as much to Peff[4].

Since it's been shipping with Perl for quite some time,
Term::ANSIColor would be a much nicer solution; worth looking into.

[1]: https://lore.kernel.org/git/Yx%2FLpUglpjY5ZNas@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/Yx%2FeG5xJonNh7Dsz@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/Yx%2FPnWnkYAuWToiz@coredump.intra.peff.net/
[4]: https://lore.kernel.org/git/CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com/
