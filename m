From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Mon, 13 May 2013 13:55:08 +0200
Message-ID: <20130513115451.GA3903@sigill.intra.peff.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
 <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
 <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
 <518E0741.1060008@drmicha.warpmail.net>
 <518E16B1.7000505@drmicha.warpmail.net>
 <7vtxm7qxql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 13:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbrLg-0002Si-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 13:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab3EMLzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 07:55:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:47537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab3EMLzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 07:55:16 -0400
Received: (qmail 27576 invoked by uid 102); 13 May 2013 11:55:41 -0000
Received: from m915736d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.87.145)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 May 2013 06:55:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 May 2013 13:55:08 +0200
Content-Disposition: inline
In-Reply-To: <7vtxm7qxql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224123>

On Sun, May 12, 2013 at 10:01:38PM -0700, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > Adding to that:
> >
> > Somehow I still feel I should introduce a new attribute "show" (or a
> > better name) similar to "diff" so that you can specifiy a diff driver to
> > use for showing a blob (or grepping it), which may or may not be the
> > same you use for "diff". This would be a much more fine-grained and
> > systematic way of setting a default for "--textconv" for blobs.
> >
> > Of course, some driver attributes would just not matter for coverting
> > blobs, but that doesn't hurt.
> >
> > I'm just wondering whether it's worth the effort and whether I should
> > distinguish between "show" and grep".
> 
> Haven't thought things through, but my gut feeling is that it is on
> the other side of the line. We could of course add more features and
> over-engineered mechanisms, and the implementation may end up to be
> even modular and clean, but I cannot answer "Yes" with a confidence
> to the question "Does such a fine grained control help the users?"
> and cannot answer "If so in what way?" myself.

Yeah, I think the _most_ flexible thing is going to look something like:

  $ cat .gitattributes
  *.pdf diff=pdf show=pdf

  $ cat ~/.gitconfig
  [diff "pdf"]
          textconv = ...
  [show "pdf"]
          textconv = ...

But that obviously sucks, because in the common case that you want to
use the same command, you are repeating yourself in the config. You
could assume that the "show" attribute points us at a "diff" block. And
that makes sense for textconv, but what does it mean if you have
"show=foo" and "diff.foo.command" set?

If the _only_ thing you would want to do with such a "show" mechanism is
to display converted contents on show/grep, then we could lose the
flexibility and say that "show" is a single-bit: do we respect diff
textconv for show/grep in this case, or not? And that leaves only the
question of where to put it: is it a gitattribute, or does it go in the
config?

I don't think that it is a property of the file itself. That is, you do
not say "foo files are inherently uninteresting to git-show, and
therefore we always convert them, whereas bar files do not have that
property'. You say "in my workflows, I expect to see converted results
from grep/show". And the latter points to using config, like either
"diff.*.showConverted" (to allow per-type setting), or even
"grep.useTextconv" and "show.textConv" (to allow setting it per-user for
all types).

And of course for any workflow-oriented config, you will sometimes want
to override it for a particular operation. But that is why we have a
command-line escape hatch, and that part is already implemented.

-Peff
