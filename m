From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default "tar" umask..
Date: Fri, 05 Jan 2007 14:15:26 -0800
Message-ID: <7vmz4xdssh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
	<7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
	<459EB78B.60000@lsrfire.ath.cx>
	<7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701051336000.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 23:16:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xLs-0004tX-BS
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbXAEWP2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXAEWP2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:15:28 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64740 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbXAEWP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 17:15:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105221527.VXRM29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 17:15:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7aEe1W00D1kojtg0000000; Fri, 05 Jan 2007 17:14:38 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701051336000.3661@woody.osdl.org> (Linus
	Torvalds's message of "Fri, 5 Jan 2007 13:40:38 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36030>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 5 Jan 2007, Junio C Hamano wrote:
>> ...
>> On the other hand, I can explain 002 fairly easily and
>> consistently.
>
> No you can't. 002 makes no sense at all in a very common old-fashioned 
> setup with a "user" group. 

I do not think so (see below).

> Maybe I'm old, and these days most setups seem to give people their own 
> group (so I'm "torvalds:torvalds" on all the machines I have access to), 
> but it used to be _very_ common to have just a "user" group that all 
> normal users were part of (or have the default gid depend on something 
> like which department you are in).
>
> In that situation, 002 is really effectively no different at all from 000.

I remember those days.  People had 022 umask for that exact
reason, as you said, in such a setup.  It was quite common.  On
the other hand, modern setups often use "own" group and people
often use 002 umask.

If you extract as a normal user (i.e. without -p) then 002 is
really effectively no different at all from 000 because umask
kicks in and give the results the user would expect in either
setups, which is good.  In "user" group setup, umask 022 makes
files to 0644, in "own" group setup, umask 002 makes files to
0664.  All is good.  If the archive is made with 022, that would
break expectation of users whose umask is 002 (a sane value in
modern "own" group setups).

The current 000 was bad for users who work as root and do not
know about implied -p (which is not their fault).  When
extracting as root, the files and directories are owned by
'root' and its group.

Even in the old "user" group setups, I _thought_ the root was in
his own group or wheel in BSD, and the group was not shared with
Joe Random users, so if that is the case, group writability is
not an problem.  In the modern "own" group setups, the root user
is in its own his group 'root', so group writability is not an
issue either.

> 022 really is very easy to explain: "readability (and executability) is a 
> lot less dangerous than writability, and by default we only give 
> writability to the user". That's why we _don't_ commonly have 066 or 077 
> as the umask, and also why 002 is the default umask ONLY on systems where 
> users have their own individual groups by default.

077 was a tongue-in-cheek comment.

I think we are basing our reasoning with the same shared
understanding of historical practice of "user" group.  I wonder
why the differenece in conclusions.

Maybe my recollection of historical practice was faulty and the
root shared its group with Joe Random users?  If so, I would
agree that 002 makes no sense at all, as you said.
