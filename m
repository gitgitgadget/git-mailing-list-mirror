From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email and aliases
Date: Tue, 27 Mar 2007 03:29:37 -0700
Message-ID: <7vircnou7i.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
	<7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
	<38b2ab8a0703270238n655bdee1kac227a6675261210@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 12:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8vu-0001Rk-G6
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbXC0K3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbXC0K3j
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:29:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47386 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbXC0K3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:29:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327102938.ZVRP748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 06:29:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fmVd1W00D1kojtg0000000; Tue, 27 Mar 2007 06:29:37 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43250>

"Francis Moreau" <francis.moro@gmail.com> writes:

> On 3/26/07, Junio C Hamano <junkio@cox.net> wrote:
>> > [alias]
>> >       send-email = send-email --no-signed-off-cc --suppress-from
>> >
>> > Is it failing because git-send-email is an external command ?
>>
>> $ sed -ne '/^alias\.\*/,/^$/p' Documentation/config.txt
>
> That said I think it's not really convenient. I'll end up doing:
>
> [aliases]
>    my-send-email = send-email --no-signed-off-cc --suppress-from
>    my-am = am -3 -s
>
> etc...
>
> Isn't possible to mimic bash alias handling:. From man: "Aliases are
> not expanded when the shell is not interactive,... "
>
> IOW is it possible for git to know if it has been invoked interactively ?

I do not think so, but I think alias expanding "git foo" while
not expanding "git-foo" should not be too hard.  You need two
extra preparation steps for such a change to be useful, though.

 (1) Build with $(gitexecdir) set to outside the usual $PATH
     (/usr/libexec/git was suggested in the past) to make sure
     we still support that configuration.  Under this model,
     only a handful programs ("git" wrapper itself and "gitk")
     should be installed on user's PATH and everything else goes
     under $(gitexecdir).  The user's interactive session MUST
     run "git foo" and not "git-foo" as bulk of the stuff is now
     outside of $PATH.  Fix any breakage if found (I do not
     expect many, but there might be some problems around object
     transfers, such as git-daemon spawning git-upload-pack, or
     git-push running git-receive-pack on the other end of the
     connection).

 (2) Audit all our scripts so that they run git commands with
     "git-foo" form, not "git foo" form.  As "git" wrapper is
     supposed to add $(gitexecdir) early in the $PATH while it
     runs itself and its subprocesses, they should find the true
     "git-foo" binary even after $(gitexecdir) is set outside of
     the usual $PATH.  Make sure things still work.

After the above two steps is done, we can be confident that the
scripts will not be broken even if we allow a user to say
something silly like "alias.cat-file = log --stat", as the
scripts will never say "git cat-file" to cause the command to be
expanded to "git log --stat" (instead they say "git-cat-file",
thanks to your audit in step (2)), thusly avoid the confusion.
