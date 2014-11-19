From: Jeff King <peff@peff.net>
Subject: Re: git-fetch: default globally to --no-tags
Date: Wed, 19 Nov 2014 13:57:09 -0500
Message-ID: <20141119185708.GA9908@peff.net>
References: <20141119030523.GO22361@norris-Latitude-E6410>
 <xmqqr3wzrpur.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:57:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrARI-0002T0-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbaKSS5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 13:57:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:42377 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754814AbaKSS5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 13:57:11 -0500
Received: (qmail 25377 invoked by uid 102); 19 Nov 2014 18:57:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 12:57:10 -0600
Received: (qmail 6260 invoked by uid 107); 19 Nov 2014 18:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 13:57:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 13:57:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3wzrpur.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 10:45:48AM -0800, Junio C Hamano wrote:

> > My email boils down to two questions:
> >
> >   (A) Has there been progress on implementing a proposal like in [2]?
> 
> I do not think so, and also I do not agree that "mirror everybody
> else's ref hierarchy into separate namespaces" is necessarily a good
> idea, especially for tags, whose reason of existence is to give
> people a way to have anchoring points they agree on to have a shared
> world view necessary to move things forward.
> 
> In other words, talks in [2] are attempting to solve a wrong
> problem.  The problem people want to solve is to have a mechanism to
> keep private anchoring points that are not necessarily shared
> project wide, which tags in refs/tags hierarchy is *not*.
> 
> Like it or not, tags are meant to be used for globally shared
> anchoring points and the whole machinery (e.g. "fetch" that
> auto-follows tags, "clone" that gives refs/tags*:refs/tags/*
> refspec) is geared towards supporting that use pattern, which will
> be broken by moving tags to per-remote namespace.
> 
> I can see "git tag --local foo" that creates refs/local-tags/foo
> and also adding a mechanism to propagate local-tags/ hierarchy just
> like heads/ hierarchy is propagated per-remote as a solution to that
> problem that does not break the "release tags" use case, though.

I am not sure I agree here that the discussions in [2] were not handling
this case. Here you are arguing for the tag-writer to distinguish
between two separate namespaces: global and local.

But I think the proposals in [2] were about pushing that logic into the
lookup phase. That is, pulling in all of the remote's tags as
"refs/remotes/origin/tags/*", and then at lookup time checking multiple
locations for tags (and preferring your local "refs/tags" to what is
pulled from a remote).

I think that system is better because it gives flexibility in resolution
to the viewer of the tags, not the writer. E.g., consider a project that
is merging two different sub-projects, project1 and project2. Each of
the sub-projects has their own global namespace with v1.0, v2.0, etc.
They would never use local-tags; these are meant to be in a per-project
global namespace.

But the superproject is pulling them both together; if it uses
refs/tags, the global namespaces will clash. Instead, it would be more
convenitn to have refs/remotes/project1/tags and so on. And then a
lookup of "v1.0" can either prefer project1 to project2, vice-versa, or
even respect neither. But the point is that the desired outcome is in
the eye of the beholder, not the writer.

> This is a tangent, but it is an important one because we are talking
> about "tagopt" specifically.  I think we should start deprecating
> "*.tagopt --[no-]tags".

Thanks for writing this out. I touched on it in the other email I sent,
but did not explain it very well. The transition you mentioned here is
exactly what I was thinking of.

-Peff
