From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 19:25:54 -0500
Message-ID: <20120208002554.GA6035@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
 <20120207192135.GC6264@tgrennan-laptop>
 <20120207193632.GC32367@sigill.intra.peff.net>
 <7v1uq61jkz.fsf@alter.siamese.dyndns.org>
 <20120207213012.GA5846@sigill.intra.peff.net>
 <20120207220806.GD6264@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 01:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuvMj-0005vy-51
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 01:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab2BHAZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 19:25:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59449
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756245Ab2BHAZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 19:25:57 -0500
Received: (qmail 13486 invoked by uid 107); 8 Feb 2012 00:33:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 19:33:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 19:25:54 -0500
Content-Disposition: inline
In-Reply-To: <20120207220806.GD6264@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190215>

On Tue, Feb 07, 2012 at 02:08:06PM -0800, Tom Grennan wrote:

> v1 and v2 wouldn't list lightweight tags of the points-at objects.
> Both versions behave like this:
>   $ git tag my-lw-v1.7.9 v1.7.9
>   $ git tag my-a-v1.7.9 v1.7.9
>   $ git tag my-s-v1.7.9 v1.7.9
>   $ git tag -l --points-at v1.7.9
>   my-a-v1.7.9
>   my-s-v1.7.9

I assume the 2nd and 3rd line should be:

  $ git tag -a my-a-v1.7.9 v1.7.9
  $ git tag -s my-s-v1.7.9 v1.7.9

> static struct points_at *match_points_at(struct points_at *points_at,
> 					 const char *refname,
> 					 const unsigned char *sha1)
> {
> 	struct object *obj;
> 	struct points_at *pa;
> 	const unsigned char *tagged_sha1;
> 
> 	/* First look for lightweight tags - those with matching sha's
> 	 * but different names */
> 	for (pa = points_at; pa; pa = pa->next)
> 		if (!hashcmp(pa->sha1, sha1) && strcmp(pa->refname, refname))
> 			return pa;

OK, I see what you are trying to accomplish here. But I really don't
like it. Two complaints:

  1. Why is the name of the tag relevant? That is, if you are interested
     in lightweight tags, and you have two tag refs, "refs/tags/a" and
     "refs/tags/b", both pointing to the same tag object, then in what
     situation is it useful to show "a" but not "b"?

     It seems to me you would either want lightweight tags or not. And I
     thought not, because the point of this was to reveal signatures or
     annotations about a tag. Your my-lw-v1.7.9 says neither. Why do we
     want to show it?

     Also, it's not symmetric. What if I say "git tag
     --points-at=my-lw-v1.7.9"? Then I would get your signed and
     annotated tags (even though they're _not_ saying anything about
     ny-lw-v1.7.9), and I would get v1.7.9 (even though it's not saying
     anything about it either; in fact, it's the opposite!).

  2. I thought --points-at was about providing an object name. But it's
     not. It's about providing a particular string. So with this code,
     "git tag --points-at=v1.7.9" and "git tag --points-at=$(git
     rev-parse v1.7.9)" are two different things. Which seems odd and
     un-git-like to me.

     Your documentation says "Only list annotated or signed tags of the
     given object", which implies to me that --points-at is an arbitrary
     object specifier, not a specific tagname.

It seems like your rationale is just avoiding a mention of v1.7.9
because, hey, it was obviously on the command line and the user isn't
interested in it. But I don't think that's true. The user asked for
every tag pointing to v1.7.9's object, and v1.7.9 is such a tag. It is
no more or less true for v1.7.9 than it is for my-lw-v1.7.9.

-Peff
