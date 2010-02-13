From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Solve continuous integration (pending head / commit queue) 
 problem using git
Date: Sat, 13 Feb 2010 17:11:16 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002131640200.14365@iabervon.org>
References: <c41cd75d1002120837t20f2a47fi41e8c67245c4284c@mail.gmail.com> <32541b131002120942w50a29e7cjf2c10820b3286017@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Koprowski <jan.koprowski@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 23:11:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgQDH-000179-Rf
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 23:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab0BMWLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 17:11:19 -0500
Received: from iabervon.org ([66.92.72.58]:56109 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab0BMWLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 17:11:18 -0500
Received: (qmail 15955 invoked by uid 1000); 13 Feb 2010 22:11:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Feb 2010 22:11:16 -0000
In-Reply-To: <32541b131002120942w50a29e7cjf2c10820b3286017@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139866>

On Fri, 12 Feb 2010, Avery Pennarun wrote:

> On Fri, Feb 12, 2010 at 11:37 AM, Jan Koprowski <jan.koprowski@gmail.com> wrote:
> > Now. My idea. There is some revision tagged as "stable". *Clone* and
> > *pull* operations is somehow "overloaded" from server side and always!
> > return last revision tagged as stable. After compiling external tool
> > just move tag to another revision which pass all tests. Of course
> > there is some additional parameter (for example --last or --unstable)
> > which can clone fine way of repository.
> >
> > Two questions.
> > 1) Maybe I try to invent the wheel again. Is there any way to take the
> > effect without overloading standard git behaviours.
> > 2) If not how overload git behaviors on git "server side" repo?
> 
> In general, code that lies to you about what's the most revision is
> evil.  Sometimes you *do* want to fetch that revision it's lying to
> you and saying doesn't exist, precisely because you'd like to help fix
> it before integration.

I think a more suitable detail here would be to have the remote system 
respond to pushes by stating that it's taking your push request under 
advisement, but cannot give an immediate verdict for that request (and it 
may want to let you know that it's updated a different ref of its choice 
that you didn't intentionally request).

$ git push
   f99642a..e70de97  HEAD -> master (proposed, not updated)

$ git log --oneline origin/master
f99642a Original commit

(wait for external signal, like getting a confirmation email)

$ git fetch
   f99642a..e70de97  maaster    -> origin/master

$ git log --oneline origin/master
f99642a Your commit

I think the only thing that would be needed would be a way for the remote 
server to report that it's not updating the ref, but it is planning to act 
on your request, so that your local git can give a non-error without 
updating the remote branch inappropriately. (Presumably, the server would 
have used a pre-update hook to give this response, which would have 
enqueued the request in the CI system; when the CI system likes a change, 
it can push and the hook would detect that it's actually the CI system and 
let the update happen).

	-Daniel
*This .sig left intentionally blank*
