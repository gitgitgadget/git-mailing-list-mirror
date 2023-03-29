Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2564C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 03:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC2DHc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Mar 2023 23:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjC2DHa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 23:07:30 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0481FD2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 20:07:29 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso2797882pjc.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 20:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680059249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrBXH3/F/kv5+P4L9UW/6Kq+c4tZQpQ0FUzwbXOyodc=;
        b=zj8SaDc0z91q+UzaUoEJJGd4zLVtlRAHERusFHrpBY1SOO9esxMd5JmQXVwFp5pWP9
         Hz7XrYgLdowYlE/TMvLHmLiqXA/jMDhc74yA7VS98mBv4+tMM6zwHhm3TozLZKKVyTV/
         WAS27ToMiOsLIhAVxPCmqHUyUCVNke6MWX0GzRt537PtbsJkkFI7Q/nmPZSGtHqeX+GY
         jIBZi/6RD7lBEIbETk9Wi+S0sjWjoK6N/oMMaTkX4AFeNLjZG5zA4cHq4YSyCjWorcPD
         SgPn5Bv8pMYYbs+JTm6c0flztvLPu9iUdItjQKG/Gc5vOV/UAbBT/mm0deoetJ0B4oRC
         md7w==
X-Gm-Message-State: AAQBX9fqd9xQZ0oX9CUFZQromMasnSePnsehkQfXsy53bwyX6ukiOC0v
        9L9b7j1VzZFJn4XbJd+DjE/vUhiSqF4QUCuh7032M3JpAss=
X-Google-Smtp-Source: AKy350ZZb/7LCMUf29hzi4HNC4IjdnPGNK9+FEu29K7BJBJf0qmceRMVCFaTH+NwXXJSAbQnQp5viLX3ijHoV7MC87I=
X-Received: by 2002:a17:90b:692:b0:23d:424d:400f with SMTP id
 m18-20020a17090b069200b0023d424d400fmr3403060pjz.9.1680059248528; Tue, 28 Mar
 2023 20:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net> <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net>
In-Reply-To: <20230329023702.GA1793752@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Mar 2023 23:07:17 -0400
Message-ID: <CAPig+cSMYt81fcU8fRNhN9qZ=95jvRNv9YGhkM6PxgdMywWnCA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 10:37 PM Jeff King <peff@peff.net> wrote:
> On Tue, Mar 28, 2023 at 02:46:12PM -0700, Junio C Hamano wrote:
> > > -           if test "OK-117" != "$(test_eval_ "fail_117 && $1${LF}${LF}echo OK-\$?" 3>&1)"
> > > -                   BUG "broken &&-chain or run-away HERE-DOC: $1"
> >
> > This "here-doc" linter is a cute trick.  With seemingly so little
> > extra code, it catches a breakage in such an unexpected way.
> >
> > Even with a very small code footprint, overhead of an extra process
> > is still there, and it would be very hard to figure out what it does
> > (once you are told what it does, you can probably figure out how it
> > works).  These make it a "cute trick".
>
> Yes, I thought it was quite clever (and it is attributed to you), but I
> agree that I did not quite realize what it was doing until after running
> git-blame. I only started with "gee, why didn't we write this in the
> simpler way?", which is often a good starting point for archaeology. :)

I never realized what the "OK-" part of "OK-117" was doing either. I
guess I should have gone spelunking through history to find out,
though it wasn't high-priority for me to know with regards to my work
on chainlint.pl, so I never got around to it. I suspect that the "OK-"
trick was discussed and added during the period I was off-list.

> > While it is a bit sad to see it lost, the resulting code certainly
> > is easier to follow, I would think.  I do not offhand know how
> > valuable detecting unterminated here-doc is, compared to the
> > increased clarity of hte code.
>
> I think the complexity is merited _if_ we think it is catching useful
> cases. And I do count unterminated here-doc as a useful case, because,
> as with broken &&-chains, the failure mode is so nasty (a test will
> report success, even though part of the test was simply not run!).
>
> I just think chainlint.pl is doing a good enough job of catching it that
> we can rely on it. I'll be curious if Eric has input there on whether it
> can do even better, which would remove all of the caveats from the
> commit message.

It was an intentional design choice, for the sake of simplicity, _not_
to make chainlint.pl a shell syntax checker, despite the fact that it
is genuinely parsing shell code. After all, the shell itself -- by
which test code will ultimately be executed -- is more than capable of
diagnosing syntax errors, so why burden chainlint.pl with all that
extra baggage? Instead, chainlint.pl is focussed on detecting semantic
problems -- such as broken &&-chain and missing `return 1` -- which
are of importance to _this_ project.

So, it was very much deliberate that chainlint.pl does not diagnose an
unclosed here-doc. When making that design choice, though, I wasn't
aware of 99a64e4b73c (tests: lint for run-away here-doc, 2017-03-22),
thus didn't know that our test framework had been allowing such
problems to slip through silently[1].

That said, it doesn't look too hard to make chainlint.pl diagnose an
unclosed here-doc.

[1]: Why is that, by the way? Is `eval` not complaining about the
unclosed here-doc? Is that something that can be fixed more generally?
Are there other syntactic problems that go unnoticed?
