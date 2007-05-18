From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 11:57:08 +0300
Message-ID: <20070518085708.GC4708@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com>
	<20070517215841.GB29259@mellanox.co.il>
	<200705180141.06862.Josef.Weidendorfer@gmx.de>
	<200705180857.18182.andyparkins@gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 10:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoyGw-0006St-2m
	for gcvg-git@gmane.org; Fri, 18 May 2007 10:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbXERI5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 04:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbXERI5K
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 04:57:10 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:4976 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbXERI5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 04:57:07 -0400
Received: by py-out-1112.google.com with SMTP id a29so1095805pyi
        for <git@vger.kernel.org>; Fri, 18 May 2007 01:57:06 -0700 (PDT)
Received: by 10.65.235.7 with SMTP id m7mr5835020qbr.1179478626136;
        Fri, 18 May 2007 01:57:06 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id d2sm3718203qbc.2007.05.18.01.57.03;
        Fri, 18 May 2007 01:57:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200705180857.18182.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47582>

...

> > As relative path I would propose $SUPERURL/subproject/$SUBPROJECTNAME, ie.
> > if the superproject is at git://git.kernel.org/pub/super.git, the above
> > subproject would default to the URL
> > git://git.kernel.org/pub/super.git/subproject/linux24 which could be a
> > symlink on the server.
> 
> I'm really uncomfortable with the idea of relying on directory structure 
> passed the root repository path; from the
>  git://git.kernel.org/pub/super.git/
> point onwards; we don't have any right to expect that this is a real directory 
> tree.  As an example; svn URLs don't match up with what's on disk:
> 
>  svn://svnhost/pub/repo/trunk/src
>                        ^^^^^^^^^^
> 
> On disk there is no such directory as /trunk/src under the repository 
> directory.  In the same way, even technically what you suggest would work, 
> the part of the URL under git://git.kernel.org/pub/super.git/ is git's own 
> namespace - it's not the users to mess with.  E.g. if I had a subproject 
> called "refs" you'd be in trouble.

Oh, that's easily solvable: just stick a 'subprojects' directory in there.
That is, the default URL to find a subproject would be:

1. For non-bare repo foo/.git/, subproject bar will live in foo/bar/.git
   or foo/bar.git.
2. For a bare repo foo.git/, subproject bar will live in
   foo.git/subprojects/bar.git.

> > > 2. Suppose .gitmodules in upstream tree points at subproject repo at
> > > kernel.org, and I clone from there - my repo will point at kernel.org by
> > > default? But now, I'd like everyone who clones from *my* repo to get
> > > pointed at *my* server by default (e.g. for mirroring),
> > > but would not changing .gitmodules create a commit so my
> > > head will now differ from upstream  - so it won't be signed properly
> > > etc... Did I misunderstand something?
> >
> > No, that is correct. Supporting a relative URL specification as proposed
> > above should solve this issue.
> 
> I think that's the wrong solution.  A change of source URL for a submodule 
> from what upstream uses to your own server is a _fork_ from upstream, 
> therefore you would fork your own branch in your supermodule and 
> alter .gitmodules to point at your server.  Everybody is happy, and the fork 
> is recorded.

Why should I record it? If the content is the same, the commit name should
be the same, it shouldn't matter where did the content came from.

I wouldn't be happy: I have just cloned both project and superproject,
but to re-publish the superproject using my clone of subproject, I have
to create a new commit, which would have a different hash from the origin.
So how do people know they can trust my tree?
And what happens when the original super-project pulls from me -
it seems that his .gitmodules will now point to my server?

> The override system is only there for the local repository (which always takes 
> precedence) not for the server provider to hide detail from those checking 
> the repo out.

I really like it that currently, in git, there is no difference between a public
and local repository.  If the override system is only for the local repository,
we create a difference here - doesn't this break the distributed nature of git?

Take offline work as an example:

So I have have cloned the supermodule and the submodule to my laptop -
it's enough to edit .git/config and I can use the history locally - that's good.
But now I try to clone the local tree - and a clone will try to go out
to the URL which I cloned - bad.

-- 
MST
