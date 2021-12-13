Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7CC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbhLMVdd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Dec 2021 16:33:33 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42852 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhLMVdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:33:33 -0500
Received: by mail-pf1-f170.google.com with SMTP id u80so16080188pfc.9
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 13:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PAk7E1trtEOg0ttr4u3MjJOkuiPXjzDcNXOp2/3pl7w=;
        b=GM/asz3/yoVzKdn+Yl7VuU/+3WTnTPNSLzA9n2QGRLWa9zpf5btgq6aZi78lqNl4eK
         jOqZaYqpH41yEquTGsm+nSkjg7KJbXP7LegmRGgByToU2mG/a2SJ6ny5d2rMzqZxWf2c
         DmBBlVqeGl2jke72sTSdvfrD48ffaAY4NqBBQQ4feM3+bl49OShiCEUrOXLk+eN5iAi0
         MDHCclsmYU2rE7hdQ1c/dgsxvuikkRR8AUIHhdasDVQyUaTKz2t+5jvlQsQgvSQHI+bf
         K+ovnUykR87I27ycfBa6gE6b18YVMqia8joJqqqfCFS8L230uLFE2KgnjAltQeSQs8I4
         5wEg==
X-Gm-Message-State: AOAM531SakoFBTRRqk7y6qNN09P8crZhxsD2JSYIXwDYPTH8qujH+guG
        CgOROPtx2F4ENyC88niUSbAxbBTLCYCtiS8L1Rk=
X-Google-Smtp-Source: ABdhPJxZlt3btK4nnxNN5ahn2Qhob43cvtdJjoAMcxd9OcwhrOt3n3srL3Iw3919n/kuS4X+M3vHqzH76wA7gfGorE0=
X-Received: by 2002:a05:6a00:140d:b0:4a9:5e10:60c2 with SMTP id
 l13-20020a056a00140d00b004a95e1060c2mr763892pfu.4.1639431212439; Mon, 13 Dec
 2021 13:33:32 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-10.13-ca55471d134-20211212T201308Z-avarab@gmail.com>
 <CAPig+cSkiFd27o8uACdX9ftg=N2XukqNSU_Tt+7rWT08JD7CAQ@mail.gmail.com>
 <211213.868rwo8o3q.gmgdl@evledraar.gmail.com> <CAPig+cTDu+gXOTeBHALCuS9ZqvuqxQW-gXdYUsyAxTOT=gHEnA@mail.gmail.com>
 <211213.86v8zs70mo.gmgdl@evledraar.gmail.com>
In-Reply-To: <211213.86v8zs70mo.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 16:33:21 -0500
Message-ID: <CAPig+cRj09FFY5LcF0=pHT0_h-v-1Y=MGvgRUEayNZxW=oxO4w@mail.gmail.com>
Subject: Re: [PATCH 10/13] test-lib-functions: add and use a "write_hook" wrapper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 2:42 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 13 2021, Eric Sunshine wrote:
> > By the way, the new chainlint could be made to catch broken &&-chains
> > (and missing `|| return 1`) in test script functions, as well; it
> > doesn't have to limit its checks only to tests. The reason I haven't
> > done so yet is that it's not clear how much we care about &&-chains in
> > functions, especially since we have _so many_ functions which don't
> > maintain the &&-chain. In the long run, I think it might be beneficial
> > to extend chainlint to check shell functions too, but fixing the
> > &&-chains in functions probably have to be done incrementally, thus
> > would likely require some sort of whitelisting or blacklisting
> > mechanism until all functions have been fixed. Anyhow, it's food for
> > thought.
>
> I think doing that & phasing it in would be very useful.

I forgot to mention another reason that I haven't really thought yet
about tackling the linting of shell functions, which is that some
shell functions drive tests:

    test_it () {
        foo=$1
        bar=$2
        test_expect_sucess "something $foo" '
            do_it "$bar"
        '
    }

in which an &&-chain within the function body isn't meaningful,
whereas other functions are called by tests:

    cmp_it () {
        a=$1 &&
        b=$2 &&
        test_cmp "$a" "$b"
    }

    test_expect_success 'something' '
        echo foo >foo &&
        echo bar >bar &&
        cmp_it foo bar
    '

in which the &&-chain within the function body is important.

It _may_ be possible to figure out automatically into which category a
function falls, but would probably be easier to have some sort of
annotation mechanism to distinguish one category of function from the
other, and only validate a function which falls into the latter
category.

> We've also said we shouldn't use things like this, i.e. a pipe with git
> on the LHS:
>
>     git <cmd> | ... &&
>
> But I've run into a few cases where a test succeeds, even if both
> commands here die:
>
>     test "$(git <cmd>)" = "$(git <cmd2>)"
>
> Which, if we're adding more lints is maybe something to consider
> too. I.e. it falls under the general umbrella of cases where we'd hide
> failures in "git".

Ya, this is a nice example, among others, of questionable code which a
linter might be able to detect. In fact, while working on the new
chainlint, I noted that it would be possible to replace
t/check-non-portable-shell.pl by adding a few more rules to the new
linter. A primary benefit of doing so is that
check-non-portable-shell.pl takes about 2.5 seconds to run on my
(admittedly 10+ year old) machine. However, I'm also hesitant to do so
since there is value in having those checks reside in a standalone
script like that; it's such a simple script that anyone can add new
checks without having to spend a lot of time studying how to do so.
