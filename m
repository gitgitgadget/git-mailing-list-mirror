From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 16:25:36 -0400
Message-ID: <20110713202536.GE31965@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070405.GB18566@sigill.intra.peff.net>
 <7vipr66kmz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 22:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh60B-0001Gy-Kd
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 22:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab1GMUZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 16:25:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41537
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab1GMUZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 16:25:39 -0400
Received: (qmail 28712 invoked by uid 107); 13 Jul 2011 20:26:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 16:26:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 16:25:36 -0400
Content-Disposition: inline
In-Reply-To: <7vipr66kmz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177075>

On Wed, Jul 13, 2011 at 12:33:24PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +`metadata_cache_lookup_uint32`::
> > +`metadata_cache_add_uint32`::
> 
> I think these are "uint31" functions, as you cannot signal missing entry
> by returning a value with the MSB set if higher-end of uint32 range can be
> a valid value.

No, look at their definitions. I am careful not to assume we have a
sentinel value for "not found", and you must use them like:

  uint32_t value;
  if (metadata_cache_lookup_uint32(c, obj, &value))
          printf("value is %"PRIu32", value);
  else
          printf("value is not there");

> > +	if (c->validity_fun) {
> > +		c->validity_fun(validity);
> > +		if (hashcmp(validity, p))
> > +			return NULL;
> > +	}
> 
> Two comments.
> 
>  - I would have expected that c->validity_check() would be a way for a
>    caller to implement a boolean function to check the validity of the
>    cache, with another hook c->validity_token() to generate/update the
>    token. I could then use the 20-byte space to store a timestamp and
>    check can say "It was still 3-days ago? fresh enough", or something
>    like that. But this is not a complaint--such a scheme I wrote in the
>    above four lines may be _too_ flexible to be useful.

I started with exactly that interface, and came to the conclusion that
it was unneeded flexibility. I can switch it back, but there's really
not a need to at this point. The fact that there are 20 opaque bytes in
the file is what will live with us from version to version. But if new
code wants to be more flexible about how it checks the bytes, that is
something that can be changed easily when the new code is added.

>  - I wonder if validity_fn() callback wants a callback parameter (the
>    pointer "c" itself, after adding an extra field to metadata_cache that
>    stores the callback parameter pointer of type "void *" and adding a
>    parameter to METADATA_CACHE_INIT() macro to initialize it).

Neither this use nor my proposed patch-id cache would have a need for
it, so I didn't bother. And like above, it can be easily changed later.

> Other than that, this is looking fun ;-)

Thanks. I'm pleased with the performance numbers I'm getting. I'm still
a bit iffy on the alignment and aliasing issues in the first two
patches.

-Peff
