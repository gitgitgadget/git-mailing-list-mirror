From: Jeff King <peff@peff.net>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 12:17:10 -0400
Message-ID: <20130531161710.GB1365@sigill.intra.peff.net>
References: <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
 <87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
 <CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
 <87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
 <20130530193046.GG17475@serenity.lan>
 <CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
 <87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
 <CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
 <87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
 <87txlj30n4.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 31 18:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiS0z-0008KO-SJ
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 18:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872Ab3EaQRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 12:17:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:59536 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756761Ab3EaQRN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 12:17:13 -0400
Received: (qmail 17084 invoked by uid 102); 31 May 2013 16:17:55 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 31 May 2013 11:17:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 May 2013 12:17:10 -0400
Content-Disposition: inline
In-Reply-To: <87txlj30n4.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226095>

On Fri, May 31, 2013 at 12:27:11PM +0200, Thomas Rast wrote:

> Thomas Rast <trast@inf.ethz.ch> writes:
> 
> > However, if that turns out to be the culprit, it's not fixable
> > currently[1].  Having commits with insanely long messages is just, well,
> > insane.
> >
> > [1]  unless we do a major rework of the loading infrastructure, so that
> > we can teach it to load only the beginning of a commit as long as we are
> > only interested in parents and such
> 
> Actually, Peff, doesn't your commit parent/tree pointer caching give us
> this for free?

It does. You can test it from the "jk/metapacks" branch at
git://github.com/peff/git. After building, you'd need to do:

  $ git gc
  $ git metapack --all --commits

in the target repository. You can check that it's working because "git
rev-list --all --count" should be an order of magnitude faster. You may
need to add "save_commit_buffer = 0" in any commands you are checking,
though, as the optimization can only kick in if parse_commit does not
want to save the buffer as a side effect.

I also looked into trying to just read the beginning part of a commit[1],
but it turned out not to be all that much of an improvement.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/212301
