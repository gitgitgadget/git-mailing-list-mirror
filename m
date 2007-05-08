From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] diff: Make numstat machine friendly also for renames
Date: Mon, 07 May 2007 18:10:21 -0700
Message-ID: <7vzm4g5ddu.fsf@assigned-by-dhcp.cox.net>
References: <11785850223782-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 03:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEDl-0008F2-3w
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966577AbXEHBKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966580AbXEHBKX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:10:23 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33947 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966577AbXEHBKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:10:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508011023.WPYR6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 7 May 2007 21:10:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wRAM1W00E1kojtg0000000; Mon, 07 May 2007 21:10:21 -0400
In-Reply-To: <11785850223782-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Tue, 8 May 2007 02:43:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46502>

Jakub Narebski <jnareb@gmail.com> writes:

> Instead of saving human readable rename information in the 'name'
> field when diffstat info is generated, do it when writing --stat
> output. Change --numstat output to be machine friendly.
>
> This makes result of git-diff --numstat more suitable for machines
> also when renames are involved, by using format similar to the one for
> renames in the raw diff format, instead of the format more suited for
> humans.
>
> The numstat format for rename is now
>
>   added deleted TAB path for "src" TAB path for "dst" LF
>
> or if -z option is used
>
>   added deleted TAB path for "src" NUL NUL path for "dst" NUL

Why two NULs?

There are already a handful in-tree users of --numstat, and also
a few tests scripts.  I think you would need to adjust them.

> The goal of this change is to make it possible to generate HTML
> diffstat against first parent for merge commits in gitweb. The current
> notation for renames, which looks for example like below:
>
>   t/{t6030-bisect-run.sh => t6030-bisect-porcelain.sh}

I do not have much objection against teaching --numstat to show
the preimage pathnames.  I do not disagree with "the goal" of
showing "git diff --stat -M $commit^1 $commit" even for merge
commit.

But I do not see the connection between the two.  Why aren't you
parsing --summary?

Have you actually _tested_ your patch?

> @@ -949,11 +955,19 @@ static void show_numstat(struct diffstat_t* data,
>  			printf("-\t-\t");
>  		else
>  			printf("%d\t%d\t", file->added, file->deleted);
> -		if (options->line_termination && !file->is_renamed &&
> +		if (options->line_termination &&
>  		    quote_c_style(file->name, NULL, NULL, 0))
>  			quote_c_style(file->name, NULL, stdout, 0);
>  		else
>  			fputs(file->name, stdout);
> +		if (file->is_renamed) {
> +			printf("%s", options->line_termination ? "\t" : "\0\0");

I know you marked it as RFC; but it is impolite to request
comments from other people on a patch that does not do what you
intended to do, without marking "this is untested".  It would
waste people's time.
