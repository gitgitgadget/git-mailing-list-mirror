Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64013C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4046E61165
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhGTGl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:41:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:54334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhGTGl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 02:41:26 -0400
Received: (qmail 2272 invoked by uid 109); 20 Jul 2021 07:22:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jul 2021 07:22:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19799 invoked by uid 111); 20 Jul 2021 07:22:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jul 2021 03:22:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Jul 2021 03:22:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/11] refs/files: add a comment about
 refs_reflog_exists() call
Message-ID: <YPZ5mzknK/nzKNCh@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-08.11-1e25b7c59c5-20210716T140631Z-avarab@gmail.com>
 <YPI7k7TnfQSQM7YF@coredump.intra.peff.net>
 <xmqqa6mintjx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6mintjx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 09:43:14AM -0700, Junio C Hamano wrote:

> >> +	 * such thing as a lock on the reflog, instead we always lock
> >> +	 * the "loose ref" (even if packet) above with
> >> +	 * lock_ref_oid_basic().
> >> +	 *
> >> +	 * If race happens we've got nothing more to do, we were asked
> >> +	 * to delete the reflog, and it's not there anymore. Great!
> >> +	 */
> >>  	if (!refs_reflog_exists(ref_store, refname)) {
> >>  		unlock_ref(lock);
> >>  		return 0;
> >
> > I think everything is accurate here, though I wouldn't have made the
> > distinction with "locking the loose ref". There is no such thing as
> > locking a packed ref; we always take the loose lock.
> >
> > s/packet/packed/, and maybe s/If race/If a race/.
> 
> Meaning, there is no such thing as locking a packed ref or a loose
> ref, we just lock a "ref" and the way it is done in files backend is
> by creating a lockfile as if we are creating/updating a loose one?

Yes, exactly. We do take a lock on the packed-refs file sometimes, but I
generally think "lock the ref" always means to take refs/heads/foo.lock
in the filesystem. Probably not all that important, but if we need a
re-roll to clarify language anyway...:)

> I do agree that the second sentence needs rewriting to make it less
> confusing.  lock_ref_oid_basic() being the way to lock "a ref" is
> not limited to cases where we want to do something to do to the
> reflog.
> 
> Taking all together, perhaps:
> 
> 	When refs are deleted, their reflog is deleted before the
> 	ref itself is deleted.  This is because there is no separate
> 	lock for reflog---instead we take a lock on the ref with
> 	lock_ref_oid_basic().
> 
>         If a race happens we've got nothing more to do...

Yeah, that reads fine to me.

-Peff
