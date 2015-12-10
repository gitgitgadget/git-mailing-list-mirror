From: Jeff King <peff@peff.net>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 15:40:35 -0500
Message-ID: <20151210204034.GA29055@sigill.intra.peff.net>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
 <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
 <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
 <20151210183426.GA27609@sigill.intra.peff.net>
 <xmqqtwnqgjpm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 21:40:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7815-0007Vl-4e
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 21:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbbLJUkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 15:40:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:39952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751222AbbLJUki (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 15:40:38 -0500
Received: (qmail 9096 invoked by uid 102); 10 Dec 2015 20:40:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 14:40:37 -0600
Received: (qmail 23575 invoked by uid 107); 10 Dec 2015 20:40:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 15:40:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 15:40:35 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwnqgjpm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282230>

On Thu, Dec 10, 2015 at 11:57:41AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But before we even hit the strict-check, we call xgetpwuid_self(), which
> > unconditionally dies on failure. I think that function needs to be
> > taught a "gently" form which we use for non-strict ident lookups.
> > Unfortunately it's a little non-trivial because the strictness will need
> > to get passed all the way down to ident_default_name() (and we need to
> > make sure that a non-strict check followed by a strict one does not
> > fail; i.e., that the first does not pollute the contents of
> > git_default_name).
> 
> All true.  The adding of "(none)" in add_domainname() I used as an
> excuse to make the function stop barfing is a symptom coming from
> the above.  That one should die when asked to do a strict thing
> (there is a corresponding kludge to do strstr "(none)" to cover it
> up, which is even uglier X-<).

Yes, I have always hated that. It seems like we should just be able to
carry a "strict" flag (both from xgetpwuid() and from the "(none)" hack)
along with ident_default_*, and barf at the right time if it is not set.

-Peff
