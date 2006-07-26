From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-clone failures abound
Date: Tue, 25 Jul 2006 22:02:54 -0700
Message-ID: <7vwta1argh.fsf@assigned-by-dhcp.cox.net>
References: <44C6F1D6.5020208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jul 26 07:03:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5bXw-0005Kh-Aa
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 07:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWGZFC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 01:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGZFC5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 01:02:57 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39812 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030385AbWGZFC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 01:02:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726050255.SEJY27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 01:02:55 -0400
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44C6F1D6.5020208@garzik.org> (Jeff Garzik's message of "Wed, 26
	Jul 2006 00:38:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24206>

Jeff Garzik <jeff@garzik.org> writes:

> I've been seeing several reports lately, from different users on
> various Linux platforms, with the same basic bug report
>
> * "git:// clone of linus's repo times out after 10 minutes"
>
> * someone says, "use rsync:// for the initial clone"
>
> * "it works, thanks!"
>
> People seems to note that this behavior only started recently.  I
> wonder if linux-2.6.git crossed some sort of size threshold that's too
> much for kernel.org CPU load to bear?  I wonder if git-clone is
> attempting to delta-ify, when it really should just be sending the
> objects in bulk?

No, this was all my fault, and sorry about the confusion.

GIT 1.4.1 contains commit 583b7ea3 which implemented a side-band
communication for the upload-pack protocol to give progress bar
output to the client downloaders, and in order to do so it
changed the pipe structure of the process.  It used to just fork
two processes piped together that exec rev-list and
pack-objects, and exec cleared alarm().  I mistakenly rewrote
that part to have an extra process that oversees these two
processes but the overseer does not exec and got killed by
alarm().  This bug affects the server side.

GIT 1.4.1 was installed on public kernel.org machines and the
problem started happening after that.

A fix was relatively simple, and I've issued GIT 1.4.1.1 with it
last night -- the master branch also has the same fix.  So when
the kernel.org public machines are updated to 1.4.1.1 it should
solve the problem.
