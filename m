From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Change "refs/" references to symbolic constants
Date: Mon, 1 Oct 2007 21:16:59 -0400
Message-ID: <20071002011659.GA7938@coredump.intra.peff.net>
References: <200709291359.59147.andyparkins@gmail.com> <200710012141.44459.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 03:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcWOc-00087H-Uw
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 03:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbXJBBRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 21:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbXJBBRF
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 21:17:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3210 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbXJBBRE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 21:17:04 -0400
Received: (qmail 20356 invoked by uid 111); 2 Oct 2007 01:17:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Oct 2007 21:17:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2007 21:16:59 -0400
Content-Disposition: inline
In-Reply-To: <200710012141.44459.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59653>

On Mon, Oct 01, 2007 at 09:41:43PM +0100, Andy Parkins wrote:

> Please hold off on applying this.  I'm getting this when running the tests:
> 
> *** t5516-fetch-push.sh ***
> *   ok 1: setup
> *   ok 2: fetch without wildcard
> *   ok 3: fetch with wildcard
> *   ok 4: push without wildcard
> *   ok 5: push with wildcard
> *   ok 6: push with matching heads
> *   ok 7: push with no ambiguity (1)
> *   ok 8: push with no ambiguity (2)
> *   ok 9: push with weak ambiguity (1)
> *   ok 10: push with weak ambiguity (2)
> *   ok 11: push with ambiguity (1)
> * FAIL 12: push with ambiguity (2)
> 
> I'm having trouble seeing where the fault is at the moment though.

>From your patch:

-		    patlen != namelen - 5 &&
-		    prefixcmp(name, "refs/heads/") &&
-		    prefixcmp(name, "refs/tags/")) {
+		    patlen != namelen - STRLEN_PATH_REFS_HEADS &&
+		    prefixcmp(name, PATH_REFS_HEADS) &&
+		    prefixcmp(name, PATH_REFS_HEADS)) {

This is totally bogus. You meant STRLEN_PATH_REFS, and the second path
should be PATH_REFS_TAGS. With those changes, t5516 passes.

I haven't combed through your patch in detail, so there might be similar
problems lurking. I did notice one or two spots where you call
strlen(PATH_REFS_*), which should of course also be changed to
STRLEN_PATH_REFS_*.

And as a final comment, your patch doesn't apply to next at all because
of the reorganization of the fetching API (e.g., fetch-pack.c doesn't
exist at all anymore). You should probably prepare a parallel patch for
next.

-Peff
