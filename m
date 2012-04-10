From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 10 Apr 2012 23:30:21 +0100
Message-ID: <4F84B47D.1080301@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <2148933.pnpYo0xMAP@flomedio> <2487557.B8qfnaixh3@flomedio> <1421035.yALBSXSHGd@flomedio> <20120410171707.GA3869@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 00:30:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHja6-00023O-Hh
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 00:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759567Ab2DJWa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 18:30:27 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:2049 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759551Ab2DJWa0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 18:30:26 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120410223024.YZPY23305.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Tue, 10 Apr 2012 23:30:24 +0100
Received: from [192.168.0.3] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120410223024.RIOX13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.3]>;
          Tue, 10 Apr 2012 23:30:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120410171707.GA3869@burratino>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=tVuCC1OT-zQcO4u6SGUA:9 a=8AUGPTO7gRugz1Q2lpMA:7 a=QEXdDO2ut3YA:10 a=ve8LIm3CKLouLWqG:21 a=ROaIY6T4wxIrTy_x:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195134>

On 10/04/12 18:17, Jonathan Nieder wrote:
<snip>
> Given the goal described here of an import with support for
> automatically detecting branches, here are some rough steps I imagine
> would be involved:

Just to be clear, my understanding is that this project will take SBL
created by another program (that I'm writing) and create branches as
specified.  This frees Florian from having to deal with the maze of edge
cases involved in that part of the problem.

> 
>  . baseline: remote helper in C
> 
>  . option to import starting with a particular numbered revision.
>    This would be good practice for seeing how options passed to
>    "git clone -c" can be read from the config file.
> 
>  . option or URL schema to import a single project from a large
>    Subversion repository that houses several projects.  This would
>    already be useful in practice since importing the entire Apache
>    Software Foundation repository takes a while which is a waste
>    when one only wants the history of the Subversion project.
> 
>    How should the importer handle Subversion copy commands that
>    refer to other projects in this case?

This is a good point.  I've just svnadmin and svnrdump, and it turns out
svnadmin doesn't allow you to dump a subtree while svnrdump strips out
the offending copy commands, so either way there's nothing to be done.

>  . automatically detecting trunk when importing a project with the
>    standard layout.  The trunk usually is not branched from elsewhere
>    so this does not require copyfrom info.  Some design questions
>    come up here: should the remote helper import the entire project
>    tree, too?  (I think "yes", since copy commands that copy from
>    other branches are very common and that would ensure the relevant
>    info is available to git.)  What should the mapping of git commit
>    names to Subversion revision numbers that is stored in notes say
>    in this case?
> 
>  . detecting trunk and branches and exposing them as different remote
>    branches.  This is a small step that just involves understanding
>    how remote helpers expose branches.

After last week's discussion about branch absorption, I tried writing
another algorithm over the weekend.  I plan to test it during the week,
but online detection of branches and trunks looks fairly practical in
most real world cases (even those that are sanitily challenged).

>  . storing path properties and copyfrom information in the commits
>    produced by the vcs-svn/ library.  How should these be stored?
>    For example, there could be a parallel directory structure
>    in the tree:

Yes, this is an important problem.  It became apparent over the weekend
that my code was I/O bound, so I started caching the metadata I need
(without e.g. file contents) in a gzipped file containing a list of JSON
blobs (one blob per revision).  That immediately caused the script to
jump from about a hundred revisions/second to a few thousand(!), and
each further size optimisation caused it to jump by another few thousand
per second.

This sort of speed is useful for the initial SVN->git conversion,
because it means even people with very large repositories can have a
quick edit/compile/test loop when they're looking for mis-detected branches.

Having said all that, a git directory is easier to examine and update
than a gzipped file.  I have no idea what the performance would be like,
but even if a directory was slower we could use gzipped JSON as a cache
layer during the initial import, then throw it away and read straight
from a git directory on update.

>  . tracing history past branch creation events, using the now-saved
>    copyfrom information.

I'm not sure if I understand correctly, but I think you're referring to
this edge case:

mkdir tronk brunches
svn add tronk brunches
svn ci -m "Initial commit, with typos to evade stdlayout detection"

mkdir tronk/libfoo
touch tronk/libfoo/main.c
svn add tronk/libfoo
svn ci -m "Created libfoo - no way to know this isn't a branch"

svn up # so the 'svn cp' works correctly below

svn cp tronk brunches/copy_of_tronk
touch brunches/copy_of_tronk/main.c
svn add brunches/copy_of_tronk/main.c
svn ci -m "Marking the copy as a branch, but what about the original?"


I'm not actually sure what the right behaviour is here.  You could argue
that once we know "copy_of_tronk" is a branch, it follows that "tronk"
itself is a branch.  On the other hand, these directories have diverged,
and who's to say it wasn't because of a disagreement about which
directory was the branch?

Branch absorption makes this problem less important - the "tronk/libfoo"
branch will be deleted and merged into the new "tronk" branch the moment
someone creates "tronk/main.c", which tends to happen pretty quickly in
the real world.

I'm open to suggestions, but my instinct right now is to say that
communicating branchiness back through a copyfrom should at least
require confirmation by the user.

>  . tracing second-parent history using svn:mergeinfo properties.

My old POC code did this, and I plan to include it in the work I'm doing
now.  I expect this to be the hardest single part of the project to
solve in the general case, because of SVN's troubled approach to merge
handling.

<snip>
> Another question is: what is the design for this?

Here's my part of the equation:

Right now I have a script that first takes an SVN dump and produces
gzipped JSON as output, then takes the gzipped JSON as input and
produces an SBL file as output.  The first round will generally only
need to be run once (and is comparable to svn-fe in speed), whereas the
second round might need to be run an arbitrary number of times (but is
very fast).

Incidentally, the initial cache generation is the only part that's still
tied to the SVN dump format, and I doubt it would be that hard for
someone to rewrite it inside svn-fe or to make it read from git metadata
in future.

I'm currently focussing on bringing all the modules up to release
quality, so that I can have something for Florian to play with in the
near future.  This should have an interface that is mature but flexible,
so I can change the interface to make his life easier but won't need to
change the interface because I missed something.  After that, I'll
concentrate on improving the quality of the SBL output.

	- Andrew
