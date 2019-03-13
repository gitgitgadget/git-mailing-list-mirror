Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13BC20248
	for <e@80x24.org>; Wed, 13 Mar 2019 16:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfCMQDW (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 12:03:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:48920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726512AbfCMQDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 12:03:22 -0400
Received: (qmail 16326 invoked by uid 109); 13 Mar 2019 16:03:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 16:03:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11708 invoked by uid 111); 13 Mar 2019 16:02:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 12:02:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 12:02:05 -0400
Date:   Wed, 13 Mar 2019 12:02:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: Race condition due to reflog expiry in "gc"
Message-ID: <20190313160204.GD24101@sigill.intra.peff.net>
References: <87tvg7brlm.fsf@evledraar.gmail.com>
 <xmqq1s3bh7ky.fsf@gitster-ct.c.googlers.com>
 <87sgvrax0o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgvrax0o.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 11:28:39AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I was under the impression that git-gc was supposed to support operating
> on a repository that's concurrently being modified, as long as you don't
> set the likes of gc.pruneExpire too aggressively.

To some degree. If it has to take locks to modify items, then inherently
there's going to be lock contention. But we may be able to work around
it some.

A big one we used to hit at GitHub is that running `git pack-refs` needs
to take the individual ref locks when pruning loose refs that have just
been packed. We dealt with that by adding retry-with-timeout logic to
ref lock acquisition, in 4ff0f01cb7 (refs: retry acquiring reference
locks for 100ms, 2017-08-21). Since then, I can't remember seeing a
single instance of this coming up in production use.

I don't think we use a timeout with the reflog lock. Maybe we ought to.
It might need to be longer than the 100ms default for refs, since I
think we'd do more significant work during the reflog expiration. On the
other hand, I think we hold the lock on the ref itself, too, during that
expiration.

We don't actually expire reflogs regularly at GitHub, so I can't say one
way or the other if there would be lock contention there.

> Running a "gc" in a loop without "git reflog expire --all" and when
> watching the repository being GC'd with:
> 
>     fswatch -l 0.1 -t -r . 2>&1 | grep lock
> 
> We only create .git/MERGE_RR.lock, .git/gc.pid.lock and
> git/packed-refs.lock. These are all things that would only cause another
> concurrent GC to fail, not a normal git command.

The packed-refs.lock can conflict with a normal operation; regular
writers need to update it when they delete a ref.

You'd also be locking regular refs as part of "pack-refs --prune", but
you probably don't see it running gc in a loop, because all of the loose
refs are pruned after the first run.

> I'm just including that as illustration that add_reflogs_to_pending() in
> revision.c during "gc" already iterates over the reflogs without locking
> anything, but of course it's just reading them.

Right. It's always safe to read without locking (refs, packed-refs, and
reflogs).

> So just this fixes that:
> 
>     diff --git a/refs/files-backend.c b/refs/files-backend.c
>     index ef053f716c..b6576f28b9 100644
>     --- a/refs/files-backend.c
>     +++ b/refs/files-backend.c
>     @@ -3037,7 +3037,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
>      	 * reference itself, plus we might need to update the
>      	 * reference if --updateref was specified:
>      	 */
>     -	lock = lock_ref_oid_basic(refs, refname, oid,
>     +	lock = lock_ref_oid_basic(refs, refname, NULL,
>      				  NULL, NULL, REF_NO_DEREF,
>      				  &type, &err);
>      	if (!lock) {
> 
> Which seems sensible to me. We'll still get the lock, we just don't
> assert that the refname we use to get the lock must be at that
> SHA-1. We'll still use it for the purposes of expiry.

I _think_ this should be OK, because we don't open the reflog until
after we hold the lock. So we don't really care what the value was at.
Wherever we got the lock, we'll do the expiration process atomically at
that point.

I don't think this makes all your problems go away, though, because
you'd still have the immediate contention of actually taking the lock
(at any value).

> But maybe I've missed some caveat in reflog_expiry_prepare() and friends
> and we really do need the reflog at that OID, then this would suck less:

If I'm reading the code correctly, we don't call reflog_expiry_prepare()
until we're holding the lock (because we pass it in as a callback to
reflog_expire()). So I think that would be OK.

>      	if (!lock) {
>     +		if (errno == EBUSY) {
>     +			warning("cannot lock ref '%s': %s. Skipping!", refname, err.buf);
>     +			strbuf_release(&err);
>     +			return -2;
>     +		}
>      		error("cannot lock ref '%s': %s", refname, err.buf);
>      		strbuf_release(&err);
>      		return -1;
> 
> I.e. we just detect the EBUSY that verify_lock() sets if the OID doesn't
> match, and don't prune that reflog.

That saves git-gc from failing. But do we have the problem in the other
direction? I.e., that the gc would take a lock, and the actual user
request to update a ref would fail?

That's what the retry-with-timeout is supposed to address, so maybe it
works. But I wouldn't be surprised if it's insufficient in practice,
since the reflog code may walk big parts of the graph under lock,
checking reachability.

-Peff
