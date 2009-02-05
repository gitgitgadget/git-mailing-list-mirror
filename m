From: Theodore Tso <tytso@mit.edu>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Wed, 4 Feb 2009 21:43:33 -0500
Message-ID: <20090205024333.GH8945@mit.edu>
References: <200902021948.54700.jnareb@gmail.com> <20090202202424.GG14762@mit.edu> <200902040304.05028.jnareb@gmail.com> <20090204235436.GA8945@mit.edu> <7v4oz9lpes.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 03:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUuEh-0001Qo-T6
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 03:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbZBECni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 21:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbZBECnh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 21:43:37 -0500
Received: from thunk.org ([69.25.196.29]:39610 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbZBECnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 21:43:37 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LUuDG-0003s7-56; Wed, 04 Feb 2009 21:43:34 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LUuDF-0002nG-8U; Wed, 04 Feb 2009 21:43:33 -0500
Content-Disposition: inline
In-Reply-To: <7v4oz9lpes.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108494>

On Wed, Feb 04, 2009 at 04:04:43PM -0800, Junio C Hamano wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > 1) In branch A, the directory src/plugin/innodb-experimental is
> >    renamed to src/plugin/innodb, and in branch B, a commit (i)
> >    modifies a file src/plugin/innodb-experimental/table.c, and (ii)
> >    creates a file src/plugin/innodb-experimental/mod-schema.c.  This
> >    commit in branch B is then pulled into branch A, where the
> >    directory rename has taken place.  The user may not know that a
> >    directory rename had taken place under the covers, so they don't
> >    give any magic options when they run the "git cherry-pick" or "git
> >    merge" command.  Does the right thing happen such that the right
> >    file in src/plugin/innodb is modified, and the new file is created
> >    in src/plugin/innodb, even though in the original commit, the
> >    changes were made to files in src/plugin/innodb-experimental?
> 
> Careful.
> 
> Although it is reasonable to expect that existing file's modification will
> move to innodb/ directory, it is not as clear-cut as some people seem to
> assume that the new file should always be created in the new directory
> innodb/.

Careful; that's actually an argument for recording the directory
rename.  If the intention is to rename the directory containing some
plugin, where all of the associated files are for the plugin foobar,
and we are renaming the directory because plugin has had its name
changed to fooblatz, then a commit which introduces a new file, say
table.c probably does want to get created in the new directory ---
especially if one of the changes was to foobar/Makefile:

--- Makefile.in	  2009-02-04 21:28:43.977052347 -0500
+++ Makefile.in.orig	     2009-02-04 21:28:38.830212569 -0500
@@ -60,7 +60,7 @@
 #
 #MCHECK= -DMCHECK
 
-OBJS= table.o crc32.o dict.o unix.o pass1.o pass1b.o pass2.o \
+OBJS= crc32.o dict.o unix.o pass1.o pass1b.o pass2.o \
       pass3.o pass4.o pass5.o journal.o badblocks.o util.o dirinfo.o \
       dx_dirinfo.o ehandler.o problem.o message.o recovery.o region.o
 
In other cases, maybe the right thing *is* to drop the new file in the
original directory.  So as the Hg and Bzr apologists might say, if the
SCM actually records whether the user intention was a *directory*
rename, versus a series of *file* rename/moves, then it becomes
obvious what the right thing to do.

But if the SCM is tracking *content* as git does, then we don't have
the benefit of having recorded the user's intention, so we have to use
hueristics.  We can say that if *all* of the files in the directory
foobar had been moved to fooblatz as part of a commit, it's likely
that new commits that create new files in foobar should create them in
fooblatz --- especially if the new file name is mentioned in a file
named "Makefile" or "Makefile.in".  Or we can give up and ask the user
what was intended at merge time.  That's admittedly as annoying as
throwing up the Annoying Dialog Box at commit time when folding in a
patch (which is how systems that record user intention have to do
things).  Ultimately, there are only three choices; either the user
tells the SCM, the SCM asks the user, or the SCM applies some
hueristic (i.e., the SCM "guesses").  This can happen at commit time
or it can happen at merge time, but and in some cases the SCM can use
a combination of techniques depending on whether a patch is being
imported or whether the user is explicitly telling the scm via "scm
mv", "scm mvdir", "scm cp", et. al.

But if we throw up our hands and say, it's impossible to guess
correctly, then that leaves us open to the argument from people from
the Hg or Bzr camp to say, "You see, tracking *content* is really for
the birds; you really have to let/force the user to *tell you* and
record the whether the directory is being moved, or a series of files
in the directory are being moved."

Instead, I would argue that just as we've shown that while collisions
can happen, the costs of locking files ala RCS outweigh the costs, it
also is better to use hueristics to determine whether a file should be
created in the original directory or the apparently renamed directory
location, and then let the user fix things up afterwards if the
algorithm gets it wrong.  If the corner case only happens 1% of the
time, and our algorithm gets it right 99% of the time, the resulting
0.01% error rate is probably quite acceptable.

      	  	    	  	     		 - Ted
