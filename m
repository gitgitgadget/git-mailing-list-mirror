From: Bob Cotton <bob.cotton@rallydev.com>
Subject: Re: Git and git-svn question.
Date: Fri, 28 Mar 2008 08:38:25 -0600
Message-ID: <m24paqsyla.fsf@rallydevelopment.com>
References: <47ECA3DC.8010901@sezampro.com>
	<ae63f8b50803280427m55f6b957r12745c8e4178588b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ivanisev@sezampro.com, git@vger.kernel.org
To: "Jean-Baptiste Quenot" <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfFzv-0008WM-M9
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 15:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbYC1Oxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 10:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbYC1Oxs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 10:53:48 -0400
Received: from smtp.rallydev.com ([67.88.103.130]:32141 "EHLO
	maldives.f4tech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753894AbYC1Oxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 10:53:47 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 10:53:46 EDT
Received: from boblaptop-2.local.rallydevelopment.com ([10.1.0.177]) by maldives.f4tech.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 28 Mar 2008 08:38:32 -0600
In-Reply-To: <ae63f8b50803280427m55f6b957r12745c8e4178588b@mail.gmail.com>
	(Jean-Baptiste Quenot's message of "Fri\, 28 Mar 2008 12\:27\:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1.50 (darwin)
X-OriginalArrivalTime: 28 Mar 2008 14:38:32.0546 (UTC) FILETIME=[65873420:01C890E1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78417>

"Jean-Baptiste Quenot" <jbq@caraldi.com> writes:

> Hi Bosko,
>
> 2008/3/28, Bosko Ivanisevic <ivanisev@sezampro.com>:
>> My company uses SVN and I have to work on the code from two offices.
>>  Since SVN is far away from git in branching I've decided to set up git
>>  repository as a mirror of company's SVN repo, which I would use as
>>  intermediate repository for my code:
>>
>>  git svn clone -t tags -b branches -T trunk
>>  svn+ssh://company_server/path_to_svn_repo --prefix=company/
>
> -t tags -b branches -T trunk == -s
>
>>  Since I just started to use git I wonder if anyone can give me any hint
>>  what is the best way to accomplish following tasks with git:
>>
>>  - In office 1 and office 2 I clone git repository that is a mirror of SVN:
>>    git clone ssh://company_server/path_to_git_repo
>
> You can't do that as SVN information is not cloned.  You have to call
> git-svn clone on every working copy.

git-svn clone takes on the order of 6 hours for us. I've had some luck
with "pre-clone/post-clone" steps that:

pre-clone (which is run after 'git svn clone')

1. create local branches for all 'remote' (svn) branches. This is so
   'git clone' will create 'remote branches'. These are just
   placeholders for the post-clone step:

   git branch -r | grep -v tags | sed -rne 's, *([^@]+)$,\1,p' | while read branch; do
     echo "git branch $branch $branch"
   done | sh

2. create real git tags from all svn tags (we never branch from tags):

  git branch -r | sed -rne 's, *tags/([^@]+)$,\1,p' | while read tag; do
    echo "git tag $tag 'tags/${tag}^'; git branch -r -d tags/$tag"
  done | sh

3. Now, with this repo, we create a "read-only" bare repo:

   git clone --bare repo /somewhere/public/repo.git

4. cleanup the heads created from #1

   git show-ref --heads | cut -d' ' -f 2 | grep -v master | while read branch; do
     echo "git branch -D `basename $branch`"; 
   done  | sh

5. Now everyone git-clones from this repo, and runs 'post-clone' (below):

   git clone git://somewhere/public/repo.git

We run 1-4 in a cron nightly.

After step 5, we 'post-clone':

1. put all 'origin/remote' branches (created in pre-clone #1) back to
   refs/remote/<branch>

   for i in `git-branch -r | egrep -v 'HEAD|master'`; do
     echo "git update-ref refs/remotes/`basename $i` $i"
     echo "git branch -D -r $i"
   done | sh

2. delete origin/HEAD and origin/master

   git update-ref --no-deref refs/remotes/origin/HEAD origin/master
   git branch -D -r origin/HEAD
   git branch -D -r origin/master

3. delete the origin repo from the config:

   git config --remove-section remote.origin
   git config --remove-section branch.master

4. re-init git-svn

    git svn init -s <your svn repo>

5. rebase
 
    git svn rebase

Now everyone has is working from the same git repo, and they have all
been reconfigured so that svn is the 'origin'.

- Bob
