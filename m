From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git and securing a repository
Date: Wed, 2 Jan 2008 23:45:52 -0500
Message-ID: <20080103044552.GB24004@spearce.org>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar> <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com> <477B69ED.3090107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201> <20080103035838.GA24004@spearce.org> <477C7459.3020402@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gonzalo =?utf-8?Q?Garramu=C3=B1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Thu Jan 03 05:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAHyI-0004ok-Sa
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 05:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbYACEp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 23:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbYACEp4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 23:45:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41655 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbYACEp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 23:45:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JAHxe-0000a2-0P; Wed, 02 Jan 2008 23:45:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C341920FBAE; Wed,  2 Jan 2008 23:45:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <477C7459.3020402@advancedsl.com.ar>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69509>

Gonzalo Garramuo <ggarra@advancedsl.com.ar> wrote:
> Shawn O. Pearce wrote:
> >
> >If you read the documentation carefully you will note that the
> >pre-receive hook receives input on stdin; 1 line of data per ref
> >that is being pushed with the old/new SHA-1 values and the ref
> >name.  The hook exits 0 to allow all changes to take place and
> >can exit > 0 to abort and disallow all updates.
> >
> 
> Sure, but I cannot pass any sort of authentication to the script other 
> than rely on environment variables or system calls, as git will not 
> provide anything else.

Correct.
 
> To do proper authentication on a file or directory basis, I have to mix 
> two things then:
> 
> A user/group base authentication/login based likely on unix permissions 
> and ssh AND a pre-receive hook script that finds the user/group name and 
> then checks whether the user can change that particular file/directory.
> 
> I hope the ref name is the (relative) path name to the file and not just 
> the file's basename.

No, the ref name is the name of the branch being modified.  If there
is only one branch in your repository its probably always going to
be the default name of "refs/heads/master".

If you want to know what files the user has changed you need to
diff the two SHA-1s (old against new) to come up with the names of
the files being changed; e.g.:

	git diff-tree -r $old $new

The update-paranoid hook in contrib has support for doing this
built-in and can allow A/M/D type changes on specific file paths,
entire directories, or any regex pattern that matches the above.
I use this at day-job to prevent users from doing stupid things to
directories they shouldn't be changing on particular branches.

> To distinguish a bad commit due to tabs for example from an actual 
> permission trouble.  I'm assuming that the stderr/stdout of git hooks is 
> redirected back to the client?

You need to diff the old against the new (or use rev-list to list
all of the commits between old and new and then get the patch for
each of those commits) to determine if the commit is "bad" or not.
Remember that a single git-push can upload hundreds of commits in
one shot to the receiving repository.

But yes, both stdout and stderr of the hook are tied to the stderr
of the client running git-push.  So error messages produced by
the hook to explain why the push is being denied are visible to
the end-user who is executing git-push.  Again, update-paranoid
uses this to tell you if the "committer" line in commit objects is
invalid, or if you are changing a file you shouldn't be.
 
> Even with all of that, it seems it is still not possible to limit pulls 
> to a certain directory only, right?

No.  Git pretty much requires that when you have access to fetch/pull
a repository you have access to *all* of that repository.  Limiting to
a subdirectory would actually require moving that entire subdirectory
into its own repository and using git-submodule instead to manage it.

> Anyway, I think I more or less have the answer I (sadly) expected. 
> Git's authorization mechanism is pretty much a roll your own type thing. 
>  I'll check out the python authorization script that Linus mentioned to 
> see if that alleviates setup troubles a bit.

Its a distributed version control system.  All peers are equal.
Most security in Git is handled by only pulling from sources you
trust, and never allowing someone to push stuff into a repository
you own.

As such it also usually boils down to UNIX filesystem security; what
I let you see is what you can see, what I firewall and hide from
you is what you cannot see.  Quite simple when you think about it,
but then you are moving away from a centralized development model
and going to a distributed one... which is what Git was built for.

-- 
Shawn.
