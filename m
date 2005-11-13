From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: git-merge-recursive: documentation and implementation notes
Date: Sun, 13 Nov 2005 18:12:07 +0100
Message-ID: <20051113171207.GB4805@c165.ib.student.liu.se>
References: <20051112203457.GA5234@c165.ib.student.liu.se> <20051112210306.GG30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 18:13:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbLOv-00071t-BN
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 18:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVKMRMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 12:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVKMRMQ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 12:12:16 -0500
Received: from [85.8.31.11] ([85.8.31.11]:35734 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S964946AbVKMRMO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 12:12:14 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id E440C4100; Sun, 13 Nov 2005 18:20:47 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EbLOh-0001a0-00; Sun, 13 Nov 2005 18:12:07 +0100
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051112210306.GG30496@pasky.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11742>

On Sat, Nov 12, 2005 at 10:03:06PM +0100, Petr Baudis wrote:
>   Hi,
> 
> Dear diary, on Sat, Nov 12, 2005 at 09:34:57PM CET, I got a letter
> where Fredrik Kuivinen <freku045@student.liu.se> said that...
> > Lets assume there is a merge conflict when we merge B and C in the
> > criss-cross case above. Then both D and E must resolve this
> > conflict. If they have done it in the same way we wont get a merge
> > conflict at M, if they have resolved it differently we will get a
> > merge conflict. In the first case there is no merge conflict at M, in
> > the second case the user has to pick which one of the two different
> > resolutions she wants.
> > 
> > Note that the algorithm will happily write non-clean merge results to
> > the object database during the "merge common ancestors" stage. Hence,
> > when we are merging B and C "internally" we will _not_ ask the user to
> > resolve any eventual merge conflicts.
> 
>   I find this part somewhat unclear. So how does the user pick which of
> the two different resolution she wants if we will not ask the user to
> resolve any conflicts?
> 

If we have a conflict when we merge B and C we will get a file with
conflict markers from merge(1) in it, so it will look something like

    1
    2
    3
    <<<<<<
    4
    5
    ======
    6
    7
    >>>>>>
    8
    9

This file will be stored in the object database and the temporary tree
which is created by the merge of B and C will refer to it.

The algorithm will then merge D and E and use the file above as the
common ancestor. There are now two cases to consider, the first one is
that both D and E resolve the conflict above in the same way (and
possible make other changes which can be cleanly merged), we end up
with something like

    1
    2
    3
    4
    5
    8
    9

in both D and E. This will be merged cleanly into M. The other case is
that D and E either resolves the conflict differently or that they do
other modifications which aren't possible to merge automatically. In
this case we will let the user do the conflict resolution.

So, what I meant was that during the first merge, of B and C, the user
do not have to do anything with any eventual conflicts. However, in
the top-level merge, conflict resolution works in the same way as it
does for the 'resolve' strategy, i.e., the output of merge(1) is
stored in the working directory and the index is updated to make 'git
diff' useful.

- Fredrik
