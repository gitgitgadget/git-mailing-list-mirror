From: Nicolas Pitre <nico@cam.org>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Fri, 22 Dec 2006 00:06:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612212337180.18171@xanadu.home>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
 <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net> <87wt4m2o99.wl%cworth@cworth.org>
 <7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net> <87vek62n1k.wl%cworth@cworth.org>
 <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net> <87tzzp3fgh.wl%cworth@cworth.org>
 <slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx>
 <7vbqlw92fw.fsf@assigned-by-dhcp.cox.net> <87d56cirs8.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 06:07:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxccV-0005hH-T6
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 06:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945938AbWLVFGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 00:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945941AbWLVFGf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 00:06:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51690 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945938AbWLVFGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 00:06:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAN005EHSUWPT30@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Dec 2006 00:06:32 -0500 (EST)
In-reply-to: <87d56cirs8.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35129>

On Thu, 21 Dec 2006, Carl Worth wrote:

> So, I think what I really want here is a complete separation in the
> interface between adding a path to the index and updating content into
> the index.

Strangely enough I think this separation is unnecessary and redundent.

> We've long had a command that updates content to the index, and it
> takes a command-line option (--add) to allow it to first do the
> necessary path addition as well.

And it is still there.

> The symmetry I would like is if we
> had a command, ("git add", say), that just did the path addition and
> could accept a command-line option (--update, say) to get it to the
> the updating of the content as well.

And you can do just that with git-update-index.

> And I think that any talk about "git cannot accept a file name without
> content" is misplaced. The proposal here does not change any internal
> models of git. I'm talking about an interface issue, and if the
> interface isn't helping the user then it's wrong. That "git diff"
> usually shows me what I've just typed but I can't (easily[*]) get it
> to do that when I'm adding a new file is really annoying.

The problem lies with the git-diff interface then, not git-add.

> [*] Well, I could get it to do that by carefully creating the file,
> running "git add" immediately, and only _then_ going on to type
> content into the file. But that's not how I work. I do a bunch of file
> manipulations without thinking about git at all, and then when I'm
> happy with that, only then do I want to turn to git and use "git add",
> "git diff", and "git commit" to get the results I want.
> 
> So I suppose I could implement the "add path without updating content"
> I want by doing something like:
> 
> 	mv file file.tmp
> 	touch file
> 	git update-index --add file
> 	mv file.tmp file
> 
> There. That gives me the result I want without breaking any git
> internals, (since I'm just building a new operation on top of existing
> git primitives).
> 
> > Carl talks about would be useful in practice.  I do not know
> > what the option should be called.
> >
> > 	"git add --modified"?
> >         "git add --tracked"?
> >         "git add --updated"?
> >
> > It would work in the same way as the pre-commit step of "git
> > commit -a".
> 
> I think the best would be:
> 
> 	git update-index --all
> 
> which would still allow room for:
> 
> 	git add --all
> 
> as a consistent way to get at the current behavior of "git add .".

There is no consistency needed between git-add and git-update-index.  
The first is for users while the second is more suited for scripting 
your own interface.

> So here I'm arguing against "git add" being a more convenient synonym
> for "git update-index". I still think it would be nice to have a more
> convenient synonym. I've proposed "stage" before but that wasn't well
> accepted. Just shortening "update-index" to "update" would be
> problematic as many other RCSs use "update" as a way of picking up new
> content that has become available on the remote end. So, the best
> suggestion I have at this point is "refresh". So I'd be happy if
> either:
> 
> 	git refresh --add
> or:
> 	git add --refresh
> 
> would provide the behavior that currently is provided by "git add",
> (that is, add a new path to the index and update the content of that
> path in the index from the content of the named file in the working
> tree). But it would be great if "git add" without the --refresh would
> add the path without updating the content.

I think you are trying to solve the wrong problem, or at least solve a 
problem the wrong way.  The problem is that git-diff doesn't give you 
the output you expect because of the index interfering in your work 
flow.  And I understand that.

But the best solution is really for git-diff to have a mode where you 
could display a diff between the work tree and the index, _or_ the index 
and HEAD, for each file listed in the index while giving priority to the 
former.

This would let you see a diff of everything that would be committed, 
including new files, if you were to do commit -a.  Maybe -a/--all should 
be used with git-diff for such a mode by symetry with git-commit -a. (OK 
-a is already taken but I doubt it is really used and it already has a 
longer equivalent so changing it would not do real harm).

With this, for users acustomed to "commit -a", the natural and pretty 
consistent way to see a diff for such a commit before actually 
performing it would bi "diff -a".  Isn't it logical?


Nicolas
