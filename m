From: Jeff King <peff@peff.net>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sat, 1 Jun 2013 05:09:35 -0400
Message-ID: <20130601090934.GA13904@sigill.intra.peff.net>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
 <51A963B7.6060002@alum.mit.edu>
 <20130601050355.GA23408@sigill.intra.peff.net>
 <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 11:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uihov-0007ic-3F
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab3FAJJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:09:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:39250 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524Ab3FAJJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:09:38 -0400
Received: (qmail 32393 invoked by uid 102); 1 Jun 2013 09:10:21 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Jun 2013 04:10:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Jun 2013 05:09:35 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226105>

On Sat, Jun 01, 2013 at 01:29:07PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > I wonder if simply sticking
> > the reflog entries into a big GRAVEYARD reflog wouldn't be a great deal
> > simpler and accomplish the "keep deleted reflogs" goal, which is what
> > people actually want.
> 
> Exactly what I was thinking when I read your proposal.  What is the
> point of having individual graveyards for deleted branches?  The
> branch names no longer have any significance, and separating the
> reflogs using branch names nobody remembers is only making
> discoverability harder.

Why don't the branch names have significance? If I deleted branch "foo"
yesterday evening, wouldn't I want to be able to say "show me foo from
2pm yesterday" or even "show me all logs for foo, so that I can pick the
useful bit from the list"?

When I suggested a big graveyard reflog, I did not mean a straight
concatenation of the deleted reflogs; I meant one which would also
record the name of the ref whose log each entry came from.

If you mean "the branch names in the filesystem don't have
significance", I agree. Using a parallel hierarchy of reflogs was an
implementation choice that let us use the same reflog format.  Defining
a new GRAVEYARD format would need an additional field for the ref name
of each entry, but lets us drop the other naming complexities.

> What is the problem we are trying to solve?  Someone deletes a branch
> by mistake, and wants to get it back?  There's the HEAD reflog for
> that.

The HEAD reflog is not sufficient for two reasons:

  1. Not all ref updates were part of the HEAD reflog (e.g.,
     refs/remotes, tags).

  2. It is not easy to see deduce which ref each entry comes from, which
     makes "deleted_branch@{yesterday}" difficult. You can sometimes
     deduce the branch by reading the surrounding entries (e.g., for
     "checkout" entries), but I do not know offhand whether it can be
     done reliably in all cases (I suspect not, given that unreachable
     reflog entries may be pruned sooner than reachable ones, leaving
     "holes" in the reflog's story).

> More than adding a graveyard to provide hard-to-dissect information,
> I'm interested in tooling support for the information we already have.

I think that is an orthogonal concern. Already with the current reflogs,
such a tool would be useful. And even without such a tool, being able to
access reflog entries of deleted branches is still useful. Even simple
things like "git branch foo deleted@{yesterday}" and "git log -g
deleted" would give a safety net. And those are supported by the
existing porcelain tooling.

I do not necessarily disagree with your criticisms of the tooling around
reflogs, but they are just not my interest right now, and I do not think
working on one concept needs to hold up the other.

-Peff
