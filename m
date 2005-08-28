From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] A new merge algorithm, take 2
Date: Sun, 28 Aug 2005 10:03:41 +0200
Message-ID: <20050828080341.GA1928@c165.ib.student.liu.se>
References: <20050827205135.GB16587@c165.ib.student.liu.se> <7vmzn2prck.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 10:04:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9I9A-0006Sh-Pt
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 10:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVH1IEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 04:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVH1IEB
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 04:04:01 -0400
Received: from [85.8.31.11] ([85.8.31.11]:54447 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750800AbVH1IDs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2005 04:03:48 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 912954102; Sun, 28 Aug 2005 10:07:47 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1E9I8j-0000eg-00; Sun, 28 Aug 2005 10:03:41 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzn2prck.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7865>

On Sat, Aug 27, 2005 at 10:23:23PM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > The main changes compared to the previous version are:
> >
> > * Lots of clean up.
> > * Some of the scripts have been renamed to better match the naming
> >   convention used in Git.
> > * A new option ('-s') has been added to git-merge-cache
> > * Unclean merges are detected and reported
> > * Clean merges are committed
> 
> I have not looked deeply into your Graph thing, so I'd comment
> only on a couple of points in the external interfaces area.
> 

The graph things are there to be able to find common ancestors for the
heads we are merging. The reason we can't use 'git-merge-base --all'
is that new 'virtual' commit objects (i.e., the objects are only added
to the graph which is internal to gitMergeCore, they are not written
to the object database) may be added to the graph during the merge.

Thinking a bit more about it, maybe it is possible to use
git-merge-base after all...  I will have a look at it.

> I am not sure why you need to be touching merge-cache.  I
> suspect that reading directly from "ls-files --stage -z" might
> be easier and certainly less intrusive.  I do not have immediate
> objections to "read-tree -i", though.  I think it is useful.

I didn't know you could do things like that with git-ls-files :) But
yeah, it's certainly less intrusive to do it that way. It will
probably simplify things a great deal too. Wouldn't '--unmerged' be
the appropriate flag to use for git-ls-files in this case?

> When there is a merge conflict, the current code leaves the
> index in unmerged state and intermediate merge result with
> conflict marker is left in the working tree.  It appears that
> your code changes this and puts the blob with conflict markers
> in the index file.  Leaving things in unmerged state has two
> advantages:
> 
>  - you _could_ run git-diff-stages to see what the changes in
>    both sides are.
> 
>  - you cannot accidentally make a commit from such an index file
>    state; in fact you cannot even write it out as a tree.
> 
> I understand why you do it this way, and I do not find your way
> _too_ problematic, but we do need to realize that this is making
> things somewhat more prone to human errors.
> 

I understand your concerns. It is probably possible to leave the index
in its unmerged state after the final merge. I will do something about
in the next version of the patch.

> I have to admit that I find that "even when merging the
> merge-base candidates results in a file with conflict markers in
> it, the parts with the conflict markers often gets changed in
> the heads being merged, and the conflict markers will be gone
> from the result" trick very cute and interesting.  By itself it
> has certain amusement value, and if it works well in practice
> that is great.
> 
> > +print 'Merging', h1, 'with', h2
> > +h1 = runProgram(['git-rev-parse', '--revs-only', h1]).rstrip()
> > +h2 = runProgram(['git-rev-parse', '--revs-only', h2]).rstrip()
> 
> Here, '--verify" would be the right flag to give to these.  Perhaps:
> 
>     h1 = runProgram(['git-rev-parse', '--verify', ('%s^0' % h1)]).rstrip()
> 

Ok, looks good.

I am going away for a couple of days and I wont be able to work on
this during that time. I will get back with an updated patch when it's
ready.


- Fredrik
