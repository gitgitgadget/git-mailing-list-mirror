From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Thu, 20 Sep 2012 13:24:08 -0400
Message-ID: <20120920172408.GC18655@sigill.intra.peff.net>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
 <20120920034804.GA32313@sigill.intra.peff.net>
 <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:25:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEkUl-0002Sp-CR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 19:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab2ITRYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 13:24:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51604 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab2ITRYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 13:24:11 -0400
Received: (qmail 17781 invoked by uid 107); 20 Sep 2012 17:24:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 13:24:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 13:24:08 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206060>

On Wed, Sep 19, 2012 at 10:57:35PM -0700, Shawn O. Pearce wrote:

> > I have been looking into this recently, as well. GitHub does not allow
> > dumb http at all these days,
> 
> Interesting that GitHub doesn't support dumb transfer either.

Our objects are still in regular repos, and is served by fairly stock
git. The main show-stopper is that we share objects via alternates, and
we aggressively repack the alternates repos. So a dumb client would end
up being quite inefficient.

We also toyed with having mixed public/private fork networks at one
point, which would obviously necessitate disabling dumb access. But we
gave it up as too risky, as you can do all sorts of weird tricks to
convince git to disclose information about what's in the private repos
(e.g., you can reliably find out which sha1s exist, and you can lie
about which sha1s you have to ask git to create deltas against them).

Doing a shared-object store right would require marking which repo
"knows" which objects (I assume that's what Google Code does, but I
don't remember if Dave talked about that aspect at last year's
GitTogether).

> > so transient errors on the initial smart
> > contact can cause us to fall back to dumb,
> 
> Transient errors is actually what is leading me down this path. We see
> about 0.0455% of our requests to the Android hosting service as these
> dumb fallbacks. This means the client never got a proper smart service
> reply. Server logs suggest we sent a valid response, so I am
> suspecting transient proxy errors, but its hard to debug because
> clients discard the error.

Yup, we see the same thing. I've tracked a few down manually to actual
things like gateway timeouts on our reverse proxy.

> > and end up reporting a
> > totally useless 403 Forbidden error.
> 
> Today I posted a change to JGit [1] to make this 406 Not Acceptable as
> I think it better matches the description of the failure. It also no
> longer reuses the common 403 Forbidden error that a server might
> choose to return if a request was given with invalid credentials.

That might be worth doing for git-http-backend, too. It might even make
sense for the git client to recognize the 406 (and possibly the 403) and
print a more useful message.

> >   1. If both smart and dumb requests fail, report the error for the
> >      smart request. Now that smart-http clients are common, I'd expect
> >      most http servers to be smart these days. Of course I don't have
> >      any sort of numbers to back this up (nor am I sure how to get them;
> >      obviously big sites like GitHub and Google Code do a lot of
> >      traffic, but who knows how many one-off repo-on-a-generic-web-host
> >      sites still exist?).
> 
> I suspect there are still a number of servers that rely on dumb
> protocol to host repositories because its very simple to setup.
> Breaking support for this wouldn't be a good idea.

I don't think it would break on most servers, though. Even for a dumb
server, the initial error will be a useful one. It's only the
weirdly-configured ones where you get wildly different results depending
on whether the query string is there.

In other words, it is really no worse than reverting 703e6e76, and it
might be better. In the common case, you get a better error message. In
the broken-server case, we still try the fallback. So it will keep
working on a broken server without any manual intervention, whereas
reverting and adding a manual escape hatch means the user has to do
something.

BUT.

I still think it's better to revert 703e6e76, because I really do think
the broken-server case is an extreme enough minority that it is not even
worth wasting the time of clients to make a second request (especially
because the first request may very well have failed because of a network
error that causes a long timeout, and the user then has to wait double
to find out what the error is).

Of course, I have no actual data aside from reading the original thread
that led to 703e6e76, and the fact that nobody else mentioned it (not
during the time when it was broken, and not even after, when people
often still complain because they haven't upgraded yet). But who knows?
Maybe I will eat my words, and we will end up getting that data in the
form of complaints. :)

We can always switch to fallback-but-prefer-the-initial-error then. And
we'll have more data on exactly how the misconfigured servers behave.

-Peff
