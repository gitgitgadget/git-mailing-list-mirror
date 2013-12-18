From: Jeff King <peff@peff.net>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 16:28:48 -0500
Message-ID: <20131218212847.GA13685@sigill.intra.peff.net>
References: <20131218171446.GA19657@kitenet.net>
 <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
 <20131218191702.GA9083@sigill.intra.peff.net>
 <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 22:29:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOfu-0002tt-9B
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab3LRV2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:28:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:46923 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942Ab3LRV2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:28:52 -0500
Received: (qmail 8344 invoked by uid 102); 18 Dec 2013 21:28:52 -0000
Received: from va-71-48-137-223.dhcp.embarqhsd.net (HELO sigill.intra.peff.net) (71.48.137.223)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 15:28:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 16:28:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239489>

On Wed, Dec 18, 2013 at 11:50:24AM -0800, Junio C Hamano wrote:

> -------------------------------- 8< ------------------------------
> 
> static unsigned int get_max_fd_limit(void)
> {
> #ifdef RLIMIT_NOFILE
> 	struct rlimit lim;
> 
> 	if (!getrlimit(RLIMIT_NOFILE, &lim))
> 		return lim.rlim_cur;
> #endif
> 
> #if defined(_SC_OPEN_MAX)
> 	{
> 		long sc_open_max = sysconf(_SC_OPEN_MAX);
> 		if (0 < sc_open_max)
> 			return sc_open_max;
> 	}
> 
> #if defined(OPEN_MAX)
> 	return OPEN_MAX;
> #else
> 	return 1; /* see the caller ;-) */
> #endif
> }
> 
> -------------------------------- >8 ------------------------------

Yeah, with the #endif followup you posted, this is what I had in mind.

> But the sysconf part makes me wonder; here is what we see in
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/sysconf.html
> 
>     If name is an invalid value, sysconf() shall return -1 and set errno
>     to indicate the error. If the variable corresponding to name is
>     described in <limits.h> as a maximum or minimum value and the
>     variable has no limit, sysconf() shall return -1 without changing
>     the value of errno. Note that indefinite limits do not imply
>     infinite limits; see <limits.h>.
> 
> For a broken system (like RLIMIT_NOFILE defined for the compiler,
> but the actual call returns a bogus error), the compiler may see the
> _SC_OPEN_MAX defined, while sysconf() may say "I've never heard of
> such a name" and return -1, or the system, whether broken or not,
> may want to say "Unlimited" and return -1.  The caller takes
> anything unreasonable as a positive value capped to 25 or something,
> so there isn't a real harm if we returned a bogus value from here,
> but I am not sure what the safe default behaviour of this function
> should be to help such a broken system while not harming systems
> that are functioning correctly.

According to the POSIX quote above, it sounds like we could do:

  #if defined (_SC_OPEN_MAX)
  {
          long max;
          errno = 0;
          max = sysconf(_SC_OPEN_MAX);
          if (0 < max) /* got the limit */
                  return max;
          else if (!errno) /* unlimited, cast to int-max */
                  return max;
          /* otherwise, fall through */
  }
  #endif

Obviously you could collapse the two branches of the conditional, though
I think it deserves at least a comment to explain what is going on.

-Peff
