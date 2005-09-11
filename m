From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Unified merge driver pushed out to "master" branch
Date: Sun, 11 Sep 2005 23:05:57 +0200
Message-ID: <20050911210557.GC7486@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <20050907165012.GA20392@c165.ib.student.liu.se> <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:08:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZ1p-0002Zb-Qd
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 23:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVIKVGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVIKVGJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 17:06:09 -0400
Received: from [85.8.31.11] ([85.8.31.11]:62696 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750890AbVIKVGI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 17:06:08 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D6FA94114; Sun, 11 Sep 2005 23:10:55 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EEZ1S-0005IU-00; Sun, 11 Sep 2005 23:05:58 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8330>

On Sat, Sep 10, 2005 at 07:54:19PM -0700, Junio C Hamano wrote:
> I've pushed out the 'git merge' along with Daniel's read-tree
> updates and your 'base on merge of bases' merge strategy driver
> in the "master" branch.
> 
> The last one is what I butchered your code without really
> auditing the changes I made, so I'd appreciate you to take a
> look at it and supply any necessary updates and fixes.  My
> changes are meant to be only to adjust the calling convention to
> that of 'git merge' -- that is, it gets merge bases and heads
> from the command line, and it is not supposed to commit and
> update HEAD itself, but is supposed to leave its best effort in
> the working tree and the paths that cannot be automerged should
> be left as that of HEAD version in the index file, so that the
> user can run 'git diff' to see what is happening while resolving
> things by hand.  I do not think my change did the last part
> correctlyx.  The change to introduce '-i' option to read-tree is
> also present.

Your changes seems to be fine.

I am a bit confused about in what state the index should be in after a
non-clean merge.

I interpreted <7vmzn2prck.fsf@assigned-by-dhcp.cox.net> as follows:

The index should preferably contain unmerged entries after a merge if
the merge was non-clean. If, for example, the file 'a' is modified in
branch A and 'a' is also modified in branch 'B' in such a way that
merge(1) cannot merge those changes, then when we have merged A with B
git-ls-files --unmerged should list 'a' in its output.

However, according to my tests 'git merge -s resolve' doesn't do
this. (the old git-resolve-script didn't do this either) They both
update the unmerged index entries to the entries that was in HEAD,
which agrees with your description of how things are supposed to work
above.

The way the 'resolve' strategy do this seems to be more usable than
"leave unmerged entries in the cache". In particular, 'git diff' gives
a usable output in this case.

Should I change git-merge-fredrik.py to have the same behaviour as the
resolve strategy?

> I primarily used the commits found in the Linux 2.6 repository
> and its derivatives that have multiple potential merge bases for
> my testing.  Among them, the attempt to merge parents of this
> commit triggered an assertion failure -- it may be my fault but
> I have not spent much time to diagnose it.
> 
> commit 6358924b06cd1aaa031b8ba0c33e5a15e795bef0
> Merge: 1da21e73bdc458f8131e6071072632b4c3b0430f 344a076110f4ecb16ea6d286b63be696604982ed
> Author: Tony Luck <tony.luck@intel.com>
> Date:   Thu Sep 8 14:29:32 2005 -0700
> 
>     Pull release into test branch
> 

It was not your fault. I have a fix for it in my local tree, it will
be sent to the mailing list soon. The result match the actual commit
when this patch has been applied.


> ----------------------------------------------------------------
> Here is a summary of my test results.
> 
> "Expect" names the commit being tested.  The parents of each of
> these commits have more than one merge-base, and the test is to
> start from one parent of it, and merge the other parent into it
> using the four merge programs:
> 
>  * traditional is 'git-resolve-script' from GIT 0.99.6 (it does
>    not even use Daniel's read-tree so that I can catch
>    regression in read-tree).
> 
>  * dbrt is 'git-merge -s resolve', i.e. Daniel's multi-base merge.
> 
>  * stupid is 'git-merge -s stupid', supposed to be the same
>    as 'git-resolve' (but internally uses Daniel's read-tree with
>    only one merge base).
> 
>  * fredrik is 'git-merge -s fredrik', the one I butchered.
> 
> ------------------------------------------------
> Expect 0c168775709faa74c1b87f1e61046e0c51ade7f3
> Method 'traditional' failed to automerge.
> Method 'dbrt' failed to automerge.
> Method 'stupid' failed to automerge.
> Method 'fredrik' automerged
> Method 'fredrik' resolved cleanly.
> 
> The fredrik is the only one that merged successfully, but its
> result is different from the actual commit.
> 
> :100644 100644 065b702df56353a00d5f460cf385f172decccf2b cd4222ff8b925f6b92414d58729d225fccc3f310 M	include/net/ieee80211.h
> 

I believe my algorithm produces the correct result in this case. I
think the difference comes from manual edits to
include/net/ieee80211.h after the merge but before the commit.

This commit was mentioned in
<20050908200559.GA26088@c165.ib.student.liu.se>.


> ------------------------------------------------
> Expect 0c3e091838f02c537ccab3b6e8180091080f7df2 (case #16)
> Method 'traditional' automerged
> Method 'traditional' resolved cleanly.
> Method 'dbrt' failed to automerge.
> Method 'stupid' automerged
> Method 'stupid' resolved cleanly.
> Method 'fredrik' automerged
> Method 'fredrik' resolved cleanly.
> 
> The fredrik result is different from the actual commit.
> 
> :100644 100644 a7bed60b69f9e8de9a49944e22d03fb388ae93c7 51a7b7b4dd0e7c5720683a40637cdb79a31ec4c4 M	arch/ia64/hp/sim/boot/bootloader.c
> 

This is Tony Luck's test case, originally described in
<200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>.

I reported the results for my algorithm on this case in
<20050826184731.GA13629@c165.ib.student.liu.se>. I think that the
result produced by my algorithm is the result which Tony expected to
get.


- Fredrik
