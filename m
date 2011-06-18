From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Sat, 18 Jun 2011 02:40:35 -0400
Message-ID: <4DFC4863.2090803@sohovfx.com>
References: <4DEB495F.9080900@kdbg.org>	<1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>	<1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>	<7vmxhlpvob.fsf@alter.siamese.dyndns.org>	<4DF64932.1090607@sohovfx.com> <20110616172454.13ff1a18@sh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 08:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXpDD-0007YN-8e
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 08:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab1FRGkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 02:40:42 -0400
Received: from smtp01.beanfield.com ([76.9.193.170]:60117 "EHLO
	smtp01.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab1FRGkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 02:40:41 -0400
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1QXpCu-0002my-1B
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QXpCu-0002my-1B; Sat, 18 Jun 2011 02:40:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110616172454.13ff1a18@sh9>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175963>

Here's a list of those commits in "git log"-order for easy reference:
   80fe82e rebase-i-p: if todo was reordered use HEAD as the rewritten 
parent
   d80d6bc rebase-i-p: do not include non-first-parent commits touching 
UPSTREAM
   acc8559 rebase-i-p: only list commits that require rewriting in todo
   a4f25e3 rebase-i-p: fix 'no squashing merges' tripping up non-merges
   bb64507 rebase-i-p: delay saving current-commit to REWRITTEN if squashing
   72583e6 rebase-i-p: use HEAD for updating the ref instead of mapping 
OLDHEAD
   42f939e rebase-i-p: test to exclude commits from todo based on its 
parents

On 11-06-16 6:24 PM, Stephen Haberman wrote:
> Perhaps that is unreasonable with whatever you guys are looking at now,
> but, IIRC, the use case was that B1=some old commit, like a 2.0
> release, and a bunch of work happened on the C1 branch, it was merged
> in E1, but now when you want to rebase D1/E1/F1 on top of B1, you don't
> want all of the noise of the C1 commit(s), since when rewriting E1 into
> E2, you can just reuse the un-rewritten C1 as its 2nd parent.
In commit a4f25e3, we could already rebase B1 and squash F1 onto D1, 
while reusing C1 and recreating the merge. That means we could already 
pass t3411.2if we adjusted the todo-list to account for the extra "pick 
C1" line.
> Well, and not just the noise--since the todo is still flat, if C1
> was listed in the todo, there's no way to recreate E2 as a merge and
> maintain the C1 commit(s) as a separate branch. I think C1 would get
> flattened between D2/E2, depending on where it was in the todo. You'd
> lose a merge, contrary to the -p flag. That sounds like the core issue
> that was being fixed
The merge shouldn't get flattened when the "-p" is used. As long as the 
merge commit appears in the todo-list, git will trace the parents of the 
merge commit, find the original or rewritten parents, and perform the 
merge.  Slightly off-topic, but I believe the branches will remain 
intact as long as the branch commits remain in the same topo-order 
relative to each other in the todo-list. i.e. git will be confused if we 
try to move a commit from one branch into the other.

The "noise" is filtered out by by commit d80d6bc.  However, I think we 
should keep the commits from branch C1, since there could be a scenario 
where we actually want to squash F1 onto C1 instead. That commit also 
introduced a bug that Jeff King was running into: if we do "git rebase 
-i -p C1", the todo-list becomes a "noop", which means HEAD is reset to 
C1 and we lose the merge commit and F1.

So what I did in my patch is essentially revert the changes from 
d80d6bc, and adjust t3411.2 to account for the extra "pick C1" line.
