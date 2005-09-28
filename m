From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 23:19:26 +0200
Message-ID: <20050928211926.GA3378@c165.ib.student.liu.se>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org> <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org> <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509280819000.3308@g5.osdl.org> <7vek79w2ps.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509281007200.3308@g5.osdl.org> <7vk6h1rr9l.fsf@assigned-by-dhcp.cox.net> <7vek79q8jj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Wed Sep 28 23:22:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKjLH-0000is-QZ
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 23:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVI1VTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 17:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVI1VTf
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 17:19:35 -0400
Received: from [85.8.31.11] ([85.8.31.11]:54194 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750930AbVI1VTd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 17:19:33 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 17D1740FF; Wed, 28 Sep 2005 23:25:24 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EKjKo-0000v8-00; Wed, 28 Sep 2005 23:19:26 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek79q8jj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9449>

On Wed, Sep 28, 2005 at 12:47:12PM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Linus Torvalds <torvalds@osdl.org> writes:
> >
> >> On Wed, 28 Sep 2005, Junio C Hamano wrote:
> >>> 
> >> I don't like doing the diff before-hand, but it looked like the default 
> >> was to try just one strategy, and avoid the diff in that case.
> >
> > By 'diff before-hand' I take it to mean the savestate for later
> > rounds to keep the pre-merge state.  You are correct that it is
> > not done in a single strategy case, and 'git pull' by default
> > would use only one of Daniel's git-merge-resolve or in the
> > multi-remote case git-merge-octopus, depending on the number of
> > heads being merged.  BTW, I decided not to use diff, just in
> > case somebody has binary blob we cannot reproduce with diff and
> > patch.
> 
> I see two more diffs that turns out to be problematic in
> git-merge.sh code.
> 
>  (1) As a safety measure I have a check to make sure the index
>      is in sync with $head.  This visibly hurts; on my slow disk
>      and CPU with a couple of locally modified paths in the
>      working tree, this check takes about a second in the kernel
>      tree with hot cache.
> 
>      git-merge-resolve uses "git-read-tree -u -m O A B" form, so
>      this is totally unnecessary.  I am not so sure about
>      Fredrik's git-merge-recursive (I haven't looked at it for a
>      while).
> 

git-merge-recursive also uses 'git-read-tree -u -m O A B' so it
shouldn't have any problems with this change.


>  (2) savestate uses "git diff $head" to find out the list of
>      paths that have local modifications, but the current code
>      calls it after the check described above, so "git-ls-files
>      -m" is enough.  On a kernel tree with hot cache and index
>      in sync with HEAD, "git-ls-files -m" is about 3-4 times as
>      fast with a couple of locally modified files.
> 
> Keeping (1) and using 'git-ls-files -m' in (2) is optimizing for
> a wrong path.  On the other hand, (1) is a safety measure, and
> if it is kept (2) becomes a quite cheap operation.
> 
> I am inclined to just remove the check in (1), and make it the
> responsibility of merge strategies to make sure it does not
> commit unrelated changes.
> 
> Comments?
> 

Looks good to me.

- Fredrik
