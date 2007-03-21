From: Junio C Hamano <junkio@cox.net>
Subject: Re: Set up for better tree diff optimizations
Date: Wed, 21 Mar 2007 00:09:11 -0700
Message-ID: <7vircv3wfc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 08:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTuwh-000280-G5
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 08:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbXCUHJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 03:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbXCUHJQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 03:09:16 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62560 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbXCUHJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 03:09:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321070915.WPMM1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 03:09:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dK9B1W00Z1kojtg0000000; Wed, 21 Mar 2007 03:09:14 -0400
In-Reply-To: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 18 Mar 2007 15:18:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42780>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This is mainly just a cleanup patch, and sets up for later changes where 
> the tree-diff.c "interesting()" function can return more than just a 
> yes/no value.
>
> In particular, it should be quite possible to say "no subsequent entries 
> in this tree can possibly be interesting any more", and thus allow the 
> callers to short-circuit the tree entirely.
>
> In fact, changing the callers to do so is trivial, and is really all this 
> patch really does, because changing "interesting()" itself to say that 
> nothing further is going to be interesting is definitely more complicated, 
> considering that we may have arbitrary pathspecs.
> ...
> Junio, your decision.

Sorry, as I was sick and spent almost all day in bed, I am
somewhat behind going through the mailing list backlog.

>  tree-diff.c |   44 ++++++++++++++++++++++++++++++++++----------
>  1 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/tree-diff.c b/tree-diff.c
> index f89b9d3..2e0a3ae 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -66,7 +66,15 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
>  	return 0;
>  }
>  
> -static int interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
> +/*
> + * Is a tree entry interesting given the pathspec we have?
> + *
> + * Return:
> + *  - positive for yes
> + *  - zero for no
> + *  - negative for "no, and no subsequent entries will be either"
> + */
> +static int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
>  {
>  	const char *path;
>  	const unsigned char *sha1;

I've already applied the patch, but I do not know how much this
interface would help, as the only easy case the function
tree_entry_interesting() can say "no subsequent entries will be
either" without looking ahead is where no pathspecs match the
base, but that is already prevented by the way you walk the tree
(you do not descend into an uninteresting tree).

If you do:

	$ git log arch/i386/ include/asm-i386/

and if the traversal is already in arch/i386/crypto, then it is
unnecessary to check if a path discovered during the traversal
is interesting, as the base ("arch/i386/crypto") for all the
entries in that subdirectory is already covered by one of the
pathspecs ("arch/i386").  It also means checking the other
pathspec "include/asm-i386/" is a waste of time, because that
will not match the base no matter what path is discovered from
the tree object anyway.

I suspect that two possible optimizations are:

 (1) instead of, or in addition to, allowing it to say "no
     subsequent ones will match", allow it to say "everything
     for this base will be interesting, stop bothering to ask me
     one path at a time".

 (2) mark include/asm-i386/ pathspec to be N/A while we are
     already in arch/i386/crypto, as we already know it will
     never match.  And remove that mark when we come back from
     that recursion.
