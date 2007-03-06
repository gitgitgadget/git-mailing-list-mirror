From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Tue, 6 Mar 2007 07:40:02 -0500
Message-ID: <20070306124002.GA18370@thunk.org>
References: <E1HORtY-0000zK-8B@candygram.thunk.org> <7vr6s3sz8r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 13:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOYyz-0000Df-Mt
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 13:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbXCFMlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 07:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933254AbXCFMlI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 07:41:08 -0500
Received: from thunk.org ([69.25.196.29]:49192 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504AbXCFMkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 07:40:43 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HOZ3j-0001L2-NI; Tue, 06 Mar 2007 07:46:28 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HOYxW-0000cJ-EM; Tue, 06 Mar 2007 07:40:02 -0500
Content-Disposition: inline
In-Reply-To: <7vr6s3sz8r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41581>

On Mon, Mar 05, 2007 at 09:43:48PM -0800, Junio C Hamano wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> 
> > +git-mergetool(1)
> > +================
> > +
> > +NAME
> > +----
> > +git-mergetool - Forward-port local commits to the updated upstream head
> > +
> 
> Hmph.  We already have a tool to achieve such a goal, and that
> is called git-rebase.  Why would we want your program? ;-)

Oops, sorry, I thought I had fixed that.  Guess you figured out which
program I used as a man page template, huh?  :-)

> > +# This file is licensed under the GPL v2, or a later version
> > +# at the discretion of Linus Torvalds.
> 
> Heh ;-).

Hey, that's what the COPYING file requested, and it was late when I
started doing the git package integration, hence the stupid think-o
with the man page.  :-)

I assume you would prefer that it read Junio instead?  Should we
change the COPYING while we're at it, perhaps after consulting with
Linus since he still owns so a fair amount of the copyright on git?
It seems that if we're going to pre-collect permissions to move to
GPLv3, it ought to be either you or him....

> Do we want to do this by hand ourselves, or dot-source sh-setup
> like others?  You would also get die() for free.

Good point, I'll use git-sh-setup.

> You should be able to set IFS to exclude SP and then you only
> have to say you do not support LF and HT, both of which are much
> less likely than SP to be in the pathname.

Do we have any coding guidelines about what characters we have to
support in filenames?  I had assumed that we should support at least
SP and HT, but life does get easier if we don't need to worry about HT.

> > +	mv "$path" "$BACKUP"
> > +	cp "$BACKUP" "$path"
> 
> What if $path is a symlink blob?  ;-)

Yeah, I need to add special case code for symlinks.

> > +	case "$merge_tool" in
> > +	    kdiff3)
> > ...
> > +	    tkdiff)
> > ...
> > +	    meld)
> > ...
> > +	    xxdiff)
> > ...
> 
> It is depressing to see that the differences between the command
> lines of these have to be much larger than just the command name
> and order of three (or four if we count the result) paths
> parameters.  


Yep, it is depressing.  There is no standard calling convention, and
there is no standard exit status convention, either.  Hence the
requirement for meld and xxdiff to check to see if the file has
changed.  Grump....

> > +		xxdiff -X --show-merged-pane \
> > +		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
> > +		    -R 'Accel.Search: "Ctrl+F"' \
> > +		    -R 'Accel.SearchForward: "Ctrl-G"' \
> 
> Do these configuration belong to individual scripts like this?

The problem is that if you don't do this, using xxdiff is user-hostile
in the extreme.  The problem isn't so much that the save command has
no accelerators, but the Save menu gives you five (5!) save options.
You can save the merged file as:

	* The right file
	* The middle file
	* The left file
	* The file that was specified as the output on the command-line
	* Some user-specified file (save-as)

So without those resource changes, the user would have to click on the
File menu, and drag down to the "correct" save option or the file with
the resolved merge conflicts would get saved to some random place.

Gaaah.  I thought xxdiff was user hostile in the extreme, but Martin
Langhoff really wanted it, and he was right that xxdiff will give you
a built-in character-diff so you can see what changed on the
individual line.  So the resource changes were in my opinion the
minimum necessary so that the user would have some chance of seeing
which one of the five save options would actually do the right thing
with respect to git-mergetool.

> > +	echo "No available merge tools available."
> 
> Curious choice of words...
> 

Yeah, that should probably read "merge conflict resolution programs",
even though that's a lot more words.

> > +if test $# -eq 0 ; then
> > +	files=`git ls-files -u --abbrev=8 | colrm 1 24 | sort -u`
> 
> Careful.  I think --abbrev=8 just means use at least 8 but more
> as needed to make them unique.  sed -e 's/^[^	]*	//'
> (whitespace are HTs) would be safer and simpler, as you are not
> dealing with a pathname that has LF in it anyway.

OK, I can do that.  Alternatively I guess I could submit a patch which
caused git-ls-files to only list the files that still needed merging.
(i.e., git-ls-files -u --nostage".)  Do you have any preferences?

						- Ted
