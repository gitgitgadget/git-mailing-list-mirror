From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree into another rather than two trees into merge base
Date: Fri, 16 Sep 2005 20:45:13 +0200
Message-ID: <200509162045.13713.blaisorblade@yahoo.it>
References: <200509102027.28812.blaisorblade@yahoo.it> <200509142019.04667.blaisorblade@yahoo.it> <tnxslw6d4qt.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:07:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGLXg-0005wm-J1
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbVIPTGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbVIPTGe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:06:34 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:60086 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161271AbVIPTGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:06:33 -0400
Received: (qmail 49695 invoked from network); 16 Sep 2005 19:06:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=NBtPO5/HMfXK+GNwB8bZDIysSkizfVjEaD5djXFxxvbgGb5rMp4EHZncb2YzOOxx7OM7qVgQZfwW4CqVpRZYMkSr62TV5MGeARqpB9ivAysuHdxjXKKVNbiqsgwSOR2kQ2wy1AKmroEneMHWaerzpwX7yENYTrxZLHTb+HWPUS4=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@62.11.79.165 with login)
  by smtp007.mail.ukl.yahoo.com with SMTP; 16 Sep 2005 19:06:26 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.8.1
In-Reply-To: <tnxslw6d4qt.fsf@arm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8707>

On Thursday 15 September 2005 12:06, Catalin Marinas wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Sunday 11 September 2005 10:24, Catalin Marinas wrote:
> >> That's indeed very slow. How may files are modified in each patch?
> >
> > 1 files, in most cases - biggest one had 5 files changed (and is big
> > 4,8K).

> OK, this doesn't really matters since the diff between the new HEAD
> and the old bottom of the patch is big.
In fact.
> >> Actually, it will three-way merge the diff between top and bottom with
> >> the diff between HEAD and bottom. The time will depend on the size of
> >> both diffs, not just the maximum.

> git-read-tree -m doesn't handle the case when a file is removed from
> one branch and unmodified in the other, which is what happens in your
> test. For each of these removed files, git-merge-cache will call
> gitmergeonefile.py which calls 'git-update-cache --remove'.

> An improvement would be to make git-read-tree smarter and only leave
> out the three-way merges and the conflicts. Otherwise, implementing my
> own git-merge-cache which includes gitmergeonefile.py or implementing
> gitmergeonefile in C would be an improvement but I'm not sure it is
> that significant.
gitmergeonefile in C wouldn't matter that much (I hope) - you'd rather move 
the code to a module to have it byte-compiled would be enough, if this 
matters.

What could make more sense is to make sure that the file removals are done in 
one step, which can be accomplished only if the Porcelain merge script is 
called at once with a file list on stdin.

But implementing the behaviour we discuss below (the one I quote from man page 
but which is unimplemented) would fix this particular problem. So yes, 
implementing this would speed things up.
> > I guess that moves between stages don't have the big memmove()
> > problem, while calling --remove shows it.
> >
> > And, with master being the SHA1 I pushed onto
> > (8920e8f94c44e31a73bdf923b04721e26e88cadd),
> >
> > git-diff-tree -r v2.6.13 master |grep ' D'|wc -l

> > gives 189. I guess that 2.5 seconds per each removal are enough to
> > justify the time which was needed above. Actually, it even had to be
> > less than a second per removal, otherwise it'd have been even
> > slower.

> The 2.5 figure was for trivial merges and most of the time was spent
> in git-read-tree.
Yes, but I think it's a reasonable figure here too (we'll have to do memmove() 
anyway, if things are reasonable - never looked at the code, though).
> >> That's not a three-way diff algorithm. I could generate the diff of the
> >> patch and apply it with git-apply but this might fail and you wouldn't
> >> even get reject files (not sure whether git-apply supports this).

> > Well, true, but either diff3 or merge would work fairly well. Also,
> > trying to apply the patch and resorting to something more complex
> > wouldn't create so many problems.

> But this would slow things down for people pulling changes on a daily
> (or even more often) basis. It could be added as an option to 'stg
> push', i.e. when you expect something like this, just pass a
> '--nothreeway' option.
Using "merge" by hand *is* a three-way merge, indeed (done with older tools, I 
agree).
> >> Another problem is that it won't detect upstream merges of your patch,
> >> you would need to check it by hand. If all you need is a way to apply a
> >> patch using the 'patch' tool, have a look at Quilt. It has similar
> >> commands (since StGIT is based on its ideas) but uses the diff/patch
> >> tools and is much faster. It also generates rejects if a patch doesn't
> >> apply cleanly but I find the diff3 information, together with the
> >> original files left in place, much more useful.

> > Yes, in most cases. I've had something to complain with diff3,
> > however (that's a separate story). Maybe merge would be even better?

> I couldn't find the difference between merge and diff3 -E. Is there
> any?
I didn't see any difference in my (limited) use. So I switched to wiggle, 
which is smart enough for my needs.

> >> > In the git-read-tree manpage (which is probably outdated), this is
> >> > documented as follows:
> >> >
> >> >        o  stage 1 and stage 3 are the same and stage 2 is different:
> >> >            take stage 2 (some work has been done on stage 2)
> >> >
> >> > But it didn't happen, which is strange.
> >>
> >> This means that the file is not modified by an StGIT patch but it is
> >> modified upstream. This case works fine for me (it's a bug if it
> >> doesn't). Did you get a conflict? Are the original files left in place?
> >
> > No, it's not a correctness bug for me - just a performance bug. Why did
> > gitupdateonefile.py need to call git-update-cache --remove? If
> > git-read-tree had done his duty, this wouldn't be needed.

> Do you mean it wasn't modified by the StGIT patch (and hence stage 3
> is the same as stage 1) but it was removed in stage 2. This case is
> *not* handled by git-read-tree, though I think it should deal with
> this trivial case as well, it's not that different from the case
> below.
Ok, manpage is out-of-date, as I guessed. The above excerpt says yes, you say 
no, I verified no, please fix man page.
> If stage 2 is a simple SHA1 modification (not file removal) the case
> was already handled by git-read-tree and there should only be a stage
> 0 entry for this file. git-merge-cache should *not* call
> gitmergeonefile.py.

> >> > So, would stgit delete a file created in patch #1 when merge-applying
> >> > patch #2?
> >>
> >> Definitely not.

> > Gonna test - but if you look at the manpage of read-tree, this would
> > probably be the expected behaviour.

> If patch #2 didn't explicitely removed this file and if patch #1 is
> applied, it won't delete it (unless there is a bug).
Yes, sorry, here you're right - I wasn't careful enough. It's true that the 
file is only in stage 2 (current HEAD) but not in stage1 (bottom) or stage3 
(top), but that is assumed as "work done in the HEAD" so it's kept.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
