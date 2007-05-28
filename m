From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 14:27:45 -0700
Message-ID: <7v1wh0bpv2.fsf@assigned-by-dhcp.cox.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon May 28 23:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsmks-0005KA-0m
	for gcvg-git@gmane.org; Mon, 28 May 2007 23:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbXE1V1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 17:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbXE1V1s
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 17:27:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56768 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbXE1V1r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 17:27:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070528212747.WPRO13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 28 May 2007 17:27:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4lTm1X0041kojtg0000000; Mon, 28 May 2007 17:27:46 -0400
In-Reply-To: <87sl9hw0o0.fsf@rho.meyering.net> (Jim Meyering's message of
	"Mon, 28 May 2007 15:14:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48648>

Jim Meyering <jim@meyering.net> writes:

> Of course error messages are annoying when your short-pipe-read is
> _deliberate_ (tho, most real uses of git tools will actually get no
> message to be annoyed about[*]), but what if there really *is* a mistake?
> Try this:
>
>     # You want to force git to ignore the error.
>     $ trap '' PIPE; git-rev-list HEAD | sync
>     $

It is perfectly valid (although it is stupid) for a Porcelain
script to do this:

    latest_by_jim=$(git log --pretty=oneline --author='Jim' | head -n 1)
    case "$latest_by_jim" in
    '') echo "No commit by Jim" ;;
    *)  # do something interesting on the commit
        ;;;
    esac

In such a case, it is a bit too much for my taste to force the
script to redirect what comes out of fd 2 of the upstream of the
pipe, so that it can filter out only the "write error" message
but still show other kinds of error messages.  You could do so
by elaborate shell magic, perhaps like this:

        filter_pipe_error () {
                exec 3>&1
                (eval "$1" 2>&1 1>&3 | grep >&2 -v 'Broken pipe')
        }

	latest_by_jim=$(filter_pipe_error \
        	'git log --pretty=oneline --author='\''Jim'\'' | head -n 1'
	)

but what's the point?

I think something like this instead might be more palatable.

diff --git a/write_or_die.c b/write_or_die.c
index 5c4bc85..fadfcaa 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -41,8 +41,8 @@ int write_in_full(int fd, const void *buf, size_t count)
 void write_or_die(int fd, const void *buf, size_t count)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		if (errno == EPIPE)
-			exit(0);
- 		die("write error (%s)", strerror(errno));
+		if (errno != EPIPE)
+			die("write error (%s)", strerror(errno));
+		exit(1);
 	}
 }
