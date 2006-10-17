From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-fetch: Use already fetched branch with the --local flag.
Date: Tue, 17 Oct 2006 10:36:35 +0200
Message-ID: <8aa486160610170136n28ef3f94q630127982156a115@mail.gmail.com>
References: <87ac3w8jl1.fsf@gmail.com>
	 <7vbqobo1m1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 10:36:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZkRE-00069b-Aa
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 10:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423166AbWJQIgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 04:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWJQIgh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 04:36:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:11282 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423166AbWJQIgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 04:36:36 -0400
Received: by wx-out-0506.google.com with SMTP id h28so2150386wxd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 01:36:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BwEV4B4pOTSSBcgYhMabsdd7t1wZHxpUjfKVh4EuT7k0XRdidwbFUfQTeE8AHqmc0HLxdD5XtXydZKuBGvQjoG5I0S0UDP/9fRI8ZLA0+wm2V9zfIhV+ABMCkV8X3eOcmHwz2gSM/tJihouurH6Efbu0aa8GuoQ9YypdRbEIxAM=
Received: by 10.70.47.19 with SMTP id u19mr13289423wxu;
        Tue, 17 Oct 2006 01:36:35 -0700 (PDT)
Received: by 10.70.46.8 with HTTP; Tue, 17 Oct 2006 01:36:35 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqobo1m1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29037>

2006/10/17, Junio C Hamano <junkio@cox.net>:

[...]

>
> You have an upstream repository that has more than one branches
> you are interested in, say "master" and "next".  And you work on
> top of both of them, so you have two branches of your own that
> correspond to them.
>
> So you organize your remote section perhaps like this:
>
>         [remote."origin"]
>                 url = git://git.k.o/.../git.git/
>                 fetch = refs/heads/master:refs/remotes/origin/master
>                 fetch = refs/heads/next:refs/remotes/origin/next
>                 fetch = +refs/heads/pu:refs/remotes/origin/pu
>
>         [branch."master"]
>                 remote = origin
>                 merge = refs/heads/master
>
>         [branch."next"]
>                 remote = origin
>                 merge = refs/heads/next
>
> That is, your refs/heads/master corresponds to upstream's master
> branch and your next corresponds to upstream's next branch.
> When you are on your "master" you would merge changes made to
> upstream's master into it with "git pull".

Yes, that is.

>
>         By the way, could you add descriptions on remote.* to
>         Documentation/config.txt?
>

I'll try. Off-topic: Do you want also docs for the ^@ notation and an
implementation in git-rev-parse?

> After doing a "git pull" while on your "master" and finishing
> working on your "master", you might switch to your "next".  At
> that point, if you want to merge upstream changes without
> re-fetching, you can do either of the following:
>
>         git pull . remotes/origin/next
>         git pull --local
>
> (the former can be "git pull" if "branch.next.remote=.").
>
> I think this is the point of your two patches, and in that
> sense, the --local one makes "branch.remote=." patch
> unnecessary.

I see them differently. "branch.remote=." is when there is no upstream
(e.g., for your next and master branches in git.git).

>
> While these save typing on "git pull", two things bother me.
>
>  * the tool is not helping you decide if you can get away
>    without re-fetching.  you need to remember that (1) you
>    fetched from the upstream to update "master" recently _and_
>    (2) because of your [remote."origin"] configuration your
>    remotes/origin/next was updated while you pulled into your
>    "master".

You never know if you can get away without re-fetching (or I don't
parse this sentence :). The way I see it, you always us "git pull"
except when you want to merge the exactly the already fetch branch
because (1) you want to merge the same upstream as with other branch
(2) you don't have access to the remote repository (3)...

>
>  * while the workflow assumes that one local branch is tied
>    closely to one remote branch (in this example, tracked under
>    remotes/origin), the rest of the tools do not take advantage
>    of that assumption to help you decide what to do next.

This is the next item in my TODO :)
Next with a program similar to "svn info" showing misc info about a branch.

>
> For example, if each of your local branch is tied closely to one
> remote branch, you should be able to "git fetch" to update the
> tracking branches and then ask:
>
>  - what changes are in remote that I haven't merged?
>
>  - what happens when I pull --local right now?
>
>  - what changes if any are in mine alone missing from remote?
>
>  - can I push to remote right now (i.e. would it fast-forward)?
>
>  - how fresh is the tracking branch that corresponds to my
>    current branch?
>
> Right now, these require you to spell out the name of the
> tracking branch.  Assuming you are on your "next" branch:
>
>         git log ..remotes/origin/next
>         git log remotes/origin/next..
>         git log remotes/origin/next...next              [*1*]
>         git show-branch remotes/origin/next next
>         tail -n 1 .git/logs/remotes/origin/next
>
> would be the ways to ask the above questions (and the last one
> is unreadable unless you can do strptime in your head).
>
> Maybe we can introduce a new extended SHA-1 notation to mean
> "the tracking branch this branch usually merges from".  Then we
> can say:
>
>         git log ..^
>         git log ^..
>         git log ^...
>         git show-branch ^ next
>
> I am not sure '^' is syntactically viable, but hopefully you get
> the idea.

I get it. Another idea is to have a .git/ORIGIN that points to the
tracking branch so you could say:

         git log ..ORIGIN
         git log ORIGIN..
         git log ORIGIN...
         git show-branch ORIGIN next

One advantage is that it only needs changes to "git checkout" (and
possibly others but not to plumbing ones).
Another is that the ^ notation forces the low level tools to follow
configs in [branch."..."] and [remote."..."].
>
>
> [*1*] While three-dots symmetric difference is a nice addition
> made recently, I often find it irritating that the output does
> not tell which branch each of the commit is reachable from, and
> end up running show-branch, which does.  Would anybody have a
> clever idea to fix this cleanly?

I don't know if it is a clever idea but...

We could use the git-name-rev method:

$git log a...b
commit sha1 (a)
....

commit sha1 (a^)
....

commit sha1 (b^)
....

commit sha1 (b)
....

and without this when on both branches.

Santi
