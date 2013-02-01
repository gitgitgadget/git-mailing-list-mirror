From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Fri, 1 Feb 2013 05:15:03 -0500
Message-ID: <20130201101503.GG30644@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh>
 <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
 <20130131110656.GA28093@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Ded-0002ju-1I
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 11:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab3BAKPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 05:15:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55364 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583Ab3BAKPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 05:15:07 -0500
Received: (qmail 27875 invoked by uid 107); 1 Feb 2013 10:16:30 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 05:16:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 05:15:03 -0500
Content-Disposition: inline
In-Reply-To: <20130131110656.GA28093@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215229>

On Thu, Jan 31, 2013 at 06:06:56PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Jan 30, 2013 at 09:16:29PM +0700, Duy Nguyen wrote:
> > Perhaps we could store abbrev sha-1 instead of full sha-1. Nice
> > space/time trade-off.
> 
> Following the on-disk format experiment yesterday, I changed the
> format to:
> 
>  - a list a _short_ SHA-1 of cached commits
>  - a list of cache entries, each (5 uint32_t) consists of:
>    - uint32_t for the index in .idx sha-1 table to get full SHA-1 of
>      the commit
>    - uint32_t for timestamp
>    - uint32_t for tree, 1st and 2nd parents for the index in .idx
>      table

Thanks for working on this, as it was the next step I was going to take. :)

The short-sha1 is a clever idea. Looks like it saves us on the order of
4MB for linux-2.6 (versus the full 20-byte sha1). Not as big as the
savings we get from dropping the other 3 sha1's to uint32_t, but still
not bad.

I guess the next steps in iterating on this would be:

  1. splitting out the refactoring here into separate patches

  2. squashing the cleaned-up bits into my patch 4/6

  3. deciding whether this should go into a separate file or as part of
     index v3. Your offsets depend on the .idx file having a sorted sha1
     list. That is not likely to change, but it would still be nice to
     make sure they cannot get out of sync. I'm still curious what the
     performance impact is for mmap-ing N versus N+8MB.

> The length of SHA-1 is chosen to be able to unambiguously identify any
> cached commits. Full SHA-1 check is done after to catch false
> positives.

Just to be clear, these false positives come because the abbreviation is
unambiguous within the packfile, but we might be looking for a commit
that is not even in our pack, right?

-Peff
