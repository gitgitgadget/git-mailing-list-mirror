From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 13:44:51 -0700
Message-ID: <7v4plwd6f0.fsf@assigned-by-dhcp.cox.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<20070528154630.GA9176@fiberbit.xs4all.nl>
	<87646cx13d.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon May 28 22:45:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsm5k-00066X-7a
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbXE1Uoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXE1Uoy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:44:54 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63086 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbXE1Uox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:44:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070528204452.GIB12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 28 May 2007 16:44:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4kks1X0031kojtg0000000; Mon, 28 May 2007 16:44:52 -0400
In-Reply-To: <87646cx13d.fsf@rho.meyering.net> (Jim Meyering's message of
	"Mon, 28 May 2007 20:19:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48639>

Jim Meyering <jim@meyering.net> writes:

> Subject: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
> ...
> You can demonstrate this with git's own --version output, too:
> (but git --help detects the failure without this patch)
>
>     $ ./git --version > /dev/full
>     fatal: write failure on standard output: No space left on device
>     [Exit 128]
>
> Note that the fcntl test (for whether the fileno may be closed) is
> required in order to avoid EBADF upon closing an already-closed stdout,
> as would happen for each git command that already closes stdout; I think
> update-index was the one I noticed in the failure of t5400, before I
> added that test.
>
> Also, to be consistent, don't ignore EPIPE write failures.
>
> Signed-off-by: Jim Meyering <jim@meyering.net>

I do not think anybody has much objection about the change to
handle_internal_command() in git.c you made.  Earlier we relied
on exit(3) to close still open filehandles (while ignoring
errors), and you made the close explicit in order to detect
errors.

But "to be consistent" above is not a very good justification.

In the presense of shells that give "annoying" behaviour (we
have to remember that not everybody have enough privilege,
expertise, or motivation to update /bin/sh or install their own
copy in $HOME/bin/sh), "EPIPE is different from other errors" is
a more practical point of view, I'd have to say.  IOW, it is not
clear if it is a good thing "to be consistent" to begin with.

I would have appreciated if this were two separate patches.  I
think the EPIPE one is an independent issue.  We could even make
it a configuration option to ignore EPIPE ;-)
