From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document khash
Date: Thu, 28 Nov 2013 05:35:55 -0500
Message-ID: <20131128103555.GA14615@sigill.intra.peff.net>
References: <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
 <ccce08818b6856f67a5316eba148d5a860d1d8f7.1385391631.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 28 11:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlyx0-000893-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 11:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398Ab3K1Kf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 05:35:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:47126 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754031Ab3K1Kf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 05:35:57 -0500
Received: (qmail 25037 invoked by uid 102); 28 Nov 2013 10:35:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Nov 2013 04:35:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Nov 2013 05:35:55 -0500
Content-Disposition: inline
In-Reply-To: <ccce08818b6856f67a5316eba148d5a860d1d8f7.1385391631.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238490>

On Mon, Nov 25, 2013 at 04:04:48PM +0100, Thomas Rast wrote:

> > I think I'll also lend you a hand writing Documentation/technical/api-khash.txt
> > (expect it tomorrow) so that we also have documentation in the git
> > style, where gitters can be expected to find it on their own.
> 
> Here goes.

Thanks. Some comments below.

> > Furthermore, would it be a problem to name the second hash sha1_int
> > instead?  I have another use for such a hash, and I can't imagine I'm
> > the only one.  (That's not critical however, I can do the required
> > editing in that other series.)
> 
> Actually, let's not do that.  Since everything is 'static inline'
> anyway, there's no cost to simply instantiating more hashes as needed.

Yeah. If we cared about code duplication, we'd have to split it into
declaration and definition macros, and then collect the definitions in
one .c file (khash does support this, but we don't use it). I don't
think we are using enough repeated ones to make it matter, and most of
the functions benefit from inlining anyway.

> +------------
> +#import "khash.h"
> +KHASH_INIT(NAME, key_t, value_t, is_map, key_hash_fn, key_equal_fn)
> +------------

#import?

> +The arguments are as follows:
> [...]
> +`khint_t key_hash_fn(key_t)`::
> +	Hash function.

It is true that this is a khint_t, but I do not think knowing that helps
the caller. They need to design a hash function, so knowing the size and
type of the hint helps. Maybe:

  Return a hash value for a key. The khint_t is a 32-bit unsigned value.
  Git provides __kh_oid_hash, which converts a sha1 into a hash value.

> +`int key_equal_fn(key_t a, key_t b)`::
> +	Comparison function.  Return 1 if the two keys are the same, 0
> +	otherwise.

Here we provide __kh_oid_cmp, and we should mention it. Based on recent
discussions, this should probably be __kh_oid_equal, since it is not a
"cmp" function in the ordering sense.

> +`khint_t kh_get_NAME(const kh_NAME_t *hash, key_t key)`::
> +	Find the given key in the hash table.  The returned khint_t
> +	should be treated as an opaque iterator token that indexes
> +	into the hash.  Use `kh_value` to get the value from the
> +	token.  If the key does not exist, returns kh_end(hash).

I do not know of the khash author's intention, but in the bitmap code we
prefer khiter_t to represent an iterator. It is the same as a khint_t,
but I think that is an implementation detail (and the khash functions
should probably be returning a khiter_t).

> [...]

The rest of it looks correct to me.

-Peff
