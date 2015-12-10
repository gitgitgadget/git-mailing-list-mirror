From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 16:32:28 -0500
Message-ID: <20151210213228.GB29055@sigill.intra.peff.net>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
 <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
 <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
 <20151210183426.GA27609@sigill.intra.peff.net>
 <xmqqtwnqgjpm.fsf@gitster.mtv.corp.google.com>
 <20151210204034.GA29055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 22:32:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a78pI-0008A4-8R
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 22:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbbLJVcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 16:32:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:39975 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753187AbbLJVcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 16:32:31 -0500
Received: (qmail 13515 invoked by uid 102); 10 Dec 2015 21:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 15:32:30 -0600
Received: (qmail 23951 invoked by uid 107); 10 Dec 2015 21:32:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 16:32:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 16:32:28 -0500
Content-Disposition: inline
In-Reply-To: <20151210204034.GA29055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282231>

On Thu, Dec 10, 2015 at 03:40:35PM -0500, Jeff King wrote:

> > All true.  The adding of "(none)" in add_domainname() I used as an
> > excuse to make the function stop barfing is a symptom coming from
> > the above.  That one should die when asked to do a strict thing
> > (there is a corresponding kludge to do strstr "(none)" to cover it
> > up, which is even uglier X-<).
> 
> Yes, I have always hated that. It seems like we should just be able to
> carry a "strict" flag (both from xgetpwuid() and from the "(none)" hack)
> along with ident_default_*, and barf at the right time if it is not set.

I don't think we want to pass down a "be strict" flag to the low-level
code filling in default_{name,email}. We might be strict in one call,
and non-strict in another within the same program. Worse, we actually
call ident_default_name() even when we don't actually want the name (we
could fix that, too, but it just adds more cases to the code).

So here's my solution, which instead carries the "is it bogus" flag
along with the default strings.

  [1/3]: ident: make xgetpwuid_self() a static local helper
  [2/3]: ident: keep a flag for bogus default_email
  [3/3]: ident: loosen getpwuid error in non-strict mode

-Peff
