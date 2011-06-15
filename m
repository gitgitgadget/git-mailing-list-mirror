From: Jeff King <peff@github.com>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 15 Jun 2011 19:00:33 -0400
Message-ID: <20110615230033.GB19803@sigill.intra.peff.net>
References: <20110608093648.GA19038@elte.hu>
 <201106141156.56320.johan@herland.net>
 <20110614171204.GC26764@sigill.intra.peff.net>
 <201106150145.12912.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 01:00:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWz4j-0003jX-CZ
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 01:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab1FOXAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 19:00:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44293
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab1FOXAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 19:00:35 -0400
Received: (qmail 7974 invoked by uid 107); 15 Jun 2011 23:00:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 19:00:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 19:00:33 -0400
Content-Disposition: inline
In-Reply-To: <201106150145.12912.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175867>

On Wed, Jun 15, 2011 at 01:45:12AM +0200, Johan Herland wrote:

> > What happens if I ask for foo/bar/baz? Should it try to resolve:
> > 
> >   1. refs/remotes/foo/heads/bar/baz
> > 
> > or
> > 
> >   2. refs/remotes/foo/bar/heads/baz
> > 
> > or both (and if both, in which order)?
> 
> I think we want to do both, following these pseudo-bash steps (or something 
> similar):
> 
>   shorthand=$1  # e.g. "foo/bar/baz"
>   for remote in $(git remote)
>   do
>       case $shorthand in
>         "$remote/"*)
>           # Found matching remote
>           trailer=${shorthand#$remote/}
>           # Assert $remote/$trailer == $shorthand
>           # DWIM $trailer into
>           # - refs/heads/$trailer
>           # - refs/tags/$trailer
>           # etc.
>           for dwimmed_ref in dwim_ref($trailer)
>           do
>               # Map $dwimmed_ref through refspec to get
>               # remote-tracking ref, e.g. mapping
>               # "refs/heads/spam" to "refs/remotes/$remote/heads/spam"
>               remote_ref=map_through_refspec($dwimmed_ref, $remote)
>               if test -n "$remote_ref"
>               then
>                   # Add $remote_ref to list of candidates
>               fi
>           done
>           ;;
>         *)
>           # Non-match, ignore
>           ;;
>       esac
>   done
> 
>   # We now have a list of (fully qualified) ref candidates
>   # for $shorthand.
> 
>   # If there are zero candidates, there is no match for $shorthand.
> 
>   # If there is only one candidate, we have found an unambiguous
>   # match for $shorthand.
> 
>   # If our current context demands a SHA1 object name, and all
>   # candidates point to the same SHA1, there is no ambiguity.
> 
>   # Otherwise, $shorthand is ambiguous.
> 

The current code doesn't care about configured remotes at all.  It
simply looks for $X in:

  refs/remotes/$X

and

  refs/remotes/$X/HEAD

So it is not the configured remotes which are special, but rather that
is a special namespace. For remotes configured with the default
refspecs, it ends up the same. But it also lets me do stuff like:

  # one-off fetch, but put it somewhere useful to us
  git fetch git://host/foo.git refs/heads/*:refs/remotes/foo/*

and then still get the shortcut of "foo/master".

I think adapting that to your scheme is pretty straighforward, though.

Given 1/2/3, you would look for tags in:

  refs/remotes/1/tags/2/3
  refs/remotes/1/2/tags/3

and then similarly heads in:

  refs/remotes/1/heads/2/3
  refs/remotes/1/2/heads/3

And then complain of ambiguity if they both match (which will almost
_never_ happen, unless you have a totally insane repo setup. So this is
really just about having well-defined rules just in case, and probably
won't affect most people in practice. In most cases, it will just DWYM).

The "HEAD" thing remains simple. You check for:

  refs/remotes/1/2/3/HEAD

since HEAD is going to be at the top-level anyway.

> Using the above (pseudo)code, and assuming remotes "foo" and "foo/bar" exist 
> (with remote branches "bar/baz" and "baz", respectively, and default new-
> style refspecs), then the "foo/bar/baz" shorthand would resolve to the 
> following two remote-tracking branches:
> 
> - refs/remotes/foo/heads/bar/baz
> - refs/remotes/foo/bar/heads/baz
> 
> This would likely result in an "ambiguous shorthand" error, unless the 
> current context wants a SHA1 object name, and the two remote-tracking refs 
> happen to point to the same SHA1 (in which case the result is unambiguous).

Yeah, I think I was just being dumb asking about the order. Of course it
shouldn't matter because we should complain of ambiguity.

> FWIW, if I run "git log some_topic" and "some_topic" only exists as a 
> remote-tracking ref ("refs/remotes/origin/heads/some_topic"), I do think I 
> would prefer git to DWIM it, instead of simply failing with:
> 
>   fatal: bad revision: some_topic
> 
> This would be somewhat in line with the DWIMing already performed by "git 
> checkout some_topic".

I'm not sure I agree, but then I'm not sure I really like the "git
checkout" DWIM, either. :)

However, I think this is an orthogonal topic to the reorganization of
the refs. So one doesn't have to come with the other.

-Peff
