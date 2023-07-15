Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D978DEB64DC
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 00:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGOAfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 20:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGOAfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 20:35:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937A43A95
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 17:35:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03C2119D8A1;
        Fri, 14 Jul 2023 20:35:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qcV6jPTdSFQ7IDDrt/w3lcis9x8uAemm6syWPJ
        vEdjc=; b=kcYMBibYNJZOlCaJZ7BUJAy5e3LKncw28U14V0Ox69Bu9gMv+2xFZn
        kToW38D15uHp/oCsev4ZPeDr+gBjgFQm5Ww6LgkBy8W80eC2C+27eGW3GYVKYJez
        msAWboAizDcD97U6mpgUmgTjAzMvX1lv1OM5SfU/oWdK+8XtOE/1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC8E219D89F;
        Fri, 14 Jul 2023 20:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29D0B19D89B;
        Fri, 14 Jul 2023 20:35:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: Splitting common-main
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
        <20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com>
        <xmqqcz2xtv83.fsf@gitster.g> <ZLHcaFvvZh88TrLb@google.com>
Date:   Fri, 14 Jul 2023 17:34:59 -0700
In-Reply-To: <ZLHcaFvvZh88TrLb@google.com> (Josh Steadmon's message of "Fri,
        14 Jul 2023 16:38:16 -0700")
Message-ID: <xmqqh6q6m2q4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F447748-22A7-11EE-84BF-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Sorry, I don't think I'm understanding your proposal here properly,
> please let me know where I'm going wrong: isn't this functionally
> equivalent to my patch, just with different filenames? Now main() would
> live in main.c (vs. my common-main.c), while check_bug_if_BUG() and
> common_exit() would live in common-main.c (now a misnomer, vs. my
> common-exit.c). I'm not following how that changes anything so I'm
> pretty sure I've misunderstood.

Sorry, the old discussion has expired out of my brain, and asking
what I had in mind back then is too late.

Your common-main.c has stuff _other than_ main(), and the remaining
main() has tons of Git specific stuff.  It may be one way to split,
but I did not find a reason to convince myself that it was a good
split.

What I was wondering as a straw-man alternative was to have main.c
that has only this and nothing else:

    $ cat >main.c <<\EOF
    #include "git-compat-util.h" /* or whatever defines git_main() */
    int main(int ac, char **av)
    {
	return git_main(ac, av);
    }
    EOF

Then in common-main.c, rename main() to git_main().

I was not saying such a split would be superiour compared to how you
moved only some stuff out of common-main.c to a separate file.  I
had trouble equally with your split and with the above strawman,
because I did not (and do not) quite see how one would evaluate the
result (go back to the message you are responding to for details).

> The issue I was trying to solve (whether for a unit-test framework or
> for the fuzzing engine) is that we don't have direct control over their
> main(), and so we can't rename it to avoid conflicts with our main().

Sure.  And if we by default use a very thin main() that calls
git_main(), it would be very easy for them to replace that main.o
file with their own implementation of main(); as long as they
eventually call git_main(), they can borrow what we do in ours.

> I guess there may be some linker magic we could do to avoid the conflict
> and have (our) main() call (their, renamed) main()?

We can throw a main.o that has the implementation of our default
"main" function into "libgit.a".

Then, when we link our "git" program (either built-in programs that
are reachable from git.o, or standalone programs like remote-curl.o
that have their own cmd_main()), we list our object files (but we do
not have to list main.o) and tuck libgit.a at the end of the linker
command line.  As the start-up runtime code needs to find symbol
"main", and the linker sees no object files listed has "main", the
linker goes in and finds main.o stored in libgit.a (which has "main"
defined) and that will end up being linked.

If on the other hand when we link somebody else's program that has
its own "main()", we list the object files that make up the program,
including the one that has their "main()", before "libgit.a" and
the linker does not bother trying to find "main" in libgit.a:main.o
so the resulting binary will use their main().

Is that what you are looking for?
