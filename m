From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH v2 00/19] Multiparent diff tree-walker + combine-diff
 speedup
Date: Tue, 25 Feb 2014 14:38:38 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140225103838.GB3844@tugrik.mns.mnsspb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <CACsJy8BXMVNVAyqPEbHTkGxSSEJ6DpYUVwZqthiMQfO7Tj9T8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 11:37:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIFO2-0003pR-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 11:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbaBYKhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 05:37:11 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:52893 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbaBYKhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 05:37:07 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WIFNf-0005iA-Oe; Tue, 25 Feb 2014 14:36:56 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WIFPK-0005yg-3d; Tue, 25 Feb 2014 14:38:38 +0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BXMVNVAyqPEbHTkGxSSEJ6DpYUVwZqthiMQfO7Tj9T8A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242660>

On Tue, Feb 25, 2014 at 06:43:24AM +0700, Duy Nguyen wrote:
> On Mon, Feb 24, 2014 at 11:21 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > Hello up there.
> >
> > Here go combine-diff speedup patches in form of first reworking diff
> > tree-walker to work in general case - when a commit have several parents, not
> > only one - we are traversing all 1+nparent trees in parallel.
> >
> > Then we are taking advantage of the new diff tree-walker for speeding up
> > combine-diff, which for linux.git results in ~14 times speedup.
> 
> I think there is another use case for this n-tree walker (but I'm not
> entirely sure yet as I haven't really read the series). In git-log
> (either with pathspec or --patch) we basically do this
> 
> diff HEAD^ HEAD
> diff HEAD^^ HEAD^
> diff HEAD^^^ HEAD^^
> diff HEAD^^^^ HEAD^^^
> ...
> 
> so except HEAD (and the last commit), all commits' tree will be
> read/diff'd twice. With n-tree walker I think we may be able to diff
> them in batch to reduce extra processing: commit lists are split into
> 16-commit blocks where 16 trees are fed to the new tree walker at the
> same time. I hope it would make git-log a bit faster (especially for
> -S). Maybe not much.

Thanks for commenting.

Unfortunately, as it is now, no, and I doubt savings will be
significant. The real speedup comes from the fact that for combined
diff, we can omit recursing into subdirectories, if we know some diff
D(commit,parent_i) is empty. Let me quote myself from

http://article.gmane.org/gmane.comp.version-control.git/242217

On Sun, Feb 16, 2014 at 12:08:29PM +0400, Kirill Smelkov wrote:
> On Fri, Feb 14, 2014 at 09:37:00AM -0800, Junio C Hamano wrote:
> > I wonder if this machinery can be reused for "log -m" as well (or
> > perhaps you do that already?).  After all, by performing a single
> > parallel scan, you are gathering all the necessary information to
> > let you pretend that you did N pairwise diff-tree.
> 
> Unfortunately, as it is now, no, and let me explain why:
> 
> The reason that is not true, is that we omit recursing into directories,
> if we know D(A,some-parent) for that path is empty. That means we don't
> calculate D(A,any-other-parents) for that path and subpaths.
> 
> More structured description is that combined diff and "log -m", which
> could be though as all diffs D(A,Pi) are different things:
> 
>     - the combined diff is D(A,B) generalization based on "^" (sets
>       intersection) operator, and
> 
>     - log -m, aka "all diffs" is D(A,B) generalization based on "v"
>       (sets union) operator.
> 
> Intersection means, we can omit calculating parts from other sets, if we
> know some set does not have an element (remember "don't recurse into
> subdirectories"?), and unioning does not have this property.
> 
> It does so happen, that "^" case (combine-diff) is more interesting,
> because in the end it allows to see new information - the diff a merge
> itself introduces. "log -m" does not have this property and is no more
> interesting to what plain diff(HEAD,HEAD^n) can provide - in other words
> it's just a convenience.
> 
> Now, the diff tree-walker could be generalized once more, to allow
> clients specify, which diffs combination operator to use - intersection
> or unioning, but I doubt that for unioning case that would add
> significant speedup - we can't reduce any diff generation based on
> another diff and the only saving is that we traverse resulting commit
> tree once, but for some cases that could be maybe slower, say if result
> and some parents don't have a path and some parent does, we'll be
> recursing into that path and do more work compared to plain D(A,Pi) for
> Pi that lacks the path.
> 
> In short: it could be generalized more, if needed, but I propose we
> first establish the ground with generalizing to just combine-diff.

besides

    D(HEAD~,  HEAD)
    D(HEAD~2, HEAD~)
    ...
    D(HEAD~{n}, HEAD~{n-1})

is different even from "log -m" case as now there is no single commit
with several parents.

On a related note, while developing this n-tree walker, I've learned
that it is important to load trees in correct order. Quoting patch 18:

-       t1tree = fill_tree_descriptor(&t1, old);
-       t2tree = fill_tree_descriptor(&t2, new);
+       /*
+        * load parents first, as they are probably already cached.
+        *
+        * ( log_tree_diff() parses commit->parent before calling here via
+        *   diff_tree_sha1(parent, commit) )
+        */
+       for (i = 0; i < nparent; ++i)
+               tptree[i] = fill_tree_descriptor(&tp[i], parents_sha1[i]);
+       ttree = fill_tree_descriptor(&t, sha1);

so it loads parent's tree first. If we change this to be the other way,
i.e. load commit's tree first, and then parent's tree, there will be up
to 4% slowdown for whole plain `git log` (without -c).

So maybe what could be done to speedup plain log is for diff tree-walker
to populate some form of recently-loaded trees while walking, and drop
trees from will not-be used anymore commits - e.g. after doing
HEAD~..HEAD for next diff for HEAD~~..HEAD~ HEAD~ trees will be there
and HEAD trees should be dropped (many of them coincides, so reference
counting could help).

This way, we'll leave the walker logic intact, and only there will be
more handy trees-pool supported by fill_tree_descriptor, which imho is a
better design. And this way we could indeed add some not-big, but
noticeable speedup.

Though it is another topic, and at present my time is limited to only go
with combined diff speedup.

Thanks,
Kirill
