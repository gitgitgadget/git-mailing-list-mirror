From: Jeff King <peff@peff.net>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Wed, 2 Nov 2011 18:06:14 -0400
Message-ID: <20111102220614.GB14108@sigill.intra.peff.net>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 23:06:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLiww-0005IC-Qs
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 23:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab1KBWGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 18:06:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60440
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab1KBWGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 18:06:17 -0400
Received: (qmail 16672 invoked by uid 107); 2 Nov 2011 22:12:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 18:12:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 18:06:14 -0400
Content-Disposition: inline
In-Reply-To: <20111031090717.GA24978@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184674>

On Mon, Oct 31, 2011 at 04:07:18AM -0500, Jonathan Nieder wrote:

> Something like Jeff's "priming the well with a server-specified
> bundle" proposal[2] might be a good way to make the same trick
> transparent to clients in the future.

Yes, that is one of the use cases I hope to address. But it will require
the publisher specifying a mirror location (it's possible we could add
some kind of automagic "hit a bundler service first" config option,
though I fear that the existing small-time bundler services would
crumble under the load).

So in the general case (and in the meantime), you may have to learn to
manually prime the repo using a bundle.

I haven't started on the patches for communicating mirror sites between
the server and client, but I did just write some patches to handle "git
fetch http://host/path/to/file.bundle" automatically, which is the first
step. They need a few finishing touches and some testing, though.

> Even with that, later fetches, which grab a pack generated on the fly
> to only contain the objects not already fetched, are generally not
> resumable.  Overcoming that would presumably require larger protocol
> changes, and I don't know of anyone working on it.  (My workaround
> when in a setup where this mattered was to use the old-fashioned
> "dumb" http protocol.  It worked fine.)

My goal was for the mirror communication between client and server to be
something like:

  - if you don't have object XXXXXX, then prime with URL
    http://host/bundle1

  - if you don't have object YYYYYY, then prime with URL
    http://host/bundle2

and so forth. A cloning client would grab the first bundle, then the
second, and then hit the real repo via the git protocol. A client who
had previously cloned might have XXX, but would now grab bundle2, and
then hit the real repo.

So depending on how often the server side feels like creating new
bundles, you would get most of the changes via bundles, and then only
be getting a small number of objects via git.

The downside of cumulative fetching is that the bundles can only serve
well-known checkpoints. So if you have a timeline like this:

  t0: server publishes bundle/mirror config with one line (the XXX bit
      above)

  t1: you clone, getting the whole bundle. No waste, because you had
      nothing in the first place, and you needed everything.

  t2: you fetch again, getting N commits worth of history via the git
      protocol

  t3: server decides a lot of new objects (let's say M commits worth)
      have accumulated, and generates a new line (the YYY line).

  t4: you fetch, see that you don't yet have YYY, and grab the second
      bundle

But in t4 you grabbed a bundle containing M commits, when you already
had the first N of them. So you actually wasted bandwidth getting
objects you already had. The only benefit is that you grabbed a static
file, which is resumable.

So I suspect there is some black magic involved in deciding when to
create a new bundle, and at what tip. If you create a bundle once a
month, but include only commits up to a week ago, then people pulling
weekly will never grab the bundle, but people pulling less frequently
will get the whole month as a bundle.

A secondary issue is also that in a scheme like this, your mirror list
will grow without bound. So you'd want to periodically repack everything
into a single bundle. But then people who are fetching wouldn't want
that, as it is just an exacerbated version of the same problem above.

Which is all a roundabout way of saying that the git protocol is really
the sane way to do efficient transfers. An alternative, much simpler
scheme would be for the server to just say:

  - if you have nothing, then prime with URL http://host/bundle

And then _only_ clone would bother with checking mirrors. People doing
fetch would be expected to do it often enough that not being resumable
isn't a big deal.

-Peff
