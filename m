From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Thu, 13 Nov 2014 04:08:32 -0500
Message-ID: <20141113090832.GA8329@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
 <20141109015918.GA24736@peff.net>
 <5463C106.5090803@kdbg.org>
 <20141112215923.GB6801@peff.net>
 <546470D0.3080809@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 10:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoqOQ-0002js-IE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 10:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbaKMJIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 04:08:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:39788 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932098AbaKMJIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 04:08:35 -0500
Received: (qmail 17789 invoked by uid 102); 13 Nov 2014 09:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 03:08:35 -0600
Received: (qmail 21873 invoked by uid 107); 13 Nov 2014 09:08:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 04:08:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 04:08:32 -0500
Content-Disposition: inline
In-Reply-To: <546470D0.3080809@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 09:50:24AM +0100, Johannes Sixt wrote:

> >That looks more like it is failing the actual test (i.e., the creation
> >of branch "one" when there is cruft in the reflog). My guess is that
> >calling open() on a directory is giving us EACCES instead of EISDIR. Can
> >you verify that?
> >
> >If that is the case, then this isn't a new breakage, I think, but just
> >code we weren't previously exercising. It would be interesting to know
> >whether:
> >
> >   git config core.logallrefupdates true
> >   git branch one/two
> >   git branch -d one/two
> >   git branch one
> >
> >works (even without my patch). If so, then there's probably something
> >else going on.
> 
> Don't know what you mean with "my patch" (the one I was responding to
> touches only t1410).

The patch you are responding to is a fix-up for 9233887, which tweaked
the code and added those tests in the first place (I doubt it would work
for you, though, as it has a problem on case-insensitive filesystems).

> But the sequence works as expected with a version built
> in September:

Hmph. So that would mean my theory is not right. Or maybe I am not
accounting for something else in my analysis.

I guess it is odd that the test right before the failing one passes (it
is basically that same sequence, with reflogs turned on for both
operations), which implies that we are properly getting EISDIR. The only
difference in the failing test is that reflogs are turned off for the
"git branch one" operation. But I cannot see why that would be broken if
the other one passes.

I wish it were easy for me to ssh into a Windows VM and run gdb. ;)

-Peff
