From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] resolve_ref_unsafe(): close race condition reading
 loose refs
Date: Wed, 12 Jun 2013 04:04:49 -0400
Message-ID: <20130612080449.GA537@sigill.intra.peff.net>
References: <20130507023802.GA22940@sigill.intra.peff.net>
 <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
 <1370960780-1055-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 10:05:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umg3D-0007A9-4J
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 10:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab3FLIE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 04:04:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:34692 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754620Ab3FLIEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 04:04:52 -0400
Received: (qmail 8091 invoked by uid 102); 12 Jun 2013 08:05:44 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 03:05:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 04:04:49 -0400
Content-Disposition: inline
In-Reply-To: <1370960780-1055-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227590>

On Tue, Jun 11, 2013 at 04:26:20PM +0200, Michael Haggerty wrote:

> Please note that if there is some bizarre filesystem somewhere for
> which, for a single, static file
> 
>     lstat() reports S_ISLNK and readlink() fails with ENOENT or EINVAL
> [...]
> then the inner loop would never terminate.

Yeah, I had the exact same thought while reading your description above.
I think we can call that "too crazy to worry about", and deal with it if
it ever actually comes up.

Overall your series looks correct to me. The use of the extra "for(;;)"
and its control flow feels a little tortured to me.  Would it be
simpler to just do:

  stat_ref:
          if (lstat(...) < 0)
            ...
          if (readlink(...) < 0)
                  if (errno == ENOENT || errno == EINVAL)
                          /* inconsistent with lstat; retry */
                          goto stat_ref;

          if (open(...) < 0)
                  if (errno == ENOENT)
                          /* inconsistent with lstat; retry */
                          goto stat_ref;

It is really the same thing, but somehow the goto makes it more obvious
to me that it is the exceptional case to loop at all (and I think your
patch 3/4 could just go away entirely).  But I don't mind that much if
it stays with the for loop.

Thanks for a pleasant read; the split made the refactoring easy to
follow.

-Peff
