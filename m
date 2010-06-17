From: William Hall <will@gnatter.net>
Subject: Re: SVN migration
Date: Thu, 17 Jun 2010 17:27:34 +0100
Message-ID: <4C1A4CF6.9080300@gnatter.net>
References: <4C1957EF.6070504@gnatter.net> <7B0F34CE-9C9F-4FC3-AD96-8B1B8DD4359B@gmail.com> <4C19FA07.9010603@gnatter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 18:27:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPHwQ-0000cP-4K
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 18:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800Ab0FQQ1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 12:27:41 -0400
Received: from mail.qualtersystems.com ([74.200.89.103]:48571 "EHLO
	mail.qualtersystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992Ab0FQQ1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 12:27:40 -0400
Received: from localhost (mail [127.0.0.1])
	by mail.qualtersystems.com (Postfix) with ESMTP id 05E7E39607F3;
	Thu, 17 Jun 2010 17:27:40 +0100 (BST)
X-Virus-Scanned: amavisd-new at qualtersystems.com
Received: from mail.qualtersystems.com ([127.0.0.1])
	by localhost (mail.qualtersystems.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CgLPAAeyggLe; Thu, 17 Jun 2010 17:27:36 +0100 (BST)
Received: from merton.mpc.local (mpc-1.sohonet.co.uk [193.203.82.226])
	(Authenticated sender: will@mail.qualtersystems.com)
	by mail.qualtersystems.com (Postfix) with ESMTP id D46463950761;
	Thu, 17 Jun 2010 17:27:35 +0100 (BST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <4C19FA07.9010603@gnatter.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149319>

I'm going to answer my own post, I *think* I have something that works - 
please check if I'm doing anything idiotic.

Just to recap: trying to convince my company to move from svn to git, 
and they have agreed to try one project using git as long as all commits 
find their way to the svn repo as well.

So I have a standard bare git repo serving the developers, a git/svn 
"bridge" repo that performs bi-directional updates to and from svn and 
the bare git repo.

Ok, here's what I've done

Create bridge
-------------
$ git svn init -s file:///path_to_svn /path_to_git_svn_bridge/
$ cd /path_to_git_svn_bridge
$ git svn fetch --authors-file=/tmp/authors.map

Configure bare repo
-------------------------------
create bare repo that developers will use
$ git init --shared=all --bare /path_to_git_repo.git

configure bridge
----------------
$ git remote add -f -m master origin /path_to_git_repo.git
$ git push origin master
$ git branch --set-upstream master origin/master

this branch will be used to perform svn rebases and fetches
$ git checkout -t -b svn svn/trunk


Workflow
--------
Developer A clones from /path_to_git_repo.git, does some work, commits 
and pushes back to origin

Now, in the bridge repo, fetch changes from origin (where developer A 
pushed)
$ git checkout master
$ git pull

Replay all changes manually, in order, onto svn branch
$ git checkout svn
$ git rev-list --reverse heads/master@{1}..heads/master | while read rev; do
         git cherry-pick -n $rev
   done

Create one commit for all changes and synchronise with svn
$ git commit -am "cherry pick merge"
$ git svn rebase
$ git svn dcommit

Now merge in anything picked up from svn, plus the rebased final commit
$ git checkout master
$ git merge svn

Send back to bare repo (at least the final merge commit)
$ git push

It seems to handle changes and preserves linear history on both sides ok.
Can anyone see anything obviously wrong with this approach?

thanks,

Will






William Hall wrote:
 > Thanks Steven,
 >
 > The noMetadata option will prevent me from doing anything other than 
a one-shot import, which is not what I want. I need to somehow devise a 
workflow that allows me bidirectional push/pull between an svn repo and 
a remote git repo.
 >
 >
 >
 > Steven Michalske wrote:
 >> On Jun 16, 2010, at 4:02 PM, William Hall wrote:
 >>
 >>> The issue is the dcommit operation from the bridge. The rebase part 
of this re-writes the commit messages to include the SVN commit-ids 
which is nice, but screws up the push/pulls between the bridge and the 
bare repo.
 >>
 >> Look into svn.noMetadata configuration option.  It will prevent you 
from rebuilding the svn to git bridge if something seriously goes wrong, 
but it prevents the messages from changing.
 >>
 >> svn-remote.<name>.noMetadata
 >> This gets rid of the git-svn-id: lines at the end of every commit.
 >> If you lose your .git/svn/git-svn/.rev_db file, git svn will not be 
able to rebuild it and you won't be able to fetch again, either. This is 
fine for one-shot imports.
 >> The git svn log command will not work on repositories using this, 
either. Using this conflicts with the useSvmProps option for (hopefully) 
obvious reasons
 > --
 > To unsubscribe from this list: send the line "unsubscribe git" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html


William Hall wrote:
> Thanks Steven,
> 
> The noMetadata option will prevent me from doing anything other than a 
> one-shot import, which is not what I want. I need to somehow devise a 
> workflow that allows me bidirectional push/pull between an svn repo and 
> a remote git repo.
> 
> 
> 
> Steven Michalske wrote:
>> On Jun 16, 2010, at 4:02 PM, William Hall wrote:
>>
>>> The issue is the dcommit operation from the bridge. The rebase part 
>>> of this re-writes the commit messages to include the SVN commit-ids 
>>> which is nice, but screws up the push/pulls between the bridge and 
>>> the bare repo.
>>
>> Look into svn.noMetadata configuration option.  It will prevent you 
>> from rebuilding the svn to git bridge if something seriously goes 
>> wrong, but it prevents the messages from changing.
>>
>> svn-remote.<name>.noMetadata
>> This gets rid of the git-svn-id: lines at the end of every commit.
>> If you lose your .git/svn/git-svn/.rev_db file, git svn will not be 
>> able to rebuild it and you won't be able to fetch again, either. This 
>> is fine for one-shot imports.
>> The git svn log command will not work on repositories using this, 
>> either. Using this conflicts with the useSvmProps option for 
>> (hopefully) obvious reasons
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
