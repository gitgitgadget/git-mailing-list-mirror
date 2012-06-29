From: Jeff King <peff@peff.net>
Subject: Re: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 15:35:05 -0400
Message-ID: <20120629193504.GA11823@sigill.intra.peff.net>
References: <20120629124122.GG1258@camk.edu.pl>
 <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
 <20120629174358.GB3804@sigill.intra.peff.net>
 <20120629181701.GB6533@camk.edu.pl>
 <20120629182944.GA20346@sigill.intra.peff.net>
 <7vd34i3pot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kacper Kornet <draenog@pld-linux.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 21:35:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkgyJ-0004LJ-IA
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 21:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab2F2TfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 15:35:09 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:49563
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab2F2TfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 15:35:08 -0400
Received: (qmail 15387 invoked by uid 107); 29 Jun 2012 19:35:12 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Jun 2012 15:35:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jun 2012 15:35:05 -0400
Content-Disposition: inline
In-Reply-To: <7vd34i3pot.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200825>

On Fri, Jun 29, 2012 at 12:04:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm tempting by the patch below, which would remove only the
> > syntactically significant meta-characters ("\n", "<", and ">"), as well
> > as trimming any stray whitespace at the edges. The problem is that we
> > don't really have a clue how many people were relying on this trimming
> > to clean up their names or emails, so there may be regressions for other
> > people.
> 
> What do you exactly mean by "syntactically significant"?  In other
> words, "whose syntax"?

I meant syntactically significant to git's ident lines. I.e., "<", ">",
and "\n". If the identities are going to be put somewhere else with
different syntax (e.g., an rfc822 header), then they would obviously
need to be quoted (and that is no different than the current state), but
that should happen elsewhere.

> The code with the patch will leave "." out of the crud, so with
> 
> 	spearce:*:1000:1000:Shawn O. Pearce:/home/spearce:/bin/sh
> 
> we would get:
> 
> 	From: Shawn O. Pearce <spearce@spearce.org>
> 
> without dropping the "." in the name.  Your MTA would likely to
> reject it.

But that is already the case. The crud() function is checked only for
the beginning and end of each item. Which is why you get senseless
outcomes like "A.B.C." turning into "A.B.C". AFAICT, the motivation for
most items in the crud function is purely about "this is junk that we
might find in a gecos field and should be stripped to make the name
prettier". I.e., they are heuristics, and we now have two reports of
those heuristics being wrong.

My concern is that those heuristics are sometimes _right_, and are
helping people. But we don't know how often, and I suspect there is no
way to know without changing it and waiting for people to scream, which
does not excite me.

The only example I could come up with by thinking is that we probably
_do_ want to strip a trailing dot from an email address (e.g., some
people will express a hostname as "example.com." to indicate that it is
fully qualified, but it is typically omitted from an email address).
Handling that would involve splitting the heuristics for names and
emails.

> I think that quoting "syntactically significant meta-characters" in
> the context of e-mail headers is a job for the MSA, and the human
> readable names in GIT_AUTHOR_NAME should allow any reasonable
> character.  And I agree that it is a sane definition of "reasonable"
> to exclude "\n", "<", and ">" (and nothing else), as they are the
> only "syntactically significant" in the context of commit object
> header.
> 
> The patch goes in the right direction in that sense, but you need to
> make sure that git-send-email and git-imap-send (the only two MSA we
> ship) do the right thing when fed names with ".", dq, etc. first.

Actually, it is format-patch where the quoting should go, as it is the
thing that puts the ident in the rfc822 header. And indeed, it already
does so (as it must, because we _do_ allow "." as in "Shawn O. Pearce",
and have always done so).

-Peff
