From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: update hook failure doesn't prevent local deletion of a branch
Date: Thu, 26 Jul 2007 21:13:42 -0700
Message-ID: <7vk5sm5vrd.fsf@assigned-by-dhcp.cox.net>
References: <200707251250.08166.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 06:13:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHD1-0002XG-Hz
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbXG0ENp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXG0ENo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:13:44 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49956 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbXG0ENn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:13:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727041343.XAAY1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 00:13:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UUDi1X00K1kojtg0000000; Fri, 27 Jul 2007 00:13:43 -0400
In-Reply-To: <200707251250.08166.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 25 Jul 2007 12:50:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53880>

Andy Parkins <andyparkins@gmail.com> writes:

> I wanted to delete a branch (let's call it "deleted-branch") from my public 
> repository.  I ran this:
>
> $ git push origin :deleted-branch
> deleting 'refs/heads/deleted-branch'
>  Also local refs/remotes/up/deleted-branch
> *** Update hook: aborting
> error: hooks/update exited with error code 1
> error: hook declined to update refs/heads/deleted-branch
> ng refs/heads/deleted-branch hook declined
> error: failed to push to '/path/to/git/repo.git'
> ...
> Summary: when using git-push to delete a remote branch, and that deletion is 
> disallowed by the update hook, the local tracking branch _is_ deleted.

Yes, a few months ago with b516968f, "send-pack" started to
pretend that it turned around and fetched immediately after it
attempted to push.

There are two problems with it.  One is this exact problem Andy
reported.  Newer receive-pack reports the status (if an update
of the ref was successful), and the sender _could_ try to detect
a failure and refrain from making the local side update (but if
the receive-pack running on the other end is old enough there is
no indication of an error); the code does not bother to do this
correctly.  I think this is correctable without major changes.
If the remote end refused to update only one of the refs, and
send-pack as a whole fails, we could refrain from updating
anything local.

But another more fundamental issue is that post-update hook on
the receiving end could do anything it pleases (for example, it
could try to rebase what was pushed), and at the protocol level
there is no way to say "you tried to push this SHA-1 but we
replaced it with this other SHA-1 instead".
