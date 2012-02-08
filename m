From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] tag: add --points-at list option
Date: Wed, 8 Feb 2012 13:57:50 -0500
Message-ID: <20120208185750.GA22220@sigill.intra.peff.net>
References: <20120208002554.GA6035@sigill.intra.peff.net>
 <1328682076-23380-2-git-send-email-tmgrennan@gmail.com>
 <20120208154442.GB8773@sigill.intra.peff.net>
 <20120208184332.GF6264@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 19:58:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvCiM-0003nB-9m
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 19:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab2BHS5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 13:57:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59671
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757202Ab2BHS5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 13:57:53 -0500
Received: (qmail 18884 invoked by uid 107); 8 Feb 2012 19:05:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 14:05:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 13:57:50 -0500
Content-Disposition: inline
In-Reply-To: <20120208184332.GF6264@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190247>

On Wed, Feb 08, 2012 at 10:43:32AM -0800, Tom Grennan wrote:

> >Though we provide a null_sha1 global already. So doing:
> >
> >  const unsigned char *tagged_sha1 = null_sha1;
> >
> >would be sufficient.
> 
> Or just initialize at test tagged_sha1 with NULL.

Oh yeah, that is even better.

> >That being said, I don't know why you want to do both lookups in the
> >same loop of the points_at. If it's a lightweight tag and the tag
> >matches, you can get away with not parsing the object at all (although
> >to be fair, that is the minority case, so it is unlikely to matter).
> 
> Yes, I think your saying that the lightweight search could go before the
> tag object search like this.

Exactly, though:

> static const unsigned char *match_points_at(const unsigned char *sha1)
> {
> 	const unsigned char *tagged_sha1 = NULL;
> 	struct object *obj = parse_object(sha1);
> 
> 	if (sha1_array_lookup(&points_at, sha1) >= 0)
> 		return sha1;
> 	if (obj && obj->type == OBJ_TAG)
> 		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;

You can delay the relatively expensive parse_object until you find the
results of the first lookup (though like I said earlier, it is unlikely to
matter, as it only helps in the positive-match case. Out of N tags, you
will likely end up parsing N-1 of them anyway).

> >Also, should we be producing an error if !obj? It would indicate a tag
> >that points to a bogus object.
> 
> I think the test of (obj) is redundant as this should be caught
> by get_sha1() in parse_opt_points_at()

No, it's not redundant. get_sha1 is purely about looking up the name and
finding a sha1. parse_object is about looking up the object represented
by that sha1 in the object db. get_sha1 can sometimes involve parsing
objects (e.g., looking for "foo^1" will need to parse the commit object
at "foo"),  but does not have to.

Besides which, you are not calling parse_object on the sha1 from
--points-at, but rather the sha1 for each tag ref given to us by
for_each_tag_ref.

> >Why write your own linear search? sha1_array_lookup will do a binary
> >search for you.
> 
> Well, it's only a linear search of the points_at command arguments.
> But by that reasoning, might as well do two sha1_array_lookups like
> above and save some code b/c "less code is always better"(TM).

Right. I expect the N to be small in this case, so I doubt it matters.
But two sha1_array_lookups is still asymptotically smaller, because the
expensive operation is hashcmp(). So two binary searches is O(2*lg n),
whereas a linear walk with 2 hashcmps per item is O(2*n).

> >Other than that, the patch looks OK to me.
> 
> Thanks, I'll send what I hope to be the final version later today.

Thanks for working on this and being so responsive to review.

-Peff
