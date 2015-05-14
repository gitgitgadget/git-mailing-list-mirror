From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 00:25:44 -0400
Message-ID: <20150514042544.GA9351@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu May 14 06:25:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YskiY-0000I3-3s
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 06:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbbENEZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 00:25:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:58400 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbbENEZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 00:25:48 -0400
Received: (qmail 7227 invoked by uid 102); 14 May 2015 04:25:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 23:25:48 -0500
Received: (qmail 19650 invoked by uid 107); 14 May 2015 04:25:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 00:25:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 00:25:44 -0400
Content-Disposition: inline
In-Reply-To: <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269022>

On Wed, May 13, 2015 at 10:41:31PM +0000, brian m. carlson wrote:

> I've been in contact with Dan Allen, the lead on the Asciidoctor
> project.  There are a few things that he pointed out.

Thanks. I was hoping you would get involved. :)

> >   - asciidoctor does not render {litdd}, which is our invention; locally
> >     this may be because I did not have the right incantation, but it is
> >     also broken on git-scm.com. I think the right fix is to define that
> >     attribute for the site renderer (so not a bug in our sources, and
> >     not an asciidoctor bug)
> 
> I passed this as a command-line argument when using asciidoctor to
> generate the docs: -a litdd=--.  For the site, I would recommend just
> defining it there, as you suggested.

Yeah, I tried what you wrote earlier in [1], but it didn't work. But I
just realized it has misplaced quotes. Doing:

  make ... ASCIIDOC_EXTRA="-a 'litdd=&#45;&#45;'"

seems to work OK.

[1] <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
    (sorry no link, gmane seems down)

> >   - in the '[verse]' section of the SYNOPSIS of each man page, AsciiDoc
> >     renders 'git add' in the usual way (with emphasis). Whereas
> >     AsciiDoctor renders it normally, with the literal quotes included.
> 
> What you want here is [verse,subs=normal].  As of Asciidoctor 1.5.0,
> this allows substitutions and markup within verse blocks.  I believe old
> versions of AsciiDoc did not render substitutions and markup in verse
> blocks, despite claiming to, and Asciidoctor picked up that behavior.

That does work for AsciiDoctor, but sadly it seems to break rendering
for AsciiDoc, where it puts:

    <div class="attribution">
    &#8212; subs=normal
    </div>

in the middle of the SYNOPSIS. Yuck. Is there a way to make it work
under both? Or a way to configure AsciiDoctor verses to always use
"subs=normal"?

> >   - We use "{attr? foo}" to display "foo" only when "attr" is set.
> >     AsciiDoctor does not seem to understand this and renders the whole
> >     string.
> 
> Yes, currently Asciidoctor doesn't support this.  Outside of
> asciidoc.conf, which Asciidoctor doesn't read, it looks like there's
> exactly two uses in diff-options.txt.  We could probably rewrite those
> using an attribute.

I think they're already attributes, and it's just a magic syntax; I have
a trivial patch I'll send in a moment.

> >   - Lots of places where we backslash-escape some syntax for AsciiDoc
> >     ends up rendered by AsciiDoctor with the backslashes included.
> [...]
> 
> This is an under-defined area.  AsciiDoc and Asciidoctor both use
> regexes instead of real parsers, and apparently there's some
> disagreement on how these should be interpreted.  (The real solution is
> to use a grammar and parser.) I think in some cases it might be
> sufficient to use backticks, as those prevent further interpretation.

I actually prefer backticks in many cases, but they do come with their
own formatting. Surely there is a way in AsciiDoctor to say "do not
interpret this magically, but also do not format it as monospace"?

I guess the nuclear option is using attributes like {litdd} everywhere
to avoid quoting. But it makes the source so ugly and hard to read.

-Peff
