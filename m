From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with a push
Date: Mon, 11 Jun 2007 18:35:09 -0700
Message-ID: <7vzm36lzua.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
	<alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
	<Pine.LNX.4.64.0706111832070.4830@www.mintpixels.com>
	<alpine.LFD.0.98.0706111727240.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: plexq@plexq.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 03:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxvHz-0002t0-EW
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 03:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbXFLBfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 21:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756568AbXFLBfM
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 21:35:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41354 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518AbXFLBfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 21:35:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612013511.SSNY2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Jun 2007 21:35:11 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ARb91X0051kojtg0000000; Mon, 11 Jun 2007 21:35:10 -0400
In-Reply-To: <alpine.LFD.0.98.0706111727240.14121@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 11 Jun 2007 17:40:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49909>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, I don't think that's necessarily the right answer in the longer 
> run. It's how git people do things, but it's not necessarily the *best* 
> way of doing things. I think the better solution in the longer term is to 
> simply improve how "git push" works:
>
>  - we should probably do the same kinds of .git/config file entries for 
>    pushing as we do for fetching, and just get rid of the old implicit 
>    model, and instead have a nice refspec pattern model for what gets 
>    pushed instead.
>
>    I _think_ the refspec cleanup work by Daniel makes this something we 
>    can almost already do. Daniel?

That has already been there long before Daniel's patches.

>  - we should also likely have some way to specify what happens when you 
>    push into a branch that is currently checked out and has a working tree 
>    associated with it.
>
>    This was briefly discussed a few weeks ago, but nobody cared enough, I 
>    suspect.

That actially is in the todo:TODO for some time.  Just have been
too busy to look into it.

> anyway, I think the _proper_ thing to do would be to associate each 
> [remote] entry in the config file with a "push" refspec pattern, the way 
> we do for "fetch" already.

I do not think that is enough.  A sane thing if we were doing
"git push" from scratch and there is no existing user's fingers
to re-train, would be:

 * "git-push" without anything will default to "git-push
   origin"; this has been working for a long time.

 * "git-push $remote" when there is [remote] refspec config use
   that refspecs, not "matching refs"; this also has been
   working for a long time.

 * We would want to change git-push so that "git-push $remote"
   will _NOT_ default to 'matching refs'.  We keep that
   'matching refs' behaviour only when the other end is a bare
   repository.

 * For "git-push $remote" to a non-bare repository, that does
   not have [remote] push refspecs, we probably would want to
   change the default to refuse operation, or push only
   'matching heads' (as opposed to 'matching refs').

Alternatively, we could teach "git clone" and "git remote add"
to add push refspec in the config, and keep the 'matching refs
if there is no push refspec in the config' behaviour.

However, the push refspec needs to be different depending on the
bareness of the remote, and I do not see a good way to arrange
this.

"git clone" does communicate with the remote, so theoretically
we ought to be able to do that, but there currently is no way to
indicate bareness of the remote to the client.

"git remote add" by default does not even communicate with the
remote, so without telepathy that is even more cumbersome to
arrange than "git clone" case.
