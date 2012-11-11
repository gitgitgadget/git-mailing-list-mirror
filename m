From: Jeff King <peff@peff.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 13:14:06 -0500
Message-ID: <20121111181406.GA21654@sigill.intra.peff.net>
References: <20121108200919.GP15560@sigill.intra.peff.net>
 <509CCCBC.8010102@drmicha.warpmail.net>
 <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
 <509E8EB2.7040509@drmicha.warpmail.net>
 <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
 <509EAA45.8020005@gmail.com>
 <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
 <509FD9BC.7050204@gmail.com>
 <20121111171518.GA20115@sigill.intra.peff.net>
 <CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:14:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXc36-0002t9-JJ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab2KKSOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:14:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44064 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005Ab2KKSOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:14:09 -0500
Received: (qmail 3206 invoked by uid 107); 11 Nov 2012 18:14:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 13:14:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 13:14:06 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209434>

On Sun, Nov 11, 2012 at 06:45:32PM +0100, Felipe Contreras wrote:

> > If there is a standard filter, then what is the advantage in doing it as
> > a pipe? Why not just teach fast-import the same trick (and possibly make
> > it optional)? That would be simpler, more efficient, and it would make
> > it easier for remote helpers to turn it on (they use a command-line
> > switch rather than setting up an extra process).
> 
> Right, but instead of a command-line switch it probably should be
> enabled on the stream:
> 
>   feature clean-authors
> 
> Or something.

Yeah, I was thinking it would need a feature switch to the remote helper
to turn on the command-line, but I forgot that fast-import can take
feature lines directly.

> > We can clean up and normalize
> > things like whitespace (and we probably should if we do not do so
> > already). But beyond that, we have no context about the name; only the
> > exporter has that.
> 
> There is no context.

There may not be a lot, but there is some:

> These are exactly the same questions every exporter must answer. And
> there's no answer, because the field is not a git author, it's a
> mercurial user, or a bazaar committer, or who knows what.

The exporter knows that the field is a mercurial user (or whatever).
Fast-import does not even know that, and cannot apply any rules or
heuristics about the format of a mercurial user string, what is common
in the mercurial world, etc. It may not be a lot of context in some
cases (I do not know anything about mercurial's formats, so I can't say
what knowledge is available). But at least the exporter has a chance at
domain-specific interpretation of the string. Fast-import has no chance,
because it does not know the domain.

I've snipped the rest of your argument, which is basically that
mercurial does not have any context at all, and knowing that it is a
mercurial author is useless.  I am not sure that is true; even knowing
that it is a free-form field versus something structured (e.g., we know
CVS authors are usernames on the server server) is useful.

But I would agree there are probably multiple systems that are like
mercurial in that the author field is usually something like "name
<email>", but may be arbitrary text (I assume bzr is the same way, but
you would know better than me).  So it may make sense to have some stock
algorithm to try to convert arbitrary almost-name-and-email text into
name and email to reduce duplication between exporters, but:

  1. It must be turned on explicitly by the exporter, since we do not
     want to munge more structured input from clueful exporters.

  2. The exporter should only turn it on after replacing its own munging
     (e.g., it shouldn't be adding junk like <none@none>; fast-import
     would need to receive as pristine an input as possible).

  3. Exporters should not use it if they have any broken-down
     representation at all. Even knowing that the first half is a human
     name and the second half is something else would give it a better
     shot at cleaning than fast-import would get.

     Alternatively, the feature could enable the exporter to pass a more
     structured ident to git.

-Peff
