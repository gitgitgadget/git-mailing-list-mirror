From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Wed, 8 Feb 2012 10:31:00 -0500
Message-ID: <20120208153100.GA8773@sigill.intra.peff.net>
References: <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
 <20120207192135.GC6264@tgrennan-laptop>
 <20120207193632.GC32367@sigill.intra.peff.net>
 <7v1uq61jkz.fsf@alter.siamese.dyndns.org>
 <20120207213012.GA5846@sigill.intra.peff.net>
 <20120207220806.GD6264@tgrennan-laptop>
 <20120208002554.GA6035@sigill.intra.peff.net>
 <20120208014515.GE6264@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 16:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv9UH-00077q-0t
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 16:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab2BHPbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 10:31:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59610
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639Ab2BHPbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 10:31:06 -0500
Received: (qmail 16760 invoked by uid 107); 8 Feb 2012 15:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 10:38:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 10:31:00 -0500
Content-Disposition: inline
In-Reply-To: <20120208014515.GE6264@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190239>

On Tue, Feb 07, 2012 at 05:45:15PM -0800, Tom Grennan wrote:

> >     Also, it's not symmetric. What if I say "git tag
> >     --points-at=my-lw-v1.7.9"? Then I would get your signed and
> >     annotated tags (even though they're _not_ saying anything about
> >     ny-lw-v1.7.9), and I would get v1.7.9 (even though it's not saying
> >     anything about it either; in fact, it's the opposite!).
> 
> Huh?  As you noted, the lightweight tag is just an alternate reference,
> so why wouldn't want to see the annotated and signed tags of that common
> object?
> 
>   $ ./git-tag -l --points-at tomg-lw-v1.7.9 
>   tomg-annotate-v1.7.9
>   tomg-signed-v1.7.9
>   v1.7.9
>   $ ./git-tag -l --points-at v1.7.9 
>   tomg-annotate-v1.7.9
>   tomg-lw-v1.7.9
>   tomg-signed-v1.7.9

Sorry, I should have been more clear here (the word symmetric isn't
right; it _is_ symmetric). My understanding of the point of your
original feature was to mention things that talk about a tag (because
you wanted to know what signatures were made around it).

With tag objects this is easy, because they contain a pointer. But when
it comes to lightweight tags, you cannot tell in which direction the
"talking about" occurred[1]. That is, a lightweight tag of another tag
is just creating a new ref, which looks the same as the old ref. So
something like --points-at cannot say "X talks about Y", because it
might as well have been "Y talks about X".

So I think you are better off to mention both X and Y (or to mention
neither).

> >     Your documentation says "Only list annotated or signed tags of the
> >     given object", which implies to me that --points-at is an arbitrary
> >     object specifier, not a specific tagname.
> 
> Yes, I changed that in the patch that I've prepared but will revert this
> if you'd rather not list these lightweight tags.

I'm OK with not mentioning lightweight tags. I just feel it should be
all-or-nothing. It was specifically the "given object" that I took issue
with, since in your examples v1.7.9 was treated differently from its
sha1.

> My reaction when I tested this was, "don't tell me what I already know."
> But consistency with $(git rev-parse ...) seems more important.
> And as you noted, a sha1_array would save code and to me, less code is
> always better.

Thanks. Either I've convinced you, or I've made you so sick of the
discussion that you're agreeing. The system works. :)

-Peff

[1] Actually, a tag object embeds the name of the ref under which it was
originally created (so the refs/tags/v1.7.9 tag has a "tag v1.7.9"
header in it). So in some cases, you _can_ determine the "original" ref
of a lightweight tag versus other refs made about it later. I'm still
not sure --points-at is a good place to try to make that distinction,
though.
