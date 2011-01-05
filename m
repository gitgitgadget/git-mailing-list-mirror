From: Jeff King <peff@peff.net>
Subject: Re: concurrent fetches to update same mirror
Date: Wed, 5 Jan 2011 16:13:14 -0500
Message-ID: <20110105211313.GB7808@sigill.intra.peff.net>
References: <ig2kjt$f2u$1@dough.gmane.org>
 <20110105204738.GA7629@sigill.intra.peff.net>
 <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com>
 <20110105205324.GA7808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 05 22:13:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paafc-00064D-Iz
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 22:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab1AEVNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 16:13:17 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52959 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab1AEVNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 16:13:16 -0500
Received: (qmail 1208 invoked by uid 111); 5 Jan 2011 21:13:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 21:13:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 16:13:14 -0500
Content-Disposition: inline
In-Reply-To: <20110105205324.GA7808@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164597>

On Wed, Jan 05, 2011 at 03:53:25PM -0500, Jeff King wrote:

> > If both fetch processes try to update the same ref at the same time,
> > one will get the lock and continue, and the other will crash with an
> > error (because the lock was busy).  If one is slightly slower than the
> > other, they will probably update the refs twice, with the slower fetch
> > updating what the faster one had just updated.  :-)
> 
> I assumed it would take the "old" value at the very beginning of the
> fetch (before talking with the remote), and then see that the ref was
> changed under our feet. Or does it simply do it at the end?

Hmm. Weirder even, builtin/fetch.c:s_update_ref takes a "check_old"
flag, and we do always use it for branch updates. But not for tag
updates. I can't think of why. The code blames all the way back to the
original builtin-fetch.

Anyway, when we do check, we check the value from the beginning of the
fetch. So you can get lock conflicts. For example, doing this:

  mkdir repo && cd repo && git init
  echo contents >foo && git add . && git commit -m one
  git update-ref refs/remotes/origin/master refs/heads/master
  git remote add origin some-remote-repo-that-takes-a-few-seconds
  xterm -e 'git fetch -v; read' & xterm -e 'git fetch -v; read'

I.e., putting some cruft into the ref and then updating it. One fetch
will force-write over the ref properly:

   + ac32203...4e64590 master     -> origin/master  (forced update)

but the other one will barf on the lock:

  error: Ref refs/remotes/origin/master is at 4e6459052ab329914c7712a926773e566b8c821d but expected ac32203727daa3bcb5fc041786aa45adbbe86299
  ...
   ! ac32203...4e64590 master     -> origin/master  (unable to update local ref)

Interestingly, in the case of ref _creation_, not update, like this:

  mkdir repo && cd repo && git init
  git remote add origin some-remote-repo-that-takes-a-few-seconds
  xterm -e 'git fetch -v; read' & xterm -e 'git fetch -v; read'

then both will happily update, the second one overwriting the results of
the first. It seems in the case of locking a ref which previously didn't
exist, we don't enforce that it still doesn't exist.

I wonder if we should, but perhaps there is some corner case I am not
considering. The code is in lock_ref_sha1_basic, but blaming didn't turn
up anything helpful.

-Peff
