From: Andreas Ericsson <ae@op5.se>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 14:22:49 +0200
Message-ID: <4E96D819.20905@op5.se>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 14:22:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REKJK-0004ae-Cq
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 14:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab1JMMWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 08:22:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61014 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab1JMMWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 08:22:49 -0400
Received: by bkbzt4 with SMTP id zt4so1361661bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 05:22:46 -0700 (PDT)
Received: by 10.204.139.85 with SMTP id d21mr2634475bku.15.1318508566577;
        Thu, 13 Oct 2011 05:22:46 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id rc12sm3426546bkb.10.2011.10.13.05.22.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 05:22:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.23) Gecko/20110928 Fedora/3.1.15-1.fc14 Thunderbird/3.1.15 ThunderGit/0.1a
In-Reply-To: <loom.20111013T130924-792@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183472>

On 10/13/2011 01:51 PM, arQon wrote:
> Snipping the bug and focusing on one of the after-effects of the bug is,
> unfortunately, not helpful to me unless I'm missing your point (which is
> certainly possible).
> 
> git switched branches while there were uncommitted files. It's not supposed to
> do this, ever, unless given -f or -m, and it broke the tree as a result. Even
> *with* -f or -m, the behavior I described is incorrect.
> The git docs seem to agree with me, which is why there's git stash. If the docs
> are wrong, fine, though it seems pretty strange to have a change on BranchA
> appear by magic "in" BranchB without any merging.
> 
> What I'm after is an understanding / explanation of how something that isn't
> supposed to happen, does. I don't care if it's "Because I'm an idiot", "Because
> git is broken", or even "Make sure your config has 'git.makebranchesworkproperly
> = true' in it, the default is false". If there is no explanation for why git
> switches branches when there are still uncommitted files, and there doesn't seem
> to be, then it's a pretty catastrophic bug and fixing it would be a Good Thing.
> 
> *AFAICT*, committing *a* file is what triggers it.
> If you commit -a, which is what all the commits prior to this were, it works
> properly. You change branches, and the files on the disk become what they should
> be.
> If you commit nothing, you correctly get the "uncommitted files" error.
> If you do a partial commit though, your tree breaks.
> 
> Like I say, if the man page, quote:
> "If you have local modifications to one or more files that are different between
> the current branch and the branch to which you are switching, the command
> refuses to switch branches in order to preserve your modifications in context."


This means that if fileX on branchA is different from fileX on branchB and you
*also* have local modifications to fileX, git will refuse to switch branches.
If, on the other hand branchA:fileX == branchB:fileX and you have modifications
to fileX in your work tree, there's no reason to refuse the branch change.
Partly because nothing will be lost and partly because you can just switch
branches back if you decide you've switched branches before committing things
to the first branch.

> is wrong, and this behavior is deliberate, that's fine. Bizarre, but fine in
> the sense that git is doing what it's supposed to (regardless of how
> counterintuitive and destructive it is).
> If the man page is right though, this is a bug. Maybe it's only in msysgit,
> but this is the second time it's happened, so hopefully it's fairly easy to
> reproduce.
> 

It's not a bug. You just read the manpage a bit wrong.

Consider this scenario:
$dev works on featureA on branchA, modifying fileX, fileZ and fileY and then
does a commit of fileZ and fileY, but realizes that the changes in fileX
will be good for developing featureB as well, so he changes to a separate
branch to do the update to fileX and be able to merge those changes to
both branchA and branchB.

I've done this myself on numerous occasions when re-working small project-
local API's, and it's very, very handy indeed. If git would refuse me to
change branches without first committing everything I'd have to first
commit the change separately, switch branch, cherrypick the change, go
back to the first branch and remove the commit I made there, merge the
other branch where the commit really belonged and only then I could go
on about my business. If, on the other hand, I happen to switch branches
before committing fileZ in the above example, I can just switch back and
amend my last commit on the first branch.

So yes, this is a feature, and it's a handy one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
