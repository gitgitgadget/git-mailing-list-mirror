From: Jeff King <peff@peff.net>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Sat, 22 Nov 2014 14:43:13 -0500
Message-ID: <20141122194313.GB13340@peff.net>
References: <5468C33E.2080108@whonix.org>
 <20141117212657.GC15880@peff.net>
 <546FC446.50101@whonix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Patrick Schleizer <patrick-mailinglists@whonix.org>
X-From: git-owner@vger.kernel.org Sat Nov 22 20:43:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsGaW-0006NI-0b
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 20:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbaKVTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 14:43:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:43532 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751860AbaKVTnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 14:43:15 -0500
Received: (qmail 14778 invoked by uid 102); 22 Nov 2014 19:43:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Nov 2014 13:43:14 -0600
Received: (qmail 1179 invoked by uid 107); 22 Nov 2014 19:43:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Nov 2014 14:43:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Nov 2014 14:43:13 -0500
Content-Disposition: inline
In-Reply-To: <546FC446.50101@whonix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260074>

On Fri, Nov 21, 2014 at 11:01:26PM +0000, Patrick Schleizer wrote:

> > Yes, it is only as "safe as SHA-1" in the sense that you have GPG-signed
> > only a SHA-1 hash. If somebody can find a collision with a hash you have
> > signed, they can substitute the colliding data for the data you signed.
> [..]
> Sounds pretty sad. Isn't this a security issue that should be fixed?

Sure, for some definition of "should". It's not a problem today. It may
be a problem in the future. If we were designing git from scratch today,
it would probably make sense to use a different hash, or to somehow
parameterize the hash.

But we're not starting from scratch. A change like that needs to
consider a transition plan. What happens to the existing history? Do we
just rewrite it all using the new hash in all object references? If so,
what do we do with non-object references to sha1s (in external systems,
or even partial sha1s mentioned in commit message)? What do we do with
signed tags which are now invalid?  Or do we graft history with the new
hashes onto the old, letting the two coexist in the same repository? How
do we expand the data structures to handle the extra information needed
to specify the hash type?

None of these problems is insurmountable, but it's going to take real
work on the development side, and is going to create incompatibilities
and headaches on the user side. It's probably something we'll need to
deal with in the next 10-15 years, but nobody knows quite when.

If you'd like to start working on it, I'd be happy to review your
patches. :) But in the meantime, I don't know that anybody considers it
an extremely high priority to work on, versus other fixes and features.

> Rather than discussing how feasible collisions in SHA-1 are... Attacks
> on SHA-1 are only getting worse, no?

Actually, not really. I do not keep up terribly well with the academic
literature, but I don't think that attacks have gotten any worse in the
last few years. Computers _are_ getting faster, though, so a number like
2^61 (which is what Wikipedia claims as the best widely accepted value
for producing a collision) gets more and more feasible as time passes.

Of course, we might find worse attacks (or if you want to put on your
tinfoil hat, perhaps certain government organizations already have and
are keeping them secret). 2^61 is a best case.

> > And of course there is the question of getting the colliding data to the
> > victim. Git does collision checks whenever a remote (e.g., from a "git
> > fetch") gives us data that we already have. So you could poison new
> > cloners with bad data, but you could not convince a repository with the
> > existing "good" half of the collision to fetch the "evil" half.
> 
> Poison git cloners with bad data is exactly my point here. Because
> sometimes I am a cloner of my own code - cloning it on a separate
> machine - then verify it using gpg - but don't check it any further. In
> such cases, I'd prefer if security wouldn't depend on SHA-1.

I agree that cloners are an important category of users to clone. But it
also means that a single fetcher can detect tampering quite easily.
Think about it this way: let's say the Walker/Schneier estimate is
right, and in 2021 it will cost ~$43K to find a collision. You spend the
money, find a collision on some binary blob that's in the kernel,
convince Linus to accept your "good" version, he signs, and then you
hack into kernel.org and replace the blob with your evil version. Now
the first time somebody fetches the evil version, their git complains
about the collision, kernel.org admins investigate, and the problem is
fixed. There's some damage, but ultimately you didn't accomplish much.

Or you could spend that $43K hiring somebody to break into Linus's house
and manipulate the local copy of the kernel on his computer that he's
going to sign. Or buy a zero-day exploit for his browser that gives you
remote code execution on his workstation.

Don't get me wrong. I think moving away from SHA-1 is a good idea, and
something we're going to want to do for security reasons eventually. But
we're definitely not at the point of "well, all of our signatures are
worthless now", and I'm not sure we'll be there sooner than a decade
from now.

-Peff
