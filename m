From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] pack-revindex: drop hash table
Date: Mon, 21 Dec 2015 02:08:28 -0500
Message-ID: <20151221070828.GA3895@sigill.intra.peff.net>
References: <20151221061948.GA25763@sigill.intra.peff.net>
 <CAPig+cTD+qknnZ3rH7skcTxZA16AL0BPbLT5ZaJdwwu_d-i=Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 08:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAuaB-0003Ut-74
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 08:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbbLUHIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 02:08:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:44808 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750875AbbLUHIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 02:08:31 -0500
Received: (qmail 581 invoked by uid 102); 21 Dec 2015 07:08:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 01:08:31 -0600
Received: (qmail 18643 invoked by uid 107); 21 Dec 2015 07:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 02:08:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Dec 2015 02:08:28 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTD+qknnZ3rH7skcTxZA16AL0BPbLT5ZaJdwwu_d-i=Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282787>

On Mon, Dec 21, 2015 at 02:06:59AM -0500, Eric Sunshine wrote:

> On Mon, Dec 21, 2015 at 1:19 AM, Jeff King <peff@peff.net> wrote:
> > The main entry point to the pack-revindex code is
> > find_pack_revindex(). This calls revindex_for_pack(), which
> > lazily computes and caches the revindex for the pack.
> >
> > We store the cache in a very simple hash table. It's created
> > by init_pack_revindex(), which inserts an entry for every
> > packfile we know about, and we never grow or shrink the
> > hash. If we ever need the revindex for a pack that isn't in
> > the hash, we die() with an internal error.
> >
> > This can lead to a race, because we may load more packs
> > after having called init_pack_revindex(). For example,
> > imagine we have one process which needs to look at the
> > revindex for a variety of objects (e.g., cat-file's
> > "%(objectsize:disk)" format).  Simultaneously, git-gc is
> > running, which is doing a `git repack -ad` is running. We
> > might hit a sequence like:
> 
> Probably want to drop one of the "is running"s...

Whoops. Not matter how many times I read it over...

It should be:

  Simultaneously, git-gc is running, which is doing a `git repack -ad`.

-Peff
