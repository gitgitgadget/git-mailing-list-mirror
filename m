From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Sun, 24 Sep 2006 06:45:53 +0200
Message-ID: <200609240645.54467.chriscool@tuxfamily.org>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org> <200609231322.30214.chriscool@tuxfamily.org> <7veju2nthl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 06:39:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRLmV-0003uU-UI
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 06:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbWIXEjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 00:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbWIXEjm
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 00:39:42 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:1669 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752119AbWIXEjm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 00:39:42 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 4546219242;
	Sun, 24 Sep 2006 06:39:40 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7veju2nthl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27647>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > You are right, so what about moving ".git/refs/heads/frotz"
> > to ".git/deleted-refs/heads/frotz.ref"
> > or ".git/deleted-refs/heads/frotz~ref" (because "~" is forbidden in ref
> > names).
>
> But wouldn't it bring up the issue of locking among deleters,
> updaters/creators, and traversers?

Yes, it will get worse. 

> If we choose to use packed-refs.lock as the "set of all refs"
> lock, the whole sequence would become something like this.  Note
> that this tries to make readers lockless but I am sure there are
> nasty race condition issues.  I am not sure what we would want
> to do about them.
>
> = Looking up a ref $frotz.

We could acquire .git/$frotz.lock here if we want to be sure that nothing 
will happen to it while we read it, but anyway something could happen to it 
just after we read it and before we use it. So the right thing to do is 
perhaps to let the caller acquire the lock if it needs to. We should just 
check in the other cases below that nothing can happen to the ref if 
someone acquired .git/$frotz.lock.

>  - check if .git/$frotz exists, and use it if it does.
>
>  - check if .git/deleted-refs/$frotz~ref exists, and return "no
>    such ref" if it does.
>
>  - find $frotz in .git/packed-refs.
>
> = Looping over refs.

Same as above. Depending on what the caller wants to do, it could 
acquire .git/packed-refs.lock or some .git/$frotz.lock to make sure nothing 
happens to all or only some refs.

>  - grab all .git/refs/ and subtract all .git/deleted-refs/
>
>  - walk .git/packed-refs and the result from the above in
>    parallel as in the current code.
>
> = Storing a new value in ref $frotz.
>
>  - acquire .git/packed-refs.lock
>
>  - lock .git/$frotz.lock.
>
>  - write into .git/$frotz.lock.
>
>  - create or update .git/logs/$frotz as needed.
>
>  - if .git/deleted-refs/$frotz~ref exists, unlink it.
>
>  - rename .git/$frotz.lock to .git/$frotz to unlock it.
>
>  - unlink .git/packed-refs.lock
>
> = Deleting a ref $frotz.
>
>  - acquire .git/packed-refs.lock

- acquire .git/$frotz.lock seems needed too

>  - look up $frotz; if it does not exist either barf or return
>    silent (haven't thought it through yet).
>
>  - create .git/deleted-refs/$frotz~ref

or move .git/$frotz to .git/deleted-refs/$frotz~ref if .git/$frotz exists

>  - remove .git/logs/$frotz

- unlink .git/$frotz.lock 

>  - unlink .git/packed-refs.lock
>
> = Packing refs, with optional pruning.
>
>  - lock .git/packed-refs.lock
>
>  - loop over refs:
>    - write it out to .git/packed-refs.lock unless a symref.
>    - if it is a loose one (not a symref), remember it for pruning.
>
>  - if pruning:
>    - remove the entire .git/deleted-refs/ hierarchy
>    - remove the remembered ones

Perhaps we should acquire .git/$frotz.lock for each $frotz that we remove 
when pruning.

>  - rename .git/packed-refs.lock to .git/packed-refs

Thanks,
Christian.
