From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 12:13:46 -0700
Message-ID: <4FA2D8EA.7030809@palm.com>
References: <4F9F128C.5020304@palm.com>            <201204302331.q3UNVo7o032303@no.baka.org>            <4F9F28F5.2020403@palm.com>            <201205010137.q411bxaU002449@no.baka.org>            <4F9F52B9.9060508@palm.com> <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 21:13:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1TN-00014O-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276Ab2ECTNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:13:48 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:35484 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab2ECTNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:13:48 -0400
X-IronPort-AV: E=Sophos;i="4.75,526,1330934400"; 
   d="scan'208";a="13294857"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 03 May 2012 12:13:47 -0700
Received: from fuji.noir.com ([10.100.2.12])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q43JDk4x031238;
	Thu, 3 May 2012 12:13:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196945>

On 4/30/12 22:32 , Michael Witten wrote:
> On Mon, 30 Apr 2012 20:04:25 -0700, Rich Pixley wrote:
>
>> I don't need separate branches for each repository.  What I really want
>> is a common branch whose changes I can push back and forth between the
>> various repositories, or coordinate through a central cache, without
>> worrying about the underlying details that git is forcing me to confront.
>
> Here's a start for a more precise discussion.
>
> Sincerely,
> Michael Witten
>
>
> Cache server:
>
>    $ git clone --mirror "$uri_for_central_repo"
>
> Machine A:
>
>    $ git clone "$uri_for_cache_repo"
>    $ git checkout -b feature_0 origin/feature_0
>    $ # ... do some work ...
>    $ git push --set-upstream origin HEAD:shared/feature_0
>    $ git config push.default upstream
>
> Machine B:
>
>    $ git clone "$uri_for_cache_repo"
>    $ git checkout -b feature_0 origin/feature_0
>    $ # ... do some work that conflicts with work done on Machine A...
>    $ git push --set-upstream origin HEAD:shared/feature_0
>    To $uri_for_cache_repo
>     ! [rejected]        HEAD ->  shared/feature_0 (non-fast-forward)
>     error: failed to push some refs to '$uri_for_cache_repo'
>    To prevent you from losing history, non-fast-forward updates were rejected
>    Merge the remote changes (e.g. 'git pull') before pushing again.  See the
>    'Note about fast-forwards' section of 'git push --help' for details.
>    $ git pull origin shared/feature_0
>    From $uri_for_cache_repo
>     * branch            shared/feature_0 ->  FETCH_HEAD
>    Auto-merging a
>    CONFLICT (add/add): Merge conflict in a
>    Recorded preimage for 'a'
>    Automatic merge failed; fix conflicts and then commit the result.
>    $ # ... resolve conflict and commit results ...
>    $ git push --set-upstream origin HEAD:shared/feature_0
>    $ git config push.default upstream
>
> Machine A:
>
>    $ git pull # pulls in origin's shared/feature_0
>    $ # ... do some work ...
>    $ git push # pushes to origin's shared/feature_0
>
> Machine B:
>
>    $ git pull # pulls in origin's shared/feature_0
>    $ # ... do some work ...
>    $ git push # pushes to origin's shared/feature_0
>
> Machine A:
>
>    $ git pull
>    $ git remote add central "$uri_for_central_repo"
>    $ git push central HEAD:feature_0 # Assume there is a conflict
>    To $uri_for_central_repo
>     ! [rejected]        HEAD ->  feature_0 (non-fast-forward)
>    error: failed to push some refs to '$uri_for_central_repo'
>    To prevent you from losing history, non-fast-forward updates were rejected
>    Merge the remote changes (e.g. 'git pull') before pushing again.  See the
>    'Note about fast-forwards' section of 'git push --help' for details.
>    $ git pull central feature_0
>    $ # ... resolve conflict and commit results ...
>    $ git push central HEAD:feature_0 # Assume it succeeds this time
>    $ # Let's update the cache repo from Machine A:
>    $ git fetch central
>    $ git push origin 'refs/remotes/central/*:refs/heads/*'
>
> Machine B:
>
>    $ git pull
>    $ git pull . origin/feature_0 # Get new stuff cached from central server

This is probably what I'm going to end up using.

Just for comparison, here's a similar process in hg.

Cache server:

   $ hg clone $uri_for_central_repo

Machine A:

   $ hg clone $uri_for_cache_repo
   $ # ...do some work...
   $ hg push

Machine B:

   $ hg clone $uri_for_cache_repo
   $ # ...do some work...
   $ hg push # assume this collides
   pushing to $uri_for_cache_repo
   searching for changes
   abort: push creates new remote head 6d2eb0a6a278!
   (you should pull and merge or use push -f to force)
   $ hg push -f # the pull and merge case parallels git, so let's use 
push -f.

Any repo:

   $ hg pull # pulls in all changes including the dual heads
   $ hg merge # collapses the dual heads
   $ hg commit # commits the merge
   $ hg push

Machine A:

   $ hg pull # pulls in all changes so far
   $ hg up
   $ #... do some work ...
   $ hg push

Machine B

   $ hg pull
   $ hg up
   $ # ... do some work ...
   $ hg push

Any repo:

   $ hg pull $uri_to_central_repo
   $ hg merge
   $ hg push $uri_to_central_repo
   $ hg push # default is cache repo

Machine B:

   $ hg pull


Some Conclusions:

* the work flows are similar.

* the hg commands are simpler and have the defaults that we want, 
primarily because no extra branches are required.

* the hg error messages are straightforward, clear, and don't require 
any deep knowledge of the source code control system or it's 
limitations.  (I still don't understand what the git message on 
collision is saying.)

* hg has more options about how to handle the collisions or the merges. 
  While git can mimic some of those options, doing so requires a priori 
knowledge that isn't stored in the source code control system and 
therefor requires a human exchange which is optional with hg.

--rich
