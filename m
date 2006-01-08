From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 00:44:27 -0800
Message-ID: <7virsv3y8k.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
	<20060108.001651.02992220.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 09:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvWAO-0008VV-Qk
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 09:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbWAHIo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 03:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbWAHIo3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 03:44:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57060 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030523AbWAHIo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 03:44:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060108084317.JYZG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 Jan 2006 03:43:17 -0500
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060108.001651.02992220.davem@davemloft.net> (David S. Miller's
	message of "Sun, 08 Jan 2006 00:16:51 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14310>

"David S. Miller" <davem@davemloft.net> writes:

> I know a lot of people react to this kind of usage with "what's the
> point of the source control system if you're just messing with patches
> in and out of the tree all the time" But as a subsystem maintainer,
> you deal with a lot of changes and it's important to get a pristine
> clean history when you push things to Linus.

I suppose another possibility of rebasing the topic branches
every now and then amounts to almost the same thing; I think
your way is safer just in case something goes wrong.  Maybe
Catalin can give us a short tutorial on StGIT here?

> #!/bin/sh
> (cd $1; git format-patch --mbox origin) || exit 1
> for i in $1/*.txt
> do
>    sed 's/\[PATCH\] //' <$i >tmp.patch
>    git-applymbox -k tmp.patch || exit 1
> done

With "git format-patch --mbox -k origin", you would not need the
sed command.

Or doing it inside a single repository:

   #!/bin/sh 
   git branch -f anchor ;# mark the current head
   git reset --hard linus ;# rewind to linus head
   # extract them, and apply them -- I suspect origin and linus
   # are the same
   git format-patch --stdout -k origin anchor | git am -k -3

To check the results, since the patch you fed to "am" as a whole
should be fairly close to the difference between the linus head
and your resulting HEAD, parhaps:

   git diff $(git merge-base origin anchor) anchor |
       git apply --stat --summary >status.1
   git diff linus HEAD | git apply --stat --summary >status.2
   diff -u status.1 status.2

If you do not like the result, you can "git reset --hard anchor"
to come back to where you started.

* format-patch --stdout implies --mbox.

* -3 to "am" is optional and as a matter of taste.  If you want
  to resolve conflicts by hand to be sure, running "am" without
  it may be preferable.  Otherwise when a patch does not cleanly
  apply it would construct an appropriate merge base tree on the
  fly and runs a 3-way merge.
