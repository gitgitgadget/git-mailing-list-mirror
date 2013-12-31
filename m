From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Runaway "git remote" if group definition contains a remote
 by the same name
Date: Tue, 31 Dec 2013 03:06:47 -0500
Message-ID: <20131231080647.GA25838@sigill.intra.peff.net>
References: <AANLkTinni=VJLoZp1Hjm4dfW8faChytDObJbXsFF5iXv@mail.gmail.com>
 <CALxABCbRZ4MmiYS4JF20qf1-iubeTfa+3OLibqdb5+raekuKQg@mail.gmail.com>
 <20131229075838.GC31788@sigill.intra.peff.net>
 <xmqqlhz2rw7s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 09:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxuLm-0000HX-CV
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 09:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab3LaIGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 03:06:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:52895 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752025Ab3LaIGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 03:06:49 -0500
Received: (qmail 3430 invoked by uid 102); 31 Dec 2013 08:06:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Dec 2013 02:06:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Dec 2013 03:06:47 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlhz2rw7s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239834>

On Mon, Dec 30, 2013 at 11:10:31AM -0800, Junio C Hamano wrote:

> > So I think the sanest thing is probably:
> >
> >   1. Teach "fetch" to expand recursively in a single process, and then
> >      tell sub-processes (via a new command-line option) not to expand
> >      any further.
> >
> >   2. Teach "fetch" to detect cycles (probably just by a simple depth
> >      counter).
> 
> I suspect that the expansion code will just accumulate remotes found
> into a string-list (as part of 4. below), so deduping would be
> fairly easily done without a depth counter.

I don't think that will work (at least not naively). The end-product of
step 1, and the string_list that is de-duped in step 4, is a list of the
concrete remotes. The cycles occur between groups, which are not
mentioned in the final list.

You can keep a separate list of the groups we visit, of course, but we
do not otherwise need it.

One thing that does make such a list easier is that we do not need to
care about order. E.g., in config like this:

  [remotes]
  a = c
  b = c
  c = d e

you can mark "c" as seen after visiting it via "a". It is not
technically a cycle, but since we would want to suppress duplicates
anyway, we can be overly broad.

> >   3. Teach the group-reading code to detect groups more robustly, so
> >      that a single-item group like "remotes.foo=bar" correctly recurses
> >      to "bar".
> 
> A single-item remote group is somewhat annoying, but expanding it
> only at some places while ignoring it at other places is even more
> annoying, so this sounds like a right thing to do.

The only configuration that I think would be negatively affected is
something like:

  [remote]
  foo = foo
  [remote "foo"]
  url = ...

that silently works now, but would become broken (because we would
complain about the cycle). I think that's OK; that config is clearly
stupid and broken. If it were "remote.foo = foo bar", trying to expand
the concrete "foo" and "bar", that might make some sense, but then it is
already broken in the current code (that is the example that started the
discussion).

-Peff
