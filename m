From: Jeff King <peff@peff.net>
Subject: Re: concurrent fetches to update same mirror
Date: Wed, 5 Jan 2011 15:47:38 -0500
Message-ID: <20110105204738.GA7629@sigill.intra.peff.net>
References: <ig2kjt$f2u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 21:47:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaaGr-0006ri-S1
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941Ab1AEUrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:47:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab1AEUrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:47:41 -0500
Received: (qmail 750 invoked by uid 111); 5 Jan 2011 20:47:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 20:47:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 15:47:38 -0500
Content-Disposition: inline
In-Reply-To: <ig2kjt$f2u$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164593>

On Wed, Jan 05, 2011 at 02:33:36PM -0600, Neal Kreitzinger wrote:

> If two or more different users perform a git-fetch on the same mirror 
> (--mirror) repo concurrently, could that cause corruption?  I tried a manual 
> test using the git protocol over separate machines and they both thought 
> they needed to do the full updates and they both appeared to work.  I'm not 
> sure if git is serializing this, or if it is possible for concurrent fetches 
> to step on each other.

No, it shouldn't cause corruption, but it will cause wasted effort and
it may cause one to report failure. The fetch process gets all of the
objects first, and then updates the ref (so we never have refs that
point to object we didn't get yet). So both of the concurrent fetches
will see that we have a big set of objects to get and will work on
getting them at the same time, after which they will update the refs
appropriately (presumably to the same thing).

I haven't looked specifically at how fetch does locking, but usually the
procedure is to lock the ref, fetch the old value, unlock it, then do
some long-running task (like fetching objects), then lock again, check
that the old value didn't change out from under us, update it, then
unlock. In which case one of the fetches might see "oops, somebody
updated while we were fetching" and complain.

However, in the default configuration, we fetch using a "+" refspec,
which forces update of the ref even in the case of a non-fast-forward. I
don't know whether that force also would override any lock-checking.

-Peff
