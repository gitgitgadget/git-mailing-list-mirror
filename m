From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove use of git-rev-parse and replace git-rev-list --pretty with git-log
Date: Sat, 03 Mar 2007 03:52:51 -0800
Message-ID: <7virdiczn0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
	<200703021929.20969.andyparkins@gmail.com>
	<7vbqjbdyxc.fsf@assigned-by-dhcp.cox.net>
	<200703030825.18378.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 12:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNSnI-00081c-9c
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 12:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbXCCLwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 06:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbXCCLwx
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 06:52:53 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64502 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbXCCLww (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 06:52:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303115253.FIZC24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 06:52:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WBsr1W00U1kojtg0000000; Sat, 03 Mar 2007 06:52:52 -0500
In-Reply-To: <200703030825.18378.andyparkins@gmail.com> (Andy Parkins's
	message of "Sat, 3 Mar 2007 08:25:16 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41287>

Andy Parkins <andyparkins@gmail.com> writes:

> Finding the "---" separator between diff and log message could at least 
> rely on finding "---" alone on a line so that "--- something else" 
> wouldn't trigger the end of log?
>
> I assume this is too simple?
>
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 766a37e..4e0795a 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -670,7 +670,7 @@ static int handle_commit_msg(int *seen)
>         return 0;
>     do {
>         if (!memcmp("diff -", line, 6) ||
> -           !memcmp("---", line, 3) ||
> +           !memcmp("---\n", line, 4) ||
>             !memcmp("Index: ", line, 7))
>             break;
>         if ((multipart_boundary[0] && is_multipart_boundary(line))) {

I think that would make us reject patches that we currently
accept.  Today, you can submit a patch created this way:

	$ cp Makefile Makefile.orig
        $ edit Makefile

	$ cat body-of-message
        $ echo "Signed-off-by: $me"
        $ diff -u Makefile.orig Makefile

The first line of the diff part would be "--- Makefile.orig"
(and the second one begins with "+++ Makefile").

I do not think I've asked Linus about how he originally came up
with "three dashes at the beginning of line" convention in the
kernel circle, but my guess always have been that it would
automatically allow us to accept patches prepared like this.
