From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 16:00:34 -0400
Message-ID: <20050503200034.GA16104@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 21:55:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3Ti-0001Or-Hi
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVECUA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVECUA4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:00:56 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:57763 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261664AbVECUAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 16:00:37 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DT3ZK-0006IT-00; Tue, 03 May 2005 16:00:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 12:15:08PM -0700, Linus Torvalds wrote:
> I just pushed out the commit that tries to finally actually write the sha1
> objects the right way in a shared object directory environment.
> 
> I used to be lazy, and just do "O_CREAT | O_EXCL" on the final name, but
> that obviously is not very nice when it can result in other people seeing
> objects that haven't been fully finalized yet.
> 
> So now I do it "right", and create a temporary file in the "top" object
> directory, and then when it's all done, I do a "link()" to the final place
> and unlink the original.

Annoyingly until this commit, git has been just about the perfect SCM
system to run on top of Coda. Almost every other SCM can and will get
conflicts on it's repository files, which are pretty much impossible to
resolve (just try merging two diverging copies of an RCS archive..)

But the only conflicts we ever see with git are when two people create
the same SHA1 object. And if the contents are in fact identical this
conflict will be trivially resolved.

I tried to pull in the latest version of your tree, but it doesn't look
like this commit has propagated to rsync.kernel.org yet. Hopefully you
will accept a small patch (should be < 5 lines) that makes git work
nicely when Coda complains about the cross-directory hardlink without
affecting the reliability of using link/unlink on normal filesystems.

Jan

> 
> I also change the permission to 0444 before it gets its final name.
> 
> Two notes:
> 
>  - because the objects all get created initially in .git/objects rather 
>    than in the subdirectory they get moved to, you can't use symlinks 
>    to other filesystems for the 256 object subdirectories. The object 
>    directory has to be one filesystem (but it doesn't have to be the same 
>    one as you actually keep your working ddirectories on, of course)
> 
>  - The upside of this is that filesystem block allocators should do the 
>    right thing. Instead of spreading the objects out (because they are in 
>    different directories), they should be created together.
> 
> Anyway, somebody should double-check the thing. It _should_ now work
> correctly over NFS etc too, and everything should be nice and atomic (and
> with any half-way decent filesystem, it also means that even if you have a
> system crash in the middle, you'll never see half-created objects).
> 
> NOTE NOTE NOTE! I have _not_ updated all the helper stuff that also write 
> objects. So things like "git-http-pull" etc will still write objects 
> directly into the object directory, and that can cause problems with 
> shared usage. Same goes for "write_sha1_from_fd()" that rpull.c uses. I 
> hope somebody will take a look at those issues..
> 
> Anyway, at least the really core operations should now really be
> "thread-safe" in a shared object directory environment.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
