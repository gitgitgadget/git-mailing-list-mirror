From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 13:32:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809231216350.19665@iabervon.org>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>  <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>  <48D8983C.7070506@op5.se>  <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com>  <48D8A97E.8070003@op5.se>
 <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Mario Pareja <mpareja.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 19:33:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiBlT-00030h-4s
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 19:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbYIWRcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 13:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754567AbYIWRcS
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 13:32:18 -0400
Received: from iabervon.org ([66.92.72.58]:37606 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031AbYIWRcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 13:32:17 -0400
Received: (qmail 28727 invoked by uid 1000); 23 Sep 2008 17:32:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Sep 2008 17:32:15 -0000
In-Reply-To: <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96579>

On Tue, 23 Sep 2008, Mario Pareja wrote:

> > So it's a communication issue then.
> 
> Yes, but I think the communication of this information needs to happen
> as part of a developers normal work-flow rather than requiring them to
> remember to check an external system.
> 
> > The way I understand locks in svn
> > and cvs is that they also only bother you when you want to check in the
> > file you've just recently modified, or if multiple people want to lock
> > the same file at the same time.
> 
> The SVN client will make locked files read-only until a lock is
> obtained for them.  This helps "remind" you that a lock should be
> obtained before editing such a file. Requiring the developer to obtain
> a lock ensures that nobody else is editing the file and prevents
> wasted work.  Upon commit, the file is marked as unlocked and the
> local file is once again read-only.

I think the right tool on the git side is actually a "smudge/clean" 
script. When you check something out, git converts it from the 
repository-stored form to a working tree form using a script (if there is 
one configured); this could check whether you've got the appropriate lock, 
and make the file unwritable if you don't. Then you have a script that 
gets or releases a lock and sets any write bits on files already checked 
out appropriately. There could also be locking-server magic to detect that 
you've pushed a change and release the lock, telling you so that it makes 
your file unwritable, but that's optional.

(Side note: consider version-specific logos; which lock you need depends 
on which version you're working on, and you may want to pick up locks for 
multiple versions and make changes to each logo, switching between the 
branches, and make sure you can get all the locks before you start 
working on any of the files, despite not having any individual file 
checked out continuously in the process)

> > Note that locking would be completely advisory though, and nothing
> > would prevent people from committing changes to a locked file.
> 
> If git were to support locking then it could prevent people from
> committing without first locking.  Even if it is not supported
> directly by git - perhaps using a lock daemon - a wrapper would need
> to be written around git commit/push to prevent developers from
> committing/pushing changes that would cause binary merging conflicts.

If you've gotten to the point of committing (let alone pushing), and you 
haven't got exclusive access, git should certainly not prevent you; the 
point of the locking is to prevent people from doing work that will be 
wasted, and the work is already done at this point. It's better then to 
actually try the binary merge, which comes down to apologizing profusely 
and then somebody openning the 3 versions (theirs, the other side's, and 
the common ancestor) in their graphics program and modifying the other 
side's to include their change. It wouldn't help anything to prevent 
people from being able to get all of these versions to each other, once 
they're made. It's also helpful to have people commit what they did before 
redoing it, so that they can use it for reference in the process and won't 
lose it.

(Actually, I bet it would be not-too-hard to set up gimp for three-way 
merge of images; open the result file with "theirs" as the contents, and 
open the common ancestor and "yours" as extra layers and set the ancestor 
to negative, and make the user clean up the mess)

On the other hand, the locking server should reject your push if somebody 
else has got the lock, so that the person who editted the file without 
having the lock is the one stuck redoing things.

In any case, the fundamental idea is: (a) you want some server to favor 
people who declare their intent to change something in advance, and give 
all the work of redoing stuff to people who didn't declare their intent in 
advance; and (b) you want to prompt people to declare their intent in case 
they forget.

(a) is a pre-update hook that checks the diffstat against other people's 
locks. (b) is a smudge script that makes files you're supposed to lock and 
haven't a-w. Of course, git doesn't have the code for manipulating a 
per-user set of locks, but it shouldn't be too hard to find some project 
that just does that.

	-Daniel
*This .sig left intentionally blank*
