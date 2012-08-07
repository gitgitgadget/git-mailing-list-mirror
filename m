From: Jeff King <peff@peff.net>
Subject: Re: info: display '--' as '-'
Date: Tue, 7 Aug 2012 15:42:11 -0400
Message-ID: <20120807194211.GB440@sigill.intra.peff.net>
References: <CANes+HZ3EH70x6KiaPsV=SQpbjr5o+pEzj2+4Xx613GPZv0SLw@mail.gmail.com>
 <20120807060157.GA13222@sigill.intra.peff.net>
 <874nofcgrl.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mofaph <mofaph@gmail.com>, git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 21:42:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sypfb-0005pW-FK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 21:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab2HGTmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 15:42:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54844 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab2HGTmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 15:42:15 -0400
Received: (qmail 30753 invoked by uid 107); 7 Aug 2012 19:42:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 15:42:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 15:42:11 -0400
Content-Disposition: inline
In-Reply-To: <874nofcgrl.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203041>

On Tue, Aug 07, 2012 at 09:17:50AM +0200, David Kastrup wrote:

> Not really: @display does not change fonts, merely indentation.  From
> the Texinfo manual:
> [...]
> But in non-typewriter fonts, -- is a shorthand for an en-dash (see
> "conventions" in the Texinfo manual):

Thanks, that's the missing piece I didn't have.

So it seems like docbook2-texi is at fault. The "--" does not have a
special meaning in docbook XML, but is special markup specially in
Texinfo source. By passing it through literally, docbook2-texi is
changing the meaning of the text. It should be escaped somehow, just as
you would escape other markup characters (e.g., "@display" literally in
the text would also need to be escaped).

I suppose you could argue that the "--" conversion is not markup, but a
presentation choice for free-form text. I find that a little dubious
when coming from docbook, which could use "&endash;" if it really wanted
an en dash.

> So somewhere in your conversion chains, you should try detecting code
> examples and translate them into @example...@end example rather than the
> merely indented @display ... @end display.  It is likely that it will
> look better in other parts of the production chain as well.

I think that's a reasonable work-around for this particular incarnation
of the bug. I still think it's wrong of the docbook to texinfo
conversion process to leave "--" in place in general, but it matters
most in fixed-font displays.

It looks like some of our asciidoc workarounds were causing listing
blocks not to be marked as monospace. I've got a patch to address that,
and it fixes this particular class of bug.

However, we also use literal "--" in lots of non-monospaced contexts.
The whole documentation tree needs to be audited for use of "--" (e.g.,
every option mentioned in git-log.txt is currently wrong in the
gitman.info result). I think the end result will look better, but it is
going to be a giant pain.

> > Cc-ing David Kastrup, who added the info version originally, and might
> > be more clueful about that part of the toolchain.
> 
> I think you are significantly overstating my contribution.  Unless my
> memory is failing me (always an option), I probably raised the main
> stink at one time about the info documentation falling into a decrepit
> state, but I don't think that I was all that much involved with getting
> it up to scratch again, and I don't think I had been responsible for
> originally implementing it.

I based my assumption on your 4739809 (Add support for an info version
of the user manual, 2007-08-06). I don't think any of the regular
contributors actually uses info, which is why it has remained largely
untouched since then.

Anyway, I was right; you were more clueful than I (not that it took
much...). Thanks for pointing me in the right direction.

-Peff
