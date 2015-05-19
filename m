From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-bitmaps: plug memory leak, fix allocation size for
 recent_bitmaps
Date: Tue, 19 May 2015 17:19:52 -0400
Message-ID: <20150519211952.GA23904@peff.net>
References: <555A7499.7090900@web.de>
 <20150519022321.GA29026@peff.net>
 <xmqqoalg73md.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Vicent Marti <tanoku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 23:20:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuovh-0000f3-CY
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbbESVT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:19:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:32804 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750937AbbESVT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:19:56 -0400
Received: (qmail 16326 invoked by uid 102); 19 May 2015 21:19:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 16:19:56 -0500
Received: (qmail 16976 invoked by uid 107); 19 May 2015 21:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 17:19:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 17:19:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoalg73md.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269402>

On Tue, May 19, 2015 at 12:45:46PM -0700, Junio C Hamano wrote:

> > I looked over the function one more time to make sure it is the function
> > that is wrong, and not my suggestion. :) The current code seems pretty
> > obviously wrong.
> 
> I actually cannot guess what the current code is trying to do.  Was
> it an attempt to cache that many entries, but instead allocated and
> discarded the space it tried to use as a cache every time?

Sort of. There are two caches at work.

The bitmaps on disk may be stored as XORs against nearby bitmaps up to
MAX_XOR_OFFSET slots away. So our goal is to reconstruct the actual
bitmaps and put them in our cache for later use. That's actually done by
store_bitmap(), which puts them into a hash table indexed by sha1.

But because we get the XOR base as an offset, we also need to be able to
quickly say "what was the bitmap that was N slots ago?", and the hash
cannot answer that quickly. So we keep a sliding window of the last
MAX_XOR_OFFSET bitmaps (pointing to the cached bitmaps stored in the
hash), and then we can index that directly by offset. And we can reuse
the array as a circular buffer (notice we always index it modulo the max
offset).

So you can think of the recent_bitmaps as an auxiliary index into the
bitmaps already cached by store_bitmap(). We don't need it after the xor
reconstruction (actually I think we don't do the xor reconstruction
here, but instead retain a pointer to the xor base and lazily do it, but
the point is that we've created that pointer).

-Peff
