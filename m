From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Tue, 7 Feb 2012 13:06:25 -0500
Message-ID: <20120207180625.GA27189@sigill.intra.peff.net>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RupR6-0003Cp-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab2BGSG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 13:06:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59335
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab2BGSG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 13:06:27 -0500
Received: (qmail 9578 invoked by uid 107); 7 Feb 2012 18:13:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 13:13:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 13:06:25 -0500
Content-Disposition: inline
In-Reply-To: <7vbopb61cd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190192>

On Mon, Feb 06, 2012 at 02:31:14PM -0800, Junio C Hamano wrote:

> > +Config files are parsed linearly, and each variable found is passed to a
> > +caller-provided callback function. The callback function is responsible
> > +for any actions to be taken on the config option, and is free to ignore
> > +some options (it is not uncommon for the configuration to be parsed
> > +several times during the run of a git program, with different callbacks
> > +picking out different variables useful to themselves).
> 
> It woud be easeier to read if you stopped the sentence after "some
> options" and made the "It is not uncommon..." a first-class sentence
> outside the parentheses.

Thanks. Putting in too many parenthetical phrases is a bad habit of
mine.  Usually I notice around the time I try nesting a parenthetical
phrase instead of existing parentheses, and go back and at least promote
the outer one to a real sentence. :)

Will fix for the re-roll.

> > +A config callback should return 0 for success, or -1 if the variable
> > +could not be parsed properly.
> 
> This matches what I have always thought, but I think I recently saw a
> series that adds callbacks that return 1 to mean "I have understood this
> variable, so callers should not look at it any more".  It felt wrong, but
> I did not find anything in the config.c API framework to prvent such a
> local calling convention.

The return value is propagated from git_parse_file. I assume the
original intent was that you could actually use it to return an integer
from your callback. In practice, though, callbacks either modify global
data (for older instances), or modify a pointer passed through the void
data pointer.

The "1 means I understood this" convention is used by userdiff_config. I
don't like that it is unlike every other config callback, but I think
it's necessary to deal with the ambiguity of "diff.color.*", which could
be either a userdiff entry or a diff color. E.g., if we see
"diff.color.binary", we know that it is the "binary" variable of the
"color" diff driver, not the color spec for the "binary" slot.

Looking at the code again, though, it seems that there is no overlap
between the userdiff slots and the color slots, and that the
color-parsing code will silently ignore any unknown slots. So it would
be safe to further investigate diff.color.binary as a color, as we would
silently ignore it.

Hmm. Yeah. The userdiff calling convention dates back to late 2008. At
that time, parse_diff_color_slot would die() if it did not understand
the slot, making the "I understood this" flag required. Then later, in
8b8e862 (ignore unknown color configuration, 2009-12-12), it was
relaxed.

So I think we could go back and simplify the userdiff_config code now.

> > +There is a special version of `git_config` called `git_config_early`
> > +that takes an additional parameter to specify the repository config.
> > +This should be used early in a git program when the repository location
> > +has not yet been determined (and calling the usual lazy-evaluation
> > +lookup rules would yield an incorrect location).
> 
> Do you want to say somethink like "Ordinary programs should not have to
> worry about git_config_early()"?  Differently put, if you are learning the
> config API by reading this document and cannot tell which one you should
> be calling, you are way too inexperienced to call git_config_early() and
> you would always want to call git_config()?

Yes, I think that would be sensible.

Though having looked a lot at the config code recently, I wonder if
git_config_early is really necessary. The only caller (besides
git_config) is check_repository_format_early, which just wants to see if
core.repositoryformatversion in a directory is sane.

But why in the world would it want to do the full config lookup?
Shouldn't it be checking git_config_from_file directly on the config
file in the proposed repo?

-Peff
