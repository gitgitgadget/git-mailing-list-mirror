Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A14C388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CAA24695
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKQBog (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:44:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:59928 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKQBog (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 20:44:36 -0500
Received: (qmail 13122 invoked by uid 109); 17 Nov 2020 01:44:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 01:44:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21300 invoked by uid 111); 17 Nov 2020 01:44:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 20:44:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 20:44:35 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] add -i: verify in the tests that colors can be
 overridden
Message-ID: <20201117014435.GA19433@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com>
 <20201111023549.GB806755@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011111635140.18437@tvgsbejvaqbjf.bet>
 <20201111180713.GC9902@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011121448550.18437@tvgsbejvaqbjf.bet>
 <20201112182925.GA701197@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011160027480.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011160027480.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 12:35:44AM +0100, Johannes Schindelin wrote:

> > Whereas add-patch parses the colors off of the version and then
> > re-colors every hunk header. Which seems doubly weird to me. Even if we
> > were going to re-color every hunk (e.g., because we don't want to store
> > the original hunk line, but instead a parsed version of it), why bother
> > parsing the color version at all, and not just the machine-readable
> > version?
> 
> Let's continue on this distraction for a bit before I go back to fixing
> the patch series, which actually tries to fix a _different_ concern.
> 
> The reason why `add-patch.c` "parses the colors off" is that we want to
> show the rest of the hunk header, in color, even after splitting hunks
> (this will only be shown for the first hunk, of course).

OK, this is the part I didn't quite understand. My contention was: if we
are regenerating a new hunk header after we split, why do we care what
was in the old one?

This "rest of the hunk header" is what I didn't get. You are talking
here about the funcname header. Which is not colored by default, but
people can set color.diff.func.

And here the builtin does differ from the perl script quite a bit. The
perl script generates the split hunk headers from scratch, and does not
bother to include the funcname in the split header:

  $ git show :foo.c
  void foo()
  {
  	call();
  	some();
  	functions();
  }
  
  $ cat foo.c
  void foo()
  {
  	call();
  	some();
  	more();
  	functions();
  	return;
  }

  $ git add -p
  diff --git a/foo.c b/foo.c
  index 270ccc7..0365419 100644
  --- a/foo.c
  +++ b/foo.c
  @@ -2,5 +2,7 @@ void foo()
   {
   	call();
   	some();
  +	more();
   	functions();
  +	return;
   }
  (1/1) Stage this hunk [y,n,q,a,d,s,e,?]? s
  Split into 2 hunks.
  @@ -2,4 +2,5 @@
   {
   	call();
   	some();
  +	more();
   	functions();
  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? n
  @@ -5,2 +6,3 @@
   	functions();
  +	return;
   }
  (2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? n

So it does not appear at all after the split, colored or otherwise. I
think the behavior of the builtin version is better in this case.

It does place more restrictions on what the diffFilter can do, as we've
been discussing. The same thing could be accomplished by retaining the
uncolored func header, and then coloring it on the fly within
add-patch.c (exactly the same way we color the numeric part of the hunk
header).

It may also be worth covering this with a test (it was a surprise to me
that the builtin version was handling this, though as I said I do agree
it's an improvement).

> But given that `git add -p` is somewhat of a fringe use, and using
> `diffFilter` is _even_ more fringe, I do not really want to spend any
> further time on this tangent.

I agree that diffFilter is quite fringe. And as I said before, I'm fine
punting on it for now. Mostly this was just the first I had found out
about the difference, and because it is user-visible, it may be
something that comes up later. So I wanted to record a description of
the problem for later.

> My thinking back then was: what if _I_ want to use a diffFilter? For what
> would I use it? Probably to emphasize certain hunk headers more, by adding
> more color to the part after the line range.

Yes, that's what I use it for. I wrote it mostly to pipe through
diff-highlight, though also it was to help diff-so-fancy folks (which I
don't use myself, but they build on diff-highlight). However, it does
seem that they haven't really worked out the problems in the meantime.

-Peff
