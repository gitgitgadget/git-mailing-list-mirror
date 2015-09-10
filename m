From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2015, #02; Wed, 9)
Date: Thu, 10 Sep 2015 05:29:23 -0400
Message-ID: <20150910092922.GB6633@sigill.intra.peff.net>
References: <xmqqpp1r5n2d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 11:29:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZyAc-0007AT-K3
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 11:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbbIJJ30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 05:29:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:57146 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753387AbbIJJ3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 05:29:25 -0400
Received: (qmail 9685 invoked by uid 102); 10 Sep 2015 09:29:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Sep 2015 04:29:25 -0500
Received: (qmail 6657 invoked by uid 107); 10 Sep 2015 09:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Sep 2015 05:29:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Sep 2015 05:29:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp1r5n2d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277577>

On Wed, Sep 09, 2015 at 01:56:26PM -0700, Junio C Hamano wrote:

> * ti/glibc-stdio-mutex-from-signal-handler (2015-09-04) 1 commit
>   (merged to 'next' on 2015-09-08 at c8047ba)
>  + pager: don't use unsafe functions in signal handlers
> 
>  Allocation related functions and stdio are unsafe things to call
>  inside a signal handler, and indeed killing the pager can cause
>  glibc to deadlock waiting on allocation mutex as our signal handler
>  tries to free() some data structures in wait_for_pager().  Reduce
>  these unsafe calls.
> 
>  I seem to recall Peff had other ideas?  Let's revisit this in the
>  next cycle.

Yeah, I'm hoping to do a pass soon over all of the signal handling code,
because the problem exists elsewhere, too.  I don't mind if this makes
it into v2.6.0 and I build on top, though. It seems like an obvious
strict improvement to me.

I did wonder if we needed to deal with any fallout from f4c3edc
(vreportf: avoid intermediate buffer, 2015-08-11). That _is_ new in this
release, so regressions are fair game during the -rc period.

I don't think it should matter, though. Though it does add an fflush(), it
is replacing an existing fprintf(), and both should be taking the same
lock on stderr (so it probably _is_ still a potential problem, but not a
new one).

The predecessor commit, 3b331e9, does convert a write() into an
fprintf(), but this code path is used only in a newly-forked child
process before it execs. I think that is OK, though; we are operating on
a newly created filehandle that is not used anywhere else.

-Peff
