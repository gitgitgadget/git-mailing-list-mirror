From: Jeff King <peff@peff.net>
Subject: Re: Announcing a new (prototype) git-remote-hg tool
Date: Fri, 5 Dec 2014 17:59:30 -0500
Message-ID: <20141205225930.GA29256@peff.net>
References: <20141205205335.GA28935@glandium.org>
 <20141205221319.GK16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:59:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1qb-00078n-NV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbaLEW7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:59:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:49178 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753599AbaLEW7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 17:59:32 -0500
Received: (qmail 22460 invoked by uid 102); 5 Dec 2014 22:59:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 16:59:32 -0600
Received: (qmail 7687 invoked by uid 107); 5 Dec 2014 22:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 17:59:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Dec 2014 17:59:30 -0500
Content-Disposition: inline
In-Reply-To: <20141205221319.GK16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260908>

On Fri, Dec 05, 2014 at 02:13:19PM -0800, Jonathan Nieder wrote:

> Mike Hommey wrote:
> 
> > I'm currently evaluating what the final tool would look like. I'm *very*
> > tempted to implement it in C, based on core git code, because there are
> > many things that this helper does that would be so much easier to do
> > with direct access to git's guts. And that wouldn't require more
> > dependencies than git currently has: it would "just" need curl and ssh,
> > and git already uses both.
> >
> > If I were to go in that direction, would you consider integrating it
> > in git core?
> 
> Yes --- I would like this a lot.

I'm concerned that this tool will have drawbacks that Felipe's remote-hg
does not. And I can well imagine that it may, as that tool builds on
Mercurial's API, which will probably handle some corner cases
differently. This isn't to disparage Mike's attempt; it will probably
have some upsides, too. But given that the approaches are so different,
it does not seem obvious to me that one will always be better than the
other.

One of the nice things about spinning remote-hg out of the core repo is
that it means we do not have to endorse a particular implementation, and
they can compete with each other on their merits.  I would very much
hate to see Felipe's remote-hg project wither and die just because
another implementation becomes the de facto standard by being included
in git.git. It's a proven tool, and this new thing is not yet.

It's a shame that both squat on the name "remote-hg", because it makes
it difficult to tell the two apart. But of course that is the only way
to make "git clone hg::..." work. Maybe we need a layer of indirection?
:)

>  - libgit.a in its current state evolves too quickly for it to be
>    convenient for out-of-tree tools to use.  cgit <http://git.zx2c4.com/cgit/>
>    uses git pinned to a particular version as a submodule to get around
>    this, which is fussy and has bad implications for remembering to
>    get security updates.

I'm not sure that this approach is any better than carrying something in
contrib/ in git.git. If I refactor a function in libgit.a, I notice
breakage in the callers because it no longer compiles, or because I am
thorough and look at the implications to git callers.

I do _not_ want to be responsible for making sure that contrib/* still
builds. That is the problem of the maintainer of the contrib/ project in
question. That may sound a little selfish, but I think that is what it
means to be in contrib, and not in the regular tree.

So once you realize that is the burden of the contrib/ author to fix
breakages, then the process is:

  git pull
  cd contrib/c-remote-hg
  make
  # oops, it broke
  fix fix fix

That is not any different than:

  git submodule add git...
  git submodule update
  make
  # oops, it broke
  fix fix fix

The hard part is not how you pull changes from the new git into your
tree. It is the fact that upstream may be breaking the interface behind
your back.  And your best bet is to aggressively merge with upstream,
rather than trying to track only occasional release versions.

Of course, if you meant to _really_ carry it in-tree, not in contrib/,
then none of that applies. But then I worry doubly about the
"endorsement" issue.

-Peff
