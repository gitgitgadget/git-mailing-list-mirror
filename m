From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as
	errors.
Date: Thu, 19 Jun 2008 09:37:48 -0400
Message-ID: <20080619133747.GA31209@sigill.intra.peff.net>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 15:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9KLy-0000ZD-3H
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 15:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYFSNhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 09:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbYFSNhv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 09:37:51 -0400
Received: from peff.net ([208.65.91.99]:2392 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbYFSNhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 09:37:50 -0400
Received: (qmail 18442 invoked by uid 111); 19 Jun 2008 13:37:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 19 Jun 2008 09:37:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2008 09:37:48 -0400
Content-Disposition: inline
In-Reply-To: <1213872715-11182-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85473>

On Thu, Jun 19, 2008 at 12:51:55PM +0200, Pierre Habouzit wrote:

> It's really painful to have git push error out when it's just that one of
> your tracking branches isn't up to date with respect to a remote branch.
> 
> Let just add a new status: "lagging", always print it to screen when we're
> lagging, but don't exit with a non 0 value, as it really alarms users.

This has been discussed before, and the suggested term was "stale".

Check out:

  http://thread.gmane.org/gmane.comp.version-control.git/73038/focus=73186

which is uncannily identical (the difference is the name, and that I
don't show the lagged branches unless -v is given).

Among the issues that were not sorted out last time:

  - should stale branches be shown without -v?

  - calling ref_newer here is inefficient, since we have already called
    it in the other direction. We should probably do the traversal once
    in such a way as to find out which ref is newer (or if it is
    indeterminate).

  - there is a possible danger with "git push -f", in that you force
    both rejected branches as well as stale branches. Junio and I
    discussed the possibility of disallowing "-f" unless the user
    explicitly requested _what_ to push; i.e., --all, --matching,
    --mirror, or a refspec. See:

      http://thread.gmane.org/gmane.comp.version-control.git/74425/focus=74481

I was considering resurrecting my patch after working up that safety
valve.

-Peff
