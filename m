From: Jeff King <peff@peff.net>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Fri, 22 Mar 2013 17:24:21 -0400
Message-ID: <20130322212421.GA5079@sigill.intra.peff.net>
References: <513A7D80.5000501@bernhard-posselt.com>
 <20130309044850.GB12167@sigill.intra.peff.net>
 <513B14EC.4040504@bernhard-posselt.com>
 <20130310070505.GA15324@sigill.intra.peff.net>
 <513C7267.2090608@bernhard-posselt.com>
 <20130311051840.GB13510@sigill.intra.peff.net>
 <51484125.9000307@bernhard-posselt.com>
 <20130319134452.GA6752@sigill.intra.peff.net>
 <7vobefjs26.fsf@alter.siamese.dyndns.org>
 <7vip4j71dw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bernhard Posselt <mail@bernhard-posselt.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9SM-00051J-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423302Ab3CVVYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:24:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36128 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423296Ab3CVVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:24:30 -0400
Received: (qmail 5383 invoked by uid 107); 22 Mar 2013 21:26:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 17:26:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 17:24:21 -0400
Content-Disposition: inline
In-Reply-To: <7vip4j71dw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218849>

On Fri, Mar 22, 2013 at 11:08:59AM -0700, Junio C Hamano wrote:

> This may be sufficient.  In the olden days, we relied on that all
> whitespace fixing rules made the result shorter and took advantage
> of it in update-pre-post-images to rewrite the images in place.  The
> oddball tab-in-indent (aka Python), however, can grow the result by
> expanding tabs (deemed "incorrect") in the input into runs of spaces
> (deemed "kosher").
> 
> Fortunately, we already support its more generalized form "match
> while ignoring whitespace differences" that can lengthen the result;
> as long as we correctly count the number of bytes needed to hold
> rewritten postimage, the existing logic in update_pre_post_images
> should be able to do the rest for us.

Yeah, your patch looks right to me. I do wonder if the optimization
here:

> @@ -2399,8 +2401,10 @@ static int match_fragment(struct image *img,
>  	 * hunk match.  Update the context lines in the postimage.
>  	 */
>  	fixed_buf = strbuf_detach(&fixed, &fixed_len);
> +	if (postlen < postimage->len)
> +		postlen = 0;
>  	update_pre_post_images(preimage, postimage,
> -			       fixed_buf, fixed_len, 0);
> +			       fixed_buf, fixed_len, postlen);

should simply go into update_pre_post_images (i.e., let it decide on
whether to do it inline or with a new allocation, rather than making
postlen==0 special). That would let the ignore-whitespace code path use
the optimization, too (when it's possible).

By the way, I notice that when update_pre_post_images does allocate, the
old value of postimage->buf is lost. It looks like that is not leaked,
because it was pointing to a strbuf (newlines in apply_one_fragment)
that we are going to release anyway afterwards. But that means nobody is
freeing postimage->buf, which means that our newly malloc'd version is
getting leaked.

-Peff
