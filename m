From: "Pico Geyer" <picogeyer@gmail.com>
Subject: Re: Help using Git(-svn) for specific use case
Date: Wed, 17 Sep 2008 16:09:51 +0200
Message-ID: <aa2b76740809170709y77275473k93d48e354bea55e5@mail.gmail.com>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
	 <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 16:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfxkb-0005Wy-2F
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 16:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbYIQOJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 10:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYIQOJx
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 10:09:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:47624 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbYIQOJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 10:09:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3198779rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/qNQ7hDTzkJ9cr3fChxASGTFZ4g72AwpSHHQfnJiGKc=;
        b=aLjRSkQ0f4hhTm3BXRxehBeowmEYwnyJUDCZCcOIeGOZWySwpSJa7yVwqGBlgtNxwg
         IsY7OMQdLd3VqwC9Muf7MvqgLKB3WbBbyuGgv8a/ojrQeLy9jtIyOZdKqi9hwg8x1OBf
         uMhLE+R7a6ez5+dZ2P0AF0p8/aAzARXlZdNag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OcQ4x9PQDx1ufYysvX9nSpmXCcKigqDqFNVYxgvt7ddsKZ2wIuhVGyX1pzXo8CH0sC
         /GyPowaXUFTfkuWXnj2rrtOitUq2vrWv1hGSKu2dbquDBB3MzC1IUCVK7qMs0lwso6QS
         a51JE1qtlrl+Rd6qomg/dnjkErmyZM0YDedmc=
Received: by 10.141.41.12 with SMTP id t12mr6518030rvj.282.1221660591115;
        Wed, 17 Sep 2008 07:09:51 -0700 (PDT)
Received: by 10.141.193.16 with HTTP; Wed, 17 Sep 2008 07:09:51 -0700 (PDT)
In-Reply-To: <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96115>

Hi Dmitry

I'm going to give example commands to confirm my understanding of the
git-svn workflow you described.
Any comments or corrections are welcome.

On the local server, get a clone of the repository:
srvA# git svn clone http://server.com/repo/proj/trunk proj
srvA# cd proj

Create a local branch, where developers will push to
srvA# git branch integration

Now a developer clones the repository on the server, and makes a local
branch for developement:
dev1# git clone ssh://svrA/path/to/repo
dev1# git checkout -b new_featureX
(Developer makes some changes and commits to the new_featureX branch)

Developer now pushes the changes to the integration branch
dev1# git push origin new_featureX:integration

The merge master now rebases the changes on to the master branch:
srvA# git rebase integration

Now push the changes to the upstream subversion server:
srvA# git svn dcommit

At some stage svn users will commit to the subversion repository, and
we will need to pull changes into srvA:
srvA# git svn rebase

Now the integration branch does not include the changes in master, so
rebase the changes to integration:
srvA# git rebase master integration

Finally the developer needs those changes too, so on his master branch:
dev1# git rebase origin

Is this the process that you were trying to describe?
Any additional steps that need to be added?

And how do I make sure that when developers push to the server that it
results in a fast-forward merge? Do I do that with commit hooks?

Thanks again for the advice.
Pico

On Mon, Sep 15, 2008 at 9:55 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Mon, Sep 15, 2008 at 4:50 PM, Pico Geyer <picogeyer@gmail.com> wrote:
>>
>> At the head office, we are (still) using a Subversion server to host
>> our source code.
>> At the branch office, we would like to do the following:
>> * Fetch the latest code from the subversion server.
>> * Push changes that we have made at the remote office back to upstream
>> SVN server.
>> * Be able to share source code changes locally (at the branch office)
>> between developers.
>
> I used Git in somewhat similar situation where almost all development
> was done in Git mirror of SVN, and then the work was propagated to SVN.
> There are some limitations with this approach. The most important is
> that SVN does not support merges, so you have to linerialize all history
> that you want to commit in SVN. That means that you are going to use git
> rebase a lot to rewrite history, which is a PITA. Another problem with
> this approach is that the author is not preserved. In SVN, all commits will
> look like all changes are done by the person who run "git svn dcommit".
>
> Yet, despite of all these limitations caused by using SVN as backend,
> it was far more pleasant to work with Git than with SVN (you can save
> your work in progress, you can easily organize the review process,
> and many other features such as "git bisect" or "git log -S" just to
> name a few...).
>
>>
>> The solution that I imagined is that we would setup a server (lets
>> call it A) at the branch office with a Git repository, that all the
>> developers can access.
>> Developers would then clone the server repository A, make mods and
>> then push changes back to A.
>> It would be nice if git users could commit to a subversion branch.
>> A merge master would then (as necessary) use svn dcommit to push the
>> changes up to the svn server.
>> Is this scenario possible?
>
> Each user has its own copy of the whole repository and they always
> commit to their _local_ branches. Then they can push their changes to
> the Git repo on your server, but it is a bad idea to push changes to
> a local branch of a non-bare repository especially if that branch is
> checked out, because push does not (and should not!) update the working
> tree and that leads to the situation where all pushed changes are
> looked undo in the working tree of that repository. Therefore, you
> will probably have a separately integration branch to which users
> will push. Oftentimes, users will have to rebase their work on top the
> integration branch to be able to push on it (only fast-forward push
> should be allowed).
>
> The merge master will merge this branch to the local branch assotiated
> with subversion (it will be fast-forward, not a real merge) and then
> run git svn dcommit to propagate to subversion.
>
> If there were some conflicting changes in subversion repo, the merge
> master will have to resolve them. After that update the merge base
> should be updated (using git branch -f) to point out to the top of
> the subversion branch.
>
> If users have some changes that were based on the old integration
> branches they will have to rebase them to the new position of the
> integration branch. As I said above, git rebase is going to be very
> often operation in this workflow.
>
> NOTE: branches in git differs from what they are in subversion. In
> essence, they are no more than pointers to where to add the next
> commit. When I learned Git, I found very useful the article called
> "Git for computer scientists" to understand basic ideas of how Git
> works: http://eagain.net/articles/git-for-computer-scientists/
>
>>
>> From the git-svn man page: "git-clone does not clone branches under
>> the refs/remotes/ hierarchy or any git-svn metadata, or config. So
>> repositories created and managed with using git-svn should use rsync
>> for cloning, if cloning is to be done at all."
>> Does that mean that one should not push changes to a repository that
>> was created with "git svn clone ..."?
>
> No, what the above description says is that SVN specific information is
> not cloned when you clone a repo created by svn. It means that users who
> cloned from you will not be able to use git-svn to push their changes in
> the original subversion repository. Yet, they can push to your repository
> as to any other Git repository.
>
> Dmitry
>
