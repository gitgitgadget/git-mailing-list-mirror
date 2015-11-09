From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 13:13:19 -0500
Message-ID: <20151109181319.GA30003@sigill.intra.peff.net>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
 <20151104064021.GB16605@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
 <20151109155538.GC27224@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
 <20151109165343.GA29179@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
 <CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Victor Leschuk <vleschuk@accesssoftek.com>,
	Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvqwY-0005bi-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 19:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbKISNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 13:13:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:55101 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752054AbbKISNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 13:13:22 -0500
Received: (qmail 12103 invoked by uid 102); 9 Nov 2015 18:13:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 12:13:21 -0600
Received: (qmail 18480 invoked by uid 107); 9 Nov 2015 18:13:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 13:13:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 13:13:19 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281073>

On Mon, Nov 09, 2015 at 09:55:34AM -0800, Linus Torvalds wrote:

> > if (list.nr || cached )
> >   num_threads = 0; // do not use threads
> > else if (num_threads == 0)
> >   num_threads = online_cpus() <= 1 ? 0 : GREP_NUM_THREADS_DEFAULT;
> 
> I will say this AGAIN.
> 
> The number of threads is *not* about the number of CPU's. Stop this
> craziness. It's wrong.

I agree with you (and that's why we have a hard-coded default here, and
not online_cpus()).

This check is just whether to turn the threading on or not, based on
whether we have multiple CPUs at all. And I agree that probably should
_not_ be respecting online_cpus() either, because we are better off
parallelizing even on a single CPU to avoid fs latency.

But note that this is already what the code _currently_ does. I do not
mind changing it, but that is a separate notion from Victor's topic,
which is to make the number of threads configurable at all.

What I'd really hope to see is:

  1. Victor adds --threads support, and changes _nothing else_ about the
     defaults.

  2. People experiment with --threads to see what works best in a
     variety of cases (especially things like cold-cache NFS). Then we
     get patches based on real world numbers to adjust:

       2a. GREP_NUM_THREADS_DEFAULT (either bumping the hard-coded
           value, or using some dynamic heuristic)

       2b. What to do for the single-CPU case.

We're doing step 1 here. I don't mind jumping to 2b if we're pretty sure
it's the right thing (and I think it probably is), but it should
definitely be a separate patch.

> So *none* of the threading in git is about CPU's. Maybe we should add
> big honking comments about that.

Minor nit: there definitely _are_ CPU-bound parallel tasks in git.
pack-objects and index-pack come to mind. If we add any user-visible
advice about tweaking thread configuration, we should be sure
that it is scoped to the appropriate flags.

> And that big honking comment should be in the documentation for the
> new flag too. Because it would be really really sad if people say "I
> have a laptop with just two cores, so I'll set the threading option to
> 2", when they then work mostly over a slow wireless network and their
> company wants minimal local installs.

Agreed. It would probably make sense for the "--threads" option
documentation for each command to discuss whether it is meant to
parallelize work across CPUs, or avoid filesystem latency.

-Peff
