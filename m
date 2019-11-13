Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFE01F5A2
	for <e@80x24.org>; Wed, 13 Nov 2019 05:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfKMFUp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 00:20:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:46196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726086AbfKMFUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 00:20:45 -0500
Received: (qmail 12779 invoked by uid 109); 13 Nov 2019 05:20:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Nov 2019 05:20:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22616 invoked by uid 111); 13 Nov 2019 05:24:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2019 00:24:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Nov 2019 00:20:44 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matheus.bernardino@usp.br, git@vger.kernel.org,
        christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        stefanbeller@gmail.com
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object
 reading
Message-ID: <20191113052044.GB3547@sigill.intra.peff.net>
References: <4c5652ab34f0989856aba919ca84b2b091dcad98.1569808052.git.matheus.bernardino@usp.br>
 <20191112025418.254880-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191112025418.254880-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 06:54:18PM -0800, Jonathan Tan wrote:

> > @@ -1580,7 +1585,9 @@ static void *unpack_compressed_entry(struct packed_git *p,
> >  	do {
> >  		in = use_pack(p, w_curs, curpos, &stream.avail_in);
> >  		stream.next_in = in;
> > +		obj_read_unlock();
> >  		st = git_inflate(&stream, Z_FINISH);
> > +		obj_read_lock();
> >  		if (!stream.avail_out)
> >  			break; /* the payload is larger than it should be */
> >  		curpos += stream.next_in - in;
> 
> As I see it, the main purpose of this patch set is to move the mutex
> guarding object reading from builtin/grep.c (grep_read_mutex) to
> object-store.h (obj_read_mutex), so that we can add "holes" (non-mutex
> sections) such as the one quoted above, in order that zlib inflation can
> happen outside the mutex.
> 
> My concern is that the presence of these "holes" make object reading
> non-thread-safe, defeating the purpose of obj_read_mutex. In particular,
> the section quoted above assumes that the window section returned by
> use_pack() is still valid throughout the inflation, but that window
> could have been invalidated by things like an excess of windows open,
> reprepare_packed_git(), etc.

Yeah, I don't think the code above is safe. The map window can be
modified by other threads.

> I thought of this for a while but couldn't think of a good solution. If
> we introduced a reference counting mechanism into Git, that would allow
> us to hold the window open outside the mutex, but things like
> reprepare_packed_git() would still be difficult.

I think you could put a reader-writer lock into each window. The code
here would take the reader lock, and multiple readers could use it at
the same time. Any time the window needs to be shifted, resized, or
discarded, that code would take the writer lock, waiting for (and then
blocking out) any readers.

A pthread_rwlock would work, but it would be the first use in Git. I
think we'd need to find an equivalent for compat/win32/pthread.h.

-Peff
