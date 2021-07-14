Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F1CC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E496136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhGNXSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 19:18:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:50250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhGNXSP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 19:18:15 -0400
Received: (qmail 2010 invoked by uid 109); 14 Jul 2021 23:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 23:15:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29756 invoked by uid 111); 14 Jul 2021 23:15:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 19:15:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 19:15:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Message-ID: <YO9wCqetxHii+TvK@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
 <871r801yp6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r801yp6.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 09:07:41PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Isn't that pseudo-code missing a conditional that's there in the real
> > code? In refs_resolve_ref_unsafe(), I see:
> >
> >        if (refs_read_raw_ref(refs, refname,
> >                              oid, &sb_refname, &read_flags)) {
> >                *flags |= read_flags;
> >
> >                /* In reading mode, refs must eventually resolve */
> >                if (resolve_flags & RESOLVE_REF_READING)
> >                        return NULL;
> >
> >                /*
> >                 * Otherwise a missing ref is OK. But the files backend
> >                 * may show errors besides ENOENT if there are
> >                 * similarly-named refs.
> >                 */
> >                if (errno != ENOENT &&
> >                    errno != EISDIR &&
> >                    errno != ENOTDIR)
> >                        return NULL;
> >
> > So if RESOLVE_REF_READING is set, we can return NULL immediately, with
> > errno set to EISDIR. Which contradicts this:
> 
> I opted (perhaps unwisely) to elide that since as you note above we
> don't take that path in relation to the removed code. I.e. I'm
> describing the relevant codepath we take nowadays given the code & its
> callers.

It's not clear to me that we don't take that path, though. The call in
files_reflog_expire() looks like it violates the assertion in your
commit message (that we would never return NULL with errno as EISDIR).

So I'm not entirely sure that the code is in fact dead (though I
couldn't find an easy way to trigger it from the command line). I do
think it probably can't do anything useful, and it is probably still OK
to delete. But in my mind that is quite a different argument.

Maybe that is splitting hairs, but I definitely try to err on the side
of caution and over-analysis when touching tricky code (and the
ref-backend code is in my experience one of the trickiest spots for
corner cases, races, etc).

> > So when is RESOLVE_REF_READING set? The resolve_flags parameter is
> > passed in by the caller. In lock_ref_oid_basic(), it comes from this:
> >
> >     int mustexist = (old_oid && !is_null_oid(old_oid));
> >     [...]
> >     if (mustexist)
> >             resolve_flags |= RESOLVE_REF_READING;
> >
> > So do any callers pass in old_oid? Surprisingly few. It used to be
> > called from other locking functions, but these days it looks like it is
> > only files_reflog_expire().
> 
> In general (and not being too familiar with this area) and per:
> 
>     7521cc4611 (refs.c: make delete_ref use a transaction, 2014-04-30)
>     92b1551b1d (refs: resolve symbolic refs first, 2016-04-25)
>     029cdb4ab2 (refs.c: make prune_ref use a transaction to delete the ref, 2014-04-30)
> 
> And:
> 
>     https://lore.kernel.org/git/20140902205841.GA18279@google.com/    
> 
> I wonder if these remaining cases can be migrated over to lock_raw_ref()
> or the transaction API, as many other similar callers have been already.
> 
> But that's a bigger change, I won't be doing that now, just wondering if
> these are some #leftoverbits or if there's a good reason they were left.

Quite possibly. It's been a while since I've looked this deep at the ref
code. It is weird that only one remaining caller passes old_oid. If even
that one could be converted, the whole lock_ref_oid_basic() could be
simplified a bit.

I agree that's a bigger change, so it might make sense to do smaller
cleanups in the interim.

> > So...I think it's fine? But the argument in your commit message seems to
> > have missed this case entirely.
> 
> Perhaps more succinctly: If we have a directory in the way, it's going
> to be impossible for the "old_oid" condition to be satisfied in any case
> in the file backend.
> 
> Even if we still had a caller that did "care" about that what could they
> hope to get from an "old_oid=<some-OID>" for a lock on "foo/bar" where
> "foo" is an empty directory?
> 
> Except of course for the case where it's not a directory but packed, but
> as you noted that's handled in another case.

Yeah, I think that's reasonably compelling. It's possible there are some
races unaccounted for here (like somebody else creating and deleting
shared-prefix loose refs at the same time), but it may be OK to just
accept those. The code is "we saw a failure, see if deleting stale
directories helps". And if the worst case is that this doesn't kick in
an obscure race (where we'd probably end up failing the whole operation
anyway), that's OK.

-Peff
