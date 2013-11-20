From: Jeff King <peff@peff.net>
Subject: Re: corrupt object memory allocation error
Date: Wed, 20 Nov 2013 16:33:48 -0500
Message-ID: <20131120213348.GA29004@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 22:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjFPJ-0002kQ-J8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 22:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579Ab3KTVdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 16:33:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:42820 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755575Ab3KTVdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 16:33:50 -0500
Received: (qmail 4659 invoked by uid 102); 20 Nov 2013 21:33:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Nov 2013 15:33:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Nov 2013 16:33:48 -0500
Content-Disposition: inline
In-Reply-To: <20131120203350.GA31139@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238097>

On Wed, Nov 20, 2013 at 04:33:50PM -0400, Joey Hess wrote:

> I've got a git repository of < 2 mb, where git wants to
> allocate a rather insane amount of memory:
> 
> >git fsck
> Checking object directories: 100% (256/256), done.
> fatal: Out of memory, malloc failed (tried to allocate 124865231165 bytes)
> 
> > git show 11644b5a075dc1425e01fbba51c045cea2d0c408
> fatal: Out of memory, malloc failed (tried to allocate 124865231165 bytes)
> 
> The problem seems to be the attached object file, which has gotten
> corrupted, presumably in the header that git reads to see how large it
> is. Thought I'd report this in case there is some easy way to
> add a sanity check.

Definitely a corrupt object. The start is not a valid zlib header, so we
guess that it is an "experimental loose object". This is a format that
git wrote for very short period as a performance experiment; it didn't
pan out and we no longer write it.

The loose object format contains the (purported) object size outside of
the checksum'd zlib data (whereas the normal format has a human-readable
header that gets zlib'd). Your corrupted bytes end up specifying a
ridiculously large size.

I wonder if it is time to drop reading support for the experimental
objects. It was never widely used, and was deprecated in v1.5.2 by
726f852 (deprecate the new loose object header format, 2007-05-09). That
would improve the case when the initial bytes of a loose object are
corrupted, because we would complain about the bogus zlib data before
trying to allocate the buffer.

The problem would still remain for packfiles, which use a similar
encoding, but I suspect it is less common there. For a single-byte
corruption, it is unlikely to be right in the length header. But for
absolute junk that is not git data at all, the first bytes are very
likely to be corrupted. In the pack case, we would notice early that it
does not look like a packfile; for the loose object, we have no such
header and proceed with the allocation.

As for your specific corruption, I can't make heads or tails of it. It
is not a single-bit error. The first two bytes of a loose object should
always be <0x78, 0x01>, which is the standard zlib deflate header. Your
bytes aren't even close, and decoding the rest with a corrupted zlib
header seems fruitless.

You don't happen to have another copy of the object (or of the data
contained in the object, such as the working tree file), do you? It
might be interesting to see a comparison of the bytes of the correct
data and your corruption.

-Peff
