From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: arbitrary number of matches for --unset and
 --replace-all
Date: Thu, 14 Nov 2013 03:37:47 -0500
Message-ID: <20131114083747.GD16327@sigill.intra.peff.net>
References: <CAPig+cQZo0R3q=J2BygTfdJ1uuiT1HPDCjTxt8mykxOXM1uf2Q@mail.gmail.com>
 <9bc62ec0072a0513865f39ba287819dd0d9d606d.1384415180.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jess Hottenstein <jess.hottenstein@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 14 09:37:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgsQz-0003a6-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 09:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab3KNIht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 03:37:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:38985 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751284Ab3KNIht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 03:37:49 -0500
Received: (qmail 30906 invoked by uid 102); 14 Nov 2013 08:37:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 02:37:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 03:37:47 -0500
Content-Disposition: inline
In-Reply-To: <9bc62ec0072a0513865f39ba287819dd0d9d606d.1384415180.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237820>

On Thu, Nov 14, 2013 at 08:50:43AM +0100, Thomas Rast wrote:

> git-config used a static match array to hold the matches we want to
> unset/replace when using --unset or --replace-all.  Use a
> variable-sized array instead.
> 
> This in particular fixes the symptoms git-svn had when storing large
> numbers of svn-remote.*.added-placeholder entries in the config file.
> 
> While the tests are rather more paranoid than just --unset and
> --replace-all, the other operations already worked.  Indeed git-svn's
> usage only breaks the first time *after* creating so many entries,
> when it wants to unset and re-add them all.
> 
> Reported-by: Jess Hottenstein <jess.hottenstein@gmail.com>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>

This looks good to me.

I agree with your earlier assessment that adding tons of config keys is
probably a bad idea. It's not just slow when looking up those keys, but
it also slows down every single git operation (which might read config
many times, if it is a script).  Still, we should at least do the right
thing in the face of such config.

> @@ -1260,11 +1259,15 @@ static int store_aux(const char *key, const char *value, void *cb)
>  		 * Do not increment matches: this is no match, but we
>  		 * just made sure we are in the desired section.
>  		 */
> +		ALLOC_GROW(store.offset, store.seen+1,
> +			   store.offset_alloc);
>  		store.offset[store.seen] = cf->do_ftell(cf);
>  		/* fallthru */
>  	case SECTION_END_SEEN:
>  	case START:
>  		if (matches(key, value)) {
> +			ALLOC_GROW(store.offset, store.seen+1,
> +				   store.offset_alloc);
>  			store.offset[store.seen] = cf->do_ftell(cf);
>  			store.state = KEY_SEEN;
>  			store.seen++;

This code is weird to follow because of the fall-throughs. I do not
think you have introduced any bugs with your patch, but it seems weird
to me that we set the offset at the top of the hunk. If we hit the
conditional in the bottom half, we do actually increment storer.seen,
but only _after_ having overwritten the value from above (with the same
value, no less).

But if we do not follow that code path, we may end up here:

> @@ -1272,6 +1275,9 @@ static int store_aux(const char *key, const char *value, void *cb)
>  			if (strrchr(key, '.') - key == store.baselen &&
>  			      !strncmp(key, store.key, store.baselen)) {
>  					store.state = SECTION_SEEN;
> +					ALLOC_GROW(store.offset,
> +						   store.seen+1,
> +						   store.offset_alloc);
>  					store.offset[store.seen] = cf->do_ftell(cf);
>  			}
>  		}

where we overwrite it again, but do not update store.seen. Or we may
trigger neither, and leave the function with our offset stored, but
store.seen not incremented.

So it seems odd to me that we would set the offset, but in some cases
never actually increment our counter. AFAICT, we do not ever access
those values. The reader limits itself to "i < store.seen", which makes
sense. And the writers always call a fresh ftell before incrementing
store.seen.  But maybe I am missing something.

Anyway, it is neither here nor there for your patch. Just something odd
I noticed while reading the code.

> +setup_many() {
> +	setup &&
> +	# This time we want the newline so that we can tack on more
> +	# entries.
> +	echo >>.git/config &&
> +	# Semi-efficient way of concatenating 5^5 = 3125 lines. Note
> +	# that because 'setup' already put one line, this means 3126
> +	# entries for section.key in the config file.
> +	cat >5to1 <<EOF &&
> +  key = foo
> +  key = foo
> +  key = foo
> +  key = foo
> +  key = foo
> +EOF
> +	cat 5to1 5to1 5to1 5to1 5to1 >5to2 &&	   # 25
> +	cat 5to2 5to2 5to2 5to2 5to2 >5to3 &&	   # 125
> +	cat 5to3 5to3 5to3 5to3 5to3 >5to4 &&	   # 635
> +	cat 5to4 5to4 5to4 5to4 5to4 >>.git/config # 3125
> +}

You could make this even more semi-efficient by just storing the end
result in 5to5, and then copying it into place rather than doing the
whole dance for each test. I doubt it matters that much, though.

-Peff
