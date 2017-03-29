Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCEBD20958
	for <e@80x24.org>; Wed, 29 Mar 2017 17:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbdC2R4U (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 13:56:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:53690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751717AbdC2R4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 13:56:19 -0400
Received: (qmail 26918 invoked by uid 109); 29 Mar 2017 17:56:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 17:56:16 +0000
Received: (qmail 24309 invoked by uid 111); 29 Mar 2017 17:56:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 13:56:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Mar 2017 13:56:14 -0400
Date:   Wed, 29 Mar 2017 13:56:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] read-cache: avoid git_path() race in
 freshen_shared_index()
Message-ID: <20170329175614.uecvtvmzoj2wfle3@sigill.intra.peff.net>
References: <20170329080820.8084-1-chriscool@tuxfamily.org>
 <xmqqfuhwau6r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuhwau6r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 10:06:52AM -0700, Junio C Hamano wrote:

> > This shows that we should be careful not to use git_path() in
> > freshen_shared_index(). It is using a shared buffer that can
> > too easily lead to races.
> 
> The impression I get from the symptom is that after git_path() is
> called here, before check_and_freshen_file() uses that result, it
> (or functions it calls) uses git_path(), and the number of times it
> does so has changed since cc/split-index-config was written on the
> mainline, and the rotating 4-element buffer get_pathname() gives is
> now exhausted, leading to the failure you observed.  By the way,
> that does not sound a race to me.
> 
> In any case, that explains why bisect says the merge is the first
> bad one, and cures the confused reader ;-) The use of git_path() on
> the topic was still safe; it was a timebomb waiting to go off.  The
> mainline started using more calls and the merge result was unsafe.

Yeah, it looks like that is what happened. I see that Christian bisected
the rebase to find the commit in the series that introduces the problem.
I'm mildly curious which commit upstream created the problem[1].
There's a reasonable chance it's some innocent-looking cleanup (possibly
one of my recent "stop using a fixed buffer" ones).

But in the end it doesn't really matter. I think code like:

  const char *filename = git_path(...);

or

  nontrivial_function(git_path(...));

is an anti-pattern. It _might_ be safe, but it's really hard to tell
without following the complete lifetime of the return value. I've been
tempted to suggest we should abolish git_path() entirely. But it's so
darn useful for things like unlink(git_path(...)), or other direct
system calls.

As an aside, this kind of static-buffer reuse _used_ to mean you might
see somebody else's buffer. Which is bad enough. But since the move to
use strbufs underneath the hood of git_path(), it may produce that
effect or it may be a use-after-free (if the strbuf had to reallocate to
grow in the meantime).

Anyway. The fix in the patch is obviously the right thing.

-Peff

[1] I think we could pinpoint the upstream change that caused the bad
    interaction by bisecting between the merge-base and the first-parent
    of the broken merge. For each commit, cherry-pick the complete
    series on top of it, and test the result.
