From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 17:13:29 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809231551320.19665@iabervon.org>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com> <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com> <48D8983C.7070506@op5.se> <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com> <48D8A97E.8070003@op5.se>
 <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com> <alpine.LNX.1.00.0809231216350.19665@iabervon.org> <7v7i92tzgb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mario Pareja <mpareja.dev@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFDV-0005sI-Fh
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYIWVNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbYIWVNe
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:13:34 -0400
Received: from iabervon.org ([66.92.72.58]:40082 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbYIWVNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:13:30 -0400
Received: (qmail 8239 invoked by uid 1000); 23 Sep 2008 21:13:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Sep 2008 21:13:29 -0000
In-Reply-To: <7v7i92tzgb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96598>

On Tue, 23 Sep 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I think the right tool on the git side is actually a "smudge/clean" 
> > script. When you check something out, git converts it from the 
> > repository-stored form to a working tree form using a script (if there is 
> > one configured); this could check whether you've got the appropriate lock, 
> > and make the file unwritable if you don't.
> 
> An obvious question is "how would such a script check the lock when you
> are 30,000 ft above ground"; in other words, this "locking mechanism"
> contradicts the very nature of distributed development theme.  The best
> mechanism should always be on the human side.  An SCM auguments
> inter-developer communication, but it is not a _substitute_ for
> communication.

If you're offline, you can't get new locks, nor release them. But it can 
make reasonable decisions if it remembers what locks you got before.

On the other hand, you can just make the file writable yourself while 
disconnected, and nothing bad happens to anybody else; if someone else 
locks the file and starts working, they'll block your eventual push until 
they push and you merge. And nothing too bad happens to you; you get stuck 
redoing the change later (as a merge), but (a) you would have had to do 
the work then anyway; (b) you knew you weren't protecting yourself; and 
(c) at least you got to practice on the plane.

The point of the locking is just that, if you get the lock for a 
particular file in a particular branch on a particular shared repository, 
you can be sure you won't have to merge that file in order to push there, 
and you can get this worked out in advance of having the push ready. A 
secondary concern is that you might want to stop yourself from working on 
certain things without this kind of reservation, but that's a local 
decision.

> But if you limit the use case to an always tightly connected environment
> (aka "not distributed at all"), I agree the above would be a very
> reasonable approach.
> 
> Such a setup would need a separate locking infrastructure and an end user
> command that grabs the lock and when successful makes the file in the work
> tree read/write.  The user butchers the contents after taking the lock,
> saves, and then when running "git commit", probably the post-commit hook
> would release any relevant locks.

The lock needs to last until you push to the repository the lock is for; 
otherwise you have the exclusive ability to make changes, but someone who 
grabs the lock right after you release it will still be working on the 
version without your change, which is what the lock is supposed to 
prevent.

> All these can be left outside the scope of git, as they can be hooked into
> git with the existing infrastructure. Once a BCP materializes it could be
> added to contrib/ just like the "paranoid" update hook.

It would be handy to link against some of git, since it will want to use 
git config files and remotes and refspecs to figure out what lock to ask 
for on the client side, and how to communicate with the target remote 
repository, and the process of getting a lock requires checking that 
you're up-to-date, and git's also got a bunch of useful code for atomic 
file updates and repository-scoped filename management. But adding this 
doesn't have to modify any existing behavior.

	-Daniel
*This .sig left intentionally blank*
