Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CE11F991
	for <e@80x24.org>; Tue,  8 Aug 2017 07:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbdHHHw6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 03:52:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:60100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751919AbdHHHw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 03:52:57 -0400
Received: (qmail 6593 invoked by uid 109); 8 Aug 2017 07:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 07:52:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13816 invoked by uid 111); 8 Aug 2017 07:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 03:53:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Aug 2017 03:52:54 -0400
Date:   Tue, 8 Aug 2017 03:52:54 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     'Shawn Pearce' <spearce@spearce.org>,
        Ben Alex <ben.alex@acegi.com.au>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        Kristoffer Sjogren <stoffe@gmail.com>
Subject: Re: reftable [v5]: new ref storage format
Message-ID: <20170808075254.sfazy7a6oc5bcc7b@sigill.intra.peff.net>
References: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
 <874ltkzlcf.fsf@gmail.com>
 <CAJo=hJuPwEWJEWOUpJ_T-=j0NxnzjOLy_=-qG51_zuYhKbBvrw@mail.gmail.com>
 <CAOhB0ruYhGAyNn84ZjS7TH7QdwxNi2bPN8KFxEEBd58B9qVrmg@mail.gmail.com>
 <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
 <833bc420609e452e8837862eb90f6a43@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <833bc420609e452e8837862eb90f6a43@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 03:40:48PM +0000, David Turner wrote:

> > -----Original Message-----
> > From: Shawn Pearce [mailto:spearce@spearce.org]
> > In git-core, I'm worried about the caveats related to locking. Git tries to work
> > nicely on NFS, and it seems LMDB wouldn't. Git also runs fine on a read-only
> > filesystem, and LMDB gets a little weird about that. Finally, Git doesn't have
> > nearly the risks LMDB has about a crashed reader or writer locking out future
> > operations until the locks have been resolved. This is especially true with shared
> > user repositories, where another user might setup and own the semaphore.
> 
> FWIW, git has problems with stale lock file in the event of a crash (refs/foo.lock 
> might still exist, and git does nothing to clean it up).
> 
> In my testing (which involved a *lot* of crashing), I never once had to clean up a
> stale LMDB lock.  That said, I didn't test on a RO filesystem.

Yeah, I'd expect LMDB to do much better than Git in a crash, because it
relies on flock. So when the kernel goes away, so too does your lock
(ditto if a git process dies without remembering to remove the lock,
though I don't think we've ever had such a bug).

But that's also why it may not work well over NFS (though my impression
is that flock _does_ work on modern NFS; I've been lucky enough not to
ever use it). Lack of NFS support wouldn't be a show-stopper for most
people, but it would be for totally replacing the existing code, I'd
think. I'm just not clear on what the state of lmdb-on-nfs is.

Assuming it could work, the interesting tradeoffs to me are:

  - something like reftable is hyper-optimized for high-latency
    block-oriented access. It's not clear to me if lmdb would even be
    usable for the distributed storage case Shawn has.

  - reftable is more code for us to implement, but we'd "own" the whole
    stack down to the filesystem. That could be a big win for debugging
    and optimizing for our use case.

  - reftable is re-inventing a lot of the database wheel. lmdb really is
    a debugged, turn-key solution.

I'm not opposed to a world where lmdb becomes the standard solution and
Google does their own bespoke thing. But that's easy for me to say
because I'm not Google. I do care about keeping complexity and bugs to a
minimum for most users, and it's possible that lmdb could do that. But
if it can't become the baseline standard (due to NFS issues), then we'd
still want something to replace the current loose/packed storage. And if
reftable does that, then lmdb becomes a lot less interesting.

-Peff
