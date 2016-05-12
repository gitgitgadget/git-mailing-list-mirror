From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 29/33] refs: resolve symbolic refs first
Date: Thu, 12 May 2016 04:25:26 -0400
Message-ID: <20160512082526.GA20817@sigill.intra.peff.net>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
 <66d33af21bd1e398973414435af43d06f2e2099c.1462550456.git.mhagger@alum.mit.edu>
 <20160512074528.GB10922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 12 10:25:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0lw9-0003t1-K9
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 10:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbcELIZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 04:25:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:38453 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752524AbcELIZa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 04:25:30 -0400
Received: (qmail 5300 invoked by uid 102); 12 May 2016 08:25:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 04:25:29 -0400
Received: (qmail 7736 invoked by uid 107); 12 May 2016 08:25:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 04:25:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 04:25:26 -0400
Content-Disposition: inline
In-Reply-To: <20160512074528.GB10922@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294403>

On Thu, May 12, 2016 at 03:45:28AM -0400, Jeff King wrote:

> So I'd expect us to hit that lock_ref_for_update() for each of the new
> refs. But then we end up in verify_refname_available_dir(), which wants
> to read all of the loose refs again. So we end up with a quadratic
> number of calls to read_ref_full().
> 
> I haven't found the actual bug yet. It may be something as simple as not
> clearing REF_INCOMPLETE from the loose-ref cache when we ought to. But
> that's a wild (optimistic) guess.

Ah, nope, nothing so simple.

It looks like we get in a chain of:

  1. we want to update a ref, so we end up in
     verify_refname_available_dir to make sure we can do so.

  2. that has to load all of the loose refs in refs/tags, which is
     expensive.

  3. we actually update the ref, which calls clear_loose_ref_cache().

And repeat. Each ref update does the expensive step 2, and it gets
larger and larger each time.

I understand why we need to verify_refname_available() on the packed
refs. But traditionally we would rely on EISDIR or EEXIST to detect
conflicts with the loose refs, rather than loading using our own cache.
So I guess that's the new thing that is causing a problem.

-Peff
