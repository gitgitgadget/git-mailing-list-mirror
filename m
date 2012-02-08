From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] tag: add --points-at list option
Date: Wed, 8 Feb 2012 10:44:42 -0500
Message-ID: <20120208154442.GB8773@sigill.intra.peff.net>
References: <20120208002554.GA6035@sigill.intra.peff.net>
 <1328682076-23380-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 16:44:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv9hR-0004Tr-PW
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 16:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab2BHPop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 10:44:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59619
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756246Ab2BHPoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 10:44:44 -0500
Received: (qmail 16830 invoked by uid 107); 8 Feb 2012 15:51:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 10:51:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 10:44:42 -0500
Content-Disposition: inline
In-Reply-To: <1328682076-23380-2-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190240>

On Tue, Feb 07, 2012 at 10:21:16PM -0800, Tom Grennan wrote:

> +static const unsigned char *match_points_at(const unsigned char *sha1)
> +{
> +	int i;
> +	const unsigned char *tagged_sha1 = (unsigned char*)"";
> +	struct object *obj = parse_object(sha1);
> +
> +	if (obj && obj->type == OBJ_TAG)
> +		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;

This is not safe. A sha1 is not NUL-terminated, but is rather _always_
20 bytes. So when the object is not a tag, you do the hashcmp against
your single-byte string literal above, and we end up comparing whatever
garbage is in the data segment after the string literal.

What you want instead is the all-zeros sha1, like:

  const unsigned char null_sha1[20] = { 0 };

Though we provide a null_sha1 global already. So doing:

  const unsigned char *tagged_sha1 = null_sha1;

would be sufficient.

That being said, I don't know why you want to do both lookups in the
same loop of the points_at. If it's a lightweight tag and the tag
matches, you can get away with not parsing the object at all (although
to be fair, that is the minority case, so it is unlikely to matter).

Also, should we be producing an error if !obj? It would indicate a tag
that points to a bogus object.

> +	for (i = 0; i < points_at.nr; i++)
> +		if (!hashcmp(points_at.sha1[i], sha1))
> +			return sha1;
> +		else if (!hashcmp(points_at.sha1[i], tagged_sha1))
> +			return tagged_sha1;
> +	return NULL;

Why write your own linear search? sha1_array_lookup will do a binary
search for you.

Other than that, the patch looks OK to me.

-Peff
