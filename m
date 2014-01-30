From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 15:45:38 -0500
Message-ID: <20140130204538.GA1130@sigill.intra.peff.net>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 21:45:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8yUa-00029t-B8
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 21:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbaA3Upk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 15:45:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:41726 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751468AbaA3Upk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 15:45:40 -0500
Received: (qmail 7695 invoked by uid 102); 30 Jan 2014 20:45:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Jan 2014 14:45:39 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jan 2014 15:45:38 -0500
Content-Disposition: inline
In-Reply-To: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241280>

On Thu, Jan 30, 2014 at 02:55:41PM -0500, Brian Gernhardt wrote:

> a201c20 (ewah: support platforms that require aligned reads) added a
> reliance on the existence of __BYTE_ORDER and __BIG_ENDIAN.  However,
> these macros are spelled without the leading __ on some platforms (OS
> X at least).  In this case, the endian-swapping code was added even
> when unnecessary, which caused assertion failures in
> t5310-pack-bitmaps.sh as the code that used the bitmap would read past
> the end.
> 
> We already had code to handle this case in compat/bswap.h, but it was
> only used if we couldn't already find a reasonable version of bswap64.
> Move the macro-defining and checking code out of a conditional so that
> either __BYTE_ORDER is defined or we get a compilation error instead
> of a runtime error in the bitmap code.

Thanks, this makes sense, and matches the assumption that a201c20 made.

I do find the failure mode interesting. The endian-swapping code kicked
in when it did not, meaning your are on a big-endian system. Is this on
an ancient PPC Mac? Or is the problem that the code did not kick in when
it should?

Either way, we should perhaps be more careful in the bitmap code, too,
that the values we get are sensible. It's better to die("your bitmap is
broken") than to read off the end of the array. I can't seem to trigger
the same failure mode, though. On my x86 system, turning off the
endian-swap (i.e., the opposite of what should happen) makes t5310 fail,
but it is because we end up trying to set the bit very far into a
dynamic bitfield, and die allocating memory.

-Peff
