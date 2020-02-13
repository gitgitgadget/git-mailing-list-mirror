Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCD4C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 20:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1093A217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBMU1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:27:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:42764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726780AbgBMU1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 15:27:45 -0500
Received: (qmail 17020 invoked by uid 109); 13 Feb 2020 20:27:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 20:27:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16352 invoked by uid 111); 13 Feb 2020 20:36:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2020 15:36:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Feb 2020 15:27:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/13] rev-list: make --count work with --objects
Message-ID: <20200213202744.GA18860@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
 <20200213021929.GF1126038@coredump.intra.peff.net>
 <xmqqwo8qqozl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo8qqozl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 11:14:06AM -0800, Junio C Hamano wrote:

> > The current behavior from "rev-list --count --objects" is nonsensical:
> > we enumerate all of the objects except commits, but then give a count of
> > commits. This wasn't planned, and is just what the code happens to do.
> >
> > Instead, let's give the answer the user almost certainly wanted: the
> > full count of objects.
> >
> > Note that there are more complicated cases around cherry-marking, etc.
> > We'll punt on those for now, but let the user know that we can't produce
> > an answer (rather than giving them something useless).
> 
> Now, finally we start changing the behaviour.  
> 
> Is the reason why --left-right and --objects do not work well
> together because same trees and blobs can be shared between commits
> on both sides?

Yes, exactly. I think you could probably define some sensible responses
there. E.g., consider this history:

  commit() { echo $1 >$1 && git add $1 && git commit -m $1; }
  commit base
  commit left
  git checkout -b side HEAD^
  commit right

which looks like this:

  $ git log --graph --oneline --all
  * e0b7b94 (master) left
  | * 2a4163a (HEAD -> side) right
  |/  
  * 8d8a806 base

That "base" commit is sort of in the same boat: it's reachable from
either side. By default we don't count it at all:

  $ git rev-list --count --left-right master...side
  1	1

but we do know about it as a boundary commit, and you could ask for it
to be counted on the right:

  $ git rev-list --boundary --left-right master...side
  <e0b7b9473efa49db3c6bf4ceab587f22d1935f28
  >2a4163a0a9bbcb837af2ac2e80e17120798f863a
  -8d8a806249905f101b5ac3f1eb74fa426f90ddf2

  $ git rev-list --count --boundary --left-right master...side
  2	1

So probably it would be sensible to do the same for the objects.
Anything reachable from both is a "boundary" object. But I don't think
we extend the left-right marking to --objects at all now:

  $ git rev-list --boundary --left-right --objects master...side
  <e0b7b9473efa49db3c6bf4ceab587f22d1935f28
  >2a4163a0a9bbcb837af2ac2e80e17120798f863a
  -8d8a806249905f101b5ac3f1eb74fa426f90ddf2
  f48654b5fe8de485e4622598842ca14b04b62c0a
  45cf141ba67d59203f02a54f03162f3fcef57830 left
  4540e3db9d99d518601ecadb81f7d55d55855033
  c376d892e8b105bd712d06ec5162b5f31ce949c3 right

Nor do we even seem to dig into the boundary objects.

So there would need to be more infrastructure in the traversal itself to
be able to do this right, I think. I'm happy to wait until somebody
demonstrates a real use for it. :)

-Peff
