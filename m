From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] Remove return undef from ask()
Date: Sun, 3 May 2009 16:26:25 -0400
Message-ID: <20090503202625.GC20468@coredump.intra.peff.net>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <1241010743-7020-2-git-send-email-wfp5p@virginia.edu> <1241010743-7020-3-git-send-email-wfp5p@virginia.edu> <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Sun May 03 22:26:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0iGj-0003tN-Kk
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 22:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbZECU01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 16:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbZECU01
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 16:26:27 -0400
Received: from peff.net ([208.65.91.99]:60907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbZECU00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 16:26:26 -0400
Received: (qmail 14329 invoked by uid 107); 3 May 2009 20:26:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 03 May 2009 16:26:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 03 May 2009 16:26:25 -0400
Content-Disposition: inline
In-Reply-To: <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118188>

On Wed, Apr 29, 2009 at 09:12:20AM -0400, Bill Pemberton wrote:

> Returning undef is rarely the correct way to return a failure.
> Replace it with bare return

I'm not sure this makes sense. The function is meant to be (and is
always) called in a scalar context, so "return" and "return undef"
produce exactly the same results. I find the latter much more clear,
because it is explicit about what the function is doing: return the
user's desire; if that fails, return the default; if no default, return
undef.

Returning undef can be a problem for programs which are meant to be used
in list context; you generally want to return the empty list in that
case (not a list with a single undef in it). So that is the reason for
the advice you are quoting.

I am not sure it is worth making this function behave properly in a list
context; it is not a library function, so we can see that all of the
existing callers use it in a scalar context (and we would have to define
sensible semantics for a list context). But even if we _did_ want to do
that, your patch is only the first step. You would have to also fix the
other returns which can return undef instead of an empty list. So there
is not much point to your patch as it stands.

On a side note, while looking at this function, I wonder if that "return
undef" is correct after all. We get there only if the user has failed to
give valid input 10 times, so presumably it is a sanity check to
prevent runaway input errors (and I am cc'ing Jay, who added the
function not too long ago). Should we be respecting the default here, as
we do when we get EOF? Although I tend to think if the user is
repeatedly giving us bogus input that we should not just proceed, but
should probably die. Because otherwise we are guessing at what they
might have wanted.

-Peff
