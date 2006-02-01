From: Nicolas Pitre <nico@cam.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 12:18:10 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com>
 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org>
 <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
 <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 18:18:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4LcX-0003eI-06
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 18:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWBARSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 12:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWBARSM
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 12:18:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:4401 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030376AbWBARSM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 12:18:12 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IU00004PQQAVKG0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Feb 2006 12:18:11 -0500 (EST)
In-reply-to: <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15430>

On Tue, 31 Jan 2006, Junio C Hamano wrote:

> This "I thought I was only checking in the two-liner I did as
> the last step but you committed the whole thing, stupid git!"
> confusion feels to be a parallel of "I thought I was only
> checking in the files I specified on the command line but you
> also committed the files I earlier git-add'ed, stupid git!"
> confusion.
> 
> Taken together with your "during a partially conflicted merge"
> example, it feels to me that the simplest safety valve would be
> to refuse "git commit paths..." if the index does not exactly
> match HEAD.  Not just mentioned paths but anywhere.
> 
> People who do not like this can set in their config file some
> flag, say, 'core.index = understood', to get the current
> behaviour.

I'd avoid hidden config options that magically change behaviors and 
semantics like that as much as possible.  _This_ would pave the way to 
even greater confusion and prevent the git user base from converging on 
a unified semantics knowledge.  Better add a command line option which 
has the vertue of being visible, and name it such that it make the 
intention explicit whether the previous index state is preserved or not,
something like --current-index or the like.

> The reason I am bringing this up is because of this command
> sequence:
> 
> 	# start from a clean tree, after 'git reset --hard'
>         $ create a-new-file
>         $ git add a-new-file
>         $ edit existing-file
>         $ edit another-file
>         $ git commit existing-file
> 
> There is no question we do not commit "another-file" and we do
> commit changes to the "existing-file" as a whole.  What should
> we do to "a-new-file", and how do we explain why we do so to
> novices?
> 
> We can argue it either way.  We could say we shouldn't because
> "commit" argument does not mention it.  We could say we should
> because the user already told that he wants to add that file to
> git.  Either makes sort-of sense from what the end user did.

It is much more intuitive to expect that, if you specify path arguments 
to commit, then only those paths are considered, and even if you didn't 
do a git add on some of them.  If nothing is specified then the current 
index (the default, including a-new-file) is considered.

> I think a file "cvs add"ed is committed if whole subdirectory
> commit (similar to our "commit -a") is done or the file is
> explicitly specified on the "cvs commit" command line, and that
> may match people's expectations.  That's an argument for not
> committing "a-new-file".

Exact.

> But to be consistent with that, this should not commit anything:
> 
>         # the same clean tree.
> 	$ create a-new-file
>         $ git add a-new-file
>         $ git commit
> 
> Which is counterintuitive to me by now (because I played too
> long with git).

IMHO this should commit a_new_file simply because you added it to the 
index and a commit without any argument should commit the whole 
(refreshed) index.

> We could make "git commit" without paths to mean the current
> "-a" behaviour, which would match CVS behaviour more closely.

Exact.

> However, it would make commit after a merge conflict resolution
> in a dirty working tree _very_ dangerous -- it may give more
> familiar feel to CVS people, but it is not an improvement for
> git people at all.  I would rather not.

For that case, (assuming that -a would be the default) maybe something 
meaning the opposite of -a could be specified on the commit argument 
list like I suggested earlier.  And maybe it should always be the 
default when committing a merge (in which case the -a would override 
that and refresh everything and not only the merged files plus those 
specified on the command line).

So to resume:

 - a non-merge commit without any argument would imply -a.

 - a non-merge commit with path arguments implies _only_ those paths, 
   regardless if they were previously "git add"ed or not.

 - a non-merge commit with, say, --no-auto or --current-index or 
   whatever would preserve the current behavior, with or without 
   additional paths.

 - a merge commit would imply that --no-auto behavior automatically.

 - a merge commit could override the --no-auto with an explicit -a.

This might look complicated when presented like that, but I think that 
the default behavior of each (non-merge vs merge) commit would more 
closely fit most people's expectations.  The merge commit create a shift 
in semantics of course, but committing a merge is already something a 
bit more involved anyway and at that point git users should have gained 
a bit more experience with the index concept and the default merge 
behavior is probably what most people will expect at that point as well.


Nicolas
