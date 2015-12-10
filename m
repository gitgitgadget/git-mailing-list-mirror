From: Jeff King <peff@peff.net>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 13:34:26 -0500
Message-ID: <20151210183426.GA27609@sigill.intra.peff.net>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
 <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
 <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Taylor Braun-Jones <taylor@braun-jones.org>
X-From: git-owner@vger.kernel.org Thu Dec 10 19:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7633-0003li-Tj
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 19:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbbLJSeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:34:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:39896 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755315AbbLJSe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:34:29 -0500
Received: (qmail 30672 invoked by uid 102); 10 Dec 2015 18:34:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 12:34:29 -0600
Received: (qmail 22549 invoked by uid 107); 10 Dec 2015 18:34:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 13:34:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 13:34:26 -0500
Content-Disposition: inline
In-Reply-To: <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282220>

On Wed, Dec 09, 2015 at 05:35:52PM -0500, Taylor Braun-Jones wrote:

> > Well.. reflog needs it. So either you disable reflog at clone time or
> > define name/email via config file. I don't see anything wrong with
> > this behavior.
> 
> Can't git just use "unknown" and "unknown@localhost" if the name or
> email can not be determined from xgetpwuid? This seems to be the way
> that Mercurial behaves.

Yeah, I think there is a mismatch here in the ident code. When we are
making a commit (which is likely to get published and is set in stone),
we ask for "IDENT_STRICT", which will barf if we can't come up with
something sensible. For reflogs, we are OK putting whatever
auto-generated crap in there we can come up with.

But before we even hit the strict-check, we call xgetpwuid_self(), which
unconditionally dies on failure. I think that function needs to be
taught a "gently" form which we use for non-strict ident lookups.
Unfortunately it's a little non-trivial because the strictness will need
to get passed all the way down to ident_default_name() (and we need to
make sure that a non-strict check followed by a strict one does not
fail; i.e., that the first does not pollute the contents of
git_default_name).

-Peff
