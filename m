From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Wed, 10 Oct 2007 08:25:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org>
References: <20071010015545.GA17336@lapse.madduck.net>
 <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org>
 <20071010102528.GB20390@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfdRW-0003RE-2m
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbXJJPZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbXJJPZh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:25:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49197 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753877AbXJJPZg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 11:25:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9AFPGtt003271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Oct 2007 08:25:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9AFPFkg013323;
	Wed, 10 Oct 2007 08:25:16 -0700
In-Reply-To: <20071010102528.GB20390@lapse.madduck.net>
X-Spam-Status: No, hits=-2.73 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60509>



On Wed, 10 Oct 2007, martin f krafft wrote:
> also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.10.0354 +0100]:
> > Cherry-picking is immaterial. It doesn't matter how the changes
> > come into the tree. It doesn't matter what the history is. The
> > only thing git cares about is the content, and the end result.
> 
> This is the part I over-estimated. I thought that Git would figure
> out that commits 1-3 had been merged into the target and thus apply,
> in sequence, only the commits from the source which had not been
> merged.

Yes, *some* SCM's have tried to do that. In particular, the ones that are 
"patch-based" tend to think that patches are "identical" regardless of 
where they are, and while re-ordering of them is a special event, it's not 
somethign that changes the fundamental 'ID' of the patch.

For example, I think the darcs "patch algebra" works that way.

It's a really horrible model. Not only doesn't it scale, but it leads to 
various very strange linkages between patches, and it fails the most 
important part: it means that merges get different results just because 
people are doing the same changes two different ways.

> Many thanks (again), Linus! Looking forward to your next content
> manager; you know, the one with artificial intelligence built in!
> You could call it "wit" :)

Well, the git model is really largely the reverse: the system is supposed 
to be as *stupid* as humanly possible, but:

 - make it predictable exactly because it's stupid and doesn't do anything 
   even half-ways smart.

   This is part of the "it doesn't matter *how* you got to a particular 
   state, git will always do the same thing regardless of whether you 
   moved an existing patch around or whether you re-did the changes as 
   (possibly more than one) new and unrelated commits".

 - conflicts aren't bad - they're *good*. Trying to aggressively resolve 
   them automatically when two branches have done slightly different 
   things in the same area is stupid and just results in more problems.

   Instead, git tries to do what I don't think *anybody* else has done: 
   make the conflicts easy to resolve, by allowing you to work with them 
   in your normal working tree, and still giving you a lot of tools to 
   help you see what's going on.

So git doesn't try to avoid conflicts per se: the merge strategies are 
fundamentally pretty simple (rename detection and the whole "recursive 
merge" thing may not be simple code, but the concepts are pretty 
straightforward), and they handle all the really *obvious* cases, but at 
the same time, I feel strongly that anything even half-way subtle should 
not be left to the SCM - the SCM should show it and make it really easy 
for the user to then fix it up.

Side note: even with a totally obvious three-way merge, with absolutely 
zero conflicts even remotely close to each other, you can have the merge 
algorithm generate a good merge that doesn't actually *work*.

For example, it's happened a few times that one branch renames a structure 
member name (and changes all the uses) and another branch adds new code 
that uses the old member name. The end result: the code will *merge* fine, 
and there are zero conflicts in the content, because all the changes were 
totally disjoint, but the end result doesn't actually work or even 
compile!

So no merge strategy is ever perfect. The git approach is to be simple and 
predictable, and also to make it easy to fix up (ie even if you get the 
above kind of automatic merge problem, if you catch it in compiling, you 
can fix it up, and do a "git commit --amend" to fix up the merge itself 
before you push it out).

			Linus
