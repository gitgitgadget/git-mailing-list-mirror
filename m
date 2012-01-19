From: John Keeping <john@metanate.com>
Subject: Re: Interactive rebase with submodules
Date: Thu, 19 Jan 2012 10:48:37 +0000
Message-ID: <4F17F505.5030204@metanate.com>
References: <4F15C22C.3020902@metanate.com> <4F15E83D.10509@web.de> <4F16AB2E.30706@metanate.com> <4F172DBB.4080303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 19 11:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnpYF-0003gs-TV
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 11:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab2ASKsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 05:48:40 -0500
Received: from shrek.metanate.com ([193.123.6.120]:41996 "EHLO
	shrek.metanate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab2ASKsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 05:48:39 -0500
Received: from farnsworth.metanate.com ([193.123.6.36])
	by shrek.metanate.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <john@metanate.com>)
	id 1RnpXq-000501-0m; Thu, 19 Jan 2012 10:48:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20120105 Thunderbird/9.0
In-Reply-To: <4F172DBB.4080303@web.de>
X-DCC--Metrics: shrek; whitelist
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188807>

On 18/01/12 20:38, Jens Lehmann wrote:
> Am 18.01.2012 12:21, schrieb John Keeping:
>> On 17/01/12 21:29, Jens Lehmann wrote:
>>> Am 17.01.2012 19:47, schrieb John Keeping:
>>>> I can understand not updating submodules while running the rebase, but I expected that having resolved a conflict and added my change to the index it would be applied by `git rebase --continue`, as indeed it is if there happen to be other (non-submodule) changes in the same commit.
>>>
>>> The irony is that you would have to update submodules (or at least
>>> their HEAD and use "--ignore-submodules=dirty") while running rebase
>>> to make that work in all cases ;-)
>>
>> I don't this this is the case, since diff-tree is being invoked with --cached won't it ignore changes in the work tree anyway?
>
> Right, thanks for nudging me with the clue bat ...
>
> I missed the "--cached" option and did not question if the code does
> what the commit message of 6848d58c6 (where the --ignore-submodules
> option was introduced) said:
>
>      Ignore dirty submodule states during rebase and stash
>
>      When rebasing or stashing, chances are that you do not care about
>      dirty submodules, since they are not updated by those actions anyway.
>      So ignore the submodules' states.
>
>      Note: the submodule states -- as committed in the superproject --
>      will still be stashed and rebased, it is _just_ the state of the
>      submodule in the working tree which is ignored.
>
> I think this logic misses the case when only submodule changes are left
> in a commit.

Yes, this is precisely the case that doesn't work as I expect.

>>> But just updating the HEAD would be dangerous as you would have to be
>>> very careful to restore the submodules HEAD after the rebase, or the
>>> submodule's work tree will be out of sync.
>>
>> Just updating HEAD in the submodule without touching its work tree doesn't seem like a good idea.  I think it will cause a lot more confusion when running `git status` which will show unexpected modified content for the submodule.
>
> Yes, we agree here.
>
>> Since I did not expect rebase to perform a submodule update, I was not surprised to see unstaged submodule changes when rebasing, but I did expect rebase to commit anything I had added to the index.
>
> Right.
>
> I'll have to add some tests for that case, but I doubt I'll manage that
> today. Until I can provide a complete patch, this diff should fix your
> problem (no, I did not test if that change is enough to fix the problem,
> but at least it does not break the test suite ;-):
>
> ---------------8<--------------
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 5812222..4546749 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -672,7 +672,7 @@ rearrange_squash () {
>   case "$action" in
>   continue)
>          # do we have anything to commit?
> -       if git diff-index --cached --quiet --ignore-submodules HEAD --
> +       if git diff-index --cached --quiet HEAD --
>          then
>                  : Nothing to commit -- skip this
>          else

This patch does indeed fix the problem I was seeing.


Thanks,

-- 
John
