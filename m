From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Sun, 8 Apr 2012 02:40:59 -0400
Message-ID: <20120408064059.GA6727@sigill.intra.peff.net>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
 <7v398gywb1.fsf@alter.siamese.dyndns.org>
 <20120407050913.GA4211@sigill.intra.peff.net>
 <7vaa2myfsz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 08:41:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGloj-0002s8-Ar
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 08:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab2DHGlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 02:41:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54262
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab2DHGlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 02:41:05 -0400
Received: (qmail 32646 invoked by uid 107); 8 Apr 2012 06:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 02:41:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 02:40:59 -0400
Content-Disposition: inline
In-Reply-To: <7vaa2myfsz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194981>

On Sat, Apr 07, 2012 at 10:05:00PM -0700, Junio C Hamano wrote:

> > So I actually do think he would be better to implement the caching
> > inside his helper, even if it is by calling out to git-credential-cache.
> 
> While I'm for keeping the interface simple, at the same time, "I have this
> credential obtained and it is valid for $X time duration" sounds like a
> very common thing, and it is somewhat a shame for the API to force its
> users (i.e. helpers) to reimplement the caching logic over and over.

But the caching _must_ be part of a helper, because the parent git
process is not long-lived. If I understand you correctly, you are
advocating adding a "ttl" field, then transparently chaining to the
cache helper when it exists.

We can do that, but the whole point of implementing a generic helper
protocol was to let people decide to do things like that themselves
(which is exactly what Shawn has done). There's no reason that git needs
to lock you into one particular implementation of caching or storage;
that's why we have configurable helpers.  There's no reason that git
should only cache when there is a ttl field (you still may want to cache
for 15 minutes, even if the credential will last longer). But nor should
git say "you always must cache".  Perhaps you don't like the complexity
or the security implications.

So I'd much rather leave it up to the user to configure their helpers
rather than trying to run credential-cache behind the scenes.

There are basically two problems to solve. The first is getting data
from one helper to the other.

One way to implement that is by just wrapping the real helper inside a
caching layer. That can even be generic. In fact, my initial version of
the credential helpers had a "chain" parameter, so you could ask
credential-cache to run a sub-helper and cache its response.
The original use was that "getpass" would be its own helper, so you
could plug in a custom version. Since nobody seemed to want to do that,
I dropped it in the name of simplicity.

You can easily write a generic wrapper like this:

  #!/bin/sh
  cache=$1
  chain=$2
  case "$3" in
  get)
          cat >request
          eval "$cache get" <request >response
          if test -s response; then
            cat response
          else
            eval "$chain" >response
            cat request response | eval "$cache store"
            cat response
          fi
          ;;
  *)
          eval "$cache $3"
          ;;
  esac

though obviously you would write it in a real language that doesn't
involve storing the intermediate states on disk (and rather than eval,
you'd take the usual helper specification). And we could easily provide
such a wrapper, and Shawn's config would look like:

  [credential]
  helper = "wrapper cache real-helper"

Another way to do it is by listing the helpers sequentially, and feeding
the output of one to the input of another during a "store". As I said,
I'm uncomfortable with the security implications of doing that by
default. Your proposal side steps it by implying that cache is special,
and does not have these security implications.  Which is mostly true
(though it also is limiting). So the obvious thing would be to mark
helpers as either "yes, it's OK to share my output with others" or "yes,
it's OK for me to see the output of others". And then Shawn's config
looks like:

  [credential]
  helper = cache
  helper = real-helper

The second issue is that of communicating the ttl or expiration between
helpers. That's easy enough. The protocol allows arbitrary key/value
pairs. We typically just drop ones we don't care about, but we could
retain them and pass them along.

-Peff
