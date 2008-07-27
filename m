From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sat, 26 Jul 2008 21:47:34 -0700
Message-ID: <7vabg43pcp.fsf@gitster.siamese.dyndns.org>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 06:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMyCZ-0004nF-K5
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 06:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbYG0Erq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 00:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYG0Erp
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 00:47:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbYG0Erp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 00:47:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CA2733CD0;
	Sun, 27 Jul 2008 00:47:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B15C33CCC; Sun, 27 Jul 2008 00:47:38 -0400 (EDT)
In-Reply-To: <20080727053324.b54fe48e.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 27 Jul 2008 05:33:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 267E3E0A-5B97-11DD-BE52-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90309>

Christian Couder <chriscool@tuxfamily.org> writes:

>  OPTIONS
>  -------
>  --all::
> -	Output all common ancestors for the two commits instead of
> -	just one.
> +	Output all merge bases for the commits instead of just one. No
> +	merge bases in the output should be an ancestor of another
> +	merge base in the output. Each common ancestor of the first
> +	commit and any of the other commits passed as arguments,
> +	should be an ancestor of one of the merge bases in the output.

The point of merge_bases_many() is that it allows you to compute a merge
base between a commit and another commit that does not yet exist which is
a merge across all others.

               o---o---o---o---C
              /                 :
             /   o---o---o---B..(M)
            /   /                 :
	---o---*---o---o---o---A..(X)

Suppose you have commits A, B and C, and you would want to come up with an
Octopus merge X across these three commits.  Because our low-level merge
machinery works always on two trees with one common ancestor tree, we
would first create a tree that is a merge between B and C (which is marked
as (M) in the picture), and then merge the tree of (M) and A using common
ancestor between (M) and A.

If we did not have merge_bases_many(), we would actually create (M) as a
real commit, and compute merge base between A and (M), which is marked as
"*" in the picture.  The use of merge_bases_many() allows us to run the
same merge base computation without actually creating commit (M).  Instead
of computing merge-base between A and (M), you can ask for the merge base
between A ("the first commit") and B, C ("the other commits") to obtain
the same answer "*".

Base between A and B is that "*", and you are correct to say that it is an
ancestor of the "*" that is output from the command; base between A and C
is the parent of "*", and again you are correct to say it is ancestor of
the "*" that is output from the command.

But if we output any other commit between "*" and A from the command, it
still satisifies your condition.  "The merge base between A and each of B,
C,... should be an ancestor of what is output".  In order to satisify your
condition, in the extreme case, we could even output A.  Both the merge
base between A and B, and the merge base between A and C, would be an
ancestor of A.

So your description may not be incorrect, but I think it completely misses
the point of what is being computed.

>  Author
>  ------
> diff --git a/builtin-merge-base.c b/builtin-merge-base.c
> index 1cb2925..f2c9756 100644
> --- a/builtin-merge-base.c
> +++ b/builtin-merge-base.c
> @@ -2,9 +2,11 @@
>  #include "cache.h"
>  #include "commit.h"
>  
> -static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_all)
> +static int show_merge_base(struct commit *rev1, int prev2_nr,
> +			   struct commit **prev2, int show_all)
>  {
> -	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
> +	struct commit_list *result = get_merge_bases_many(rev1, prev2_nr,
> +							  prev2, 0);

This is just style, but if you must break lines somewhere, I'd prefer to
have prev2_nr and prev2 on the same line, like this:

	struct commit_list *result = get_merge_bases_many(rev1,
							  prev2_nr, prev2, 0);

because they logically belong to each other.  Further, I think this
84-column single-line statement is perfectly fine as well in this case:

	struct commit_list *result = get_merge_bases_many(rev1, prev2_nr, prev2, 0);

I would probably do this myself in this case, though:

	struct commit_list *result;

	result  = get_merge_bases_many(rev1, prev2_nr, prev2, 0);
