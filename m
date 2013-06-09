From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Sat, 8 Jun 2013 20:18:45 -0400
Message-ID: <20130609001845.GC29964@sigill.intra.peff.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net>
 <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net>
 <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
 <20130606064409.GA20334@sigill.intra.peff.net>
 <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
 <20130606174032.GB32174@sigill.intra.peff.net>
 <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 02:19:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlTLc-0004XX-3V
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 02:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab3FIASt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 20:18:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:58168 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909Ab3FIASs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 20:18:48 -0400
Received: (qmail 30684 invoked by uid 102); 9 Jun 2013 00:19:37 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Jun 2013 19:19:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Jun 2013 20:18:45 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226865>

On Fri, Jun 07, 2013 at 12:12:52PM +0200, Erik Faye-Lund wrote:

> > Yeah, if it were mingw_raise responsible for this, I would suggest using
> > the POSIX shell "128+sig" instead. We could potentially check for
> > SIG_DFL[1] mingw_raise and intercept and exit there. I don't know if
> > that would create headaches or confusion for other msys programs,
> > though. I'd leave that up to the msysgit people to decide whether it is
> > worth the trouble.
> >
> 
> ...and here's the code to do just that:
> [...]
> @@ -1715,6 +1720,13 @@ int mingw_raise(int sig)
>  			sigint_fn(SIGINT);
>  		return 0;
> 
> +	case SIGTERM:
> +		if (sigterm_fn == SIG_DFL)
> +			exit(128 + SIGTERM);
> +		else if (sigterm_fn != SIG_IGN)
> +			sigterm_fn(SIGTERM);
> +		return 0;

I'm a little negative on handling just SIGTERM. That would make the test
pass, but does it really address the overall issue? To me, the
usefulness is having exit values with consistent meanings. Imagine I run
a very large git hosting site, and I want to log exceptional conditions
(e.g., a git sub-process crashes). What exit code do I get from a
SIGSEGV or SIGBUS (or GPF, or whatever Windows calls these)?

On Unix systems, this is pretty easy. To be honest, I do not care that
much about Windows systems because I would not host a large site on it.
:) But IMHO, the point of such a scheme is to be consistent across all
signals.

-Peff
