From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 18:02:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709161715090.5298@iabervon.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161054380.5298@iabervon.org> <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 17 00:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2CZ-0003VK-0d
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbXIPWCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbXIPWCq
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:02:46 -0400
Received: from iabervon.org ([66.92.72.58]:51128 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbXIPWCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:02:45 -0400
Received: (qmail 6460 invoked by uid 1000); 16 Sep 2007 22:02:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2007 22:02:43 -0000
In-Reply-To: <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58356>

On Sun, 16 Sep 2007, david@lang.hm wrote:

> On Sun, 16 Sep 2007, Daniel Barkalow wrote:
> 
> > > I however think your idea to have extra "permission information
> > > file" is very interesting.  What would be more palatable, than
> > > mucking with the core level git, would be to have an external
> > > command that takes two tree object names that tells it what the
> > > old and new trees our work tree is switching between, and have
> > > that command to:
> > >
> > >  - inspect the diff-tree output to find out what were checked
> > >    out and might need their permission information tweaked;
> > >
> > >  - inspect the differences between the "permission information
> > >    file" in these trees to find out what were _not_ checked out,
> > >    but still need their permission information tweaked.
> > >
> > >  - tweak whatever external information you are interested in
> > >    expressing in your "permission information file" in the work
> > >    tree for the paths it discovered in the above two steps.
> > >    This step may involve actions specific to projects and call
> > >    hook scripts with <path, info from "permission information
> > >    file" for that path> tuples to carry out the actual tweaking.
> >
> > Why not have the command also responsible for creating the files that need
> > to be created (calling back into git to read their contents)? That way,
> > there's no window where they've been created without their metadata, and
> > there's more that the core git doesn't have to worry about.
> 
> my initial thoughts were to have git do all it's normal work and hook into git
> at the point where it's writing the file out (where today it chooses between
> writing the data to a file on disk, pipeing to stdout, or pipeing to a pager)
> by adding the option to pipe into a different program that would deal with the
> permission stuff. this program would only have to write the file and set the
> permissions, it wouldn't have to know anything about git other then where to
> find the permissions it needs to know.
> 
> it sounds like you are suggesting that the hook be much earlier in the
> process, and instead of one copy of git running and calling many copies of the
> writing program, you would have one copy of the writing program that would
> call many copies of git.

A lot of the git commands are actually currently shell scripts  that call 
back to git, so that's not too different. The reason to have a single copy 
of the writing program is that it would be able to get the whole set of 
differences that need to be handled, and first pick out the metadata file, 
process it to figure out the writing instructions once, figure out the 
changes in the writing instructions, and figure out the changes in the 
content, and decide what to do.

> > I could see the program getting the index, the target tree, and the
> > directory to put files in, and being told to do the whole 2-way merge
> > (except, perhaps, updating the index to match the tree, which git could do
> > afterwards). As far as git would be concerned, it would mostly be like a
> > bare repository.
> 
> if this functionality does shift to earlier in the process, how much of the
> git logic needs to be duplicated in this program?
> 
> if this program needs to do the merge, won't it have to duplicate the merge
> logic, including the .gitattributes checking for custom merge calls?

This is two-way merge, not three-way merge. The basic concept is that 
you're in state A, and you want to be in state B. Rather than writing out 
all of state B, you write out all of state B that's different from state 
A. Think of taking a diff of two big trees and then applying it as a 
patch, instead of copying the new tree onto the old tree; the benefit is 
that stuff that doesn't change doesn't get rewritten, and the diff is 
blazingly fast, given how we store our information.

3-way merge will be handled by git, and not in a live /etc directory 
anyway (that is, you'd want to fix up the metadata files as plain text 
files, not as metadata bits on a checked out directory; otherwise, you'll 
be trying to put conflict markers in mode bits, and that's clearly not 
what you want).

> I have been thinking primarily in terms of doing a complete checkout,
> overwriting all files, and secondarily how do do a checkout of just a few
> files, but again where all files selected overwrite the existing files.
> 
> I wasn't thinking of the fact that git optimizes the checkout and avoids
> writing a file that didn't change.
> 
> this changes things slightly
> 
> prior to this I was thinking that the permission file needed to be handled
> differently becouse writing it out needed to avoid doing any circular
> refrences where you would need to check the contents of it to write it out.
> 
> it now appears as if what really needs to happen is that if the permission
> file changes a different program needs to be called when it's written out then
> when the other files are written out. by itself this isn't hard as
> .gitattributes can have a special entry for this filename and that entry can
> specify a different program, and that program fixes all the permissions
> (and/or detects that they can't be fixed due to user/filesystem limits,
> records the error, checks if the repository is set appropriately, and screams
> to the user if it isn't)

While we're at it, you probably don't even want to write the permission 
file to the live filesystem. It's just one more thing that could leak 
information, and changes to the permissions of files that you record by 
committing the live filesystem would presumably be done by changing the 
permissions of files in the filesystem, not by changing the text file.

(Of course, you could check out the same commits as ordinary source, with 
developer-owned 644 files and a 644 "permissions" file, and there you'd 
have the permissions file appear in the work tree, and you could edit it 
and check it in in a totally mundane way.)

> it would be a nice optimization to this permission checkout for it to compare
> the old and the new permissions so that it only tries to change the
> permissions where it needs to, but is that really nessasary? the program can
> look at the permissions of the existing files to see what they are and decide
> if it needs to change them (this would tromp on local changes that aren't
> checked in. how big of a problem is this?) my initial reaction is that having
> to know the two commits and do the comparison between them is adding a lot of
> logic and git interaction that I'd rather avoid if I could.

You probably want to be able to keep local uncommitted changes. People 
like to be able to have things slightly different in their particular 
deployment from the way things are in the repository, for stuff that only 
applies to one system and isn't "how it should be".

	-Daniel
*This .sig left intentionally blank*
