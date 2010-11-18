From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Thu, 18 Nov 2010 12:50:08 -0500
Message-ID: <20101118175007.GA26505@sigill.intra.peff.net>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:50:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8cy-00073f-Km
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759996Ab0KRRuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:50:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43075 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755363Ab0KRRuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:50:12 -0500
Received: (qmail 17361 invoked by uid 111); 18 Nov 2010 17:50:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 17:50:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 12:50:08 -0500
Content-Disposition: inline
In-Reply-To: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161695>

On Thu, Nov 18, 2010 at 08:39:17AM +0100, Jan Hudec wrote:

> What happened is that the push took the values of all the
> refs -- including those in refs/remotes/svn as it's a mirror
> for pushing them to the backup. Meanwhile the fetch udpated
> them. But when the push finished with the remote repo, it
> updated the local refs back to the values it pushed, undoing
> the effects of that fetch.

Hrm. There are actually two issues here, I think.

What is happening, I believe, is that push is trying to
opportunistically update your local tracking branches.

So the first issue is that you do not have the usual branches-in-heads,
tracking-branches-in-remotes setup. Instead it is looking at your fetch
refspec:

>     [remote "backup"]
> 	url = /mnt/server/path/to/repo.git
> 	fetch = +refs/*:refs/*
> 	mirror = true

and trying to update everything in refs/* with what it just pushed.
Usually this is a no-op, since it is the same as the value we just
pushed, but as you found out, it is in a race with concurrent commands.

I think we don't want to be doing the opportunistic update in this case.
But what is the correct rule for deciding not to do it? I can think of a
few possibilities:

 1. When the mirror option is used. But this doesn't help people who
    have a broad fetch refspec they have configured without mirror.

 2. When the RHS of a fetch refspec is something that is being pushed.
    But this doesn't cover the case of pushing local "refs/heads/foo" to
    remote "refs/heads/bar", and then having it update "refs/heads/bar"
    locally.

 3. When the ref to be updated is not in refs/remotes. This feels a
    little hack-ish, but I think would work the best in practice. The
    refs/remotes hierarchy is supposed to just be a cache of remote
    state, so really it is the only place such an opportunistic update
    should be safe. People who are doing exotic things like fetching
    directly into refs/heads will have to live without the opportunistic
    update.

The second issue I mentioned is that transport_update_tracking_ref does
not actually check the old sha1 of the ref it is updating. The usual
practice in git to avoid holding long locks is:

  1. lock ref, read sha1, unlock ref
  2. do stuff to make a new sha1, remembering old sha1
  3. lock ref, read sha1, check that it equals old sha1, write new sha1,
     unlock

We don't do that here. It is tempting to do something like:

diff --git a/transport.c b/transport.c
index 0078660..02212fb 100644
--- a/transport.c
+++ b/transport.c
@@ -605,7 +605,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 			delete_ref(rs.dst, NULL, 0);
 		} else
 			update_ref("update by push", rs.dst,
-					ref->new_sha1, NULL, 0, 0);
+					ref->new_sha1, ref->old_sha1, 0, 0);
 		free(rs.dst);
 	}
 }

but that is not right. That is saying "if we updated the remote ref R
from A to B, update the tracking ref of R to B only if it is at A".
However, our tracking ref of R is not necessarily at A; it might be
stale with respect to upstream.

So really we would need to read the current value of the tracking ref at
the beginning of the push. But that is inefficient, and it is not
actually atomic with the push we are doing.

So I think it is OK to keep this the way it is, and assume that
update_tracking_ref is about overwriting whatever is there. The real
problem in your case is that the things it is overwriting are actually
precious heads, not just a remote cache.

-Peff
