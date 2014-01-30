From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 17:46:57 -0500
Message-ID: <20140130224657.GA30478@sigill.intra.peff.net>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
 <20140130220233.GH27577@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 23:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W90O0-0003IP-B2
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 23:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbaA3WrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 17:47:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:41792 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753522AbaA3Wq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 17:46:59 -0500
Received: (qmail 14594 invoked by uid 102); 30 Jan 2014 22:46:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Jan 2014 16:46:59 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jan 2014 17:46:57 -0500
Content-Disposition: inline
In-Reply-To: <20140130220233.GH27577@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241285>

On Thu, Jan 30, 2014 at 02:02:33PM -0800, Jonathan Nieder wrote:

> In an ideal world I would prefer to just rely on ntohll when it's
> decent (meaning that the '#if __BYTE_ORDER != __BIG_ENDIAN' block
> could be written as
> 
> 	if (ntohll(1) != 1) {
> 		...
> 	}
> 
> or
> 
> 	if (ntohll(1) == 1)
> 		; /* Big endian.  Nothing to do.
> 	else {
> 		...
> 	}
> 
> ).  But compat/bswap.h already relies on knowing the endianness at
> preprocessing time so that wouldn't buy anything.

Yes, though it would simplify things because we are depending on ntohll
being defined, rather than some obscure macros.

> Another "in an ideal world" option: make the loop unconditional after
> checking that optimizers on big-endian systems realize it's a noop.
> In any event, in the real world your patch looks like the right thing
> to do.

I had the same thought when reading the original patch. The loop after
pre-processing on a big-endian system should look like:

  {
          size_t i;
          for (i = 0; i < self->buffer_size; ++i)
              self->buffer[i] = self->buffer[i];
  }

It really seems like the sort of thing that any halfway decent compiler
should be able to turn into a noop. I'm OK to go that route, and if you
don't have a halfway decent compiler, tough cookies; git will waste your
precious nanoseconds doing a relatively small loop. If this loop
actually mattered, we would probably do better still to leave it in disk
order, and fix it up as-needed only when we look at a particular bitmap
(we do not typically need to look at all of them on disk).

-Peff
