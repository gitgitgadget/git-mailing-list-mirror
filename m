From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t9200: avoid grep on non-ASCII data
Date: Mon, 22 Feb 2016 17:25:04 -0500
Message-ID: <20160222222503.GD18522@sigill.intra.peff.net>
References: <20160219193310.GA1299@sigill.intra.peff.net>
 <cover.1456075680.git.john@keeping.me.uk>
 <42c95c23bffcbb526aaae302f80667867d164876.1456075680.git.john@keeping.me.uk>
 <CAPig+cQkcUPD5+0rUPkKCcJSzRC0NkuRYKHmW54eZ041PqaqmQ@mail.gmail.com>
 <20160221234345.GB14382@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:25:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyup-0006xP-Ne
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbcBVWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:25:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:47010 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932127AbcBVWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:25:06 -0500
Received: (qmail 20699 invoked by uid 102); 22 Feb 2016 22:25:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:25:06 -0500
Received: (qmail 22662 invoked by uid 107); 22 Feb 2016 22:25:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:25:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:25:04 -0500
Content-Disposition: inline
In-Reply-To: <20160221234345.GB14382@river.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286963>

On Sun, Feb 21, 2016 at 11:43:45PM +0000, John Keeping wrote:

> On Sun, Feb 21, 2016 at 04:15:31PM -0500, Eric Sunshine wrote:
> > On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
> > > GNU grep 2.23 detects the input used in this test as binary data so it
> > > does not work for extracting lines from a file.  We could add the "-a"
> > > option to force grep to treat the input as text, but not all
> > > implementations support that.  Instead, use sed to extract the desired
> > > lines since it will always treat its input as text.
> > >
> > > Signed-off-by: John Keeping <john@keeping.me.uk>
> > > ---
> > > diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> > > @@ -35,7 +35,7 @@ exit 1
> > >  check_entries () {
> > >         # $1 == directory, $2 == expected
> > > -       grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
> > > +       sed -ne '\!^/!p' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
> > 
> > This works with BSD sed, but double negatives are confusing. Have you
> > considered this instead?
> > 
> >     sed -ne '/^\//p' ...
> 
> What do you mean double negatives?  Do you mean using "!" as an
> alternative delimiter?  I find changing delimters is normally simpler
> than following multiple levels of quoting for escaping slashes, although
> in this case it's simple enough that it doesn't make much difference.

I agree that changing delimiters is much nicer than backslashes. But I
wonder if using "!" is more confusing than it needs to be, given its
other meanings.

I dunno. I admit that the backslash threw me off, too (since it needs
escaped in interactive shells, I first assumed that's what was going
on). Using backslash to select the delimiter was new to me. I've usually
seen:

  s!/foo/!/bar/!

which is arguably a little more clear. Too bad we cannot do:

  m!/foo!

which I think reads better. Oh well. Maybe:

  sed -ne '\#^/#p'

would be more readable, but I'm just bikeshedding at this point.  The
grep invocation really was the most clear. :-/

-Peff
