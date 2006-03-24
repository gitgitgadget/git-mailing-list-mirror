From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Fri, 24 Mar 2006 02:21:25 -0800
Message-ID: <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net>
References: <20060324084423.GA30213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 11:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMjQA-0008PX-NG
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 11:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWCXKV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 05:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWCXKV1
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 05:21:27 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54160 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751617AbWCXKV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 05:21:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324102126.IEBY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 05:21:26 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20060324084423.GA30213@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 24 Mar 2006 03:44:23 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17905>

Jeff King <peff@peff.net> writes:

> tree_timewarp was calling read, egrep, and rm in an O(N) loop where N is
> the number of changed files between two trees. This caused a bottleneck
> when seeking/switching/merging between trees with many changed files.
>...
> ---
>
>  cg-Xlib |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
>
> a9a160c0bd63973c53ba3aa74650728135d23ac7
> diff --git a/cg-Xlib b/cg-Xlib
> index a2f28cf..ceddeeb 100644
> --- a/cg-Xlib
> +++ b/cg-Xlib
> @@ -345,12 +345,9 @@ tree_timewarp()
>  
>  	# Kill gone files
>  	git-diff-tree -r "$base" "$branch" |
> ...
> +		# match ":100755 000000 14d43b1abf... 000000000... D"
> +		sed -ne 's/^:\([^ ][^ ]* \)\{4\}D\t//p' |
> +		xargs rm --
>  	git-checkout-index -u -f -a

Metainformation fields are internally separated with SP and a
TAB comes before pathname; you can just say:

	sed -ne 's/^:[^	]* D	//p'

there (whitespace inside [] and after D are TAB; one before D is
a SP).  You might also want to consider "xargs rm -f --", BTW.

However, I wonder why it does not do this instead:

	... stash away the local changes
	git-read-tree -m "$base" ;# reset the index to $base

	# switch to $branch -- removing gone files as well
	git-read-tree -m -u "$base" "$branch"

Then you can also lose diff-tree and checkout-index there.
