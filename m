From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] Fix some reference-related races
Date: Thu, 20 Jun 2013 07:52:22 -0400
Message-ID: <20130620115221.GA773@sigill.intra.peff.net>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
 <20130619185645.GB23647@sigill.intra.peff.net>
 <51C2C6DD.90107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 20 13:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpdPk-0007LG-7f
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 13:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965522Ab3FTLw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 07:52:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:56116 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965044Ab3FTLw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 07:52:27 -0400
Received: (qmail 14211 invoked by uid 102); 20 Jun 2013 11:53:26 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 06:53:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 07:52:22 -0400
Content-Disposition: inline
In-Reply-To: <51C2C6DD.90107@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228483>

On Thu, Jun 20, 2013 at 11:09:49AM +0200, Michael Haggerty wrote:

> If the packed-refs file is already locked by another process (and there
> is no reason why that cannot be, and there is only one attempt to
> acquire the lock), then repack_without_ref() emits an error and returns
> with an error code.  delete_ref() passes the error along, but doesn't
> restore the loose ref.
>
> [...]
>
> I think this problem would also be fixed by the locking scheme that I
> proposed earlier [1]: to acquire and hold the packed-refs lock across
> the modification of *both* files, and to rewrite the packed-refs file
> *before* deleting the loose-refs file (because rewriting the packed-refs
> file without the to-be-deleted reference is a logical NOP).

Yeah, I agree. You could also "roll back" the loose deletion, but I'd
rather just try to do it atomically.

I don't think this increases lock contention, since delete_ref would
need to lock the packed-refs file anyway. However, there is the related
change that we should probably lock the packed-refs file before checking
"is this ref in the packed-refs file?" in repack_without_ref. Which does
increase lock contention, but is more correct.

We should also consider deadlock issues. If the order is always "acquire
packed-refs lock, then acquire loose locks", we are fine. If this does
loose-then-packed, we are also fine with the current code, as
git-pack-refs does not prune the loose refs while under the packed-refs
lock. But I seem to recall discussion of pruning them under the
packed-refs lock, which would deadlock if repack_without_ref does
loose-then-packed.

But I guess we do not actually block on locks, but rather just die (and
release our locks), so deadlock is not an option for us.

-Peff
