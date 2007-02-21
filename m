From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Wed, 21 Feb 2007 12:00:13 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702211031470.6485@iabervon.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702210014140.6485@iabervon.org> <7vmz37pxf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 18:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJupM-0003zK-N9
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 18:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbXBURAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 12:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbXBURAS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 12:00:18 -0500
Received: from iabervon.org ([66.92.72.58]:3605 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422670AbXBURAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 12:00:16 -0500
Received: (qmail 28573 invoked by uid 1000); 21 Feb 2007 12:00:13 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Feb 2007 12:00:13 -0500
In-Reply-To: <7vmz37pxf8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40305>

On Wed, 21 Feb 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > "git apply" should be able to notice the many clues that this patch 
> > doesn't go at the root: (1) it's not -r; (2) it's not a rename, but the 
> > filenames aren't the same; (3) there isn't an extra path element to 
> > remove.
> 
> I would sort-of agree with (1) and (3) but people can do
> 
> 	cd drivers && diff -u Makefile~ Makefile
> 
> so (2) is not a good clue and (3) is not really either.

In this case you get:

--- Makefile~   2007-02-16 18:03:16.000000000 -0500
+++ Makefile    2007-02-19 20:13:18.000000000 -0500

Which means that the before and after filenames don't agree. And this 
isn't a patch where git can tell what it applies to, so I think (2) is 
giving the right conclusion in this case. I'm not seeing any case where 
(1), (2), and (3) all don't trigger, and the patch isn't BCP, except for 
the case I gave in my previous email, which I don't think anyone would 
actually do (if only because it would be confusing and annoying to prepare 
the change).

So my contention is that git can reliably detect non-git-formatted/BCP 
patches, and so convenient support for git-formatted/BCP patches is 
beneficial, because it won't cause git to do the wrong thing.

I think it's as simple as: if apply.c line 290 changes name, the patch 
shouldn't be assumed to be "absolute" (-p1 in the repository root). Other 
than that, I think the patch pretty much has to be "absolute", unless the 
author has done something really odd. And I think an author who does that 
will just be misunderstood in general, including by human reviewers.

> However, the current version (in v1.5.0.1) of git-apply has a
> few inconsistencies.
> 
>  * When --index (or --cached) is given, and when the patch is a
>    git generated (or BCP formatted) patch, it finds out where in
>    the working tree you are, and strips the right prefix
>    automatically.
> 
>  * When there is no --index nor --cached, however, it does not
>    bother to find out where in the working tree your $cwd is,
>    and assumes you are at the toplevel (you may not even be in a
>    git managed tree but are using git-apply as a better "patch",
>    in which case there is no way to find out where the toplevel
>    is).  You need to give -p<n> to explicitly strip the leading
>    path.  This is not a problem but happens to be a feature to
>    help applying handcrafted patches, like G.patch above.  Also,
>    it is consistent with how GNU patch would behave.  However,
>    -p<n> is ignored when the patch is a git generated one, which
>    is a minor additional problem.
> 
> I was initially in favor of correcting this inconsistency by
> matching the behaviour of non --index/--cached case to that of
> the behaviour of --index/--cached case (in other words, making
> things more convenient for people who apply git generated and/or
> BCP formatted patches).  But Linus talked me out of it --- and I
> think he is right.
> 
> Inconsistency is fixed by making the behaviour more similar to
> "GNU patch".  The behaviour of --index/--cached case is changed
> so that it does not automatically strip "some/dir" part when you
> are in a subdirectory, which is how git-apply without these
> options operates.  Of course, ignoring -p<n> for git generated
> patches no longer makes sense with this change, which is also
> fixed, so you can use the same -p<n> as you would give to "GNU
> patch".

I think there are three cases:

 - "absolute" patch in a git repository. We can tell it's "absolute", and 
   we know what the project root is, so we know what the correct -p<n> 
   level is. We should default to the right answer, and give an error if 
   the user specifies something else.

 - "absolute" patch in a non-git repository. We know the paths of the 
   files relative to the repository root, but we need -p<n> to determine 
   what the repository root is. We should default to -p1, and let the user
   specify they're running git-apply in a subdirectory with -p<n>.

 - non-"absolute" patch. We don't know what directory the patch author was 
   in, relative to the author's repository root. We should require that 
   the user figure it out and use -p<n> to specify the right answer. But 
   maybe we could still default to -p1, because it's relatively safe and 
   traditional (if it's not right, chances are there won't be any filename 
   left, and we'll just give an error).

I think that the only way this would go wrong is if the user is applying 
an "absolute" patch to the toplevel Makefile when in a subdirectory of a 
non-git tree, and expects to get an error message instead of having it try 
to patch the subdirectory Makefile.

I don't see any reason to match GNU patch, because that just means that 
we're doing something we know is wrong in the first case, and something we 
suspect is wrong in the third case. 

On the other hand, I agree that the old interpretation of -p<n> wasn't 
right. I think the first case above should change the *default* plevel, 
not (as it used to) change the interpretation of the default -p1. I.e., if 
you're in drivers/usb/, and you apply a BCP patch, it should work with -p3 
and give an error with -p1, but it should also work without a -p<n> 
option.

> P.S.  I think the list hasn't heard from you for quite some
> time.  Welcome back.

Thanks. :) I've been following the list somewhat, but I've been 
too distracted with other projects to get involved with discussions.

	-Daniel
*This .sig left intentionally blank*
