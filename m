Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45FAC33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975CE206D3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgBAL3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:29:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:50338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726297AbgBAL3V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 06:29:21 -0500
Received: (qmail 21188 invoked by uid 109); 1 Feb 2020 11:29:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Feb 2020 11:29:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8108 invoked by uid 111); 1 Feb 2020 11:37:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Feb 2020 06:37:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 Feb 2020 06:29:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] diff: only prefetch for certain output formats
Message-ID: <20200201112920.GD1864948@coredump.intra.peff.net>
References: <20200130055136.GA2184413@coredump.intra.peff.net>
 <20200130232002.203193-1-jonathantanmy@google.com>
 <20200131001416.GB2394563@coredump.intra.peff.net>
 <xmqqeevfbisb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeevfbisb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 10:08:36AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > fetches anything at all). I.e., for "diff -M -p", you'd want:
> >
> >   1. diffcore_std() sees "-p" and fetches everything
> >
> >   2. diffcore_rename() sees there's nothing we don't already have
> >
> > rather than:
> >
> >   1. diffcore_rename() fetches a few blobs to do rename detection
> >
> >   2. diffcore_std() fetches a few more blobs that weren't rename
> >      candidates, but we need for "-p"
> 
> Hmph, a pure rename only change will cause no blobs transferred with
> the latter (because there is no content change for "-p" to report,
> and the rename detection for R100 paths would be done at the object
> name level), but all blobs in filepairs (before rename matches A/D
> up) with the former, no?

Hmm, good point that an exact rename won't show the blobs. I don't think
there's a way that covers all cases in a single fetch at the granularity
of the functions I listed above. But we could if we break it down a bit:

  1. look for exact renames

  2. queue for fetching any inexact rename candidates leftover

  3. if we're going to show a diff that requires contents, then:

     3a. if marked as an exact rename/copy, don't queue (I guess this is
         really checking p->one->oid versus p->two->oid)

     3b. likewise, deletions with --irreversible-delete don't need queued

     3c. otherwise, queue for fetch

  4. fetch whatever was queued

  5. proceed with inexact rename detection, then showing the diffs

So that logic has to go in the middle of diffcore_rename(). And if we're
not doing renames, then the logic from (3) needs to get triggered by
diffcore_std(). So it probably needs to be hoisted out into a helper,
and made idempotent (it already should be, since after the first
prefetch we'd have all of the objects, but we might want a flag to avoid
unnecessarily checking again).

-Peff
