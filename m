From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fast textconv
Date: Tue, 30 Mar 2010 13:07:48 -0400
Message-ID: <20100330170748.GD17763@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <7vtyryxy8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 19:08:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwevB-00026G-Az
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 19:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab0C3RIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 13:08:01 -0400
Received: from peff.net ([208.65.91.99]:38919 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754Ab0C3RIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 13:08:00 -0400
Received: (qmail 22709 invoked by uid 107); 30 Mar 2010 17:08:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 13:08:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 13:07:48 -0400
Content-Disposition: inline
In-Reply-To: <7vtyryxy8r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143579>

On Mon, Mar 29, 2010 at 08:52:04PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The speedup is purely from caching; I am not using the "we only need to
> > read the first part of the file" optimization.
> 
> This made me wonder if the end result might be easier to use if the
> interface does not change "textconv", but adds some property to the
> filter, i.e. "the output from this filter is stable and it is safe to
> reuse a cached conversion result for a given blob object", boolean.  E.g.
> 
>         [diff "jpg"]
>                 textconv = exif
>                 textconv_stable = true
> 
> and let the calling side handle the caching.  I further suspect that
> an unstable textconv filter would be an anomaly, so this could even be on
> by default.

Yep, that is the conclusion I came to later in the thread. I am tempted
not to even make it configurable, but it is a space-time tradeoff, so I
can see how certain corner cases would want to disable.

So consider "fasttextconv" (and this series) scrapped, and I'll work on
a new series that does internal caching via notes.

> If we do so, stock conversion filters people have accumulated in the past
> could be sped up without any additional change from the end user's side.
> 
> I guess that I am suggesting to postpone the potential speed-up that could
> come from being able to inspect the header information as a separate
> topic.  Besides, some file format has metadata at the end, which won't
> help you.

Yes, I agree that the "header only" speed-up is not worth pursuing at
this point. With caching, actually looking at the file at all becomes
the slow path, and you just don't care as much. It might help if you
have 2G files or something where even just spooling the file the first
time is awful, but I will leave that as a later itch to be scratched if
people want.

For metadata at the end (or other spots), probably it would need to be
accompanied by an extension to cat-file to peek at random positions
within the file.

> About the caching scheme; to help invalidating the cache, it probably is a
> good idea to use not just the blob object name but also at least the name
> (command line) of the textconv filter as the key for the caching layer.
> 
> Instead of the "textconv_stable" boolean depicted above, you could add a
> "textconv_filter_version" variable there, compute a hash over blob object
> name, textconv filter name and textconv filter version, and use that as
> the key to look into the cache (filters lacking textconv_filter_version
> would then get no caching, and if you update your "exif" program you bump
> the "textconv_filter_version" variable).

I was thinking of having a separate notes tree for each textconv helper.
Most projects will only have a small number, so the extra tree setup
cost is negligible. And because we know which helper we are using, we
can look in each tree separately, which means you may not even need to
load cache entries at all for filetypes which are not being diffed.

For cache validity, I'm planning to store a special "validity" entry
(either keyed by the null sha1 in a cache tree, or to wrap the tree in a
parentless commit with that information in the comment field). The entry
would contain the command line used to run the helper. If it matches,
the cache is valid. If not, we clear the notes tree.

I think this ends up being slightly simpler for the user to manage the
cache, and it has better cache growth characteristics.

In both schemes, git will automatically correctly handle:

  $ git config diff.foo.textconv foo-helper
  $ git show
  $ git config diff.foo.textconv "foo-helper --options"
  $ git show

In my case, by clearing refs/notes/textconv/foo, and in your case by
storing under a different key sha1. I would argue my scheme is better
here, because it actually _throws away_ the now useless cache entries.
So the cache is automatically pruned (and if you really want to go back
in time to salvage an old cache, you can do it via the reflog).

They will also both automatically handle:

  $ echo '*.jpg diff=foo' >.gitattributes
  $ git show
  $ echo '*.jpg diff=bar' >.gitattributes
  $ git show

In my case, by using a totally different tree. In your case, again a
different key sha1. Which means I'm now leaving the old "foo" tree in
place with stale entries for '*.jpg' files. But this is the same data
wastage as with your scheme. In both cases, you can clean things out by
blowing away the cache. But in my scheme, you are allowed to blow away
only the "foo" cache. The cache data for other helpers isn't precious,
obviously, but it does make things slower.

Neither scheme will automatically handle the semantics of a helper
changing (e.g., upgrade of the "foo" helper). In my scheme, the solution
is to clear the "foo" cache (git update-ref -d refs/notes/textconv/foo).
In yours, it would be to update the textconv_filter_version field in the
config. I would argue that mine is conceptually simpler for the user.
It's a cache. When a cache is in a broken or invalid state, you clear it
and start again.

You could try to get very fancy and include the stat() data for the
helper script in the cache validity information to detect version
changes, but I doubt that it's worth it. It's much more complex (we run
helpers with the shell, so it may not be a single program), and it still
isn't foolproof (your environment, dynamic libraries, or other factors
may be what's changing the answer).

I'll see if I can work up some patches in the next day or two.

-Peff
