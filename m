From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] "git" calls help_unknown_cmd(""); "git help" and "git help -a" return 0
Date: Wed, 24 Oct 2007 21:40:55 -0700
Message-ID: <7vd4v33iy0.fsf@gitster.siamese.dyndns.org>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkuWy-0008EA-FF
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 06:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbXJYElD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 00:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbXJYElC
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 00:41:02 -0400
Received: from rune.pobox.com ([208.210.124.79]:45211 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754044AbXJYElA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 00:41:00 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 91B3214E33E;
	Thu, 25 Oct 2007 00:41:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EEAC214E33A;
	Thu, 25 Oct 2007 00:41:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62269>

Scott R Parish <srp@srparish.net> writes:

> Signed-off-by: Scott R Parish <srp@srparish.net>
> ---
>  git.c  |    5 ++---
>  help.c |    4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/git.c b/git.c
> index 853e66c..e1c99e3 100644
> --- a/git.c
> +++ b/git.c
> @@ -445,9 +445,8 @@ int main(int argc, const char **argv)
>  		if (!prefixcmp(argv[0], "--"))
>  			argv[0] += 2;
>  	} else {
> -		/* Default command: "help" */
> -		argv[0] = "help";
> -		argc = 1;
> +		/* The user didn't specify a command; give them help */
> +		help_unknown_cmd("");

Sorry, but I fail to see why this is an improvement.

If you type "git<Enter>", before this patch we call cmd_help()
without help_cmd, which gives the usage string and lists common
commands, and exits with 1.

With this patch, you get "git: '' is not a git-command",
followed by list of common commands, and then the invocation
exits with 1.

I think "git help" should exit with 0.  The user asked for help,
we give help, everything is going as expected and there is no
reason to exit with non-zero.

However, with the current implementation, these changes to
help.c also make "git<Enter>" to exit with 0 after it gives
help, which is not so nice (both "cvs" and "svn" without
parameter seem to exit with 1 and it sort of makes sense,
although I do not think it matters much).  As a few datapoints,
"cvs -H" exits with 1 and "svn help" exits with 0.

So in short,

 - "git" should retain the current behaviour (both output and
   exit code).

 - "git help" should retain the current output but probably
   should exit with 0.

 - Ditto for "git help -a".
