From: Jeff King <peff@peff.net>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Sun, 13 Sep 2015 06:07:29 -0400
Message-ID: <20150913100728.GA26562@sigill.intra.peff.net>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
 <20150911140133.GA14311@sigill.intra.peff.net>
 <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
 <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
 <20150912033054.GA30431@sigill.intra.peff.net>
 <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 12:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb4C8-0007oB-MV
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 12:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbbIMKHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 06:07:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:58355 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752134AbbIMKHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 06:07:31 -0400
Received: (qmail 3738 invoked by uid 102); 13 Sep 2015 10:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Sep 2015 05:07:32 -0500
Received: (qmail 17469 invoked by uid 107); 13 Sep 2015 10:07:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Sep 2015 06:07:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2015 06:07:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277772>

On Sat, Sep 12, 2015 at 01:29:43AM -0700, Junio C Hamano wrote:

> >> -		for (p = commit->parents; p; p = p->next)
> >> +		for (p = commit->parents;
> >> +		     p && !revs->first_parent_only;
> >> +		     p = p->next)
> >>  			add_child(revs, p->item, commit);
> >>  	}
> >>  }
> 
> ... this is a total crap and shows that I am doubly an idiot.
> 
> The loop is a no-op when first-parent-only (the intent is to call
> add-child for just the first parent), so the code is stupid and
> wrong in the first place, but more importantly, the logic is utterly
> confused.

Whoops, yeah. I think you need "if (revs->first_parent_only) break;".

> The thing is, traversing first-parent chain in reverse fundamentally
> is undefined.  You can fork multiple topics at the tip of 'master'
> and each of the topics may be single strand of pearls, but which one
> of the topics is the first-child-chain---there is no answer to that
> question.

In general I think I agree, but in the case of blame, we know that we
are starting from a single tip (and we know because we are using
first-parent that we remain in a single strand of pearls, because we
follow only one parent and there are no cycles).

That is assuming that we create the set of children by traversing the
first-parent history, though, which I am not at all sure about.

-Peff
