From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Default remote branch for local branch
Date: Mon, 3 Apr 2006 01:28:42 +0200
Message-ID: <200604030128.42680.Josef.Weidendorfer@gmx.de>
References: <1143856098.3555.48.camel@dv> <200604021817.30222.Josef.Weidendorfer@gmx.de> <7v7j67k65b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 01:29:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQC0E-0002HD-JA
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 01:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWDBX2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWDBX2s
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 19:28:48 -0400
Received: from mail.gmx.de ([213.165.64.20]:48060 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751522AbWDBX2r (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 19:28:47 -0400
Received: (qmail invoked by alias); 02 Apr 2006 23:28:45 -0000
Received: from p5496B76B.dip0.t-ipconnect.de (EHLO linux) [84.150.183.107]
  by mail.gmx.net (mp041) with SMTP; 03 Apr 2006 01:28:45 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7v7j67k65b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18297>

On Sunday 02 April 2006 23:40, you wrote:
> > Let me try to understand this: the general idea is that
> >
> >   pull.origin = [<refspec> of] <remote> for <branch>
> >
> > specifies the default action of git-pull if we are on <branch>, ie.
> > a "git pull" then runs "git pull <remote> [<refspec>]".
> 
> Not quite.
> 
> It will be (if this were a serious proposal -- I am not
> absolutely convinced this is a good idea) more like "git fetch
> <remote>" followed by "git-merge HEAD the-refspec-named-there".

So it is not really a <refspec>, but a <localbranch> which has to
appear in the .git/remotes file on the right side of a refspec on
a Pull line.
Then, I think it is redundant to specify the <remote>, as
this can be detected by looking at the .git/remotes files and
searching for <localbranch>.

> > So the example above, if .git/remotes/linus would contain two
> > refspecs, and you are on the branch of the 2nd refspec, it would
> > do the wrong thing: merge the 1st refspec with current branch.
> 
> Sorry I fail to visualize this part.

All I wanted to remark is, that, with

 URL: <remote-URL>
 Pull: refs/head/master:refs/head/remote1
 Pull: refs/head/other:refs/head/remote2

the config

 pull.origin = <remote> for refs/head/my-devel-for-remote2

which does not use the [<refspec> of] part, always is bogus:
We get remote1 merged into my-devel-for-remote2 on a git-pull,
which is not what we want.

> > It is also useful to specify this relation if the upstream is purely a
> > local branch, e.g. when branching off a local branch, and you want to
> > pull in changes from the local upstream.

> 
> Interesting.
> 
> You would need sanity checker for $GIT_DIR/remotes/* files if
> you do this to make sure no local tracking branch is by mistake
> configured to track two remote branches,

Why should this always be a mistake? If you have two developers
doing topic branches for you, you could use this type of config
to make "git-pull" fetching both remotes, and creating an
octopus merge.

And for your "next", you could use this to make "git-pull" merge
both from the stable branch and all topics.

> which is a good change, 

The sanity checker probably should be put into a branch attribute
editor which allows to add the config discussed here. And it
should only print a warning when you are trying to add multiple
upstreams.

> but then:
> 
> 	git-pull, without parameter, would:
> 
>         (1) check if this branch has any local branch it usually
>             merges from; if not, do whatever we traditionally
>             did (or barf).

Yes. This is simply looking up the config.
We could automatically add such a config when branching off to
specify the upstream of a branch.
And git-clone should set this, too, and: We get rid of the current
"origin" hardcoded special handling.

Optionally, branching <new> off from <old> could add <new> as
topic branch of <old>: Thus, if you are on <old> and do git-pull,
you get <new> merged in.

>         (2) if there is a local branch it merges from, check if
>             it is a tracking branch for a remote, by looking at
>             remotes/* files.  It would be nice if we could
>             detect tracking branches fed from external svn/cvs
>             repositories via svn/cvs-import this way at this
>             time.

Good idea. I suppose this needs an entry in .git/remotes like

 URL: ...
 Type: SVN 

>             If not, skip the next step and go directly to 
>             (4).
> 
>         (3) run git-fetch (or svn/cvs-import) to update the
>             tracking branch;

If (1) found multiple branches, do (2)/(3) for every branch.

>         (4) merge from that other local branch.

Or for multiple, do an octopus.


> A bigger thing is that I am trying to avoid _requiring_ tracking
> branches.

I don't think you force anything when you add functionality to git-pull
for the config discussed here. Nobody *has* to use this config - it's
a porcelain thingie.

Cogito could use this, too. AFAIK, it has the same origin/master hardcoded
tracking behavior.

> If you are not micromanaging your subsystem 
> maintainers, you should not have to care where they were the
> last time you pulled from them.  You should be able to just
> pull, examine what the merge brings in, and decide it is worth
> merging.  If it isn't, do a "reset", tell them "not good, please
> rework and let me know when you are ready," and forget about it.
> 
> If we are going require tracking branches,

I do not understand. Why should we require this?

> we could do a bit 
> more with them, like remembering where the tip was when we
> fetched the last time (or the time before that...) and diff with
> that, but the tracking branch heads are not set up to do things
> like that right now -- they are single pointers.
> 
> >> Perhaps you are missing a remotes editor command?
> 
> Perhaps.  Also perhaps a remotes/ sanity checker.
> Something like this:
> ...

Doing this as part of git-branch sounds good.

Josef
