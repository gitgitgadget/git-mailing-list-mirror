X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Mon, 06 Nov 2006 14:43:09 +0100
Message-ID: <454F3BED.9010401@op5.se>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 13:44:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <454F31D7.1030202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31013>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh4ku-0004bX-KR for gcvg-git@gmane.org; Mon, 06 Nov
 2006 14:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753129AbWKFNnN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 08:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbWKFNnN
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 08:43:13 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:5062 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1753132AbWKFNnM (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 08:43:12 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 1FA3C6BCC9; Mon, 
 6 Nov 2006 14:43:11 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 677026BCC4; Mon,  6 Nov 2006 14:43:10 +0100 (CET)
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao wrote:
> Thanks to Junio for his patient explanation about branches in git, I 
> find there is a subtle difference between GIT and regular VCS that can 
> be easily
> neglected by newbies.
> 
> I realize that git is a *content tracker*, it only creates commit object
> when the corresponding tree is really modified, git records content merging
> but not usual merging operation, that's why git is called a content 
> tracker.
> This explains why a merging that is really a fast forwarding doesn't create
> any new commit.
> 
> This feature is different from many regular VCS like CVS and Subversion and
> confuses newbies that come from them: mainline doesn't make sense too much,
> 'git log' shows many logs from other branches. In git, a branch is almost a
> tag, you can't get the *track* of a branch(It's a pity reflog is only for
> local purpose). I am used to one-trunk-and-more-side-branches way, every
> branches are isolated clearly, git makes me very confused at the beginning.
> 
> 
> Then, what bad *logical* problem will happen if a merging that is really 
> a fast forwarding creates a new commit?
> 

If "fake" commits (i.e., commits that doesn't change any content) are 
introduced for each merge, it will change the ancestry graph and the 
resulting tree(s) won't be mergable with the tree it merged with, 
because each such "back-merge" would result in
* the "fake" commit becoming part of history
* a new "fake" commit being introduced

Consider what happens when Alice pulls in Bob's changes. The merge-base 
of Bob's tip is where Alice HEAD points to, so it results in a 
fast-forward, like below.

a---b---c---d               <--- Alice
              \
               e---f---g     <--- Bob


If, we would have created a fake commit instead, Alice would get a graph 
that looks like so:

a---b---c---d-----------h   <--- Alice
              \         /
               e---f---g     <--- Bob


Now, we would have two trees that are identical, because the merge can't 
cause conflicts, but Alice and Bob will have reached it in two different 
ways. When Bob decides he wants to go get the changes Alice has done, 
his tree will look something like this:

a---b---c---d-----------h          <--- Alice
              \         / \
               e---f---g---i        <--- Bob


He finds it odd that he's got two commits that, when checked out, lead 
to the exact same tree, so he asks Alice to get his tree and see what's 
going on. Alice will then end up with this:

a---b---c---d-----------h---j      <--- Alice
              \         / \ /
               e---f---g---i        <--- Bob


Now there's four commits that all point to identical trees, but the 
ancestry graphs differ between all developers. In the case above, 
there's only two people working at the same project. Imagine the amount 
of empty commits you'd get in a larger project, like the Linux kernel.

Fast-forward is a Good Thing and the only sensible thing to do in a 
system designed to be fully distributed (i.e., where there isn't 
necessarily any middle point with which everybody syncs), while scaling 
beyond ten developers that merge frequently between each other.

> If we throw away all compatibility, efficiency, memory and disk consumption
> problems,
> (1) we can get the track of a branch without reflog because HEAD^1 is
> always the tip of target branch(or working branch usually) before merging.
> 
> (2) with the track, branch mechanism in git is possibly easier to 
> understand,
> especially for newbies from CVS or Subversion, I really like git's light 
> weight, simple but powerful design and great efficiency, but I am really
> surprised that 'git log' shows logs from other branches and a side 
> branch can become part of main line suddenly.
> 
> A revision graph represents fast forwarding style merging like this:
> 
>             (fast forwarding)
>  ---- a ............ * ------> master
>        \            /
>         b----------c -----> test         (three commits with three trees)
> 
> can be changed to:
> 
>  ---- a (tree_1) ----------- d (tree_3) ------> master
>        \                    /
>         b (tree_2) ------- c (tree_3) ----> test
> (four commits with three trees, it's normal as more than one way can 
> reach Rome :-)
> 

That's where our views differ. In my eyes, "d" and "c" are exactly 
identical, and I'd be very surprised if the scm tried to tell me that 
they aren't, by not giving them the same revid.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
