From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn problem: unexpected files/diffs in commit
Date: Fri, 25 Aug 2006 17:46:58 -0700
Message-ID: <m2lkpcfhml.fsf@ziti.local>
References: <m2u040n5e2.fsf@ziti.local> <20060825191516.GA8957@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 26 02:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGmK9-0002Ip-Bh
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 02:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422902AbWHZAqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 20:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422950AbWHZAqn
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 20:46:43 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:30635 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422902AbWHZAqn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 20:46:43 -0400
Received: by py-out-1112.google.com with SMTP id n25so1453704pyg
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 17:46:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=oZMzN/K7uscDveCeodD6gckpZ9ewcCheJ0+3PxcR1celQwQvAIcMYkzKG9f3IK46zSoyrlZKz8ED3NZbNA+SobagjbXzTLuWdmB9nalbTB0AHNHBxY5wv6VvCtoVQttsX4+gh9pdAhmwbtv9dDDvj4JFrFI5xtb2fHiCPvS7qZo=
Received: by 10.35.128.1 with SMTP id f1mr6297960pyn;
        Fri, 25 Aug 2006 17:46:42 -0700 (PDT)
Received: from ziti.local ( [140.107.181.122])
        by mx.gmail.com with ESMTP id 8sm206765nzn.2006.08.25.17.46.41;
        Fri, 25 Aug 2006 17:46:42 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060825191516.GA8957@localdomain> (Eric Wong's message of "Fri, 25 Aug 2006 12:15:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26022>

Eric Wong <normalperson@yhbt.net> writes:
> Cool that it works for you, I've yet to get SVN:: libs working with a
> repository I didn't have full read access to.  I assume you have full
> read access?

Yes, I have full rw access on that part of the svn repos.  The 
SVN:: libs are noticeably faster.

Aside:
   For others tracking this: the "SVN::" libs in question are the Perl
   bindings that come with Subversion and are optionally built when
   you build from source.  I wasted some google time searching CPAN
   for SVN:: so this might help someone. :-)

> Outside of the SSL problems, the mis-commit isn't strictly user-error,
> but git-svn is confusing in this case, as the documentation is unclear
> about what git-svn should do in this case :x

> I usually check with git log remotes/git-svn..HEAD instead of git
> diff.  Perhaps adding --no-merges would be more correct?

I'm not sure how to reproduce the situation I was in, but what would
git log have shown me that git diff didn't -- IOW, would it have been
obvious that the commit op was going to add extra stuff and
effectively undo a rev in svn?

> Simple answer: instead of pull, you should've used git rebase.  But I
> don't think the documentation makes it clear at all.

... reads git-rebase man page...
Ah, git-rebase does sound like what I want.

> I've been really slacking on the git-svn documentation the past few
> months, help would be much appreciated.

I will try to send some doc patches.  But I may have a few questions ;-)

> Here's an in-depth explanation:
>
> This is what git-svn does when issued "commit remotes/git-svn..master":
> 1. git-rev-list remotes/git-svn..master | tac =>
> 	0681f7614c342b85b91d909ff02a9a966a44c3f4
> 	0cccf3753b472b52a93154ed8021499055bb3923
>
> 0cccf3753b472b52a93154ed8021499055bb3923 is the result of your
> 'git pull . remotes/git-svn', correct?
> And 0681f7614c342b85b91d909ff02a9a966a44c3f4 was made to git before
> the pull.
>
> So this is what git-svn does, it commits the output of:
> diff-tree f5ebf17f7e460d3bc3de72ab381c72dc76d26936 0681f7614c342b85b91d909ff02a9a966a44c3f4
> (f5eb... is remotes/git-svn at that point).
>
> If the SVN/SSL connection had not died, it would've then proceeded to
> commit the output of:
>
> diff-tree 1b75d81a95da328f0b0d06b7562fdb48970b4c98 0cccf3753b472b52a93154ed8021499055bb3923
> Where 1b75d81a95da328f0b0d06b7562fdb48970b4c98 is the output of your
> previous commit (r19467)

I think I'm getting it.  Thank you very much for providing these details.

> Personally, I've been starting to favor 'git-svn commit-diff' myself
> over 'git-svn commit', as it leaves cleaner history and makes git-svn
> fetch results reproducable on different machines.
>
> [1] - unfortunately, I seem to have forgotten about it since I use
> commit-diff more often these days :x

I think commit-diff might be what I want to be using too, but I need
to contribute some documentation for it before I can read the man page
and start using it ;-)

An example call to git-svn commit-diff would be very helpful, I
suspect.

I will have a look...

While I'm thinking of it, it would be really nice for git-svn's commit and
commit-diff to have a dry-run type of flag.  Commits to your own git
repos are easy to correct, but those made on some other public scm are
less pretty.

Cheers,

+ seth
