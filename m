From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Mon, 14 May 2012 17:02:25 -0400
Message-ID: <20120514210225.GA9677@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 23:02:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU2Pa-0000Jp-HF
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 23:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207Ab2ENVC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 17:02:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43090
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757400Ab2ENVC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 17:02:27 -0400
Received: (qmail 25394 invoked by uid 107); 14 May 2012 21:02:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 17:02:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 17:02:25 -0400
Content-Disposition: inline
In-Reply-To: <20120514162824.GA24457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197810>

On Mon, May 14, 2012 at 12:28:24PM -0400, Jeff King wrote:

> When we pull the user's name from the GECOS field of the
> passwd file (or generate an email address based on their
> username and hostname), we put the result into a
> static buffer. While it's extremely unlikely that anybody
> ever hit these limits (after all, in such a case their
> parents must have hated them), we still had to deal with the
> error cases in our code.
> 
> Converting these static buffers to strbufs lets us simplify
> the code and drop some error messages from the documentation
> that have confused some users.
> 
> Note that there is still one length limitation: the
> gethostname interface requires us to provide a static
> buffer, so we arbitrarily choose 1024 bytes for the
> hostname.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Ick, there is something very wrong with this patch. While testing a
completely unrelated bug, I noticed that it set my name to "Jeff
KingJeff KingJeff King". Which, while a wonderful ego massage, is
probably excessive.

I'm sure the problem is the switch to strbuf's appending semantics
rather than strlcpy's overwriting semantics. I thought we were careful
not to bother re-run the gecos code if we had already gotten a name, but
obviously that is not the case in some code paths. I'll investigate.

-Peff
