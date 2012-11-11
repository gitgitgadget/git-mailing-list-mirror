From: Jeff King <peff@peff.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 12:15:18 -0500
Message-ID: <20121111171518.GA20115@sigill.intra.peff.net>
References: <5093DC0C.5000603@drmicha.warpmail.net>
 <20121108200919.GP15560@sigill.intra.peff.net>
 <509CCCBC.8010102@drmicha.warpmail.net>
 <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
 <509E8EB2.7040509@drmicha.warpmail.net>
 <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
 <509EAA45.8020005@gmail.com>
 <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
 <509FD9BC.7050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXb8E-0003Gb-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab2KKRP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:15:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44007 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab2KKRPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:15:25 -0500
Received: (qmail 1926 invoked by uid 107); 11 Nov 2012 17:16:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 12:16:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 12:15:18 -0500
Content-Disposition: inline
In-Reply-To: <509FD9BC.7050204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209422>

On Sun, Nov 11, 2012 at 12:00:44PM -0500, A Large Angry SCM wrote:

> >>>a) Leave the name conversion to the export tools, and when they miss
> >>>some weird corner case, like 'Author<email', let the user face the
> >>>consequences, perhaps after an hour of the process.
> [...]
> >>>b) Do the name conversion in fast-import itself, perhaps optionally,
> >>>so if a tool missed some weird corner case, the user does not have to
> >>>face the consequences.
> [...]
> >>c) Do the name conversion, and whatever other cleanup and manipulations
> >>you're interesting in, in a filter between the exporter and git-fast-import.
> >
> >Such a filter would probably be quite complicated, and would decrease
> >performance.
> >
> 
> Really?
> 
> The fast import stream protocol is pretty simple. All the filter
> really needs to do is pass through everything that isn't a 'commit'
> command. And for the 'commit' command, it only needs to do something
> with the 'author' and 'committer' lines; passing through everything
> else.
> 
> I agree that an additional filter _may_ decrease performance somewhat
> if you are already CPU constrained. But I suspect that the effect
> would be negligible compared to the all of the SHA-1 calculations.

It might be measurable, as you are passing every byte of every version
of every file in the repo through an extra pipe. But more importantly, I
don't think it helps.

If there is not a standard filter for fixing up names, we do not need to
care. The user can use "sed" or whatever and pay the performance penalty
(and deal with the possibility of errors from being lazy about parsing
the fast-import stream).

If there is a standard filter, then what is the advantage in doing it as
a pipe? Why not just teach fast-import the same trick (and possibly make
it optional)? That would be simpler, more efficient, and it would make
it easier for remote helpers to turn it on (they use a command-line
switch rather than setting up an extra process).

But what I don't understand is: what would such a standard filter look
like? Fast-import (or a filter) would already receive the exporter's
best attempt at a git-like ident string. We can clean up and normalize
things like whitespace (and we probably should if we do not do so
already). But beyond that, we have no context about the name; only the
exporter has that.

So if we receive:

  Foo Bar<foo.bar@example.com> <none@none>

or:

  Foo Bar<foo.bar@example.com <none@none>

or:

  Foo Bar<foo.bar@example.com

what do we do with it? Is the first part a malformed name/email pair,
and the second part is crap added by a lazy exporter? Or does the
exporter want to keep the angle brackets as part of the name field? Is
there a malformed email in the last one, or no email at all?

The exporter is the only program that actually knows where the data came
from, how it should be broken down, and what is appropriate for pulling
data out of its particular source system. For that reason, the exporter
has to be the place where we come up with a syntactically correct and
unambiguous ident.

I am not opposed to adding a mailmap-like feature to fast-import to map
identities, but it has to start with sane, unambiguous output from the
exporter.

-Peff
