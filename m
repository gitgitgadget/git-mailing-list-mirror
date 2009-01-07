From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 7 Jan 2009 08:07:25 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
 <1231314099.8870.415.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 17:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKb84-0000lS-TT
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 17:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbZAGQSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 11:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbZAGQSA
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 11:18:00 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37315 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751941AbZAGQR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 11:17:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07G7QCC007880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 08:07:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07G7PcN007141;
	Wed, 7 Jan 2009 08:07:25 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231314099.8870.415.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104809>



On Tue, 6 Jan 2009, R. Tyler Ballance wrote:
> > 
> > The thing to do is
> > 
> >  - untar it on some trusted machine with a local disk and a known-good 
> >    filesystem.
> > 
> >    IOW, not that networked samba share.
> > 
> >  - verify that it really does happen on that machine, with that untarred 
> >    image. Because maybe it doesn't. 
> 
> Unfortunately it doesn't

Well, that's not necessarily "unfortunate". It does actually end up 
showing that the objects themselves were apparently never really corrupt.

So there is no fundamental data structure corrupttion - because when you 
copy the repository, it's all good agin!

In other words, that's not a worthless piece of information at all, and it 
does tell us a lot, namely that the corruption was never real long-term 
data corruption of the git object archive, but something local and 
temporary. Again, we're really back to either:

 - it could be some _temporary_ git corruption caused internally inside a 
   git process - ie a wild pointer, or perhaps a race condition (but we 
   don't really use threading in 1.6.0.4 unless you ask for it, and even 
   then just for pack-file generation)

 - or it's the disk cache corruption, and the tar/untar ended up flushing 
   it.

And quite frankly, since the corruption seems to be site-specific, I 
really do suspect the second case. Although it's possible, of course, that 
it could be some compiler issue that makes _your_ binaries have issues 
even when nobody else sees it.

> what I did notice was this when I did a `git
> status` in the directory right after untarring:
>         tyler@grapefruit:~/jburgess_main> git status
>         #
>         # ---impressive amount of file names fly by---
>         # ----snip---
>         #
>         # Untracked files:
>         #   (use "git add <file>..." to include in what will be
>         committed)
>         #
>         #       artwork/
>         #       bt/
>         #       flash/

Hmm. That's actually _normal_ under some circumstances. At least with 
older git versions, or if your .git/index file couldn't be rewritten for 
some reason - your existing index file contains all the old stat 
information, and if git cannot (or, in the case of older git version, just 
will not) refresh it automatically, it will show all the files as changed, 
even if it's just the inode number that really changed.

A _normal_ git install should have auto-refreshed the index, though. 
Unless the tar archive only contained the ".git" directory, and not the 
checkout?

>         tyler@grapefruit:~/jburgess_main>
> 
> Basically, somehow Git thinks that *every* file in the repository is
> deleted at this point. I went ahead and performed a `git reset --hard`
> to see if the issue would manifest itself thereafter, but it did not.

That would be what I'd expect if you had only tarred up .git, although 
then I wouldn't have expected those "Untracked files:". Hmm. Without being 
able to look at the archive, I'm just guessing randomly.

> I did try to do a git-fsck(1), and this is what I got:
>         tyler@grapefruit:~/jburgess_main> /usr/local/bin/git fsck --full
>         [1]    19381 segmentation fault  /usr/local/bin/git fsck --full
>         tyler@grapefruit:~/jburgess_main> 

.. and that's the unrelated fsck bug that got fixed later.

> >    The hope is that you caught the corruption in the cache, and it 
> >    actually got written out to the tar-file. But if it _is_ a disk cache 
> >    (well, network cache) issue, maybe the IO required to tar everything up 
> >    was enough to flush it, and the tar-file actually _works_ because it 
> >    got repopulated correctly.
> 
> When I was working through this with Jan, one of the things that we did
> was move the actual object file in .git/objects, they existed so maybe I
> could look into those to check?

Yes. If you have any bad loose objects, if you compare them to the good 
objects with the same name, that's going to be interesting information. 
The pattern of corruption can be very telling. For example, on Linux, a 
disk cache corruption would usually be at 4kB block boundaries, because 
that's the granularity of the cache. While a bit error would be obvious 
etc etc.

> I checked with our operations team, and contrary to my suspicion (your
> NFS comment piqued my curiosity), these disks that are actually on the
> machines are not NFS mounts but rather local disk arrays.

Ok, that generally makes caching much simpler. What filesystem?

Is there anything else that you do that is site-specific and/or slightly 
different? For example, a long time ago we had a bug related to CRLF 
conversion which would cause a use-after-free problem, and that would 
corrupt the data internally to git.

And dobody else saw it than this one person, and it was a total mystery to 
everybody until we realized that he used this one feature that nobody else 
was using. So as you're on OS X, I assume you don't have CRLF conversion, 
but maybe you use some other feature that we support but nobody really 
actually uses. Like keyword expansion or something?

Oh - that would also explain why you got all those entries in "git status" 
that went away when you did a "git reset --hard": if you had some keyword 
expansion (or CRLF) enabled in the original users "~/.gitconfig", that 
checkout would have had expansion/CRLF/whatever conversion, but then when 
you tarred/untarred it on another setup, the expansion would be seen as a 
difference because it wasn't enabled.

Hmm?

		Linus
