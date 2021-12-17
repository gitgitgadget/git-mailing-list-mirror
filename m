Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9EFC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 20:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhLQUsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:48:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54815 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbhLQUsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 15:48:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3483317F377;
        Fri, 17 Dec 2021 15:48:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=qbMOil4ljSbqLSH/Bt02pJFRO
        2hG1ontiOL4ICSDK5E=; b=YqJHHw8WAsctE2A3OwIEDO8WPvgyXlovrYrIiIY8O
        VnKQG58HLaIASyDUfLXYEUCFdtSzPCr8mOIfCW4+pkyXLiw6epNDXy3qsYhJdFg7
        KXEHgs5PaxhVqRHW7HgBkGCNvNlyBUjfRBLgQJyGm89Yi/KP/OX3rhWUQxmVSifP
        2s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CD7D17F376;
        Fri, 17 Dec 2021 15:48:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8CE0917F375;
        Fri, 17 Dec 2021 15:48:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH V5 2/2] git-apply: add --allow-empty flag
References: <20211213220327.16042-1-jerry@skydio.com>
        <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
        <211217.86wnk395bz.gmgdl@evledraar.gmail.com>
X-Gnus-Delayed: Fri, 17 Dec 2021 13:40:25 -0800
Date:   Fri, 17 Dec 2021 12:48:32 -0800
Message-ID: <xmqqr1ab2c0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B307BD10-5F7A-11EC-8453-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't see how us not having a 1=3D1 mapping between say a "mktag.sh"
> test script and that script *only* running "git mktag" makes the
> approach with SANITIZE=3Dleak misguided.

Sorry, if I was not clear.  SANITIZE=3Dleak tests are perfectly fine.

What I consider misguided is to mark each test script with
TEST_PASSES marker.

We will *NOT* have "this script uses 'git tag' to check it, and
nothing else", ever.  It is simply impossible to test the behaviour
of a single command, as we need other git commands to prepare the
scene for the command being tested to work in, and other git
commands to observe the outcome.  We'd run "git commit" to prepare a
commit before we can 'git tag' to tag it, and 'git verify-tag' to
see if the signature is good.

And the approach to say "at this point in time, sanitize test passes
because all the git command we happen to use in this test script are
sanitize-clean" is misguided, when done way too early.  Because it
is not just a statement about the state of the file at one point in
time, but it is a declaration that anybody touches the file is now
responsible for new leaks that triggers in that test script,
regardless of how the leaks come.

Surely, I am sympathetic to the intent.  If you are updating "git
frotz" that is sanitizer-clean, and if you write a new test in a
test script that happens to be sanitizer-clean, if you introduced a
new leak to "git frotz", you would appreciate if the CI notices it
and blocks you.

But it is not the only way to get blockoed by CI.  You may need to
use another git subcommand that is known not to be sanitizer-clean
yet to set things up or validate the result of the new feature you
added to "git frotz", and use of these commands will be caught as a
"new leak in the script file", even if your change to "git frotz"
introduced no new leaks.

The only time we can sensibly do the "now these are leak-free, and
we will catch and yell at you when you add a new leak" is when we
know _all_ git commands are sanitize clean; then _any_ future change
to _any_ git command that introduce a new leak can be caught.  Doing
so before that is way too early, especially when only 230 among 940
scripts can be marked as clean (and there are ones that are
incorrectly marked as clean, too).  There is a very high chance for
any of these 230 that are marked as "clean" to need to use a git
command that is not yet sanitizer ready to set up the scene or
validate the result, when a change is made to a command that is
already clean and is the target of the test.

> You can, FWIW, mark things in a more gradual manner than un-marking the
> script entirely. There's the SANITIZE_LEAK prerequisite for individual
> "test_expect_success".

That will *NOT* work for the setup step, and you know it.

What would have been nicer was a more gradual and finer-grained
approach.  If we ignore feasibility for a moment, the ideal would be
to have a central catalog of commands that are already sanitizer
clean, so that test framework, when running a git command that is
known to be leaky, would disable sanitizer to avoid triggering its
output and non-zero exit, while enabling the sanitizer to catch any
new leaks in a git command that was known and declared to be
leak-free (which was the reason why it was placed on that catalog).

If we had something like that, we wouldn't be having this discussion
on this thread, which is about improving the "git apply" command,
not about plugging known leaks in "format-patch" command.  "apply"
would have been on the "clean" list, and the "format-patch" whose
use is introduced to the "setup" step in this series is known to be
unclean.

Merging down the "mark more of them as sanitizer-clean" topic at
f346fcb6 (Merge branch 'ab/mark-leak-free-tests-even-more',
2021-12-15) was a mistake.  It was way too early, but unfortunately
reverting and waiting would not help all that much, as the tests the
patches in that topic touch will be updated while it is waiting, and
the point of the topic is to take a snapshot and to declare that all
the git commands it happens to use are leak-free, at least in the way
they are used in the script.

Having said that, what would be the next step to help developers to
avoid introducing new leaks while yelling at them for existing leaks
they did not introduce and not forbidding them to use git subccommands
with existing leaks in their tests?

I would prefer an approach that does not force the project to make
it the highest priority to plug leaks over everything else.

Hopefully, this time I was clear enough?

Thanks.
