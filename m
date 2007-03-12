From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH,RFC] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Mon, 12 Mar 2007 09:16:05 -0400
Message-ID: <20070312131605.GA4372@thunk.org>
References: <E1HQdaX-00025N-3s@candygram.thunk.org> <7vodmzt0ud.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 14:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQkO3-0001Xw-4q
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 14:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965851AbXCLNQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 09:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965852AbXCLNQY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 09:16:24 -0400
Received: from thunk.org ([69.25.196.29]:35694 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965851AbXCLNQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 09:16:23 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HQkTd-0006l9-Av; Mon, 12 Mar 2007 09:22:13 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HQkNh-0004OU-7q; Mon, 12 Mar 2007 09:16:05 -0400
Content-Disposition: inline
In-Reply-To: <7vodmzt0ud.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42026>

On Sun, Mar 11, 2007 at 11:47:22PM -0700, Junio C Hamano wrote:
> Thanks.  By the way, is it fashionable to misspell "scenario" in
> the kernel circles? ;-)

Probably not; it's just that many of us are probably fast typists, and
there's a race condition between the 'n' and the 'e on the right and
left hands, respectively.  :-)

> 
> > +    git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
> > +    git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
> > +    git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
> > +
> > +    if test -z "$local_mode" -o -z "$remote_mode"; then
> > +	echo "Deleted merge conflict for $path:"
> > +	describe_file "$local_mode" "local" "$LOCAL"
> > +	describe_file "$remote_mode" "remote" "$REMOTE"
> > +	resolve_deleted_merge
> > +	return
> > +    fi
> 
> Running cat-file even when you know it does not exist at that
> stage does not feel right here, although you are not checking
> the exit status and discarding 2>/dev/null...

OK, I'll fix that.  

> One situation that happens in the real life to cause "we deleted
> while they modified" is when in reality we moved then modified
> so much that the difference between our version and the common
> ancestor version is too large to be considered a rename anymore.
> 
> Such a misidentified rename would appear as one path that is "we
> deleted while they modified" (original path) and the other path
> that is "we created while they didn't do anything to the path".
> The latter does not conflict and is already resolved in the
> index when you would run git-mergetool.
> 
> So if you have "we deleted while they modified" conflict, it may
> make sense to give the paths the index adds (relative to HEAD),
> let the user pick one of them and allow 3-way merge to update
> the path we renamed to.  The original path which had conflicted
> would be removed as the result.

I agree that would be useful, but it I'm going to have to restructure
the code a bit to support that.  Hmm, let me think about that a bit.

It occurs to me that I might also want to think about the order in
which I present files to be merged to the user in the "git mergetool"
case.  If we force the user to resolve these cases first, probably in
this order:

	* 2/3-way modified symlink/symlink
	* The symlink/modified file case
	* 3-way modified file case
	* 2-way modified file case (no common ancestor)

It also occurs to me that listing all of the files and characterizing
them according to what needs to be done up-front might also be a good
idea.  

I can remember, in the pre-git, Bitkeeper days some *truly nasty* ACPI
merges where there were some 20-30 files getting renamed and merged at
the same time.  Blech.  Can't we just slap the developers hands when
they do something this evil?  (Oh right, we already gave the ACPI
developers octopus merges which are a bisect nightmare.
Sigh... sometimes I'm not sure why we encourage them like this; I
guess it makes the kernel have some really test cases for git, which
is the only reason why it exists, right?  :-)


Junio, when and how do you feel about merging this?  It's clear the
code is going to have to go through some significant changes still to
add the above functionality, which would be an argument against
merging it, but on the other hand, it's quite useful in its current
form and I'd love to get more testers.  Another argument in favor of
merging it is that we already have more functionality here than hg,
monotone, Bitkeeper (as of the last free version), et. al.  And hey, I
created a man page so that proves I'm going to keep
maintaining/improving it.  :-)

						- Ted
