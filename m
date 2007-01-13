From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 10:01:51 -0800
Message-ID: <7v1wlylsa8.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
	<7virfct737.fsf@assigned-by-dhcp.cox.net>
	<slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
	<7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
	<20070112210403.GB6262@xp.machine.xx>
	<7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net>
	<20070113093322.GA4825@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 19:02:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5nCV-0003zX-ED
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 19:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbXAMSBx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 13:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbXAMSBx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 13:01:53 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64889 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422739AbXAMSBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 13:01:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113180151.GOKN3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 13:01:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ai281W0051kojtg0000000; Sat, 13 Jan 2007 13:02:08 -0500
To: Peter Baumann <waste.manager@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36763>

Peter Baumann <waste.manager@gmx.de> writes:

> Yes. I am adding content. And not a file. But at least to me, it makes a
> *BIG* difference if I'm adding totally new content (reserving one more
> bucket where to place to content) or just replacing the content *in* one
> of those already reserved buckets. And that has nothing to do with
> files (or at least the silly me can't grok it).

To put this silly naming argument to the rest for now, because I
am not going to change add/rm nor introduce refresh, at least
during this round, so keeping this thread alive would just waste
everybody's time doing mental masturbation.

Physically the index is represented as a list of <blob object
name, pathname> tuples.  When we say "git tracks contents",
however, we look at it as if content of each blob object is just
a bytestream labeled with the pathname.

When you say "git-update-index file" (without --add/--remove),
what happens is "UPDATE" (in SQL sense).  The part of the data
recorded in the current index that is labeled with "file" is
replaced with what is from the working tree.

The --add option changes the "UPDATE" to "INSERT OR REPLACE".
It allows contents that are labelled with a pathname that does
not yet exist in the index.  What --remove does is to allow it
to also "DELETE".

So there _is_ a distinction between adding new pathname and
updating the contents at the low level.

However, if you look at the way 'git-update-index' is used in
the Porcelain-ish scripts (now you would need to go back and
examine a bit older versions of git, since many commands have
been rewritten in C to become built-in and we use update-index
in much fewer places in today's version), we almost always used
update-index with --add when talking about the set of paths the
end user talks about ('am' and 'applypatch' uses --index-info;
this is also "INSERT OR REPLACE" operation primarily).  The
places we did not, we knew we were only dealing with known set
of paths taken from the current index, so they also could have
had --add without any ill effects.  

In other words, there was not much need for "UPDATE only, please
do not INSERT" in practice.

That's primarily why the higher level interface git-add / git-mv
does not expose that distinction; git-add will do "INSERT OR
REPLACE".  git-rm will do "DELETE", and there will be no higher
level to only do "UPDATE".
