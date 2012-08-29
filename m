From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: dangling submodule references after rebase
Date: Wed, 29 Aug 2012 22:19:09 +0200
Message-ID: <503E793D.4080305@web.de>
References: <503DE6F8.3030106@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stijn Souffriau <stijn.souffriau@essensium.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 22:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6ojU-0000zX-N9
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 22:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab2H2UTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 16:19:18 -0400
Received: from mout.web.de ([212.227.17.11]:60494 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021Ab2H2UTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 16:19:17 -0400
Received: from [192.168.178.41] ([91.3.157.95]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lr2I7-1TbSin3xVz-00eDHB; Wed, 29 Aug 2012 22:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <503DE6F8.3030106@essensium.com>
X-Provags-ID: V02:K0:HVMTtIv7kuOwEusFw7CrS0tKcuTC0XSrybaKExgzZXA
 R0Dp9lJR7O1G3JyZ5sJFRJFc1HcYCtYTisgg6ul6TyFNotDkW1
 329EdRUum8NwaBj+GNyO20C+dSGU+GJyHDots4ld6REus5eZeQ
 ok1MIeq3oR5/ex33M/Za2MCpntd8T+PUiI2c98PiXSSIGpegHE
 gUd18U++g1N3JGCpYcEGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204495>

Am 29.08.2012 11:55, schrieb Stijn Souffriau:
> I am using a repository that has a sub module which is being committed to frequently by myself as well as others. Because of the heavy concurrent development I need to do a lot of rebasing. Since the sub module commit hashes referenced by the parent repository can become dangling as a result of rebasing the sub module I am required to do lots of manual "fixing" of the references in the parent repository using an interactive rebase. This is a tedious, error-prone procedure which I would like to automate.

I am very interested to hear how you intend to do that. I can't think of
a sane way to do that but would really like to be convinced otherwise.

> I was wondering if anyone has thought about solving this problem yet in the past and what might be a good solution?

We don't solve this problem, but try to avoid it by having the best
practice that only commits which are on (or merged into) a stable branch
in the submodule may be committed on a branch in the superproject. This
works really well for us.

> I was thinking something along the lines of extending the add and commit commands so that a parent repository would signal to the sub modules that it's index or some if it's commits reference certain sub module commits; and also the rebase command so that it would update the parent repository commits with new hashes using the information stored by the add or commit commands. The procedure would have to be made recursive because changing commits in the parent repository might also require changing commits in it's parent repository as well.

Submodules aren't aware that they have a superproject (which is a feature),
so maybe you could issue something like a "rebase that branch in the
submodule and update all commits in this branch here referencing those
rebased commits" in the topmost superproject and iterate down from there.

> I'm still no quite sure for which sub module rebase operations the referencing parent repository commits would actually have to be "updated".

Me thinks it could make sense to have a branch in the superproject which
follows the development in the submodule, which would answer what commits
you'd have to check.

> The reason being that the rebased commits might still be referenced by another branch and so they might continue to exist after the rebase which raises the question if the parent repository commits need to be udated or not. I think this question would have to be answered by the add and commit commands which would also have to specify a referenced branch in addition to referenced commits so that the parent repo commits would only have to be updated if the commits on this branch are rebased. By default this could be the branch checked out in the sub module at the time the
> referencing commit was made.

And the distributed nature of git leaves plenty of room to have other
branches in other repos referencing the commits you just rebased. And for
lots of submodules there is more than a single superproject, making that
problem even more interesting.

> For obvious reasons this should only be done for newly made, unpushed and unpulled commits in the repository.

So that would make this operation impossible once you pushed a submodule
branch e.g. just to back it up on the server? I think that would make
this much less useful. When you rewrite history in a submodule you always
have the potential problem of removing the commits used by another branch
in your repo, somebody else's copy of the repo or even in a completely
different superproject, so you'll have to be careful there anyway.

> However, it might be interesting to also enable people to manually bind a parent repo commits to a submodule branch so that the commits in this parent repo branch are updated when the sub module branch is rebased.
> 
> I would like see this end up in the mainline and so I'm very interested in your opinions.

I think it the first step should be to line out the solution and then
create one or more scripts demonstrating how that approach could work.
Then we can decide how to move on from there.
