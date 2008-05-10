From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit / jgit] Implementation of a file tree iteration using ignore rules.
Date: Fri, 9 May 2008 20:11:32 -0400
Message-ID: <20080510001132.GF29038@spearce.org>
References: <48244F88.8060109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: Florian =?utf-8?Q?K=C3=B6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Sat May 10 02:12:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuchP-0004dN-Fh
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 02:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbYEJALi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 20:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757271AbYEJALh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 20:11:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40024 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884AbYEJALg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 20:11:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JucgN-0002MD-Q6; Fri, 09 May 2008 20:11:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 970C820FBAE; Fri,  9 May 2008 20:11:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48244F88.8060109@web.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81637>

Florian Kberle <FloriansKarten@web.de> wrote:
> 
> I like the idea of a Java implementation of git and would like to
> contribute to the jgit/egit project.

Even better, we'd love to have you contribute!  :-)
 
> In order to get familiar with the code I started to implement a command
> like tool which works like git using the jgit library. I implemented
> very simple versions of the commands "help", "init"

This is an interesting start.  Did you see the existing "Main" class
in org.spearce.jgit/src/org/spearce/jgit/pgm?  It sets up and invokes
a TextBuiltin, which is sort of like the "Command" class you added in
your first patch.  Though TextBuiltins are created on-the-fly and thus
are harder/impossible to use to format a "jgit help".

I think your approach of building up a table of commands is likely
the better one long term, so I am interested in seeing the two unify,
taking the best from each (from Main and MainProgram that is).

Please note that jgit is restricted to Java 5 APIs only right now.
The "MainProgram" class you introduced uses Arrays.copyOfRange()
which does not compile under Java 5.  I guess it is new in Java 6?

> and finally wanted
> to implement the "add" command. However, I didn't find any tools to
> determine the files which should be added.

Right.  We haven't implemented this properly yet.  So I am very
happy to see someone starting to approach this.

> So I implemented a factory which returns an Iterable<File> for the
> iteration over all the files in a directory.

Sadly this is a reimplementation of the already existing FileTreeIterator,
which is meant to be used within a TreeWalk instance.

The TreeWalk API is meant to iterate over a working directory in
canonical tree entry name ordering, so that we can walk not just
a working directory but also the index file and one or more tree
objects in parallel.  We can even walk multiple working directories
at once making directory differencing fairly simple.

What is missing here is really two things:

 #1)  Take .gitignore and .git/info/exclude (and other patterns) into
      account as WorkingTreeIterator (base class of FileTreeIterator)
      loops over the entries in a directory.

      Since .gitignore can be per-directory we may need to add rules
      as we enter into a subtree (createSubtreeIterator method)
      and pop rules as we exit a subtree.

      Fortunately the pop part is easy if the rules are held within
      the WorkingTreeIterator as instance members as pop is already
      dealt with up inside of TreeWalk by simply discarding the
      subtree instance and returning back to the parent instance.

  #2) Be able to edit one (or more) index files during a
      TreeWalk.  I am (sort of) in the middle of that work on my
      egit/spearce.git fork's dircache branch.

We already have a method for filtering entries during TreeWalk; its
the TreeFilter API and its many subclasses.  I wonder if the rules
for say .gitignore could simply be implemented through this API and
then allow a TreeFilter to be set directly on the WorkingTreeIterator
to "pre-filter" the entries before they get returned for merging
in the TreeWalk main loop.

I am certain we need to write new subclasses of TreeFilter to handle
fnmatch(3C) style glob rules.  But they shouldn't be too difficult.
For example we already have PathFilter to perform equality testing
on path names.

Building onto TreeFilter makes for some more interesting cases,
as we can then feed globs into the revision machinary and actually
do something like `jgit log -- 'path/*.c'`, with the globbing being
done _on_the_fly_ at each tree, and not once up front by the shell.

 
> For an example see the unit test testRealisticExample() in the class
> FileIterableFactoryForAddCommandTest:
> http://repo.or.cz/w/egit/florian.git?a=blob;f=org.spearce.jgit.test/tst/org/spearce/jgit/lib/fileiteration/FileIterableFactoryForAddCommandTest.java;h=d3c78f4422c708f26ccb56434053bb711fa3116b;hb=669fd814d34e2f989b5f8eedbcb0d5bcf9743ce7
> 
> You can view the patches online at:
> http://repo.or.cz/w/egit/florian.git?a=shortlog;h=refs/heads/mailinglist-patches-0
> 
> I signed all patches and formatted them with the code formatter as I
> should. It's ok for me to put the patches under a dual license between a
> 3-clause BSD and the EPL[*3*]. Currently all files have a GPL 2 notice.
> I hope that is ok.

Thanks.

I'll be writing a script to edit the headers to switch GPL notice to
EDL (3-clause BSD) notice real soon, and apply it to the bleeding
edge tree.  We may need to use it a few times to cover everyone's
topic branches before they merge into the main tree.
 
> If you want I will send the patches to the mailing list, but I don't
> know any automated way to create all the emails. I am not even sure if I
> will get them formatted correctly with Thunderbird 2. It would be cool
> if you could tell me how to send patches via command line.

I think the command you are looking for is `git send-email`.
 
-- 
Shawn.
