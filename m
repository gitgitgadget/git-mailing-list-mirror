From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 4 Mar 2014 19:56:49 -0500
Message-ID: <20140305005649.GB11509@sigill.intra.peff.net>
References: <20140304174806.GA11561@sigill.intra.peff.net>
 <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 01:56:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL08m-0003AS-HH
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 01:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbaCEA4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 19:56:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:33064 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754764AbaCEA4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 19:56:51 -0500
Received: (qmail 26406 invoked by uid 102); 5 Mar 2014 00:56:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Mar 2014 18:56:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2014 19:56:49 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243410>

On Tue, Mar 04, 2014 at 12:52:18PM -0800, Junio C Hamano wrote:

> > We already make an attempt to do the right thing in several
> > places by turning off read_replace_refs. However, we missed
> > at least one case (during bundle creation), and we do
> > nothing anywhere to handle grafts.
> 
> "Doing nothing for grafts" has been pretty much a deliberate
> omission.  Because we have no way to transfer how histories are
> grafted together, people cloning from a repository that grafts away
> a commit that records a mistakenly committed sekrit will end up with
> a disjoint history, instead of exposing the sekrit to them, and are
> expected to join the history by recreating grafts (perhaps a README
> of such a project instructs them to do so).  That was deemed far
> better than exposing the hidden history, I think.

I see your point, but I would be tempted to say that the person trying
to hide a secret with grafting is simply wrong to do so. You need to
cement that history with a rewrite if you want to share with people.

I do not recall any past discussion on this topic, and searching the
archive only shows people echoing what I said above. Is this something
we've promised to work in the past?

I'm certainly sympathetic to systems failing to a secure default rather
than doing something that the user does not expect. But at the same
time, if using grafts for security isn't something people reasonably
expect, then failing only hurts the non-security cases.

> And "replace tries to do the right thing" was an attempt to rectify
> that misfeature of grafts in that we now do have a way to transfer
> how the history is grafted together, so that project README does not
> have to instruct the fetcher of doing anything special.

Perhaps the right response is "grafts are broken, use git-replace
instead". But then should we think about deprecating grafts? Again, this
patch was spurred by a real user with a graft trying to push and getting
a confusing error message.

> It _might_ be a misfeature, however, for the object connectivity
> layer to expose a part of the history replaced away to the party
> that fetches from such a repository.  Ideally, the "right thing"
> ought to be to include history that would be omitted if we did not
> have the replacement (i.e. adding parents the underlying commit does
> not record), while not following the history that replacement wants
> to hide (i.e. excluding the commits replacement commits overlay).

I don't really think it's worth the complexity. It's fairly common
knowledge (or at least I think so) that replace refs are a _view_ onto
the history. When you share the history graph, you share the true
objects. You can _also_ share your views in replace/refs, but it is up
to the client to fetch them. If you want to hide things, then you need
to rewrite the true objects, end of story.

I dunno. Maybe there are people who have different expectations.

-Peff
