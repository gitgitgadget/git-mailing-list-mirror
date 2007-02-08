From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git rescue mission
Date: Wed, 07 Feb 2007 16:48:42 -0800
Message-ID: <7vr6t13251.fsf@assigned-by-dhcp.cox.net>
References: <17866.27739.701406.722074@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:48:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HExSy-0001I8-Rn
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161504AbXBHAsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161503AbXBHAsp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:48:45 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42868 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161498AbXBHAso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:48:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208004842.MFZH1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 19:48:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Looi1W0191kojtg0000000; Wed, 07 Feb 2007 19:48:43 -0500
In-Reply-To: <17866.27739.701406.722074@lisa.zopyra.com> (Bill Lear's message
	of "Wed, 7 Feb 2007 18:18:35 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39023>

Bill Lear <rael@zopyra.com> writes:

> 2) Why does git pull do the right thing when on master, but seemingly
> changes behavior when on topic?

Because you told it to.

      %  cat .git/remotes/origin
      URL: /repos/git/project
      Pull: refs/heads/master:refs/heads/origin
      Pull: refs/heads/topic:refs/heads/topic

It tells "git pull" to drive "git fetch" to copy their master to
your origin and overwrite your topic with their topic, and then
merge their master to whatever branch you are currently on.

The sane/safe thing to do in the traditional layout (I'll talk
about non-traditional one in a second) is:

 - do your 'pull' only and always while on your 'master' and not
   anywhere else.

 - never build on a branch that appears on the RHS of ':'.

This layout is convenient when you always do fetches and pulls
while on 'master', but has burned enough people.  So what people
on the list seem to recommend is to use a separate remote layout
in the repository.

The principle is:

 * The branches you work on in the repository are kept in refs/heads/

 * Copies of branches from other repositories (it does not
   matter who is in control of them -- some of them may be your
   repository) are kept in refs/remotes/<symbolic name>.

So the current "git clone" (if you are using 1.4.4 series, you
can say "git clone --use-separate-remote") creates something
like this instead:

      URL: /repos/git/project
      Pull: refs/heads/master:refs/remotes/origin/master
      Pull: refs/heads/topic:refs/remotes/origin/topic

(git-clone from 1.5.0 does not actually make remotes/origin file
in .git/ that has the above -- it creates the moral equivalent
in .git/config).

So whatever you do the first step of "git pull", which is "git
fetch", will _not_ overwrite the current branch.

In order to prevent merging their 'master' into your 'topic'
when you are on 'topic', git-fetch/git-pull from 1.5.0 uses
further safety which is left by 'git clone'.  The real
configuration created by 'git clone' looks like this:

	[remote "origin"]
        	url = /repos/git/project
                fetch = refs/heads/*:refs/remotes/origin/*
	[branch "master"]
        	remote = origin
                merge = refs/heads/master

The 'fetch' lines correspond to 'Pull' in .git/remotes/origin file;
it uses globbing pattern so if there are new branches on the
remote side you can automatically track them, which is a plus.

But more importantly, when 'fetch' lines only do the globbing
pattern, 'git pull' without explicitly saying which remote
branch you want to merge to the current branch (perhaps by
mistake) refuses to do a merge, if there is no branch.*.merge
configuration ("refs/heads/master" in the above example).  So
with the above configuration, 'git pull' from 1.5.0 will fetch
two remote branches and keep them in remotes/origin/master and
remotes/origin/topic, and if you are on 'master' their
refs/heads/master is merged into your current branch, but if you
are on 'topic', it will not do the merge step (this only applies
to "git pull" without any refspec parameters).

With 1.4.4 series, I think you can create the [branch] section
yourself and do something like this:

	[remote "origin"]
        	url = /repos/git/project
                fetch = refs/heads/master:refs/remotes/origin/master
                fetch = refs/heads/topic:refs/remotes/origin/topic
	[branch "master"]
        	remote = origin
                merge = refs/heads/master
	[branch "topic"]
        	remote = origin
                merge = refs/heads/topic

This configuration also works with 1.5.0, so if you are happy
with this (I am assuming you are using 1.4.4 series, preferably
the last one, 1.4.4.4), after you upgrade to 1.5.0, it will
continue to do its thing (but you would want to upgrade the
fetch line).
