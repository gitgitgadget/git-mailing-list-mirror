From: Wink Saville <wink@saville.com>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 09 Dec 2007 11:12:37 -0800
Message-ID: <475C3E25.30704@saville.com>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 20:13:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1RaJ-0005br-T3
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 20:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbXLITMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 14:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXLITMm
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 14:12:42 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:19114 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbXLITMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 14:12:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1343217rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 11:12:40 -0800 (PST)
Received: by 10.140.169.4 with SMTP id r4mr3805371rve.1197227560272;
        Sun, 09 Dec 2007 11:12:40 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id f42sm4744571rvb.2007.12.09.11.12.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Dec 2007 11:12:39 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20071209104336.GA3163@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67651>

Alex Riesen wrote:
> Wink Saville, Sun, Dec 09, 2007 07:34:01 +0100:
>   
>> I've got several git repositories of different projects and was thinking
>> I should combine into one repository, but my googling around didn't turn up
>> any simple way of doing it.
>>
>> Any advice?
>>     
>
> Should they both be visible in one working tree as directories?
>   
Yes, I currently have:

  ~/prgs/android/StateMachine
  ~/prgs/android/test2
  ~/prgs/android/test-annotation

I'd with 3 git repo's in StateMachine, test2 & test-annotation.
Ideally I was thinking having using submodules as they
separate but related. But not sure submodules are ready.
> Should these be independent branches?
>
> For instance, you can fetch one into another:
>
>     $ cd project1
>     $ git config remote.project2.url /path/to/project2
>     $ git config remote.project2.fetch 'refs/heads/*:refs/project2/*'
>     $ git fetch project
>
> That will give you two (or more) branches, containing history of the
> project1 and project2. They are still completely independent, just use
> the same object store.
>   
So the above isn't what I want, but for grins I tried it, and got to
this point:

wink@ic2d1:$ cd StateMachine
wink@ic2d1:$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
wink@ic2d1:$ git config remote.test2.url ../test2
wink@ic2d1:$ git config remote.test2.fetch 'refs/heads/*:refs/test2/*'
wink@ic2d1:$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "test2"]
        url = ../test2
        fetch = refs/heads/*:refs/test2/*
wink@ic2d1:$ git fetch test2
warning: no common commits
remote: Counting objects: 24, done.  
remote: Compressing objects: 100% remote: (16/16), done.  
remote: Total 24 (delta 3), reused 0 (delta 0)
Unpacking objects: 100% (24/24), done.  
 From ../test2
 * [new branch]      master -> refs/test2/master
wink@ic2d1:$ git checkout -b test2 test2/master
Branch test2 set up to track remote branch refs/test2/master.
Switched to a new branch "test2"
wink@ic2d1:$ git status
# On branch test2
nothing to commit (working directory clean)
wink@ic2d1:$ git status
# On branch test2
nothing to commit (working directory clean)
wink@ic2d1:$ git branch -a
  master
* test2
wink@ic2d1:$ git checkout master
Switched to branch "master"
wink@ic2d1:$ git checkout test2
Switched to branch "test2"

So that worked, but as I mentioned not quite what I want
as I want to "see" them all simultaneously.

> You can merge them, for example:
>
>     $ cd project1
>     $ git merge project2/master
>   
Starting over (restoring the original from a tar backup)
this didn't work I get:

wink@ic2d1:$ cd StateMachine
wink@ic2d1:$ git merge ../test2/master
../test2/master - not something we can merge

> Assuming that there is no filename collisions you'll get a repo with
> two merged histories (and two starting points). In case you get
> conflicts you can either resolve them by editing or just move the
> problematic project in subdirectory:
>
>     $ git merge -s ours --no-commit project2/master
>     Automatic merge went well; stopped before committing as requested
>
> here will be no conflicts. Merge strategy "ours" (-s ours) does not
> take anything from the branch to be merged. The coolest strategy ever.
> "--no-commit" stops the operation just before committing.
>
>     $ git read-tree --prefix=project2/ project2/master
>     $ git checkout-index -a
>     $ git commit
>
> That's it. The histories are merged and the files of project2 are
> placed in the directory "project2". It is a wee bit harder to browse
> the history of the files: you have to give both new and "old" name of
> the project2's files, as if you renamed them (that's what read-tree
> with --prefix did).
>
>   
So the first suggestion works, but I don't want them as
separate branches as I want to work on the simultaneously
and they'll share common code.

Another option I was thinking would work for me would be to use
submodules. But I'm not sure submodules are ready for
neophytes and maybe it doesn't do what I want?

Thanks,

Wink Saville
