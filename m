X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 15 Dec 2006 22:42:49 +0100
Message-ID: <200612152242.50472.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612150007.44331.Josef.Weidendorfer@gmx.de> <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 21:43:10 +0000 (UTC)
Cc: "R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34555>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKpb-0004xt-GC for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753506AbWLOVnA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbWLOVnA
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:43:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:53696 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753500AbWLOVm7
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 16:42:59 -0500
Received: (qmail invoked by alias); 15 Dec 2006 21:42:57 -0000
Received: from p5496A9B3.dip0.t-ipconnect.de (EHLO noname) [84.150.169.179]
 by mail.gmx.net (mp001) with SMTP; 15 Dec 2006 22:42:57 +0100
To: "Torgil Svensson" <torgil.svensson@gmail.com>
Sender: git-owner@vger.kernel.org

On Friday 15 December 2006 18:43, Torgil Svensson wrote:
> On 12/15/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > However, there is nothing wrong with it. Yet, you perhaps want
> > the 2 Lib submodules not to go out of sync. This easily
> > can be done with symlinking the Lib checkouts. As they are submodules,
> > everything should work fine.
> 
> This is interesting. In my notation:
> 
> /path/to/link/name -> <commit>/path/to/subtree
> 
> means that there is a link named "name" in the tree object for
> "path/to/link". The link points to a "link object" specifying a
> subtree or blob of the tree that is pointed to in a submodule commit.

Ah, now I understand. I somehow missed this notation.

> This is not currently implemented but has at least the following
> advantages:
> 
> 1. You can access files in a submodule without fetching the whole
> submodule (which may be very large). (App1 is only interested in
> lib1.h, the rest is toally irrelevant)
> 2. Superproject can access referenced (linked) files in it's own
> folder-structure without being forced a structure by the subproject.

That all sounds fine, but how do you create such symlinks in practice?
Do you want to introduce special porcelain commands to create them?
Especially, what is the SCM user supposed to do to change the link
target, ie. from
 <commit>/path/to/subtree
to 
 <commit>/path2/to2/subtree2
?
Should this do a re-checkout at the other point?

By linking a file from a submodule, such a link seems to force that
this file has to be at a fixed position in the submodule. Otherwise,
some magic has to happen when the file is moved in the submodule,
possibly leading to a dangling link, eg. if the whole subdirectory
specified in the link is removed.

IMHO this is getting way to complex.
Much simpler is to include the full submodule at some path in
the supermodule, and create normal symlinks from the supermodule
into the submodule.

If you only want to check out part of a submodule, this should be
done with path-limiting checkouts, which should be a feature totally
independent from submodules.

And if you want to limit the number of objects transferred in cloning
of a subproject, it is better to further split this subproject into
multiple subprojects itself.
 
> If you do a symlink instead, doesn't you loose versioning information?

Of course, you need the submodule fully checked out somewhere in the
supermodule, and the link goes into the submodule directory. The
versioning is given by the supermodule/submodule link.

> What happens with the symlinks if someone clones the superproject?

As already said: the link has to go into a submodule directory, which
will be checked out automatically with the clone of the supermodule.

> > Perhaps an option you want to have is to force a checkout
> > of AppBuild to make these symlinking itself when it detects
> > identical submodules links.
> >
> > Hmmm... the only problem with a symlink is that it can go wrong
> > when moved. Unfortunately, I do not have a good solution for
> > this. We can not make UNIX symlinks smart in any way.
> > Hardlinking directories would be a solution, but that is not
> > possible.
> >
> 
> Wouldn't specifying the submodule path in the link object fit in well
> here? Then each "link object" can represent a checked out tree from
> the subproject in the superproject directory-structure.

The problem is not the representation in the git repository, but the
checked out module/submodule, where you need to use normal UNIX file semantics.
To move submodules around, the user should be able to just use
the normal UNIX "mv" commands, and git should be able to detect move
actions after the fact.
The simple thing here is that currently, git does not have this problem
as it tracks content, and does not even try to detect any moves at
commit time. This is different with submodules, as there, you want to
be able to track moves of any submodule root directories.

This now becomes a problem if you use symlinks to "unify" multiple checkouts
of the same submodule at multiple places in the supermodule, and move
the symlink around, as it easily can get dangling this way. Thus, you would
not have a way to see what submodule this link was talking about.

And for this thing, I do not see how your link object could help.

So it is better to use a simple submodule concept, and for this corner
cases, we perhaps could expect the user to fix e.g. a dangling symlink
to a previous submodule checkout himself, using a meaningful error message.

> > BTW, build project commits probably should not depend on any
> > history of other build commits.
> 
> Why? Can you give an example here.

If you have a source commit chain A => B => C => D, you want
to make any build commits totally independent: you first only
are interested in a build commit for source versions A and D,
and later find out that a build commit for B and C would be nice,
too. If you force build commits into some history order, this
order now would be A => D => B => C, which makes no sense.

Build commit independence can easily be achieved by making every commit
parentless, without further history. You still have the link
to the source version via the submodule link in the tree.
But to not loose any such build commits, they have to appear
as tags or refs (unless integrated in another superproject
build commit).


> > > Link: /headers/lib1.h -> <lib1-commit3>/src/lib1.h
> > > Link: /bin/lib1.so -> <build1-commit>/i386/lib1/lib1.so
> > > Link: /bin/app1 -> <build1-commit>/i386/app1/app1
> > >
> > >
> > > <lib1-commit1>, <lib1-commit2> and <lib1-commit3> should be the same,
> > > dictated by the app1 project.
> >
> > I do not see any problem here. Symlinks are stored in the git repository.
> > As the AppBuild commit depends on App and LibBuild submodule commits, the
> > symlinks always should be correct.
> 
> The main reason for these "links" are for versioning purposes: the
> uniqe SHA1 of the "link" representing a tree/blob in a version of the
> submodule should be "included" in the supermodules commit. Symlinks
> won't give that at all.

The version coupling will be there if the whole submodule is available
at some path in the supermodule checkout, as said above.

