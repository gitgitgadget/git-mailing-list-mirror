From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree
	into another rather than two trees into merge base
Date: Sun, 11 Sep 2005 09:24:47 +0100
Message-ID: <1126427087.8457.33.camel@localhost.localdomain>
References: <200509102027.28812.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 10:25:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEN93-000563-Sb
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 10:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVIKIYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 04:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVIKIYw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 04:24:52 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:51622 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750804AbVIKIYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 04:24:51 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050911082450.WVIC23002.mta08-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>;
          Sun, 11 Sep 2005 09:24:50 +0100
Received: from cpc4-cmbg5-3-0-cust94.cmbg.cable.ntl.com ([82.20.209.94])
          by aamta12-winn.ispmail.ntl.com with ESMTP
          id <20050911082450.RJYS24380.aamta12-winn.ispmail.ntl.com@cpc4-cmbg5-3-0-cust94.cmbg.cable.ntl.com>;
          Sun, 11 Sep 2005 09:24:50 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200509102027.28812.blaisorblade@yahoo.it>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8275>

On Sat, 2005-09-10 at 20:27 +0200, Blaisorblade wrote:
> I experienced a (performance) problem with StGit, but I don't know if it's the 
> culprit or if git-merge-cache is.

('s/cache/index/g' below since I still use the old names)

Maybe both. I did some profiling in StGIT but only for trivial patches
which did not involved calling gitmergeonefile.py. It was taking around
2.5s to push a patch with a changed base (involving merge) on an
NFS-mounted directory but most of the time, 1.8s, was spent in
git-read-tree to do the actual merge.

Someone else (Bcc'ed, not sure he wants his address to be public) did
some profiling on GIT and his conclusion was that most of the time was
spend in memmove() called from add_cache_entry() in read-cache.c called
from read-tree.c.

> Today I was pushing my patch stack (which was against Linux 2.6.13) on top of 
> the latest snapshot I have (i.e. upstream will likely have some mega of 
> patches). And it was *really* slow (say it pushed 8 patches in 5 minutes).

That's indeed very slow. How may files are modified in each patch? Do
you run it over NFS? Also for profiling, it is useful to run a 'stg
status' just to warm up the cache a little bit.

> I looked with "top" at what was happening, and I saw a lot of time spent by 
> either gitmergeonefile.py or git-update-cache --remove*. And looking at the 
> merge algorithm, I realized it merges both HEAD and patch top into the patch 
> bottom (or something like that).

It does a three-way merge between 'HEAD' and 'top' with 'bottom' as the
common ancestor. The new 'bottom' will become 'HEAD' and the new 'top'
will become the result of the merge.

> I.e. if upstream rewrote everything, it will merge this rewrite into the patch 
> bottom, together with the patch itself. So, the merge time will depend on the 
> biggest of the two changed trees, not on the least one.

Actually, it will three-way merge the diff between top and bottom with
the diff between HEAD and bottom. The time will depend on the size of
both diffs, not just the maximum. If the merge is not trivial, StGIT
will call git-merge-cache which calls gitmergeonefile.py. The Python
script is pretty simple and it simply calls diff3 or updates the cache
but if this happens for many files, the cumulated time might be big.
It's also worth profiling git-update-cache to check how it re-shuffles
the index file. Again, I haven't looked at the algorithm and I can't
comment more on this.

> A more reasonable algorithm would be along "read-tree HEAD"; merge "stg diff 
> -r /" (i.e. the current patch) in it.

That's not a three-way diff algorithm. I could generate the diff of the
patch and apply it with git-apply but this might fail and you wouldn't
even get reject files (not sure whether git-apply supports this).
Another problem is that it won't detect upstream merges of your patch,
you would need to check it by hand. If all you need is a way to apply a
patch using the 'patch' tool, have a look at Quilt. It has similar
commands (since StGIT is based on its ideas) but uses the diff/patch
tools and is much faster. It also generates rejects if a patch doesn't
apply cleanly but I find the diff3 information, together with the
original files left in place, much more useful.

> I don't know if there's any real difference between cg-Xmergefile, 
> gitmergeonefile.py and git-merge-one-file-script, and if that would matter in 
> this case.

There is not big difference since these are only scripts that simply
call other tools.

> In the git-read-tree manpage (which is probably outdated), this is documented 
> as follows:
> 
>        o  stage 1 and stage 3 are the same and stage 2 is different: 
>            take stage 2 (some work has been done on stage 2)
> 
> But it didn't happen, which is strange.

This means that the file is not modified by an StGIT patch but it is
modified upstream. This case works fine for me (it's a bug if it
doesn't). Did you get a conflict? Are the original files left in place?

> Additional note: in StGIT, git-read-tree is called with stage1 which is not 
> the merge base between stage2 and stage3.

stage1 is the bottom of the patch, stage2 is the HEAD (the upstream
hash) and stage3 is the top of the patch.

> For the first patch, the patch bottom is the merge base, but not otherwise; so 
> differences between either stage1 or stage3, and stage2, include files 
> changed in previous patches.

For the first patch, the bottom is the *old* base (== stage1), stage2 is
the new base and stage3 is the top of the patch.

> So, would stgit delete a file created in patch #1 when merge-applying patch 
> #2?

Definitely not.

-- 
Catalin
