From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 00:31:22 -0500
Message-ID: <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 06:33:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMyNX-00067a-Bi
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 06:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbZANFbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 00:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZANFbg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 00:31:36 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:44472 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbZANFbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 00:31:33 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 9F7311FFC061; Wed, 14 Jan 2009 05:31:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 78CF81FFC052;
	Wed, 14 Jan 2009 05:31:12 +0000 (UTC)
In-Reply-To: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105585>

On Jan 13, 2009, at 9:40 PM, skillzero@gmail.com wrote:

> I created a branch from master, did a commit (8e9fdd), then did 2 more
> commits (11c59c and 7024d), then did another commit (2daf23). From
> master, I did a commit (47bd1b) then cherry-pick'd 2 commits from the
> branch (11c59c and 7024d). When merged the branch into master, I see
> the 2 cherry-picked commits twice in the log (once from the original
> cherry-pick's and again from the merge).

Before the cherry-picks, your repository looks like this

o-o (master: 47bd1b)
  \
   o-A-B-o (branch:2daf23)

A and B are the two commits you cherry-picked (11c59c and 7024d)

After the cherry-picks, the repo looks like this:

o-o-A'-B' (master)
  \
   o-A-B-o (branch:2daf23)

A and A' are different commits.  Same with B and B'.  If you check the  
SHA1 of master at this point, it will NOT be 702fd... (B).  Cherry  
pick creates a new commit that (as far as git is concerned) is totally  
unrelated.

After the merge, you get:

o-o-A'-B'-o (master)
  \       /
   o-A-B-o

Since git has no knowledge that the cherry-picked (A' B') commits are  
related to their originals (A B), it displays both to you.  If you  
want, you can use the -x flag when you use "git cherry-pick" to add a  
line that describes the original source of the patch in the new commit  
which eases confusion when you look at the history, but will not stop  
them from being displayed.

(The reason git will still display them is that the cherry-picked  
commits may be different if there were conflicting changes on the  
branches.  Also, hiding those commits would give a false view of  
history since the changes were actually added to the repository  
twice.  Using gitk or "git log --graph" will show the commits on two  
different lines of development.)

> I thought git would realize that master already had those 2 commits
> and not add them again when merging?

The simplest method is to rebase branch after doing the cherry-picks.   
This should only be done if your branch has not been published.  From  
after the cherry-picks:

o-o-A'-B' (master)
  \
   o-A-B-o (branch:2daf23)

"git rebase master branch" would give you

o-o-A'-B' (master)
         \
          o'-o' (branch)

Git should detect that the changes from A and B were already present  
in master during the rebase and skip the commits.

~~ Brian Gernhardt
