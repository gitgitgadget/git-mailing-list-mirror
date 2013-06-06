From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 6 Jun 2013 13:40:32 -0400
Message-ID: <20130606174032.GB32174@sigill.intra.peff.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net>
 <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net>
 <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
 <20130606064409.GA20334@sigill.intra.peff.net>
 <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 19:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkeAy-0004g3-A8
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 19:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab3FFRkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 13:40:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:33630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3FFRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 13:40:35 -0400
Received: (qmail 5731 invoked by uid 102); 6 Jun 2013 17:41:22 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Jun 2013 12:41:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jun 2013 13:40:32 -0400
Content-Disposition: inline
In-Reply-To: <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226517>

On Thu, Jun 06, 2013 at 10:21:47AM -0700, Junio C Hamano wrote:

> > The particular deficiency is that when a signal is raise()d whose SIG_DFL
> > action will cause process death (SIGTERM in this case), the
> > implementation of raise() just calls exit(3).
> 
> After a bit of web searching, it seems to me that this behaviour of
> raise() is in msvcrt, and compat/mingw.c::mingw_raise() just calls
> that.  In other words, "the implementation of raise()" is at an even
> lower level than mingw/msys, and I would agree that it is a platform
> issue.

Yeah, if it were mingw_raise responsible for this, I would suggest using
the POSIX shell "128+sig" instead. We could potentially check for
SIG_DFL[1] mingw_raise and intercept and exit there. I don't know if
that would create headaches or confusion for other msys programs,
though. I'd leave that up to the msysgit people to decide whether it is
worth the trouble.

[1] I'd use sigaction to do that on POSIX, but I would not be surprised
    to find that there is no support for it in msys. :)

> I tried to summarize the issue for end-user documentation and came
> up with this:
> 
>     The Git implementation on MinGW exits with status code 3 upon
>     receiving an uncaught process-terminating signal, just like any
>     program that link with msvcrt (Microsoft C Runtime library)
>     whose raise() implementation just calls exit(3).  This is
>     different from Git on POSIX, which reports a death by receiving
>     a signal with the exit status code (128 + signal number).
> 
> But when stated this way, it feels that it belongs to Msysgit
> documentation, not ours, at least to me.

Yeah, I think I agree.

-Peff
