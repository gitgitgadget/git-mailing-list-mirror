From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Wed, 8 Apr 2015 02:17:13 +0200
Message-ID: <20150408001712.GA16798@peff.net>
References: <20150405010611.GA15901@peff.net>
 <20150405011110.GC30127@peff.net>
 <20150405045614.GA12053@peff.net>
 <87zj6kjbgu.fsf@rasmusvillemoes.dk>
 <20150407190413.GB2553@peff.net>
 <87k2xn8sqq.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Wed Apr 08 02:17:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfdgO-0001xW-34
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 02:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbbDHARW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 20:17:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:43561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753952AbbDHARW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 20:17:22 -0400
Received: (qmail 28392 invoked by uid 102); 8 Apr 2015 00:17:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Apr 2015 19:17:21 -0500
Received: (qmail 24483 invoked by uid 107); 8 Apr 2015 00:17:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Apr 2015 20:17:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Apr 2015 02:17:13 +0200
Content-Disposition: inline
In-Reply-To: <87k2xn8sqq.fsf@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266945>

On Wed, Apr 08, 2015 at 12:43:09AM +0200, Rasmus Villemoes wrote:

> Hm, I'm afraid it's not that simple. It seems that data may be lost from
> the stream if getdelim encounters ENOMEM: Looking at the glibc
> implementation (libio/iogetdelim.c), if reallocating the user buffer
> fails, -1 is returned (presumably with errno==ENOMEM set by realloc), and
> there's no way of knowing how many bytes were already copied to the
> buffer (cur_len).
> 
> For regular files, I suppose one could do a ftell/fseek dance. For
> other cases, I don't see a reliable way to retry upon ENOMEM.

Ah, right, that makes sense.

I think it may be OK to just `die()` on ENOMEM here. The "try to free"
routine is basically about unmapping pack memory, in case it is clogging
up the address space (it is mmap'd, so it shouldn't cause real RAM
pressure; the OS can just drop the pages from the cache if it wants).

But getdelim() calls are not likely to be big allocations in the first
place (so they are not likely to fail at all, and if they do, we really
are horribly out of memory). I'd also question whether
release_pack_memory is doing anything in practice on 64-bit machines. We
have quite a bit of address space to work with in that case.

-Peff
