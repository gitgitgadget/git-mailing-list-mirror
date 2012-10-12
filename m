From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: fix segfault in handle_curl_result
Date: Fri, 12 Oct 2012 03:30:53 -0400
Message-ID: <20121012073053.GC17026@sigill.intra.peff.net>
References: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
 <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
 <20121012062249.GB17026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brad Hein <linuxbrad@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:31:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZi7-0001uM-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab2JLHa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:30:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50702 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab2JLHa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 03:30:56 -0400
Received: (qmail 32656 invoked by uid 107); 12 Oct 2012 07:31:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Oct 2012 03:31:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2012 03:30:53 -0400
Content-Disposition: inline
In-Reply-To: <20121012062249.GB17026@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207533>

On Fri, Oct 12, 2012 at 02:22:49AM -0400, Jeff King wrote:

> We should probably not be passing the slot to handle_curl_results at
> all, since it may have already been reused and is not safe to read. The
> only thing we do with it is to set up any new auth information in the
> curl handle.  This doesn't suffer the same problem because a reused slot
> will always have a curl handle. However, it means we may be setting the
> auth information for a random handle. Which is OK, since all handles use
> the same auth information anyway.  But it should also be pointless,
> because since dfa1725 (fix http auth with multiple curl handles) we
> always refresh the curl handle's auth information whenever we get an
> active slot.
> 
> However, I'm leaving that out of this patch.  Commit 8809703 was
> supposed to be a refactor with zero behavior changes, but it regressed.
> This fixes the regression by behaving exactly as we did beforehand. We
> can build the other thing on top.

I took a look at this, and indeed, it breaks existing code. But the
broken code is wrong and is easy to fix. So here is a series to do this,
on top of the one I am responding to.

These ones shouldn't have any functional impact, but do clean up the
code. I'd recommend the regression fix I already posted for maint and
1.8.0, and leave these to cook for post-1.8.0.

  [1/2]: remote-curl: do not call run_slot repeatedly
  [2/2]: http: do not set up curl auth after a 401

-Peff
