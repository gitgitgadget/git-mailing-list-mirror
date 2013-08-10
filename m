From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: remove ternary operator evaluating always to true
Date: Sat, 10 Aug 2013 03:21:14 -0400
Message-ID: <20130810072114.GD30185@sigill.intra.peff.net>
References: <1375986704-11441-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 09:21:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V83UV-0007SS-Og
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 09:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758200Ab3HJHVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 03:21:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:54398 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757626Ab3HJHVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 03:21:16 -0400
Received: (qmail 28620 invoked by uid 102); 10 Aug 2013 07:21:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 02:21:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 03:21:14 -0400
Content-Disposition: inline
In-Reply-To: <1375986704-11441-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232076>

On Thu, Aug 08, 2013 at 08:31:44PM +0200, Stefan Beller wrote:

> The next occurrences are at:
> 	/* Never use a non-valid filename anywhere if at all possible */
> 	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
> 	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
> 
> 	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
> 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
> 
> In the last line of this block 'name_b' is dereferenced and compared
> to '/'. This would crash if name_b was NULL. Hence in the following code
> we can assume name_b being non-null.

I think your change is correct, but I find the reasoning above a little
suspect. It assumes that the second chunk of code (accessing name_a and
name_b) is correct, and pins the correctness of the code you are
changing to it. If the second chunk is buggy, then you are actually
making the code worse.

The interesting part is the top chunk, which aliases the names if one of
them is NULL. And there is an implicit assumption there that we will
never get _two_ NULL names in this function. And that is why the second
chunk does not ever crash (and why your change is the right thing to
do).

Sorry if this seems nit-picky. It is just that seemingly trivial
cleanups can sometimes end up revealing larger bugs, and I think it is
worth making sure we understand the root cause to be sure that our
cleanup really is trivial.

I wonder if the implicit expectation of the function to take at least
one non-NULL name would be more obvious if the first few lines were
written as:

  if (DIFF_FILE_VALID(one)) {
          if (!DIFF_FILE_VALID(two))
                  name_b = name_a;
  } else if (DIFF_FILE_VALID(two))
          name_a = name_b;
  else
          die("BUG: two invalid files to diff");

That covers all of the cases explicitly, though it is IMHO uglier to
read (and there is still an implicit assumption that the name is
non-NULL if DIFF_FILE_VALID() is true).

-Peff
