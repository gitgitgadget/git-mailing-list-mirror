From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Thu, 28 Aug 2014 15:04:50 -0400
Message-ID: <20140828190450.GD26855@peff.net>
References: <20140827165854.GC1432@peff.net>
 <20140827170127.GA6138@peff.net>
 <CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
 <20140828123257.GA18642@peff.net>
 <xmqqwq9sa3h8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:05:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN50Z-0001pI-RW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 21:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbaH1TEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 15:04:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:60950 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752704AbaH1TEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 15:04:52 -0400
Received: (qmail 22687 invoked by uid 102); 28 Aug 2014 19:04:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 14:04:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 15:04:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq9sa3h8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256115>

On Thu, Aug 28, 2014 at 11:11:47AM -0700, Junio C Hamano wrote:

> > +	Anonymize the contents of the repository while still retaining
> > +	the shape of the history and stored tree.  See the section on
> > +	`ANONYMIZING` below.
> 
> Technically s/tree/trees/, I would think.  For a repository with
> multiple branches, perhaps s/history/histories/, too, but I would
> not insist on that ;-).

Sure, I think both of those are fine (I meant "tree" here to refer to
the general notion of a set of paths over time, not a particular tree
object).

> > +With this option, git will replace all refnames, paths, blob contents,
> > +commit and tag messages, names, and email addresses in the output with
> > +anonymized data.  Two instances of the same string will be replaced
> > +equivalently (e.g., two commits with the same author will have the same
> > +anonymized author in the output, but bear no resemblance to the original
> > +author string). The relationship between commits, branches, and tags is
> > +retained, as well as the commit timestamps (but the commit messages and
> > +refnames bear no resemblance to the originals). The relative makeup of
> > +the tree is retained (e.g., if you have a root tree with 10 files and 3
> > +trees, so will the output), but their names and the contents of the
> > +files will be replaced.
> 
> While I do not think I or anybody who would ask other people to use
> this option would be confused, the phrase "the same string" may risk
> unnecessary worries from those who are asked to trust this option.
> 
> I am not yet convinced that it is unlikely for the reader to read
> the above and imagine that the anonymiser may go word by word,
> replacing "the same string" with the same anonymised gibberish
> (which would be susceptible to old-school cryptoanalysis
> techniques).

I tried to use phrases like "bears no resemblance" to indicate that the
mapping was not leaking information. Does it bear a separate paragraph
explaining the transformation (I was trying to avoid that because it is
necessarily intimately linked with the particular implementation
chosen).

> Among the ones that listed, refnames, blob contents, commit messages
> and tag messages are converted as a single "string" and I wish I
> could think of phrasing to stress that point somehow.

Maybe a separate paragraph like:

  Note that the replacement strings are chosen with no input from the
  original strings. There is no cryptography or other tricks involved,
  but rather we make up a new string like "message 123", replace a
  particular commit message with it, and then use the mapping between
  the two for the rest of the output. Thus, no information about the
  original commit message is leaked, and only the internal mapping
  (which is not part of the output stream) could reverse the
  transformation.

> Each path component in paths is converted as a single "string", so
> we can read from two anonymised paths if they refer to blobs in the
> same directory in the original.  This is a good thing, of course,
> but it shows that among those listed in "refnames, paths, blob
> contents, ..." in a flat sentence, some are treated as a single
> token for replacement but not others, and it is hard to tell for a
> reader which one is which, unless the reader knows the internals of
> Git, i.e. what kind of things we as the debuggers-of-Git would want
> to preserve.

Yes, I was really trying not to get into those details, because I do not
think they matter to most callers and are subject to change as we come
up with better heuristics. I do not even want to promise an
implementation like "no tricky cryptography" above, because we may think
of a more interesting way to transform components.

> Isn't the unit for human identity anonymisation even more coarse?
> If it is not should it?
> 
> In other words, do "Junio C Hamano <junio@pobox.com>" and "Junio C
> Hamano <gitster@pobox.com>" map to one gibberish human readable name
> with two gibberish e-mail addresses, or 2 "User$n <user$n>"?  Is the
> fact that this organization seems to allocate two e-mails to each
> developer something this organization may want to hide from the
> public (and something we as the Git debuggers would not benefit from
> knowing)?

The ident mapping takes a single "Name <email>" string and converts it
into a "User X <userX@example.com>" string. So no, we are not leaking
the fact that one name has multiple emails. I actually started down that
path, but gave it up, as it could produce entries like "User 3
<email5@example.com>" which were downright confusing. Plus I did not
think that would be a useful thing for debuggers to know, and replacing
the whole string is simpler (I also entertained the idea of just
blanking _all_ idents; what I expect to be of primary use here is the
history shape, and I doubt that a bug would be triggered by the pattern
of usernames but not their actual content).

-Peff
