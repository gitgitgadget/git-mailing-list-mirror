From: Jeff King <peff@peff.net>
Subject: Re: renaming remote branches
Date: Thu, 16 Apr 2009 02:59:34 -0400
Message-ID: <20090416065934.GA20071@coredump.intra.peff.net>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 09:01:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuLb0-00037A-Ed
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 09:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbZDPG7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 02:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbZDPG7k
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 02:59:40 -0400
Received: from peff.net ([208.65.91.99]:56747 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbZDPG7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 02:59:39 -0400
Received: (qmail 553 invoked by uid 107); 16 Apr 2009 06:59:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 02:59:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 02:59:34 -0400
Content-Disposition: inline
In-Reply-To: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116675>

On Thu, Apr 16, 2009 at 12:27:31PM +0900, Miles Bader wrote:

> I can "rename" a remote branch by doing:
> 
>    git push REMOTE REMOTE/OLD:refs/heads/NEW
>    git push REMOTE :OLD
> 
> is there any better way to do this (I mean, er... more
> user-friendly/less-dangerous/... I dunno... "better" :-)?

No, the git protocol doesn't know about moving refs at all, so you are
stuck with creation and deletion (and the creation, as you noticed, is
even more painful because we don't guess that "NEW" is going to be a
branch, so you are stuck saying "refs/heads/").

Not only is this not user-friendly, but it does not preserve any branch
config or reflog at the remote (both things that "branch -m" does).

In your situation, I would probably do:

  ssh remote-host 'cd remote-dir && git branch -m OLD NEW'

but that is not always an option, depending on your setup.

> Also, I note that the old name ("OLD") remains in .git/info/refs, both
> locally and in the remote; is this a problem?  I can update the local
> .git/info/refs by running "git update-server-info", but I'm not sure how
> to do in for the remote repo without having a login there...

If you are not sharing your repo over a dumb transport (like http), then
the contents of .git/info/refs shouldn't matter. If you are, then you
should enable the post-update hook to run update-server-info after every
push (i.e., it is not just the deletion that is a problem, but none of
your pushes is being marked in .git/info/refs).

-Peff
