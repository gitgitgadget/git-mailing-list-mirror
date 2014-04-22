From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-bitmap: do not core dump
Date: Tue, 22 Apr 2014 19:17:48 -0400
Message-ID: <20140422231748.GA20353@sigill.intra.peff.net>
References: <781073ea08e86301f62e708bc0b80fd@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 01:17:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcjwq-0004nc-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 01:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaDVXRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 19:17:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36468 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750705AbaDVXRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 19:17:50 -0400
Received: (qmail 27550 invoked by uid 102); 22 Apr 2014 23:17:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Apr 2014 18:17:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2014 19:17:48 -0400
Content-Disposition: inline
In-Reply-To: <781073ea08e86301f62e708bc0b80fd@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246805>

On Tue, Apr 22, 2014 at 03:53:02PM -0700, Kyle J. McKay wrote:

> So I was trying to use pack.writebitmaps=true and all I got was core dumps.

Eek.

> The fix with a real subject line ;) is below.  I think perhaps this should be
> picked up for the 2.0.0 release.  (Patch is against master.)

Yes, this is definitely the sort of bugfix we want to see during the -rc
period (well, we would prefer not to see bugs at all, but if we must
have them, fixes are helpful).

> ---- >8 ----
> Subject: [PATCH] ewah_bitmap.c: do not assume size_t and eword_t are the same size

Thanks for a very well-written commit message. I think your fix makes
sense:

> -	self->rlw = self->buffer + (rlw_offset / sizeof(size_t));
> +	self->rlw = self->buffer + (rlw_offset / sizeof(eword_t));

We could also write it as:

  self->rlw = (uint8_t *)self->buffer + rlw_offset;

but I do not think that is necessarily any more readable, especially
because we probably need to cast it like:

  self->rlw = (eword_t *)((uint8_t *)self->buffer + rlw_offset);

Given that self->rlw is a pointer to eword_t, though, we can assume
rlw_offset is always going to be a multiple of sizeof(eword_t) anyway
(and if it is not, the division in the original is a big problem, but I
do not think that is the case).  So why do any uint8_t math in the first
place? I think we could write it as:

	eword_t *old = self->buffer;
	... realloc ...
	self->rlw = self->buffer + (self->rlw - old);

I'm fine with your patch, though.

I also poked through the rest of the bitmap code looking for similar
problems, but didn't find any. I do not think this was a systemic issue
with bad use of types; it was just a think-o that happened to work on
64-bit machines.

-Peff
