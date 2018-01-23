Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F991F404
	for <e@80x24.org>; Tue, 23 Jan 2018 05:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeAWFqA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 00:46:00 -0500
Received: from imap.thunk.org ([74.207.234.97]:47444 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbeAWFp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 00:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tH9pDaR1gFHvsg610dYLUvqfkUd/WMd9tyqrY7EPGxg=; b=xENe4Gz4IdX88X/OYxePZr2Cwg
        JRskACX2xJunB08sixtBSVBvfyKQdQuHA88lMIMhdvPC972XHr4sJJBQFEq+WAwW826zqjIOMtyw5
        oTUra76ZMNm9kNWnGrsCbRpSArHwcUdX9+ui5Nj/BPpZ41ccLRHlaI4xVJnuOimYJUBY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1edrP8-0001Dd-P1; Tue, 23 Jan 2018 05:45:54 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A81F9C00554; Tue, 23 Jan 2018 00:45:53 -0500 (EST)
Date:   Tue, 23 Jan 2018 00:45:53 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180123054553.GA21015@thunk.org>
References: <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <20180117235220.GD6948@thunk.org>
 <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
 <20180118162721.GA26078@lst.de>
 <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
 <20180120221445.GA4451@thunk.org>
 <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
 <871siihqvw.fsf@evledraar.gmail.com>
 <20180122180903.GB3513@thunk.org>
 <20180123004710.GF26357@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180123004710.GF26357@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 07:47:10PM -0500, Jeff King wrote:
> 
> I think Ævar is talking about the case of:
> 
>   1. You make 100 objects that aren't referenced. They're loose.
> 
>   2. You run git-gc. They're still too recent to be deleted.
> 
> Right now those recent loose objects sit loose, and have zero cost at
> the time of gc.  In a "cruft pack" world, you'd pay some I/O to copy
> them into the cruft pack, and some CPU to zlib and delta-compress them.
> I think that's probably fine, though.

I wasn't assuming that git-gc would create a cruft pack --- although I
guess it could.  As you say, recent loose objects have relatively zero
cost at the time of gc.  To the extent that the gc has to read lots of
loose files, there may be more seeks in the cold cache case, so there
is actually *some* cost to having the loose objects, but it's not
great.

What I was thinking about instead is that in cases where we know we
are likely to be creating a large number of loose objects (whether
they referenced or not), in a world where we will be calling fsync(2)
after every single loose object being created, pack files start
looking *way* more efficient.  So in general, if you know you will be
creating N loose objects, where N is probably around 50 or so, you'll
want to create a pack instead.

One of those cases is "repack -A", and in that case the loose objects
are all going tobe not referenced, so it would be a "cruft pack".  But
in many other cases where we might be importing from another DCVS,
which will be another case where doing an fsync(2) after every loose
object creation (and where I have sometimes seen it create them *all*
loose, and not use a pack at all), is going to get extremely slow and
painful.

> So if we pack all the loose objects into a cruft pack, the mtime of the
> cruft pack becomes the new gauge for "recent". And if we migrate objects
> from old cruft pack to new cruft pack at each gc, then they'll keep
> getting their mtimes refreshed, and we'll never drop them.

Well, I was assuming that gc would be a special case which doesn't the
mtime of the old cruft pack.  (Or more generally, any time an object
is gets copied out of the cruft pack, either to a loose object, or to
another pack, the mtime on the source pack should not be touched.)

	      	  	       	      	   	   - Ted
