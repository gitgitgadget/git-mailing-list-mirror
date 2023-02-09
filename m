Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0BCC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 12:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBIMt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 07:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBIMt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 07:49:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EEF5DC25
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 04:49:27 -0800 (PST)
Received: (qmail 561 invoked by uid 109); 9 Feb 2023 12:49:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Feb 2023 12:49:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12707 invoked by uid 111); 9 Feb 2023 12:49:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Feb 2023 07:49:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Feb 2023 07:49:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Max Gautier <max.gautier@redhat.com>
Subject: Re: [PATCH] gpg-interface: lazily initialize and read the
 configuration
Message-ID: <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
 <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
 <xmqqmt5orqgv.fsf@gitster.g>
 <xmqqh6vwrpce.fsf@gitster.g>
 <xmqqlel7rj9z.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlel7rj9z.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2023 at 12:31:36PM -0800, Junio C Hamano wrote:

> > I wonder if gpg-interface functions can and should be taught to
> > initialize themselves lazily without relying on the usual
> > git_config(git_gpg_config) sequence.  I.e. the first call to
> > sign_buffer(), check_signature(), get_signing_key_id(), etc.
> > would internally make a git_config(git_gpg_config) call, with the
> > current callers of git_config(git_gpg_config) removed.
> 
> So here is such a change.  I only checked that it passed t/ tests
> locally (and I do not run some tests like svn and p4).

I think the tests tell us two things:

  - you didn't miss a spot where config needed to be initialized lazily
    here. The risk here is that many tests will be using defaults, not
    configured values, so coverage is not as good as you might hope.

  - there isn't a case where initializing the config all the time is a
    problem (i.e., the plumbing/porcelain thing discussed earlier). My
    "yikes" patch from upthread likewise passed, so that gives us a
    little confidence (though again, it's not clear that the plumbing
    cases which didn't _expect_ to read config would have test
    coverage).

    That said, having manually reviewed what the function is doing, I
    think it's probably OK (see my other response).

>  builtin/am.c            |  6 ------
>  builtin/commit-tree.c   |  3 ---
>  builtin/commit.c        |  4 ----
>  builtin/log.c           |  2 --
>  builtin/merge.c         |  3 ---
>  builtin/pull.c          |  6 ------
>  builtin/push.c          |  5 -----
>  builtin/receive-pack.c  |  4 ----
>  builtin/send-pack.c     |  2 --
>  builtin/tag.c           |  5 -----
>  builtin/verify-commit.c |  3 ---
>  builtin/verify-tag.c    |  3 ---
>  fmt-merge-msg.c         |  5 -----
>  gpg-interface.c         | 24 +++++++++++++++++++++++-
>  gpg-interface.h         |  1 -
>  sequencer.c             |  4 ----

This all looks fairly sensible to me. I think we'd really want to see a
"rev-list --format" test, too. One, because that's the immediate goal of
this change. But two, because I think we are only guessing that loading
the config is sufficient here. We've had bug with other subsystems where
they expected to be initialized but plumbing callers didn't (e.g., the
lazy init of notes-refs, etc).

I _think_ we're probably good here. Just looking at "git log" (where we
know --format, etc, works), it doesn't seem to do anything beyond
initializing the config.

-Peff
