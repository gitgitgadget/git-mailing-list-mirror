From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add filter-objects command
Date: Fri, 19 Jun 2015 06:52:11 -0400
Message-ID: <20150619105210.GA29755@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434705059-2793-4-git-send-email-charles@hashpling.org>
 <20150619101010.GA15802@peff.net>
 <20150619103324.GA4093@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5tuF-0005dz-G5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbbFSKwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 06:52:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:48718 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751363AbbFSKwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:52:13 -0400
Received: (qmail 12387 invoked by uid 102); 19 Jun 2015 10:52:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 05:52:13 -0500
Received: (qmail 14450 invoked by uid 107); 19 Jun 2015 10:52:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 06:52:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 06:52:11 -0400
Content-Disposition: inline
In-Reply-To: <20150619103324.GA4093@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272124>

On Fri, Jun 19, 2015 at 11:33:24AM +0100, Charles Bailey wrote:

> > Obviously I've glossed over the "how to get a list of objects" part.
> > If you truly want all objects (not just reachable ones), or if "rev-list
> > --objects" is too slow [...]
> 
> So, yes, performance is definitely an issue and I could have called this
> command "git magically-generate-all-object-for-scripts" but then, as it
> was so easy to provide exactly the filtering that I was looking for in
> the C code, I thought I would do that as well and then "filter-objects"
> ("filter-all-objects"?) seemed like a better name.

Right, my point was only that it works for _your_ particular filter, but
it would be nice to have something more general. And we already have
"cat-file --batch-check". IOW, I think I would prefer the "magical" form
because it's a better scripting building block. As you note,
"filter-objects" without any filters is exactly that. Your 10 extra
lines of C code are not exactly bloat, but I just wonder if other people
will find it all that useful.

> It's about an order of magnitude faster on the systems I've checked to
> do a parameterless filter-objects then rev-list --all --objects,
> although I understand they do different things.

Right, it's the object-opening and hash lookups that kill you in
"rev-list", because it's actually walking the graph.

> I am also thinking about another piece that answers the question: "which
> commits introduce any of (or the first of) this list of objects?". This
> can be done by parseing a diff --raw for commits but I think it should
> be possible to do this faster, too.

If you care about "introduce", I think you have to traverse and do the
diffs. If you only care about "contains" (for example, because you want
to know which path the blob is found at), you can find trees which
mention it, then trees which mention that tree, and so on. I think that
ends up slower in practice, though.

I have patches that implement a "rev-list --find=$sha1", which sets a
bit on $sha1 and then traverses with --objects until we find it (or
them; you can specify multiple). It's pretty straightforward, but it
does cost as much as "git rev-list --objects" in the worst case. Let me
know if you're interested and I can clean it up and post it.

-Peff
