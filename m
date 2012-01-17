From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Interactive rebase with submodules
Date: Tue, 17 Jan 2012 22:29:33 +0100
Message-ID: <4F15E83D.10509@web.de>
References: <4F15C22C.3020902@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@metanate.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 22:29:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnGbH-000084-2M
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 22:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab2AQV3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 16:29:46 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:39177 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab2AQV3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 16:29:45 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6B6EE1A903960
	for <git@vger.kernel.org>; Tue, 17 Jan 2012 22:29:34 +0100 (CET)
Received: from [192.168.178.43] ([91.3.175.223]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LrKEG-1SnibK0bHw-013TjC; Tue, 17 Jan 2012 22:29:34
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F15C22C.3020902@metanate.com>
X-Provags-ID: V02:K0:wxs/2HL+bCzMObL9kUUYyZIEkJEd6m9kdarigGEh6Fu
 hraYzKz4YwqeSDA0TjDLTqKt/8JbH1xPs6PxKh1UyuFSYr5a3a
 2ye0mMCNk5yVY2HSMNsxAcLY+FvBuR2vnGe/kBKQAgLsNn+HEK
 NNJhkygcRn2zWXtzOl5gez8HYeVzYc9m1NdqHd9xpuDbplsswl
 Zf1M/u2ARaGXrsnjxp6Sg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188722>

Am 17.01.2012 19:47, schrieb John Keeping:
> I've encountered a scenario where git rebase --interactive drops a commit which contains a modification to a submodule but no other changes.
> 
> This occurs when there is a conflict when applying the commit (for example if the submodule's history has been rewritten and you are rewriting the parent repository to match the new version of the submodule).
> 
> To clarify:
> 
> git rebase -i
> # Edit a commit, switching submodule to an unrelated commit
> git rebase --continue
> # Conflict in submodule, checkout the correct submodule commit
> git add path/to/submodule
> # Only change in index is updated submodule
> git rebase --continue
> # No commit is created for the submodule change
> 
> 
> This appears to be because the git-rebase--interactive script inspects whether there is anything to commit when `rebase --continue` is invoked by running:
> 
>     git diff-index --cached --quiet --ignore-submodules HEAD --

Thanks for pinning that down.

> Is there a reason for the `--ignore-submodules` in this command? Removing that option results in the expected behaviour.

Yes, removing it will help your use case but break others. The reason
for that is that because submodules are not updated during a rebase
it doesn't make sense to compare their HEAD to what is recorded in
the superproject, as that might have been changed by an earlier
commit. And as the submodules HEAD hasn't been updated back then,
it is stale and will always show up as modified (even if it wasn't).

> I can understand not updating submodules while running the rebase, but I expected that having resolved a conflict and added my change to the index it would be applied by `git rebase --continue`, as indeed it is if there happen to be other (non-submodule) changes in the same commit.

The irony is that you would have to update submodules (or at least
their HEAD and use "--ignore-submodules=dirty") while running rebase
to make that work in all cases ;-)

But just updating the HEAD would be dangerous as you would have to be
very careful to restore the submodules HEAD after the rebase, or the
submodule's work tree will be out of sync.

I suspect in the long run a rebase should, e.g. when invoked with
--recurse-submodules, update the submodules too and won't use the
--ignore-submodule option for diff anymore ... then everything
should Just Work. But until that happens, I don't see a solution
for your problem.
