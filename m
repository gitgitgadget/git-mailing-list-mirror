From: Jeff King <peff@peff.net>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Tue, 13 Nov 2012 12:04:52 -0500
Message-ID: <20121113170452.GE20361@sigill.intra.peff.net>
References: <20121111232820.284510@gmx.net>
 <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net>
 <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org,
	jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:05:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJvE-0005fd-IF
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 18:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025Ab2KMRE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 12:04:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47601 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095Ab2KMRE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 12:04:57 -0500
Received: (qmail 26744 invoked by uid 107); 13 Nov 2012 17:05:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 12:05:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 12:04:52 -0500
Content-Disposition: inline
In-Reply-To: <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209641>

On Tue, Nov 13, 2012 at 09:44:06AM -0500, Drew Northup wrote:

> I don't buy the argument that we don't need to clean up the input as
> well. There are scant few of us that are going to name a file
> "<script>alert("Something Awful")</script>" in this world (I am
> probably one of them). Input validation is key to keeping problems
> like this from coming up repeatedly as those writing the guts of
> programs are typically more interested in getting the "assigned task"
> done and reporting the output to the user in a safe manner.

Oh, you absolutely do need to clean up the input side. And we do. Notice
how validate_pathname cleans out dots that could allow an attacker to do
a "../../etc/passwd" attack. But the input validation is _different_
than the output escaping. We are turning arbitrary junk from the user
into something we know is safe to treat as a filename. Our goal is
protecting the filesystem and the server, and we do that already.
Protecting the browser on output is a different problem, and happens
only when we are sending to the browser.

As far as "people will not use <script>" in their filenames, the
end-game to any quoting or blacklist fix is that we need to escape or
black _all_ HTML.  Because whether it is "<b>" or "<script>", it is
still wrong. Are you as comfortable saying that nobody will ever have a
"<" or "&" in their filename?

> >   3. Your filter is too simplistic. At the very least, it would not
> >      filter out "<SCRIPT>". I am not up to date on all of the
> >      sneaking-around-HTML-filters attacks that are available these days,
> >      but I wonder if one could also get around it using XML entities or
> >      similar.
> 
> You will note that I said "a more definitive fix is in order" in my
> original. In other words, I claimed it to be utterly incomplete to
> start with.

Sorry if I came off as too harsh. My intent was to guide you in the
right direction for the definitive fix. The fact that I ended up rolling
the patch myself was just because my "probably something like this"
ended with everybody saying "yeah, that", and it seemed simpler to just
roll a test and be done.

> > I think the right answer is going to be a well-placed call to esc_html.
> > This already happens automatically when we go through the CGI
> > element-building functions, but obviously we failed to make the call
> > when building the output manually.  This is a great reason why template
> > languages which default to safe expansion should always be used.
> > Unfortunately, gitweb is living in 1995 in terms of web frameworks.
> 
> Escaping the output protects the user, but it DOES NOT protect the
> server. We MUST handle both possibilities.

Right. But I think we already do, via validate_pathname. If that is not
the case, please point it out.

> Besides, inserting one call to esc_html only fixes one attack path. I
> didn't look to see if all others were already covered.

Properly quoting output is something that the web framework should do
for you. gitweb uses CGI.pm, which does help with that, but we do not
use it consistently. If there are other problematic areas, I think the
best path forward is to use our framework more.

-Peff
