From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Wed, 15 May 2013 23:31:51 -0400
Message-ID: <20130516033151.GB13296@sigill.intra.peff.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
 <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
 <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
 <518E0741.1060008@drmicha.warpmail.net>
 <518E16B1.7000505@drmicha.warpmail.net>
 <7vtxm7qxql.fsf@alter.siamese.dyndns.org>
 <20130513115451.GA3903@sigill.intra.peff.net>
 <5190FF73.1080606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 16 05:32:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucov8-0007EV-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab3EPDby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:31:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:44778 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab3EPDby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:31:54 -0400
Received: (qmail 20549 invoked by uid 102); 16 May 2013 03:32:22 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 May 2013 22:32:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2013 23:31:51 -0400
Content-Disposition: inline
In-Reply-To: <5190FF73.1080606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224469>

On Mon, May 13, 2013 at 04:57:55PM +0200, Michael J Gruber wrote:

> > I don't think that it is a property of the file itself. That is, you do
> > not say "foo files are inherently uninteresting to git-show, and
> > therefore we always convert them, whereas bar files do not have that
> > property'. You say "in my workflows, I expect to see converted results
> > from grep/show". And the latter points to using config, like either
> > "diff.*.showConverted" (to allow per-type setting), or even
> > "grep.useTextconv" and "show.textConv" (to allow setting it per-user for
> > all types).
> 
> I strongly disagree here. I have textconv filters for pdf, gpg, odf,
> xls, doc, xoj... I know, ugly. At least some of them would benefit from
> different filteres or different settings.

OK. I was speaking mostly from intuition, and I suspect you have more
real-world experience here. So I am willing to admit that my "you do not
say..." above was a strawman. :)

> The way I propose it, a user would just have to add "show=foo" to the
> "diff=foo" lines without having to ad an extra filter, but with the
> flexibility to do so.

Yes, I think that would work OK. The only problem is that it is a bit
weird to pointing "show=foo" to "diff.foo.*", especially when most of
the driver options are ignored. But if we can accept that wrinkle in the
UI, I think it would otherwise do what users want.

> One may ask what a purely ui output oriented setting like "show" has to
> do in .gitattributes, of course, but that applies to "diff" as well.
> Separating the two (one in attributes, one in config) looks artificial
> to me.

I think the point is that the attribute says "a property of this path is
that it has type X". And then the config says "when you see type X, do
this thing with it".

So arguably "diff=X" is wrong in the first place. It should be "type=X",
and we should have "diff.X", "merge.X", etc in the config. And
diff.*.textconv is potentially misplaced; it is not really about diffing
at all, but rather about creating a human-readable presentation for the
file. I don't think it is so bad that it is worth the pain of fixing it
now, though. It is a historical weirdness that "diff=X" means "present
the path according to the rules in X", but we can live with that.

But if we think of it that way, then automatically respecting textconv
for "git show" is a sensible thing to do. Hmph. Now I may have convinced
myself that flipping the default is the right thing. :)

So if it is not clear, I am pretty on the fence about how the defaults
should be handled, or what would surprise users the least. Either way,
though, it would probably make sense to have a configurable option. And
with the reasoning above for the split between attributes/config, it
would make sense to me for that option to be a boolean
"diff.X.showtextconv". Which seems totally odd and broken (we are not
doing a diff at all!), but that is where the textconv config lives, for
historical reasons.

-Peff
