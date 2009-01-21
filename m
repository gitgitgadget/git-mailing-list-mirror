From: Jeff King <peff@peff.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 11:19:40 -0500
Message-ID: <20090121161940.GA20702@coredump.intra.peff.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <49773240.7090605@drmicha.warpmail.net> <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com> <49773E48.90302@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 17:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfpD-0003Ug-RW
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbZAUQTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbZAUQTn
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:19:43 -0500
Received: from peff.net ([208.65.91.99]:42275 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbZAUQTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:19:42 -0500
Received: (qmail 15751 invoked by uid 107); 21 Jan 2009 16:19:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 11:19:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 11:19:40 -0500
Content-Disposition: inline
In-Reply-To: <49773E48.90302@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106625>

On Wed, Jan 21, 2009 at 04:24:56PM +0100, Michael J Gruber wrote:

> So, you get these errors on the local repo when dealing with the remote
> repo, right? I guess this means two things:
> 
> 1) You are deleting a remote branch

Actually, he doesn't have to delete the remote branch; somebody else
can. The problem is that the HEAD pointer for his remote tracking
branches points to a branch that doesn't exist. This can happen because
we sometimes update the tracking branches (including deletion) without
impacting the HEAD pointer.

There are two ways that I can think of (and there may be more) to
provoke this:

  1. delete a remote branch via push. The local side will helpfully
     delete your local tracking branch to match what happened on the
     remote. If it was the remote's HEAD, then you get a broken state
     (and while we discourage pushing to the remote HEAD on a non-bare
     repo, it is perfectly OK for a bare one).

  2. somebody else deletes the remote branch that is the HEAD, and you
     update your tracking branches via "git remote prune", which deletes
     your tracking branches corresponding to any deleted remote branches.

And actually there is a slight variant on both of the above. The deleted
branch does not actually have to be the current HEAD on the remote. It
just has to match your _idea_ of the current HEAD on the remote, which
may be out of date.

Situation (1) happens entirely locally. So it can be fixed fairly easily
by checking whether the remote tracking HEAD points to a branch we are
deleting, and deleting the HEAD in that case (the code should be in
builtin-send-pack.c:update_tracking_ref). Of course you have probably
also created a broken situation on the remote, so perhaps receive-pack
should handle that.

Situation (2) could do something similar: when we see that we are about
to delete the ref pointed to by the remote tracking HEAD, we could
delete the HEAD.

But both situations are a little hack-ish to me. You are deleting the
HEAD because you don't know what the right value is from the remote end.
A better fix would be to actually pull the HEAD information down during
fetch. And I seem to recall a patch about that at some point (it
required a new protocol extension), but I don't know what become of it.

However, even if we kept the tracking HEAD totally in sync with the
remote's HEAD, it still may be possible that the remote HEAD is broken.
In which case it might be nice to detect that when pulling it down and
just leave the tracking HEAD unset.

-Peff
