From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 29/33] refs: resolve symbolic refs first
Date: Fri, 13 May 2016 08:51:56 -0400
Message-ID: <20160513125155.GA24031@sigill.intra.peff.net>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
 <66d33af21bd1e398973414435af43d06f2e2099c.1462550456.git.mhagger@alum.mit.edu>
 <20160512074528.GB10922@sigill.intra.peff.net>
 <20160512082526.GA20817@sigill.intra.peff.net>
 <5735C990.8080502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 13 14:52:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1CZa-0000jr-FX
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 14:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbcEMMwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 08:52:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:39130 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751407AbcEMMv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 08:51:59 -0400
Received: (qmail 26982 invoked by uid 102); 13 May 2016 12:51:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 08:51:58 -0400
Received: (qmail 18700 invoked by uid 107); 13 May 2016 12:51:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 08:51:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 08:51:56 -0400
Content-Disposition: inline
In-Reply-To: <5735C990.8080502@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294529>

On Fri, May 13, 2016 at 02:33:20PM +0200, Michael Haggerty wrote:

> The problem in this case is a misguided call to
> verify_refname_available_dir() in the case that read_raw_ref() fails
> with ENOENT. In that case it is not possible for there to be a conflict
> with another loose reference, because (1) we already hold the lock, so
> the containing directory must exist, and (2) we got ENOENT, so there
> can't be a loose reference in a subdirectory named after the reference
> that we are trying to create.

Right, that makes perfect sense.

> As Peff explained, the call of verify_refname_available_dir() was
> forcing the loose tags to be loaded, which is expensive in this test
> because there are 100000 of them being created one at a time. (If they
> were created in a single ref_transaction instead, the "available" tests
> would all be done together, before any changes are committed, so the
> loose ref cache would not have to be invalidated each time.)

Yeah, I noticed that, too, and had to wonder whether we should make
"fetch" do a single ref transaction. I think the thing blocking that
(besides the obvious refactoring needed in fetch) is that transactions
are currently all-or-nothing. And fetch right now will do its best to
update whatever refs it can.

> Please note that there are still some calls of
> verify_refname_available_dir() against the loose reference cache in this
> function. If we wanted to give up a little bit on the quality of our
> error messages, I think we could make those paths faster, too. But they
> are all in failure paths, so I don't think that they are performance
> critical, so I won't make that change.

That's probably fine. I think the most pathological case becomes a fetch
a fetch where every other incoming ref is bogus. So, "refs/tags/2/nope",
"refs/tags/2-ok". And there are 100K of those (or whatever large number
you choose).

The bogus refs cause us to load the loose ref cache, and the successful
ones cause us to discard it. The result is still quadratic (it's just
n/2 squared). I have a hard time believing anybody would run into this
situation in practice, but I do wonder if somebody could cause
denial-of-service mischief. Probably not any more than they could cause
by other means (like sending a nasty diff case).

-Peff
