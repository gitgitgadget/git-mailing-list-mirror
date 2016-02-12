From: Jeff King <peff@peff.net>
Subject: Re: Gated Merge?
Date: Fri, 12 Feb 2016 14:26:13 -0500
Message-ID: <20160212192612.GA20992@sigill.intra.peff.net>
References: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
 <CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
 <xmqqr3ghvn6a.fsf@gitster.mtv.corp.google.com>
 <20160212190017.GA20801@sigill.intra.peff.net>
 <xmqq1t8hvjdv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 20:26:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUJMC-0005BA-4w
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 20:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbcBLT0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 14:26:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:41166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750959AbcBLT0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 14:26:15 -0500
Received: (qmail 15299 invoked by uid 102); 12 Feb 2016 19:26:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 14:26:15 -0500
Received: (qmail 18565 invoked by uid 107); 12 Feb 2016 19:26:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 14:26:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 14:26:13 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1t8hvjdv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286073>

On Fri, Feb 12, 2016 at 11:06:04AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I don't think this needs to have anything to do with merges in
> > particular, or rules like "when merging a branch that does not have me
> > in it". It is about saying "from here on out, the tree state should
> > match this property, and we can test it by running this script". And
> > then running "make code-lint-tests" becomes part of the acceptance
> > testing for a proposed topic merge, just like "make test" is already
> > (and likewise, people forking _new_ branches from master after the topic
> > is merged would make sure they do not fail the code-lint tests before
> > even submitting the topic).
> 
> That certainly is true, but this strays more and more from my
> original motive of implementing an automated evil-merge scheme that
> is better than what I currently have.
> 
> We try to do our tree-wide refactoring in such a way that it would
> break the compilation (by changing function signature) when we can.
> Catching with "make test" would certainly generalize it, but the
> endgame result I was shooting for was to come up with a solution for
> each topic in-flight just once and keep replaying it until it is
> merged.

Yeah, that makes sense. I do repeated merges myself, and it is a pain.
I do not usually use your Reintegrate scripts, though when I have done
so, they work pretty well. And I don't think you're going to come up
with anything much better for the general case.

Let's split the problem into "detect a problem" from "apply the fix for
a topic".

You do not want to stop detecting once the original topic is merged. The
new rule is "we spell this as FORMAT_PRINTF" and you want to detect it
in simultaneous topics, _and_ in future topics. So if it is worth
checking in an auomated way, that should go into the tree.

So once we've detected a problem, how do we fix it?

For the specific case of FORMAT_PRINTF, you showed a possible "extra
processing" snippet to fix the problem in an automated way. But if we
realize that these gated attributes are really just another form of
test, it should be obvious that we cannot do so automatically in the
general case. You do not expect to fix a failed "make test" on a merge
in an automated way; there are too many possible resolutions. The best
we can do is detect the problem, create a patch, and then apply that
patch as appropriate.

So I'm somewhat doubtful that it would be worth the effort to create
infrastructure for "automate this fix" that is anything except "apply
this patch and tell me if we now pass the test".

-Peff
