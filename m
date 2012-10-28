From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: avoid out-of-bounds memory access
Date: Sun, 28 Oct 2012 07:02:07 -0400
Message-ID: <20121028110207.GA11434@sigill.intra.peff.net>
References: <87k3ub4jjg.fsf@silenus.orebokech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Romain Francoise <romain@orebokech.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 12:02:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSQdR-0006dd-86
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 12:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab2J1LCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 07:02:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41253 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab2J1LCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 07:02:15 -0400
Received: (qmail 7769 invoked by uid 107); 28 Oct 2012 11:02:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 07:02:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 07:02:07 -0400
Content-Disposition: inline
In-Reply-To: <87k3ub4jjg.fsf@silenus.orebokech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208536>

On Sun, Oct 28, 2012 at 12:49:55AM +0200, Romain Francoise wrote:

> AddressSanitizer (http://clang.llvm.org/docs/AddressSanitizer.html)
> complains of a one-byte buffer underflow in parse_name_and_email() while
> running the test suite. And indeed, if one of the lines in the mailmap
> begins with '<', we dereference the address just before the beginning of
> the buffer when looking for whitespace to remove, before checking that
> we aren't going too far.
> 
> So reverse the order of the tests to make sure that we don't read
> outside the buffer.

Thanks, I think your fix is correct.

> diff --git a/mailmap.c b/mailmap.c
> index 47aa419..ea4b471 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -118,7 +118,7 @@ static char *parse_name_and_email(char *buffer, char **name,
>  	while (isspace(*nstart) && nstart < left)
>  		++nstart;
>  	nend = left-1;
> -	while (isspace(*nend) && nend > nstart)
> +	while (nend > nstart && isspace(*nend))
>  		--nend;

The fix confused me for a moment, because the problem is not actually in
the loop condition itself; working backwards from "nend > nstart", we
will at worst dereference nstart unnecessarily. The real problem is in
the "nend = left-1" above, which sets the loop precondition outside the
string to be examined.

So you could also check for "left == nstart" before the loop even
begins. I think your fix (to just make the loop more robust to that
precondition) is better, though, as the rest of the code does the right
thing with such a value of nend.

It looks like t4203 triggers this problem. Curious that valgrind does
not find it. I guess since it does not have compiler support, it cannot
find out-of-bound errors on stack buffers. Does the rest of the test
suite turn up clean with AddressSanitizer?

-Peff
