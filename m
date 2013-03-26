From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Tue, 26 Mar 2013 16:39:14 -0400
Message-ID: <20130326203914.GA29167@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-3-git-send-email-gitster@pobox.com>
 <20130326185559.GB26462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaep-0002k6-7P
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab3CZUjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:39:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40673 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130Ab3CZUjT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:39:19 -0400
Received: (qmail 7612 invoked by uid 107); 26 Mar 2013 20:41:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 16:41:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 16:39:14 -0400
Content-Disposition: inline
In-Reply-To: <20130326185559.GB26462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219203>

On Tue, Mar 26, 2013 at 02:55:59PM -0400, Jeff King wrote:

> >  * Otherwise, make sure we use only the counted part of the strings
> >    when calling fnmatch_icase().  Because these counted strings are
> >    full strings most of the time, avoid unnecessary allocation.
> 
> I think this is OK, with the intention that we would eventually drop the
> allocations from your third bullet point in favor of using a
> byte-counted version of fnmatch (i.e., nwildmatch). But until then we're
> going to see a performance drop.
> 
> The pattern is usually going to be NUL-terminated at the length counter,
> but every time we feed a directory, it's going to run into this
> allocation. And we do it once for _every_ directory against _every_
> wildcard gitignore pattern. So I think it is probably going to be
> measurable. I guess we can try measuring it on something like WebKit,
> which has plenty of both directories and gitattributes.

I timed this doing "git archive HEAD" on webkit.git before and after. It
actually ended up not mattering much (I think because it is only the
directories which are affected, not each individually path, so it's a
much smaller number than you'd think). The best-of-five timing was
slightly slower, but was within the noise.

So I do still think it would make sense to go to a byte-limited version
of fnmatch eventually, just for code cleanliness and predictability of
performance, but this is really not a bad solution in the interim.

-Peff
