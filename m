From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Move refspec parser from connect.c and cache.h to remote.{c,h}
Date: Sat, 12 May 2007 00:32:47 -0700
Message-ID: <7v7ire5wf4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705112238420.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 12 09:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmm62-0001Gt-28
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbXELHct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 03:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755672AbXELHct
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:32:49 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59437 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbXELHcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:32:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512073247.REIN22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 03:32:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id y7Yn1W0021kojtg0000000; Sat, 12 May 2007 03:32:47 -0400
In-Reply-To: <Pine.LNX.4.64.0705112238420.18541@iabervon.org> (Daniel
	Barkalow's message of "Fri, 11 May 2007 22:39:27 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47025>

Daniel Barkalow <barkalow@iabervon.org> writes:

> diff --git a/remote.c b/remote.c
> index 1dd2e77..2ac7bc8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -181,6 +181,44 @@ static void read_config(void)
> + ...
> +static int match_explicit_refs(struct ref *src, struct ref *dst,
> +			       struct ref ***dst_tail, struct refspec *rs,
> +			       int rs_nr)
> +{
> +	int i, errs;
> +	for (i = errs = 0; i < rs_nr; i++) {
> +		struct ref *matched_src, *matched_dst;
> +
> +		const char *dest = rs[i].dest;
> +		if (dest == NULL)
> +			dest = rs[i].src;

I am not a big fan of gratuitous renaming of structure members
and variables such as this s/dst/dest/, especially when the
change breaks consistency (between src vs dst -- you left
matched_dst intact).

> ...
> +		switch (count_refspec_match(dest, dst, &matched_dst)) {
> ...
> +		case 0:
> +			if (!memcmp(dest, "refs/", 5)) {
> ...
> +			else {
> +				errs = 1;
> +				error("dst refspec %s does not match any "
> +				      "existing ref on the remote and does "
> +				      "not start with refs/.", rs[i].dest);
> +			}

I think you meant to say 'dest' instead of 'rs[i].dest' here.

> +...
> +	}
> +	return -errs;
> +}
