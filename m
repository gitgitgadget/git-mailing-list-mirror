From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 7/8] fetch: fetch objects by their exact SHA-1 object
 names
Date: Tue, 5 Feb 2013 04:19:38 -0500
Message-ID: <20130205091938.GB24973@sigill.intra.peff.net>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <1359571542-19852-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 10:20:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ehl-0003Oj-4E
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 10:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab3BEJUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 04:20:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33003 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249Ab3BEJTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 04:19:43 -0500
Received: (qmail 27552 invoked by uid 107); 5 Feb 2013 09:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Feb 2013 04:21:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2013 04:19:38 -0500
Content-Disposition: inline
In-Reply-To: <1359571542-19852-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215472>

On Wed, Jan 30, 2013 at 10:45:41AM -0800, Junio C Hamano wrote:

> Teach "git fetch" to accept an exact SHA-1 object name the user may
> obtain out of band on the LHS of a pathspec, and send it on a "want"
> message when the server side advertises the allow-tip-sha1-in-want
> capability.

Hmm. The UI on this is a little less nice than I would have hoped. Right
now if you want a ref outside of refs/heads, it's up to you to configure
a refspec or do a one-off fetch of the ref:

  git config --add remote.origin.fetch '+refs/pull/*:refs/pull/*'
  git fetch
  git checkout refs/pull/123/head
  ... inspect the contents ...

Without advertisement, we have to learn that refs/pull/123/head exists
out of band. We can no longer fetch all of the refs/pull hierarchy
preemptively, but we can in theory grab at least that one ref like this:

  git fetch refs/pull/123/head
  git checkout FETCH_HEAD
  ... inspect the contents ...

But that does not work with your patch; instead you have to learn not
just the existence of the ref, but also its sha1. This may seem like a
little thing, since you are already learning of the ref out-of-band,
but:

  1. The full sha1 is more annoying to work with. You'd have to cut and
     paste or otherwise script getting it to fetch.  A human-readable
     ref, though, is much easier to remember. The "refs/pull/N/head"
     pattern is simple to learn and type.

  2. Related to (1) above, is that it may be easier to come up with a
     hidden ref name out of band than the full sha1. E.g., if I am
     looking at https://github.com/me/foo.git/pulls/123, I can easily
     construct the ref from that. Getting the sha1 will take extra
     steps.

  3. You have to do the out-of-band step, which may be inconvenient,
     every time the ref is updated. There is no way to say "just give me
     what is at the tip of refs/pull/123/head".

I think you could solve it by teaching upload-pack to understand refs on
"want" lines and convert them into the pointed-to object.

But taking a step back, this really seems quite inferior to an extension
that would allow the client to share its refspecs with the server. That
would solve the bandwidth efficiency problem for normal fetchers who are
looking at "refs/heads/*", while still giving people who are interested
in "refs/pull/*" (or even a specific refs/pull tip) the information they
need to fetch.

The obvious problem is that the server speaks first. But I recall
somebody suggested a combination of:

  1. For git-over-ssh and git-over-tcp, the server advertises
     tell-me-your-refspecs as it starts advertising.  Client interrupts
     advertisement with refspecs once it sees that it is OK to do so.

     We waste some bandwidth during the round-trip, but there will still
     be a benefit for repos with many refs (I wonder if we could even
     re-order the advertisement to show refs/heads/ first, as they are
     the most likely case to be requested). And as time goes on and the
     majority of clients support tell-me-your-refspecs, the server side
     can introduce a short delay after the first advertisement.

  2. For git-over-http, the client speaks first via the http protocol.
     We can stuff the refspecs into extra query parameters.

It's a little more complicated as a solution, but I feel like it gets
the efficiency without a loss of functionality. And it helps in more
situations than the hidden refs proposal (e.g., fetching refs/heads/foo
can avoid enumerating all of refs/heads/*).

-Peff
