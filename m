Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF9C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF9B2074D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 09:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHMJLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:11:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgHMJLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 05:11:04 -0400
Received: (qmail 17252 invoked by uid 109); 13 Aug 2020 09:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 09:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11569 invoked by uid 111); 13 Aug 2020 09:11:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 05:11:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 05:11:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] midx: use buffered I/O to talk to pack-objects
Message-ID: <20200813091103.GD3092220@coredump.intra.peff.net>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
 <9162c1cb-36fd-3203-ec58-4bd1501938d0@web.de>
 <xmqqh7t7623d.fsf@gitster.c.googlers.com>
 <xmqqd03v61xd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd03v61xd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 01:31:58PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > René Scharfe <l.s.r@web.de> writes:
> >
> >>  		nth_midxed_object_oid(&oid, m, i);
> >> -		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
> >> -		xwrite(cmd.in, "\n", 1);
> >> +		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
> >
> > I do think it is silly to send an object name and terminating LF in
> > two different system calls per object.
> >
> > The original uses xwrite() so that it does not have to worry about
> > having to restart interrupted system calls and such.
> 
> Oops.  There is not much in "and such".  xwrite() only restarts but
> the caller must deal with truncated write, which the original does
> not do.

Yeah, so I think the new code should be an improvement there, because it
will eventually retry the write when the buffer fills, or when we
eventually flush on close (my "everything written by the time we hit
fflush()" in the previous mail really should have been "...by the time
we hit fclose()").  Maybe another reason to use stdio. :)

The original also doesn't handle "real" errors at all (stuff besides
EINTR, etc). Nor does the rewrite. I guess it's unlikely to see a write
error here that doesn't also involve pack-objects returning a non-zero
exit code.

-Peff
