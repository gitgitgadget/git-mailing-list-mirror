From: Jeff King <peff@peff.net>
Subject: Re: pack count on repo.or.cz [was "Medium term dreams"]
Date: Tue, 2 Sep 2008 07:54:24 -0400
Message-ID: <20080902115424.GA11303@coredump.intra.peff.net>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net> <20080902010410.GI10360@machine.or.cz> <20080902011433.GA12682@coredump.intra.peff.net> <20080902111531.GL10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 02 13:56:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaUUT-0003HU-1Y
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 13:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYIBLy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 07:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYIBLy1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 07:54:27 -0400
Received: from peff.net ([208.65.91.99]:3147 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbYIBLy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 07:54:26 -0400
Received: (qmail 13477 invoked by uid 111); 2 Sep 2008 11:54:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Sep 2008 07:54:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Sep 2008 07:54:24 -0400
Content-Disposition: inline
In-Reply-To: <20080902111531.GL10360@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94667>

On Tue, Sep 02, 2008 at 01:15:31PM +0200, Petr Baudis wrote:

> > Hmm, I thought that was the point of adding the "-A" flag to git-repack.
> 
> Ok, I did
> 
> 	git repack -A -d
> 
> in repo.or.cz's git.git. What next? I have brand-new
>
> 	-rw-rw-r-- 1 root root  1314056 2008-09-02 13:07 pack-d19ca8b0cfd0e3357c475a3e96ce55b9f7195667.idx
> 	-rw-rw-r-- 1 root root 17344999 2008-09-02 13:07 pack-d19ca8b0cfd0e3357c475a3e96ce55b9f7195667.pack
> 
> but all the old packs too; git repack didn't delete anything,
> git prune-packed seems to have no effect either.

Hmm. Certainly the new pack is as expected. And you may also have some
new loose objects. It's easier to see what's going on with:

  mkdir repo && cd repo
  git init
  git config core.logallrefupdates false
  echo content >file && git add file && git commit -m one
  echo changes >>file && git commit -a -m two
  git repack -a -d

at this point we have the one pack:

  $ find .git/objects -type f
  .git/objects/pack/pack-ba174ac1cf22ba99a92878c562483321baa93d38.pack
  .git/objects/pack/pack-ba174ac1cf22ba99a92878c562483321baa93d38.idx
  .git/objects/info/packs

and then we lose the reference and pack again:

  git reset --hard HEAD^
  git repack -A -d

and now we have our single-commit pack, with a few loose objects from
the other commit:

  $ find .git/objects -type f
  .git/objects/13/cb02d81aac9cedca2700fb56aeddeb984dc57b
  .git/objects/78/a66295f2d04f2dd4ea90b4b99a6de73ea4ac12
  .git/objects/fe/79de90b5f7d6d4b23dc858f861834e2a76af7b
  .git/objects/info/packs
  .git/objects/pack/pack-c9a76fe2b061890a18396b70ec3d6a638383046e.idx
  .git/objects/pack/pack-c9a76fe2b061890a18396b70ec3d6a638383046e.pack

So did you check for loose objects? That is what you should get if there
were any objects that would have been lost. If there aren't any new
loose objects, then there were no objects that would be lost.

As to why the other packs weren't pruned, I don't know. In my example,
you can see that the pruning happens as we expect. So either there is a
bug in git-prune-packed, or there is something we're not realizing.

> So not just refs but also alternates? What if someone accesses the
> reposiory at that moment? I would also need to make the symlinks quite
> densely to avoid refs/forkee/-induced loops.

I think you could probably do it safely with a symlink farm (and I sort
of assumed you were doing something like that already for pruning, but
perhaps you are just not pruning at all).

> I might as well just use a common repository for all the forks then. But
> this does not scale at all for dumb transports, does it?

It depends how different the forks are. :) But I think it is better if
we can avoid that.

-Peff
