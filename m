From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to get rid of tracking branch?
Date: Wed, 14 Feb 2007 09:04:42 -0800
Message-ID: <7vsld8r7px.fsf@assigned-by-dhcp.cox.net>
References: <45D30D8F.50261DB0@eudaptics.com>
	<200702141335.41165.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:05:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNYl-0002Jo-Ud
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXBNREo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbXBNREo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:04:44 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56925 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXBNREo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:04:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214170443.FMAI22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 12:04:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PV4i1W00y1kojtg0000000; Wed, 14 Feb 2007 12:04:43 -0500
In-Reply-To: <200702141335.41165.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 14 Feb 2007 13:35:37 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39686>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2007 February 14 13:24, Johannes Sixt wrote:
>> Call me clueless, but how the heck do I get rid of a tracking remote
>> branch? I've cloned a repo locally, but in the clone I don't want to
>> track all the topic branches of the origin. But git branch -d keeps
>> saying it doesn't find the remote branch:
>
>  $ git branch -r -d origin/repo-devel
>
> I suffered the same thing a while ago :-)

I think you would also need to futz with remote.origin.fetch
that says "track all branches from remote", or your next pull
will re-create them.

You probably have

	[remote "origin"]
        	url = ...
                fetch = +refs/heads/*:refs/remotes/origin/*
	[branch "master"]
        	remote = origin
                merge = refs/heads/master

You would change it to list the branch you want to track
explicitly:

	[remote "origin"]
        	url = ...
                fetch = refs/heads/master:refs/remotes/origin/master

However, this has a subtle side effect.  If you create a new
branch, say "test", running "git pull" while on "test" will
merge "master".  This is not wrong per-se (it has been the
traditional git-pull behaviour and if you want to use the remote
branch that is not the one first listed on remote.origin.fetch
line, you can set up branch.test.merge yourself), but it may
surprise you because it is different when you use the globbing
refspec on the remote.origin.fetch line.

So if you want to track only two remote branches, say 'master'
and 'dev', and if you want to also have your own 'master' and
'dev' that builds on them, you would have something like:

	[remote "origin"]
        	url = ...
                fetch = refs/heads/master:refs/remotes/origin/master
                fetch = refs/heads/dev:refs/remotes/origin/dev
	[branch "master"]
        	remote = origin
                merge = refs/heads/master
	[branch "dev"]
        	remote = origin
                merge = refs/heads/dev

Then while on 'master', "git pull" will fetch from origin and
merge their 'master' in, and while on 'dev' "git pull" will
merge their 'dev' in.
