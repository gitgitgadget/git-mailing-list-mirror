Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12C4C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA06148E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCHS0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:26:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:55762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCHS0B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:26:01 -0500
Received: (qmail 26419 invoked by uid 109); 8 Mar 2021 18:26:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 18:26:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19394 invoked by uid 111); 8 Mar 2021 18:26:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 13:26:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 13:26:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: generate 'git' as 'cc [...] -o git+ && mv git+
 git'
Message-ID: <YEZsON5OxUiDkqPG@coredump.intra.peff.net>
References: <20210307132001.7485-1-avarab@gmail.com>
 <xmqq35x68zob.fsf@gitster.c.googlers.com>
 <87ft15kegn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ft15kegn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 01:38:32PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> Change the compilation of the main 'git' binary to not have the CC
> >> clobber 'git' in-place. This means that e.g. running the test suite
> >> in-place and recompiling won't fail whatever tests happen to be
> >> running for the duration of the binary being regenerated.
> >
> > I am not sure why I would want to support the workflow this is
> > trying to help.
> 
> Because it also allows me and others to do more testing on patches to
> git.git.
> 
> If I'm working on a patch to e.g. git-fsck I might be doing
> edit->save->some-tests, where "some-tests" are a subset of the test
> suite I think is relevant to fsck.
> 
> But after doing N commits with passing tests I might notice that some
> other part of the test suite I didn't expect to have anything to do with
> fsck broke because I wasn't running that test.
> 
> I wasn't running that test because I'm not going to wait 10-15 minutes
> for it to run while actively editing, but will wait 30s-1m for 10-50
> test files to run.
> 
> So I can also have the full test suite running in a loop in some side
> window that'll give me a headsup if the "while do-full-tests; [...]"
> loop breaks, at which point I'm likely to investigate it sooner than
> otherwise, and not waste time going down the wrong path.
> 
> You can of course do that now, but it requires having a worktree on the
> side or whatever, which isn't always ideal (sometimes I'd like to have
> these tests on uncommitted changes).

I don't always use it, but I have a "ci" script[1] that just runs the
test on each individual commit in a loop. The interesting things about
it (beyond a simple loop) are:

  - it operates in a worktree (that copies the config.mak from the main
    worktree if necessary).

  - it uses Michael Haggerty's git-test[2] to memoize results for a given
    tree. That makes it reasonable to leave running in the background,
    where it will only use CPU when there's something useful to do.
    I also use git-test for "git rebase -x", so a final "is each commit
    OK" check usually runs instantly, because the results are cached.

  - it uses inotifywait to decide when HEAD has been updated. This is
    mostly a fun hack. It could also just poll every 10 seconds or
    whatever.

  - it triggers a custom command when the tests fail. I can share my
    sad-trombone.wav with you if you need. ;)

Your mention of 10-15 minutes makes me wonder why your system is so
slow, though. I generally run the whole suite (minus cvs/svn/p4 bits) in
under a minute. I know it's _much_ slower on Windows, but I didn't think
that was your platform.

(In general, I'm mildly negative on your patch here. I have definitely
run into this myself, but I think having the test suite loudly complain
is a good way to remind you that you have not in fact run the whole
suite on a given build).

[1] https://github.com/peff/git/blob/meta/ci
[2] https://github.com/mhagger/git-test

-Peff
