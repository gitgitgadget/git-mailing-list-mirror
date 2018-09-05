Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F291F404
	for <e@80x24.org>; Wed,  5 Sep 2018 08:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeIEN2x convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 5 Sep 2018 09:28:53 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:37498 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbeIEN2x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 09:28:53 -0400
Received: by mail-qt0-f180.google.com with SMTP id n6-v6so7188152qtl.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 01:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sjYzoXef+wnqEaUQ1kaG+GBwjISTPUjYuD+dMblwxgM=;
        b=IKhHj2y/kZQMhoEDCnPAs+9T0Lh2qYMRiaOxDEQIACkb05f/TqFEJ6tDqoZy9d8qKv
         njDvyaEmdM5NAaSLwCQ/60LH5SGaPcfMSLuzf+SU2QL65XhTLfVTblYzARElSAh12rvK
         JipgdHwXdJd7VNeHjDl/2UL0tweflF2CQZP4OL4gaGxHiMDI8pN4mGeShyH5cJzI3tLw
         na3Uy5ylBq4rD9Gr/rRLsk3MEDsrCWPRd8p/kJbZAUbxgTg06mLFiaBOdPqepuD3WtOG
         HipxjhdUiB6fb1qqSy2CPmRW+BAtUCwTy+3u3RQ5d3hhZ1S4Idu4cAL9Oy86usrJWRsd
         W1eA==
X-Gm-Message-State: APzg51DBkplSFRdHJcV+fPNSO6KraSPMfu/J2qqKOnDP0yMOgurLu2Zr
        RLfzO0p4NNVL9loMPZM1rS/poS7t9WeUl17Rf3Q=
X-Google-Smtp-Source: ANB0VdZSWnq1If+CqLQ66s1alPVJkF0YodrK9hzrDZqEJ6AuN3Xi37IGg/fg0zCBK/ySI2xq1JQlXaOM3SPCl3DFKe4=
X-Received: by 2002:a0c:e292:: with SMTP id r18-v6mr32465522qvl.62.1536137978926;
 Wed, 05 Sep 2018 01:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180824152016.20286-5-avarab@gmail.com> <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
 <87bm9cs5y6.fsf@evledraar.gmail.com>
In-Reply-To: <87bm9cs5y6.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Sep 2018 04:59:27 -0400
Message-ID: <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 4:29 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> I recently gained access to a Solaris 10 SPARC (5.10) box and discovered
> that the chainlint.sed implementation in 2.19.0 has more sed portability
> issues.
>
> First, whoever implemented the /bin/sed on Solaris apparently read the
> POSIX requirements for a max length label of 8 to mean that 8 characters
> should include the colon, so a bunch of things fail because of that, but
> are fixed with a shorter 7 character label.

I'm pretty sure that Solaris 'sed' predates POSIX by a good bit, but
that's neither here nor there.

> Then GIT_TEST_CHAIN_LINT=1 still fails because 878f988350 ("t/test-lib:
> teach --chain-lint to detect broken &&-chains in subshells", 2018-07-11)
> added a "grep -q" invocation. The /bin/grep on that version of Solaris
> doesn't have -q.

I knew that '-q' was potentially problematic on some platforms, so I
checked and saw that existing tests were already using it, thus went
ahead and used it. Dropping '-q' here and redirecting stderr to
/dev/null is a perfectly fine alternative.

> We fixed a similar issue way back in 80700fde91
> ("t/t1304: make a second colon optional in the mask ACL check",
> 2010-03-15) by redirecting to /dev/null instead.
>
> A bunch of other tests in the test suite rely on "grep -q", but nothing
> as central as chainlint, so it makes everything break. Do we want to
> away with "grep -q" entirely because of old Solaris /bin/grep?

I count 132 instances in existing tests (though, I may have missed some).

> At this point those familiar with Solaris are screaming ("why are you
> using anything in /bin!"). Okey fine, but it mostly worked before, so
> are we OK with breaking it? "Mostly" here is "test suite would fail
> 20-30 tests for various reasons, but at least no failures in test-lib.sh
> and the like".
>
> However, if as config.mak.uname does we run the tests with
> PATH=/usr/xpg6/bin:/usr/xpg4/bin:$PATH, at this point sed is fine with 8
> character labels [...]

So, if you run the tests via 'make test' (or whatever), then you get
/usr/xpg?/bin in PATH, but if you run an individual test script (and
haven't set your PATH appropriately), then you encounter the problems
you report above?

> [...] but starts complaining about this (also in
> chainlint.sed):
>
>     sed: Too many commands, last: s/\n//

Erm. Any additional context to help narrow this down?

>     diff --git a/config.mak.uname b/config.mak.uname
>     @@ -163,6 +163,10 @@ ifeq ($(uname_S),SunOS)
>             BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
>     +       # t/chainlint.sed is hopelessly broken all known (tested
>     +       # Solaris 10 & 11) versions of Solaris, both /bin/sed and
>     +       # /usr/xpg4/bin/sed
>     +       GIT_TEST_CHAIN_LINT = 0
>      endif
>
> It slightly sucks to not have chainlint on
> Solaris, but it would also suck to revert chainlint.sed back to 2.18.0
> (there were some big improvements). So I think the patch above is the
> best way forward, especially since we're on rc2. What do you think?

Keeping in mind that the main goal of 'chainlint' is to prevent _new_
breakage from entering the test suite, disabling 'chainlint' on
Solaris is an entirely reasonable way forward. In present day, it
seems quite unlikely that we'll see someone develop new tests on
Solaris, so having 'chainlint' disabled there isn't likely to be a big
deal. Moreover, if someone does write a new test on Solaris which has
a broken &&-chain in a subshell, that breakage will be caught very
quickly once the test is run by anyone on Linux or MacOS (or Windows
or BSD or AIX), so it's not like the broken test will make it into the
project undetected.
