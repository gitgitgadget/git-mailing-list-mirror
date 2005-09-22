From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 14:22:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221413400.2553@g5.osdl.org>
References: <E1EIWUv-0004HR-F6@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:22:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIYWk-0002Ye-FD
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 23:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVIVVWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 17:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVIVVWW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 17:22:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030375AbVIVVWW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 17:22:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MLMCBo016098
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 14:22:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MLM8PE021041;
	Thu, 22 Sep 2005 14:22:10 -0700
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EIWUv-0004HR-F6@jdl.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9143>



On Thu, 22 Sep 2005, Jon Loeliger wrote:
>
> > For example, you can do that with
> >
> >	git fetch linus master:linus
> >
> > which says: "fetch the branch 'master' from the repository described by 
> > 'linus' (.git/remotes/linus) into _my_ branch 'linus'".
> 
> Just to be clear on the overloaded use of "linus" here,
> let me rewrite that:
> 
> 	git fetch foo master:bar
> 
>     which says: "fetch the branch 'master' from the repository described
>     by 'foo' (.git/remotes/foo) into _my_ branch 'bar'".
> 
> Right?

Right.

> OK.  I think I get it.  The concept you are trying to beat into
> my head is essentially the difference between a "complete" and
> an "incomplete" specifier.  If there is enough specification to
> fetch and merge into a branch, you can.  And there are a few
> different ways to do so:
> 
>     A) git fetch rsync:..../linus-2.6.git master:origin
> or 
>     B) git fetch linus master:linus
>        with just the URL bits in the .git/remotes
> or
>     C)	git fetch linus
>         with both URL and "Pull:" clauses in .git remotes
>             URL: rsync:..../linus2.6.git
> 	    Pull: master:linus

Absolutely.

Note that you can also override, so let's say that you have _both_ the
"URL:" and the "Pull:" line in your "remotes" file, the "pull" line is 
still just a default, so you could do

	git fetch linus other:myother

and it would now use the URL line, but since you specified the branch by
hand, it would ignore the default branch information, and instead fetch
the "other" branch from the remote site into the "myother" local branch.

> > Now, this is where "dirty" comes in. The merge will fail if you have 
> > changed any files that the merge wants to modify. So do a
> 
> D'oh.  This is what bites me.  Some of those diffs that
> come back to me in the linus tree are one that I originated
> and sent up stream in the first place.  To get those to
> wash-out with the merge, I will have had to have had those
> committed in my branch, right?

Yes. Then git will merge them for you automatically (if they are 
identical), or may ask you to fix up any merge rejects (if there are 
clashes). 

Now, the fixing up any merges is pretty much exactly the same as under 
CVS - you'll get the same "<<<<" "====" ">>>>" markers.

>			  Otherwise they just look
> like dirty files -- never mind that they are (should be)
> the exact same bits coming back at me.

Right, but git doesn't know, and is too lazy to check. 

I _considered_ allowing a dirty file that happened to match the end 
result, but I never felt it was worth the complexity. It's nasty. And if 
it doesn't match, you really can't merge, because it's too dangerous to 
overwrite the users changes (even if you use some three-way merge and 
leave the rejects there).

> I want to return to this for one last comment:
> 
>     > You can make your .git/remotes/linus file look like this instead:
>     >
>     >	URL: rsync:..../linus2.6.git
>     >	Pull: master:linus
> 
> So, philosophically perhaps, there are several different
> reasons for having branches within a repository.  One of
> them is to track external repositories as indicated above.

Yes.

> But no-one (ie, no tool) currently constructs the .git/remotes
> files to have that layout, right?

The "git clone" thing will construct the original "origin" file to that 
layout. That's fairly recent, though.

And I think "cg-branch" will do it these days - and that's very much the
intent.  Havign porcelain on top of git that hides this thing so that you
don't have to edit configuration files by hand.

(Don't get me wrong: I think it's wonderful to have ASCII configuration 
files that you _can_ edit by hand, and it's the UNIX way of doing things, 
but I also think it's great to have front-end tools that allow doing these 
things without even having to understand the config file syntax etc).

		Linus
