From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default remote branch for local branch
Date: Sun, 02 Apr 2006 14:40:48 -0700
Message-ID: <7v7j67k65b.fsf@assigned-by-dhcp.cox.net>
References: <1143856098.3555.48.camel@dv>
	<7vodzmngfp.fsf@assigned-by-dhcp.cox.net>
	<1143865123.14465.26.camel@dv>
	<200604021817.30222.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 23:40:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQAJd-00064v-G6
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 23:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWDBVku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWDBVku
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 17:40:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49309 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964786AbWDBVkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 17:40:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402214049.UWWJ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Apr 2006 17:40:49 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200604021817.30222.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 2 Apr 2006 18:17:29 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18288>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Saturday 01 April 2006 06:18, Pavel Roskin wrote:
>> On Fri, 2006-03-31 at 19:05 -0800, Junio C Hamano wrote:
>> > Maybe you would want something like this.
>> >
>> > In $GIT_DIR/config:
>> > 
>> > 	[pull]
>> > 	origin = linus for master
>> >         origin = irq-pio of libata for ata-irq-pio
>> >         origin = pata-drivers of libata for ata-pata
>
> Let me try to understand this: the general idea is that
>
>   pull.origin = [<refspec> of] <remote> for <branch>
>
> specifies the default action of git-pull if we are on <branch>, ie.
> a "git pull" then runs "git pull <remote> [<refspec>]".

Not quite.

It will be (if this were a serious proposal -- I am not
absolutely convinced this is a good idea) more like "git fetch
<remote>" followed by "git-merge HEAD the-refspec-named-there".
The implementation of the above would involve changes to
git-fetch, because it needs to give ".not-for-merge" mark to
different line in FETCH_HEAD depending on [<refspec> of] part.

> So the example above, if .git/remotes/linus would contain two
> refspecs, and you are on the branch of the 2nd refspec, it would
> do the wrong thing: merge the 1st refspec with current branch.

Sorry I fail to visualize this part.

>> Secondly, I think the relationship should be between a local development
>> branch and a local tracking branch.
>
> Agree.
> It is also useful to specify this relation if the upstream is purely a
> local branch, e.g. when branching off a local branch, and you want to
> pull in changes from the local upstream.
>
> This works automatically if git-pull only does upstream fetching if
> there is a remote branch associated. The default action of git-fetch
> similar could be "fetch the upstream branch, if that tracks a remote
> branch", using the same configuration.

Interesting.  

You would need sanity checker for $GIT_DIR/remotes/* files if
you do this to make sure no local tracking branch is by mistake
configured to track two remote branches, which is a good change,
but then:

	git-pull, without parameter, would:

        (1) check if this branch has any local branch it usually
            merges from; if not, do whatever we traditionally
            did (or barf).

        (2) if there is a local branch it merges from, check if
            it is a tracking branch for a remote, by looking at
            remotes/* files.  It would be nice if we could
            detect tracking branches fed from external svn/cvs
            repositories via svn/cvs-import this way at this
            time.  If not, skip the next step and go directly to
            (4).

        (3) run git-fetch (or svn/cvs-import) to update the
            tracking branch;

        (4) merge from that other local branch.

> Junio's proposal has the advantage that you do not have to search in all
> files in .git/remotes (and even .git/branches) for the remote branch that
> maps to a given local branch.
> But that is not the big issue.

A bigger thing is that I am trying to avoid _requiring_ tracking
branches.  If you are not micromanaging your subsystem
maintainers, you should not have to care where they were the
last time you pulled from them.  You should be able to just
pull, examine what the merge brings in, and decide it is worth
merging.  If it isn't, do a "reset", tell them "not good, please
rework and let me know when you are ready," and forget about it.

If we are going require tracking branches, we could do a bit
more with them, like remembering where the tip was when we
fetched the last time (or the time before that...) and diff with
that, but the tracking branch heads are not set up to do things
like that right now -- they are single pointers.

>> Perhaps you are missing a remotes editor command?

Perhaps.  Also perhaps a remotes/ sanity checker.
Something like this:

	$ git branch --describe ata-pata
        Typically merges from pata-drivers branch of
        	git://.../jgarzik/libata-dev.git
	which is tracked with local refs/remotes/libata/pata-drivers.

	$ git branch --decribe refs/remotes/libata/pata-drivers
	Tracking branch for pata-drivers branch of
               	git://.../jgarzik/libata-dev.git

	$ git checkout origin
        warning: you are checking out a tracking branch for "master" branch of
	warning:	git://.../torvalds/linux-2.6.git
	warning: commit/pull/merge commands are disabled.
	hint: you can still create a new branch from here.
