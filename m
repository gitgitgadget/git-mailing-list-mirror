From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] attr.c::path_matches(): special case paths that end
 with a slash
Date: Tue, 26 Mar 2013 17:33:19 -0400
Message-ID: <20130326213319.GA3058@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-4-git-send-email-gitster@pobox.com>
 <20130326190558.GC26462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:33:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbVD-0006UQ-2f
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab3CZVdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:33:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40730 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab3CZVdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:33:23 -0400
Received: (qmail 8230 invoked by uid 107); 26 Mar 2013 21:35:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 17:35:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 17:33:19 -0400
Content-Disposition: inline
In-Reply-To: <20130326190558.GC26462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219213>

On Tue, Mar 26, 2013 at 03:05:58PM -0400, Jeff King wrote:

> On Tue, Mar 26, 2013 at 11:39:30AM -0700, Junio C Hamano wrote:
> 
> > A similar adjustment for match_pathname() might be needed, but I
> > didn't look into it.
> 
> I notice that match_pathname takes _two_ lengths for the pattern: the
> nowildcardlen (called "prefix", and the full patternlen). But the first
> thing it does is:
> 
>   if (*pattern == '/') {
>           pattern++;
>           prefix--;
>   }
> 
> which seems obviously wrong, as patternlen should be dropped, too. But
> we do not seem to look at patternlen at all! I think we can drop the
> parameter totally.
> 
> We do seem to use strncmp_icase through the rest of the function,
> though, which should be OK. The one exception is that we call fnmatch at
> the end. Should the allocation hack from the previous patch make its way
> into an "fnmatch_icase_bytes()" function, so we can use it here, too?
> And then when we have a more efficient solution, we can just plug it in
> there.

Hmm. match_pathname does have this:

        /*
         * baselen does not count the trailing slash. base[] may or
         * may not end with a trailing slash though.
         */
        if (pathlen < baselen + 1 ||
            (baselen && pathname[baselen] != '/') ||
            strncmp_icase(pathname, base, baselen))
                return 0;

which seems to imply that the trailing slash is important here, and that
we should not drop it when passing the path to match_pathname. I'm
still trying to figure out exactly what it is that the extra slash check
is for, and whether it might not have the same problem.

-Peff
