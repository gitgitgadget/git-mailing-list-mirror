From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: handle errors on setting tracking branches
Date: Thu, 24 Sep 2015 10:05:38 -0400
Message-ID: <20150924140538.GA11666@sigill.intra.peff.net>
References: <1443090721-14519-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu Sep 24 16:06:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf79q-0007gn-CY
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 16:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116AbbIXOFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 10:05:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:35659 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756335AbbIXOFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 10:05:41 -0400
Received: (qmail 18575 invoked by uid 102); 24 Sep 2015 14:05:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 09:05:41 -0500
Received: (qmail 25427 invoked by uid 107); 24 Sep 2015 14:05:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 10:05:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 10:05:38 -0400
Content-Disposition: inline
In-Reply-To: <1443090721-14519-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278546>

On Thu, Sep 24, 2015 at 12:32:01PM +0200, Patrick Steinhardt wrote:

> The function `install_branch_config`, which is used to set up
> tracking branches, does not verify return codes of
> `git_config_set`. Due to this we may incorrectly print that a
> tracking branch has been set up when in fact we did not due to an
> error.
> 
> Fix this by checking the return value of `git_config_set` and
> returning early in the case of an error. The
> `install_branch_config` function has been changed to return an
> error code that reflects whether it has been successful.

I think it's nice to tell the user when something has gone wrong, so in
that sense this is a good change. Though git_config_set does already
print something, so the main improvement here is passing up the error
code from install_branch_config. What happens to that error?

I count 4 callers in the current code, and none of them currently looks
at the return value. Your patch updates setup_tracking() to propagate
the error, which is good. But that is called from exactly one place,
create_branch(), which also ignores the outcome. :-/

I don't think we want to die() when the config fails. That might be the
right thing for "branch --set-upstream-to", but probably not for
"checkout -b". I think we need to look at each call site and see whether
we should be propagating the error back. With the hope that we would
ultimately affect the exit code of the command.

In the case of branch creation, we are in a two-step procedure: create
the branch, then set up its tracking config. We _could_ rollback the
first step when the second step fails, but that is probably not worth
the complication.

> Actually, there are quite a few places where we don't check the
> return values of git_config_set and related functions. I didn't
> go through them yet, but might do so if you deem this to be of
> value.

I think more error-checking is better than less. But I do think it's
worth plumbing through the error codes in each case.

It's tempting to just die() when the operation fails, but as discussed
above, that's not always the most appropriate thing.

>  branch.c | 24 ++++++++++++++++--------
>  branch.h |  3 ++-
>  2 files changed, 18 insertions(+), 9 deletions(-)

The patch itself looks OK to me from a cursory read.

-Peff
