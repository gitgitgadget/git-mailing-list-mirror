From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 08:50:14 -0400
Message-ID: <20120426125014.GB25067@sigill.intra.peff.net>
References: <20120426085156.GB22819@sigill.intra.peff.net>
 <87d36uomlq.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 26 14:50:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNO9R-0001uc-Gq
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 14:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab2DZMuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 08:50:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47127
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715Ab2DZMuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 08:50:17 -0400
Received: (qmail 15627 invoked by uid 107); 26 Apr 2012 12:50:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 08:50:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 08:50:14 -0400
Content-Disposition: inline
In-Reply-To: <87d36uomlq.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196365>

On Thu, Apr 26, 2012 at 11:42:41AM +0200, Thomas Rast wrote:

> > In asciidoc 7, backticks like `foo` produced a typographic
> > effect, but did not otherwise affect the syntax. In asciidoc
> > 8, backticks introduce an "inline literal" inside which markup
> > is not interpreted. To keep compatibility with existing
> > documents, asciidoc 8 has a "no-inline-literal" attribute to
> > keep the old behavior. We enabled this so that the
> > documentation could be built on either version.
> 
> The switch was actually at asciidoc 8.4.1, as explained in 71c020c
> (Disable asciidoc 8.4.1+ semantics for `{plus}` and friends,
> 2009-07-25).

Yeah, I think I was thrown by the "ifndef ASCIIDOC7" bits in the
Makefile. So technically dropping no-inline-literal would mean we're
breaking compatibility with pre-8.4.1. That's still OK based on the
table of versions you posted earlier.

> >  ifndef ASCIIDOC7
> > -ASCIIDOC_EXTRA += -a asciidoc7compatible -a no-inline-literal
> > +ASCIIDOC_EXTRA += -a asciidoc7compatible
> >  endif
> 
> That of course raises the question what asciidoc7compatible means.  I
> have no idea, and google hasn't exactly been helpful.  The only thing I
> could find was
> 
>   http://www.methods.co.nz/asciidoc/chunked/apa.html
> 
> It mostly seems to affect quoting rules.  Do we really need it?

Yeah, chasing that definition through their changelog and then the user
guide, it seems that it is about "unconstrained quotes" that can appear
in the middle of a word. So I think it is another thing that we could
get rid of, but we would have to check the output to see if there were
any regressions (if I understand correctly, something like "F**O**O"
would be literal under asciidoc7 rules, but would make the middle-O bold
under asciidoc8).

> As for the actual patch, I only did some "lazy verification" using
> 
>   git grep '`[^`]*[\\{]' Documentation/
> 
> That (unsurprisingly :-) turned up no mistakes on your part.

That misses cases like this:

  here is a `literal split
  over two lines`

and there are several of them. I missed them in my initial grep, but
caught them by reviewing the diff of the generated files.

> However, some markup mistakes show up in git-fast-import.txt:
> 
> diff --git i/Documentation/git-fast-import.txt w/Documentation/git-fast-import.txt
> index 2620d28..3e8fbd1 100644
> --- i/Documentation/git-fast-import.txt
> +++ w/Documentation/git-fast-import.txt
> @@ -422,9 +422,9 @@ The `committer` command indicates who made this commit, and when
>  they made it.
>  
>  Here `<name>` is the person's display name (for example
> -``Com M Itter'') and `<email>` is the person's email address
> -(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
> -and greater-than (\x3e) symbols.  These are required to delimit
> +`Com M Itter`) and `<email>` is the person's email address
> +(`cm@example.com`).  `LT` and `GT` are the literal less-than (`\x3c`)
> +and greater-than (`\x3e`) symbols.  These are required to delimit
>  the email address from the other fields in the line.  Note that
>  `<name>` and `<email>` are free-form and may contain any sequence
>  of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.
> 
> On my box (asciidoc 8.4.5) the preimage renders as
> 
>   `Com M Itter''

Sorry, do you mean that it is screwed up only after my patch, or that in
reviewing, you noticed that it is always screwed up?

Either way, your patch looks reasonable.

> in fixed-width font.  In the process of debugging this, I noticed that
> the quoting rules are hilariously screwy.  It seems that within a
> paragraph, saying
> 
>   ``foo'' means `bar`
>    ^^^^^^^^^^^^^
>
> treats the underlined part as a `-quoted chunk of text, and renders it
> appropriately using a fixed-width font.

Yeah, I ran into some weird stuff, too. The gitweb.conf doc behaves
oddly with `$projname`; I solved it by using "+" to use a teletype face
without making it literal (since it doesn't actually have any asciidoc
metacharacters).

Even though I carefully reviewed the output before and after my patch,
it makes me slightly concerned that somebody with a different asciidoc
version will get different results. On the other hand, it's nice to
clean up a mess, so I'm willing to try it and see if we get any bug
reports.

-Peff
