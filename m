From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 15:10:43 -0400
Message-ID: <20150430191043.GA4461@peff.net>
References: <20150430033725.GB12361@peff.net>
 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
 <5541E3D4.7040207@alum.mit.edu>
 <1430417023.22711.8.camel@ubuntu>
 <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
 <1430418522.22711.22.camel@ubuntu>
 <20150430183226.GA2855@peff.net>
 <1430419490.22711.30.camel@ubuntu>
 <20150430184944.GA3661@peff.net>
 <1430420422.22711.37.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:10:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntrG-0004cd-P3
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbD3TKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:10:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:52442 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751745AbbD3TKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:10:46 -0400
Received: (qmail 13304 invoked by uid 102); 30 Apr 2015 19:10:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 14:10:46 -0500
Received: (qmail 8349 invoked by uid 107); 30 Apr 2015 19:11:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 15:11:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 15:10:43 -0400
Content-Disposition: inline
In-Reply-To: <1430420422.22711.37.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268093>

On Thu, Apr 30, 2015 at 12:00:22PM -0700, David Turner wrote:

> > > Also, BUILD files are scattered throughout the tree, so the entire tree
> > > would still need to be traversed.  At present, our monorepo is not quite
> > > large enough for this to matter (a full ls-tree only takes me 0.6s), but
> > > it is growing.
> > 
> > But aren't you asking git to do that internally? I.e., it can limit the
> > traversal for a prefix-match, but it cannot do so for an arbitrary
> > filename. It has to open every tree. So the extra expense is really just
> > the I/O over the pipe. That's not optimal, but it is a constant factor
> > slowdown from what git would do internally.
> 
> No, I'm not trying to find all BUILD files -- only ones that are in the
> transitive dependency tree of the target I'm trying to sparsely check
> out. So if the target foo/bar/baz depends on morx/fleem, and morx/fleem
> depends on plugh/xyzzy, then I have to examine those three places only.
> I don't have to examine anything in the gibbberish/ subtree, for
> instance.  

OK, let me see if I understand your use case by parroting it back.

You _don't_ want to feed git a "find all BUILD" pattern, which is good
(because it doesn't work ;) ). You do want to feed it a set of raw
paths to find, because you're going to discover the paths yourself at
each step as you recurse through the dependency-chain of build files. 
You don't actually care about feeding those paths to "ls-tree" at all.
You care only about the _content_ at each path (and will parse that
content to see if you need to take a further recursive step).

So I think git out-of-the-box supports that pretty well (via cat-file).
And your sticking point is that some of the paths may involve symlinks
in the tree, so you want cat-file to answer "if I had checked this out
and typed cat /some/path/to/BUILD, what content would I get". Which
brings us back to the original symlink question.

Is that all accurate?

I'm not sure that helps with the "how to handle symlinks" discussion,
but at least your goals make sense to me at this point.

-Peff
