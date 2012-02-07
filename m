From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 16:30:12 -0500
Message-ID: <20120207213012.GA5846@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
 <20120207192135.GC6264@tgrennan-laptop>
 <20120207193632.GC32367@sigill.intra.peff.net>
 <7v1uq61jkz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 22:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuscI-0007iR-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 22:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab2BGVaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 16:30:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59413
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756924Ab2BGVaP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 16:30:15 -0500
Received: (qmail 12562 invoked by uid 107); 7 Feb 2012 21:37:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 16:37:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 16:30:12 -0500
Content-Disposition: inline
In-Reply-To: <7v1uq61jkz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190213>

On Tue, Feb 07, 2012 at 12:20:44PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I think the following would show the pointed at tag too.
> >>   $ git tag my-v1.7.9 v1.7.9
> >>   $ ./git-tag -l --points-at v1.7.9
> >>   my-v1.7.9
> >>   v1.7.9
> >> 
> >> vs.
> >> 
> >>   $ ./git-tag -l --points-at v1.7.9
> >>   my-v1.7.9
> >> 
> >> I found that I had to filter matching refnames.
> >
> > Ah, so you are trying _not_ to show lightweight tags (I thought you
> > meant you also wanted to show them)? But I still don't see why the code
> > I posted before wouldn't work in that case. The "object" field of v1.7.9
> > is not the sha1 of the v1.7.9 tag object, but rather some commit, so it
> > would not match.
> 
> I think he is trying to avoid saying "v1.7.9 points at itself", and wants
> to know not just the value of $(rev-parse v1.7.9) but the refname.

Hmm. I read his example again, and now I'm even more confused.

If I give an object name to --points-at, should or should not a
lightweight tag pointing to that object be found?

If not, then I don't see how "git tag --points-at v1.7.9" would find
v1.7.9. Because we would use get_sha1 to parse "v1.7.9", returning the
sha1 of the tag object. And then when trying to match, we would look at
each tag object, find its "object" line, and compare that. In the case
of considering whether to show the v1.7.9 tag, we would be comparing the
sha1 of the commit that it points to to the actual tag sha1 itself, and
not match.

But in that case, nor would we match "my-v1.7.9" above, as it is a
lightweight tag that also points to v1.7.9's tag object.

If we _do_ want to match lightweight tags, then in the matching phase we
look for both the sha1 contained in the tag ref, as well as the sha1 of
the thing the tag points to (_if_ it is a tag object). In that case, we
would find both v1.7.9 and my-v1.7.9.

So I am not sure which is preferable. But I don't see how you could or
would want to distinguish the two tags above. They are functionally
identical, in that they are both refs pointing to the exact same tag
object. If the example had started with "git tag -s my-v1.7.9 v1.7.9"
then it would make more sense to me.

-Peff
