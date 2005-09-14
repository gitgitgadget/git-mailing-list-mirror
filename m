From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree into another rather than two trees into merge base
Date: Wed, 14 Sep 2005 20:16:27 +0200
Message-ID: <200509142016.28390.blaisorblade@yahoo.it>
References: <200509102027.28812.blaisorblade@yahoo.it> <1126427087.8457.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:23:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbsm-0006jz-71
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 20:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVINSVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVINSVQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 14:21:16 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:45713 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932560AbVINSVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 14:21:15 -0400
Received: (qmail 12565 invoked from network); 14 Sep 2005 18:21:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=QiKm9vShS8IxdTuT85pLfMm7n/mMy7sdEkrYkSAHzHwy8N/Dzfl17iVXb6biZwsJvuDLvAVolmrGgz1aUjWate7bx6MCTl7sIvD7jYo123ldDU8L5wBhk7WVkV6rRY6m7b6w/4WcrobXH7HXiIxNjXCWgQUCtDS8okKKCMfdgJs=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@62.11.80.49 with login)
  by smtp003.mail.ukl.yahoo.com with SMTP; 14 Sep 2005 18:21:02 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.8.1
In-Reply-To: <1126427087.8457.33.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8551>

On Sunday 11 September 2005 10:24, Catalin Marinas wrote:
> On Sat, 2005-09-10 at 20:27 +0200, Blaisorblade wrote:
> > I experienced a (performance) problem with StGit, but I don't know if
> > it's the culprit or if git-merge-cache is.

> ('s/cache/index/g' below since I still use the old names)

> Maybe both. I did some profiling in StGIT but only for trivial patches
> which did not involved calling gitmergeonefile.py.

> It was taking around 
> 2.5s to push a patch with a changed base (involving merge) on an
> NFS-mounted directory but most of the time, 1.8s, was spent in
> git-read-tree to do the actual merge.
Yes, I even remember you mentioned that.
> > Today I was pushing my patch stack (which was against Linux 2.6.13) on
> > top of the latest snapshot I have (i.e. upstream will likely have some
> > mega of patches). And it was *really* slow (say it pushed 8 patches in 5
> > minutes).

> That's indeed very slow. How may files are modified in each patch?
1 files, in most cases - biggest one had 5 files changed (and is big 4,8K).

> Do 
> you run it over NFS?
No, local reiserfs.
> Also for profiling, it is useful to run a 'stg 
> status' just to warm up the cache a little bit.
Yes, I realized that -  but processing kept the same speed all the time (it's 
not like it spent 4:30 minutes for warming the cache).

> > I looked with "top" at what was happening, and I saw a lot of time spent
> > by either gitmergeonefile.py or git-update-cache --remove*. And looking
> > at the merge algorithm, I realized it merges both HEAD and patch top into
> > the patch bottom (or something like that).

> It does a three-way merge between 'HEAD' and 'top' with 'bottom' as the
> common ancestor. The new 'bottom' will become 'HEAD' and the new 'top'
> will become the result of the merge.

> > I.e. if upstream rewrote everything, it will merge this rewrite into the
> > patch bottom, together with the patch itself. So, the merge time will
> > depend on the biggest of the two changed trees, not on the least one.

> Actually, it will three-way merge the diff between top and bottom with
> the diff between HEAD and bottom. The time will depend on the size of
> both diffs, not just the maximum.
Yes, true, but the problem in this case was that one diff (the upstream one) 
was extremely huge. And it even involved some files removal - I almost never 
caught, with top, anything else than gitmergeonefile.py or git-update-cache 
--remove.

I guess that moves between stages don't have the big memmove() problem, while 
calling --remove shows it.

And, with master being the SHA1 I pushed onto 
(8920e8f94c44e31a73bdf923b04721e26e88cadd), 

git-diff-tree -r v2.6.13 master |grep ' D'|wc -l
gives 189.

I guess that 2.5 seconds (more or less) per each removal are enough to justify 
the time which was needed above. So fixing this should fix the behaviour I 
met.
> If the merge is not trivial, StGIT 
> will call git-merge-cache which calls gitmergeonefile.py. The Python
> script is pretty simple and it simply calls diff3 or updates the cache
> but if this happens for many files, the cumulated time might be big.
> It's also worth profiling git-update-cache to check how it re-shuffles
> the index file. Again, I haven't looked at the algorithm and I can't
> comment more on this.

> > A more reasonable algorithm would be along "read-tree HEAD"; merge "stg
> > diff -r /" (i.e. the current patch) in it.

> That's not a three-way diff algorithm. I could generate the diff of the
> patch and apply it with git-apply but this might fail and you wouldn't
> even get reject files (not sure whether git-apply supports this).
Well, true, but either diff3 or merge would work fairly well. Also, trying to 
apply the patch and resorting to something more complex wouldn't create so 
many problems.
> Another problem is that it won't detect upstream merges of your patch,
> you would need to check it by hand. If all you need is a way to apply a
> patch using the 'patch' tool, have a look at Quilt. It has similar
> commands (since StGIT is based on its ideas) but uses the diff/patch
> tools and is much faster. It also generates rejects if a patch doesn't
> apply cleanly but I find the diff3 information, together with the
> original files left in place, much more useful.

Yes, in most cases. I've had something to complain with diff3, however.

> > I don't know if there's any real difference between cg-Xmergefile,
> > gitmergeonefile.py and git-merge-one-file-script, and if that would
> > matter in this case.

> There is not big difference since these are only scripts that simply
> call other tools.

> > In the git-read-tree manpage (which is probably outdated), this is
> > documented as follows:
> >
> >        o  stage 1 and stage 3 are the same and stage 2 is different:
> >            take stage 2 (some work has been done on stage 2)
> >
> > But it didn't happen, which is strange.

> This means that the file is not modified by an StGIT patch but it is
> modified upstream. This case works fine for me (it's a bug if it
> doesn't). Did you get a conflict? Are the original files left in place?
No, it's not a correctness bug for me - just a performance bug. Why did 
gitupdateonefile.py need to call git-update-cache --remove? If git-read-tree 
had done his duty, this wouldn't be needed.

> > Additional note: in StGIT, git-read-tree is called with stage1 which is
> > not the merge base between stage2 and stage3.

> stage1 is the bottom of the patch, stage2 is the HEAD (the upstream
> hash) and stage3 is the top of the patch.
Yes, saw that in the code.
> > For the first patch, the patch bottom is the merge base, but not
> > otherwise; so differences between either stage1 or stage3, and stage2,
> > include files changed in previous patches.

> For the first patch, the bottom is the *old* base (== stage1), stage2 is
> the new base and stage3 is the top of the patch.
Yes, but the *old* base happens to be, in this case (i.e. upgrading the stack 
base from upstream), also the merge base.
> > So, would stgit delete a file created in patch #1 when merge-applying
> > patch #2?

> Definitely not.
Gonna test - but if you look at the manpage of read-tree, this would probably 
be the expected behaviour.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
