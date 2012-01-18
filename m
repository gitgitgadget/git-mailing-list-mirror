From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Interactive rebase with submodules
Date: Wed, 18 Jan 2012 21:38:19 +0100
Message-ID: <4F172DBB.4080303@web.de>
References: <4F15C22C.3020902@metanate.com> <4F15E83D.10509@web.de> <4F16AB2E.30706@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@metanate.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 21:38:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RncHL-0003ba-3Y
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 21:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449Ab2ARUiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 15:38:25 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:36247 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab2ARUiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 15:38:24 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id CD87B1BFE5988
	for <git@vger.kernel.org>; Wed, 18 Jan 2012 21:38:22 +0100 (CET)
Received: from [192.168.178.43] ([91.3.164.132]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MAMTy-1Ry1ae0kMU-00BEYl; Wed, 18 Jan 2012 21:38:22
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F16AB2E.30706@metanate.com>
X-Provags-ID: V02:K0:Gyrte0TJDHDCEUNm4eTTfxwZwu1/sOxdC2jvBIxn6cY
 uSfY6zrJaQbowDs+kVNoC4TSA97sozsTfUZatbb9vWn6gRi18N
 nKx/ET51IiZmz+de5WDYbXz81KVvPBXKBopSin5pf+nYDt3fko
 WN23UbnOOzcPYBzPYD6qLsqyF82WrlnaM4oeIKME0PfRSYlOY8
 BRPaRVphEOjD25QteMyFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188762>

Am 18.01.2012 12:21, schrieb John Keeping:
> On 17/01/12 21:29, Jens Lehmann wrote:
>> Am 17.01.2012 19:47, schrieb John Keeping:
>>> This appears to be because the git-rebase--interactive script inspects whether there is anything to commit when `rebase --continue` is invoked by running:
>>>
>>>      git diff-index --cached --quiet --ignore-submodules HEAD --
>>
>>> Is there a reason for the `--ignore-submodules` in this command? Removing that option results in the expected behaviour.
>>
>> Yes, removing it will help your use case but break others. The reason
>> for that is that because submodules are not updated during a rebase
>> it doesn't make sense to compare their HEAD to what is recorded in
>> the superproject, as that might have been changed by an earlier
>> commit. And as the submodules HEAD hasn't been updated back then,
>> it is stale and will always show up as modified (even if it wasn't).
> 
> Is this worse than the current behaviour?

If we break established behavior that would be worse unless we have
a *very* good reason to do so. But please see below ...

>  If I perform a rebase where there is a (non-submodule) conflict in a commit where a submodule changes I can see something like:
> 
> # Changes to be committed:
> #     modified:    path/to/submodule
> #
> # Unmerged paths:
> #     both modified:      path/to/file
> #
> # Changes not staged for commit:
> #     modified:    path/to/submodule (new commits)
> 
> This occurs if a later commit in the rebase will modify the submodule. In this case, `rebase --continue` correctly recreates the commit once I have resolved the conflict in the file, ignoring the unstaged submodule changes.

Yeah, as rebase doesn't touch the submodules, that is expected.

>>> I can understand not updating submodules while running the rebase, but I expected that having resolved a conflict and added my change to the index it would be applied by `git rebase --continue`, as indeed it is if there happen to be other (non-submodule) changes in the same commit.
>>
>> The irony is that you would have to update submodules (or at least
>> their HEAD and use "--ignore-submodules=dirty") while running rebase
>> to make that work in all cases ;-)
> 
> I don't this this is the case, since diff-tree is being invoked with --cached won't it ignore changes in the work tree anyway?

Right, thanks for nudging me with the clue bat ...

I missed the "--cached" option and did not question if the code does
what the commit message of 6848d58c6 (where the --ignore-submodules
option was introduced) said:

    Ignore dirty submodule states during rebase and stash

    When rebasing or stashing, chances are that you do not care about
    dirty submodules, since they are not updated by those actions anyway.
    So ignore the submodules' states.

    Note: the submodule states -- as committed in the superproject --
    will still be stashed and rebased, it is _just_ the state of the
    submodule in the working tree which is ignored.

I think this logic misses the case when only submodule changes are left
in a commit.

>> But just updating the HEAD would be dangerous as you would have to be
>> very careful to restore the submodules HEAD after the rebase, or the
>> submodule's work tree will be out of sync.
> 
> Just updating HEAD in the submodule without touching its work tree doesn't seem like a good idea.  I think it will cause a lot more confusion when running `git status` which will show unexpected modified content for the submodule.

Yes, we agree here.

> Since I did not expect rebase to perform a submodule update, I was not surprised to see unstaged submodule changes when rebasing, but I did expect rebase to commit anything I had added to the index.

Right.

I'll have to add some tests for that case, but I doubt I'll manage that
today. Until I can provide a complete patch, this diff should fix your
problem (no, I did not test if that change is enough to fix the problem,
but at least it does not break the test suite ;-):

---------------8<--------------
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..4546749 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -672,7 +672,7 @@ rearrange_squash () {
 case "$action" in
 continue)
        # do we have anything to commit?
-       if git diff-index --cached --quiet --ignore-submodules HEAD --
+       if git diff-index --cached --quiet HEAD --
        then
                : Nothing to commit -- skip this
        else
