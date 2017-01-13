Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF4B20756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbdAMRxD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:53:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:38913 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdAMRxC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:53:02 -0500
Received: (qmail 5879 invoked by uid 109); 13 Jan 2017 17:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 17:53:01 +0000
Received: (qmail 7305 invoked by uid 111); 13 Jan 2017 17:53:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 12:53:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2017 12:52:58 -0500
Date:   Fri, 13 Jan 2017 12:52:58 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: [PATCH 0/6] loose-object fsck fixes/tightening
Message-ID: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
References: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
 <1483825623.31837.9.camel@kaarsemaker.net>
 <20170108052619.4ucjamsqad4g5add@sigill.intra.peff.net>
 <CAEBDL5Vf=rvb4fZF87pNYci4sicmzhS_qPJYHHOGcnPTMBhhWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEBDL5Vf=rvb4fZF87pNYci4sicmzhS_qPJYHHOGcnPTMBhhWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 04:15:42AM -0500, John Szakmeister wrote:

> > I did notice another interesting case when looking at this. Fsck ends up
> > in fsck_loose(), which has the sha1 and path of the loose object. It
> > passes the sha1 to fsck_sha1(), and ignores the path entirely!
> >
> > So if you have a duplicate copy of the object in a pack, we'd actually
> > find and check the duplicate. This can happen, e.g., if you had a loose
> > object and fetched a thin-pack which made a copy of the loose object to
> > complete the pack).
> >
> > Probably fsck_loose() should be more picky about making sure we are
> > reading the data from the loose version we found.
> 
> Interesting find!  Thanks for the information Peff!

So I figured I would knock this out as a fun morning exercise. But
sheesh, it turned out to be a slog, because most of the functions rely
on map_sha1_file() to convert the sha1 to an object path at the lowest
level.

But I finally got something working, so here it is. I found another bug
on the way, along with a few cleanups. And then I did the trailing
garbage detection at the end, because by that point I knew right where
it needed to go. :)

  [1/6]: t1450: refactor loose-object removal
  [2/6]: sha1_file: fix error message for alternate objects
  [3/6]: t1450: test fsck of packed objects
  [4/6]: sha1_file: add read_loose_object() function
  [5/6]: fsck: parse loose object paths directly
  [6/6]: fsck: detect trailing garbage in all object types

 builtin/fsck.c  |  46 +++++++++++----
 cache.h         |  13 ++++
 sha1_file.c     | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 t/t1450-fsck.sh |  86 +++++++++++++++++++++++----
 4 files changed, 284 insertions(+), 41 deletions(-)

-Peff
