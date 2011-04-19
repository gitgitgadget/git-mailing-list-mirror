From: Jeff King <peff@peff.net>
Subject: Re: Git notes list/show <revision-range>
Date: Tue, 19 Apr 2011 16:32:11 -0400
Message-ID: <20110419203211.GA12071@sigill.intra.peff.net>
References: <4DAC80CF.8020704@lyx.org>
 <20110418182724.GB11250@sigill.intra.peff.net>
 <4DAD371F.9040003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Git Mailing List <git@vger.kernel.org>, bebarino@gmail.com,
	johan@herland.net
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 22:32:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCHay-00067g-Bt
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 22:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab1DSUcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 16:32:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34100
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab1DSUcP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 16:32:15 -0400
Received: (qmail 12781 invoked by uid 107); 19 Apr 2011 20:33:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Apr 2011 16:33:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2011 16:32:11 -0400
Content-Disposition: inline
In-Reply-To: <4DAD371F.9040003@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171815>

On Tue, Apr 19, 2011 at 09:17:51AM +0200, Michael J Gruber wrote:

> But since the OP is volunteering to code for notes :-)
> We could need a feature which allows to log the history of a note. The alias
> 
> `git noteslog' is aliased to `!sh -c 'git log $(git notes get-ref) "$@"' -'
> 
> gives you the history of the notes tree (try it with "-p"),

Hmm, I just use "git log notes/<whatever>", which works fine. It does
help if you know that the default ref is "notes/commits", though.

It's not something I do often, though (most of my notes use has been
things that automatically make notes, so the history tends to be
uninteresting and useful only for debugging the note-making code).

> sometimes I would like the history of the notes to a specific commit, and in
> 
> git noteslog -p -- $(commit)
> 
> I would have to use for $(commit) all possible breakdowns of the sha1 of
> the commit for all possible notes tree structures. It feels as of the
> revision walker needs to learn another pathspec, say
> 
> ":(note):<sha1>"
> 
> in line with our magic pathspec discussion.

That's a clever solution. It is a little non-intuitive for a user to
need to know about notes storage, though. Maybe you were already
thinking this, but we could have something like:

  git notes log [revs] [--] [pathspec]

where "[revs]" are checked for in refs/notes/*, defaulting to
"refs/notes/commits". And each element of the pathspec gets the
":(note):" magic automatically. I wonder if we could even resolve the
pathspec bits as regular refs.

So you could write:

  # long form, just as you can do with "git log"
  git notes log notes/commits -- ":(note):`git rev-parse HEAD`"

  # or with automagic ref lookup for pathspec
  git notes log notes/commits -- HEAD

  # and automagic default ref
  git notes log -- HEAD

  # and I think you should be able to write a disambiguator similar to
  # what we use for the revs/paths distinction, but this time for
  # notes-refs versus regular refs. And then drop the "--":
  git notes log HEAD

I think it would need a little refactoring of setup_revisions() to be
more flexible, but most of the hard work is already done by the usual
revision traversal mechanism.

-Peff
