From: John Keeping <john@metanate.com>
Subject: Re: Interactive rebase with submodules
Date: Wed, 18 Jan 2012 11:21:18 +0000
Message-ID: <4F16AB2E.30706@metanate.com>
References: <4F15C22C.3020902@metanate.com> <4F15E83D.10509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 18 12:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnTa1-0000vj-1W
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 12:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab2ARLVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 06:21:21 -0500
Received: from shrek.metanate.com ([193.123.6.120]:42515 "EHLO
	shrek.metanate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab2ARLVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 06:21:20 -0500
Received: from farnsworth.metanate.com ([193.123.6.36])
	by shrek.metanate.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <john@metanate.com>)
	id 1RnTZu-0005A1-Mk; Wed, 18 Jan 2012 11:21:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20120105 Thunderbird/9.0
In-Reply-To: <4F15E83D.10509@web.de>
X-DCC--Metrics: shrek; whitelist
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188745>

On 17/01/12 21:29, Jens Lehmann wrote:
> Am 17.01.2012 19:47, schrieb John Keeping:
>> This appears to be because the git-rebase--interactive script inspects whether there is anything to commit when `rebase --continue` is invoked by running:
>>
>>      git diff-index --cached --quiet --ignore-submodules HEAD --
 >
>> Is there a reason for the `--ignore-submodules` in this command? Removing that option results in the expected behaviour.
>
> Yes, removing it will help your use case but break others. The reason
> for that is that because submodules are not updated during a rebase
> it doesn't make sense to compare their HEAD to what is recorded in
> the superproject, as that might have been changed by an earlier
> commit. And as the submodules HEAD hasn't been updated back then,
> it is stale and will always show up as modified (even if it wasn't).

Is this worse than the current behaviour?  If I perform a rebase where 
there is a (non-submodule) conflict in a commit where a submodule 
changes I can see something like:

# Changes to be committed:
#     modified:    path/to/submodule
#
# Unmerged paths:
#     both modified:      path/to/file
#
# Changes not staged for commit:
#     modified:    path/to/submodule (new commits)

This occurs if a later commit in the rebase will modify the submodule. 
In this case, `rebase --continue` correctly recreates the commit once I 
have resolved the conflict in the file, ignoring the unstaged submodule 
changes.

>> I can understand not updating submodules while running the rebase, but I expected that having resolved a conflict and added my change to the index it would be applied by `git rebase --continue`, as indeed it is if there happen to be other (non-submodule) changes in the same commit.
>
> The irony is that you would have to update submodules (or at least
> their HEAD and use "--ignore-submodules=dirty") while running rebase
> to make that work in all cases ;-)

I don't this this is the case, since diff-tree is being invoked with 
--cached won't it ignore changes in the work tree anyway?

> But just updating the HEAD would be dangerous as you would have to be
> very careful to restore the submodules HEAD after the rebase, or the
> submodule's work tree will be out of sync.

Just updating HEAD in the submodule without touching its work tree 
doesn't seem like a good idea.  I think it will cause a lot more 
confusion when running `git status` which will show unexpected modified 
content for the submodule.

Since I did not expect rebase to perform a submodule update, I was not 
surprised to see unstaged submodule changes when rebasing, but I did 
expect rebase to commit anything I had added to the index.


-- 
John
