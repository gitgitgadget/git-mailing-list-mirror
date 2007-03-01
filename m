From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-revert & git-cherry-pick a builtin
Date: Thu, 01 Mar 2007 03:51:30 -0800
Message-ID: <7vzm6xqj0d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703010526080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:51:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMjpC-00047x-Qr
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbXCALvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933254AbXCALvc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:51:32 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49679 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933260AbXCALvb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:51:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301115131.QTKY748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 06:51:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VPrW1W00J1kojtg0000000; Thu, 01 Mar 2007 06:51:31 -0500
In-Reply-To: <Pine.LNX.4.63.0703010526080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 1 Mar 2007 05:26:30 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41088>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile         |   11 +-
>  builtin-revert.c |  406 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h        |    2 +
>  git-revert.sh    |  197 --------------------------
>  git.c            |    2 +
>  5 files changed, 414 insertions(+), 204 deletions(-)
>  create mode 100644 builtin-revert.c
>  delete mode 100755 git-revert.sh

Thanks.  I haven't looked the patch closely but I trust this
round is a fairly faithful straight translation from the shell
script, which is good.  I have a few gripes on the behaviour of
these commands, and it might be worthwhile to address them in
the later rounds.

> +static int merge_recursive(const char *base_sha1,
> +		const char *head_sha1, const char *head_name,
> +		const char *next_sha1, const char *next_name)
> +{
> + ...
> +}

Somehow I would have expected you to call merge-recursive not
spawn, but this is saner ;-).

> +static int revert_or_cherry_pick(int argc, const char **argv)
> +{
> + ...
> +	msg_fd = hold_lock_file_for_update(&msg_file, ".msg", 1);

Although the detailed reason escapes me, we earlier moved the
temporary files to $GIT_DIR/.  This .msg in the current
directory somehow survived.  It probably is a good idea to move
this to $GIT_DIR/ in later rounds.

> +		if (action == CHERRY_PICK) {
> +			fprintf(stderr, "You may choose to use the following "
> +				"when making the commit:\n"
> +				"GIT_AUTHOR_NAME=\"%s\"\n",
> +				getenv("GIT_AUTHOR_NAME"));
> +			fprintf(stderr, "GIT_AUTHOR_EMAIL=\"%s\"\n",
> +				getenv("GIT_AUTHOR_EMAIL"));
> +			fprintf(stderr, "GIT_AUTHOR_DATE=\"%s\"\n"
> +				"export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL "
> +				"GIT_AUTHOR_DATE\n",
> +				getenv("GIT_AUTHOR_DATE"));
> +		}
> +		exit(1);
> +	}

I am to blame for this crap, but I think this part of code was
done before we invented "git commit -C <commit>".  It would be a
lot better to suggest using that command.
