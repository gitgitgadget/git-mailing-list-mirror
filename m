From: Junio C Hamano <junkio@cox.net>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Wed, 20 Dec 2006 23:32:05 -0800
Message-ID: <7vk60l1z7u.fsf@assigned-by-dhcp.cox.net>
References: <4589F9B1.2020405@garzik.org> <4589FD9E.2010000@bellsouth.net>
	<46a038f90612202304uabdffacld857cfcb90ec3e76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jay Cliburn" <jacliburn@bellsouth.net>
X-From: git-owner@vger.kernel.org Thu Dec 21 08:32:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxIPV-0004eM-Ce
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 08:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbWLUHcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 02:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWLUHcK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 02:32:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39520 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422788AbWLUHcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 02:32:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221073205.ELFD20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 02:32:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1KXP1W00N1kojtg0000000; Thu, 21 Dec 2006 02:31:24 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90612202304uabdffacld857cfcb90ec3e76@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 21 Dec 2006 20:04:27 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35022>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 12/21/06, Jay Cliburn <jacliburn@bellsouth.net> wrote:
>> $ git diff $(git merge-base master driver)..driver
>
> There is a nicer way to do it with 1.4.x git -- note the 3 dots:
>
> $ git diff master...driver

Careful.

I think Jay was looking at this kind of ancestry graph:

         *---*---*---* driver
        /
 --o---o---x---x---x---x master

There might be quite a few merges on either side, but the point
is '*' are not yet 'in', and 'o' and 'x' are already in the
'upstream (but 'x' are not in Jay's driver yet).

The three dots would give both '*' and 'x'; I do not think that
is what Jay wants.  A submitter to mainline usually wants only
'*' commits.

I've always thought that 'submission' is supposed to be done as
a series of patches, in which case a reasonable way would be to
do:

	git format-patch -n master driver

If on the other hand a single roll-up patch is desired, I think
the most reasonable thing to do is to first merge the tip of the
master to the tip of driver, resolve all the conflicts as
needed, and take the diff between the 'master' and the result:


         *---*---*---*---y driver (y is the test merge)
        /               / 
 --o---o---x---x---x---x master

	git checkout driver
        git merge master
	... resolve conflicts if any, then "git commit"
	git diff master

This diff by definition should apply cleanly to the tip of
'master' and would result in the source that contains the
updates for the driver.

When you are done, it would be advisable to do:

	git reset --hard HEAD^

to remove that 'y' merge, unless the merge involved a true
conflict resolution.
