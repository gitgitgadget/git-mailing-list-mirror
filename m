From: William Hall <will@gnatter.net>
Subject: Re: SVN migration
Date: Mon, 21 Jun 2010 23:26:28 +0100
Message-ID: <4C1FE714.6080100@gnatter.net>
References: <4C1957EF.6070504@gnatter.net>	<7B0F34CE-9C9F-4FC3-AD96-8B1B8DD4359B@gmail.com>	<4C19FA07.9010603@gnatter.net>	<4C1A4CF6.9080300@gnatter.net> <AANLkTinUc5z66Yk13ZKgHU113nRuAcl3HyC3eXAJAE6j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Michalske <smichalske@gmail.com>, git@vger.kernel.org
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 00:26:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQpS4-0001En-54
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab0FUW0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:26:42 -0400
Received: from mail.qualtersystems.com ([74.200.89.103]:58191 "EHLO
	mail.qualtersystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0FUW0m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:26:42 -0400
Received: from localhost (mail [127.0.0.1])
	by mail.qualtersystems.com (Postfix) with ESMTP id 907FE39507FE;
	Mon, 21 Jun 2010 23:26:41 +0100 (BST)
X-Virus-Scanned: amavisd-new at qualtersystems.com
Received: from mail.qualtersystems.com ([127.0.0.1])
	by localhost (mail.qualtersystems.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IgU3Xf7ssiYR; Mon, 21 Jun 2010 23:26:31 +0100 (BST)
Received: from [192.168.1.84] (xambo.qualtersystems.com [82.152.227.154])
	(Authenticated sender: will@mail.qualtersystems.com)
	by mail.qualtersystems.com (Postfix) with ESMTP id 759C52B6889C;
	Mon, 21 Jun 2010 23:26:30 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <AANLkTinUc5z66Yk13ZKgHU113nRuAcl3HyC3eXAJAE6j@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149455>

Hi Joshua - glad I'm not the only one facing this conundrum.

Yes, I've followed the Jon Loeliger's guide and am using something very 
similar.

I've come up with a couple of solutions, but this is my latest effort.
The only real difference in our situations is that I wanted the 
developers to get a feel of a bog-standard bare git repo to which they 
pull/push as usual - the gateway (...much better name) will also push 
and pull to this.

I've created a post-update hook in the bare git repo that does the 
following on the gateway repo

( there's a branch "svn" that tracks refs/remotes/svn/trunk)
- pulls commits from bare repo into master (all current dev work)
- on svn branch, run "git merge --squash master"
- commit changes
- git svn rebase (pick up changes from other depts)
- git svn dcommit
- switch back to master and merge in svn changes (with --no-ff)
- git push, back to bare repo

All git commits between pushes are squashed which probably represents 
the frequency of usual svn commits (ie, only when something is finished) 
so it's probably ok. Also, it prevents the developers from seeing 
duplicate commit messages - one from master and a duplicate (with svn 
commit-id) which may get annoying or confusing.

I've also tried doing a rebase with --onto to replay all changes to 
master onto the svn branch, which is ok, but all commits are duplicated 
and propagated.

I'm keen to merge the branches at some stage otherwise I'll end up with 
two branches on the gateway that never converge - which is probably not 
a good idea.

Have tried (briefly) your solution which also seems to work, but without 
any merge commits - will try more.

Naturally, I'd like a completely linear history, but the does not seem 
viable. I don't think git will be hard sell (most of our developers seem 
to agree that git is the future), but I need to get this right from the 
outset or confidence will be lost.


will




On 21/06/10 22:12, Joshua Shrader wrote:
> In Jon Loeliger's "Version Control with Git", Chapter 16, he describes
> a similar situation in which there is a Subversion repository, and at
> least a couple users that want to be using Git.  He proposes a single
> "gatekeeper" git repository, what you refer to as a bridge, which is
> the only interface to subversion.  After git svn cloneing the
> subversion repo (with --prefix=svn/), all the branches are then pushed
> to a bare repository (git push ../svn-bare.git
> 'refs/remotes/svn/*:refs/heads/svn/*', and other git users are told to
> clone this repo, which now contains local branches of all the svn
> remotes.  Then, to merge back to subversion, in the gatekeeper repo,
> you do
>
> git checkout svn/trunk (or other branch - this is checking out a
> detached head as svn/trunk is a remote)
> git merge --no-ff new-feature
> git svn dcommit
>
> This results in a merge commit on a detached head, and then the
> modified commit (after the git-svn-id line is added) is put on the
> real svn/trunk branch.  The commit on the detached head is "worse than
> redundant.  Using it for anything else eventually results in
> conflicts.  So, just forget about that commit.  If you haven't put it
> on a branch in the first place, it's that much easier to forget" (Jon
> Loeliger).
>
> I haven't tried this yet, but I'm in a similar situation in that I'm
> trying to convince my project to convert to using Git.  We're going to
> use this gatekeeper approach for a while, and allow users to migrate
> over at their own discretion.  Then hopefully, if there's not too much
> resistance, we'll get rid of the subversion repo entirely.
>
> If there's a problem with this workflow, I'd love to hear about it.
> I'm only in the middle of setting this up, but hopefully I should know
> if it works by the end of the week.
>
> On Thu, Jun 17, 2010 at 12:27 PM, William Hall<will@gnatter.net>  wrote:
>> I'm going to answer my own post, I *think* I have something that works -
>> please check if I'm doing anything idiotic.
>>
>> Just to recap: trying to convince my company to move from svn to git, and
>> they have agreed to try one project using git as long as all commits find
>> their way to the svn repo as well.
>>
>> So I have a standard bare git repo serving the developers, a git/svn
>> "bridge" repo that performs bi-directional updates to and from svn and the
>> bare git repo.
>>
>> Ok, here's what I've done
>>
>> Create bridge
>> -------------
>> $ git svn init -s file:///path_to_svn /path_to_git_svn_bridge/
>> $ cd /path_to_git_svn_bridge
>> $ git svn fetch --authors-file=/tmp/authors.map
>>
>> Configure bare repo
>> -------------------------------
>> create bare repo that developers will use
>> $ git init --shared=all --bare /path_to_git_repo.git
>>
>> configure bridge
>> ----------------
>> $ git remote add -f -m master origin /path_to_git_repo.git
>> $ git push origin master
>> $ git branch --set-upstream master origin/master
>>
>> this branch will be used to perform svn rebases and fetches
>> $ git checkout -t -b svn svn/trunk
>>
>>
>> Workflow
>> --------
>> Developer A clones from /path_to_git_repo.git, does some work, commits and
>> pushes back to origin
>>
>> Now, in the bridge repo, fetch changes from origin (where developer A
>> pushed)
>> $ git checkout master
>> $ git pull
>>
>> Replay all changes manually, in order, onto svn branch
>> $ git checkout svn
>> $ git rev-list --reverse heads/master@{1}..heads/master | while read rev; do
>>         git cherry-pick -n $rev
>>   done
>>
>> Create one commit for all changes and synchronise with svn
>> $ git commit -am "cherry pick merge"
>> $ git svn rebase
>> $ git svn dcommit
>>
>> Now merge in anything picked up from svn, plus the rebased final commit
>> $ git checkout master
>> $ git merge svn
>>
>> Send back to bare repo (at least the final merge commit)
>> $ git push
>>
>> It seems to handle changes and preserves linear history on both sides ok.
>> Can anyone see anything obviously wrong with this approach?
>>
>> thanks,
>>
>> Will
>>
>>
>>
>>
>>
>>
>> William Hall wrote:
>>> Thanks Steven,
>>>
>>> The noMetadata option will prevent me from doing anything other than a
>>> one-shot import, which is not what I want. I need to somehow devise a
>>> workflow that allows me bidirectional push/pull between an svn repo and a
>>> remote git repo.
>>>
>>>
>>>
>>> Steven Michalske wrote:
>>>> On Jun 16, 2010, at 4:02 PM, William Hall wrote:
>>>>
>>>>> The issue is the dcommit operation from the bridge. The rebase part of
>>>>> this re-writes the commit messages to include the SVN commit-ids which is
>>>>> nice, but screws up the push/pulls between the bridge and the bare repo.
>>>>
>>>> Look into svn.noMetadata configuration option.  It will prevent you from
>>>> rebuilding the svn to git bridge if something seriously goes wrong, but it
>>>> prevents the messages from changing.
>>>>
>>>> svn-remote.<name>.noMetadata
>>>> This gets rid of the git-svn-id: lines at the end of every commit.
>>>> If you lose your .git/svn/git-svn/.rev_db file, git svn will not be able
>>>> to rebuild it and you won't be able to fetch again, either. This is fine for
>>>> one-shot imports.
>>>> The git svn log command will not work on repositories using this, either.
>>>> Using this conflicts with the useSvmProps option for (hopefully) obvious
>>>> reasons
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> William Hall wrote:
>>>
>>> Thanks Steven,
>>>
>>> The noMetadata option will prevent me from doing anything other than a
>>> one-shot import, which is not what I want. I need to somehow devise a
>>> workflow that allows me bidirectional push/pull between an svn repo and a
>>> remote git repo.
>>>
>>>
>>>
>>> Steven Michalske wrote:
>>>>
>>>> On Jun 16, 2010, at 4:02 PM, William Hall wrote:
>>>>
>>>>> The issue is the dcommit operation from the bridge. The rebase part of
>>>>> this re-writes the commit messages to include the SVN commit-ids which is
>>>>> nice, but screws up the push/pulls between the bridge and the bare repo.
>>>>
>>>> Look into svn.noMetadata configuration option.  It will prevent you from
>>>> rebuilding the svn to git bridge if something seriously goes wrong, but it
>>>> prevents the messages from changing.
>>>>
>>>> svn-remote.<name>.noMetadata
>>>> This gets rid of the git-svn-id: lines at the end of every commit.
>>>> If you lose your .git/svn/git-svn/.rev_db file, git svn will not be able
>>>> to rebuild it and you won't be able to fetch again, either. This is fine for
>>>> one-shot imports.
>>>> The git svn log command will not work on repositories using this, either.
>>>> Using this conflicts with the useSvmProps option for (hopefully) obvious
>>>> reasons
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
