From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-list --max-age, --max-count: support --boundary
Date: Mon, 19 Feb 2007 15:40:16 -0800
Message-ID: <7v8xet67j3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702190312120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJI7M-0003P3-DA
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965548AbXBSXkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965551AbXBSXkV
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:40:21 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55204 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965548AbXBSXkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:40:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219234017.LLLM1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 18:40:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RbgF1W0131kojtg0000000; Mon, 19 Feb 2007 18:40:16 -0500
In-Reply-To: <Pine.LNX.4.63.0702190312120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 19 Feb 2007 03:14:59 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40164>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, when saying --max-age=<timestamp>, or --max-count=<n>, together
> with --boundary, rev-list prints the boundary commits, i.e. the
> commits which are _just_ not shown without --boundary, i.e. their
> children are, but they aren't.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>
> 	Of course, this is meant to speed up an otherwise expensive
> 	operation in git-bundle.
>
> 	However, this touches a very sensitive point in core git:
> 	the revision walking machinery. It passes all tests, but
> 	some eyeballing is much appreciated.

I think this looks fine.

Initially I thought setting BOUNDARY_SHOW unconditionally would
be wrong (the "limited" case takes pains to avoid showing
redundant boundary commits), and that was exactly why I said it
would be a bit more involved change, but I do not think of a
topology that needs redundancy removal outside of "limited" case.

> @@ -1336,7 +1342,17 @@ struct commit *get_revision(struct rev_info *revs)
>  	case -1:
>  		break;
>  	case 0:
> -		return NULL;
> +		if (revs->boundary) {
> +			struct commit_list *list = revs->commits;
> +			while (list) {
> +				list->item->object.flags |=
> +					BOUNDARY_SHOW | BOUNDARY;
> +				list = list->next;
> +			}
> +			revs->max_count = -1;
> +			revs->limited = 1;
> +		} else
> +			return NULL;

The resetting of max_count and limited probably needs some
commenting.
