From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] simplify-merges: drop merge from irrelevant side branch
Date: Tue, 30 Apr 2013 13:54:56 -0700
Message-ID: <7vr4hrbuxr.fsf@alter.siamese.dyndns.org>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
	<1367342788-7795-8-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:55:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXHZq-0000Eu-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933800Ab3D3UzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:55:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932355Ab3D3UzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:55:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E9511B20F;
	Tue, 30 Apr 2013 20:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hjJObXkahhOPI+C6WZ8QVydqi94=; b=M75Gz2
	6XmifZuDVLuKSpODJcQVq/hgM2S4ZTTWPugrFvKNBvmb5qan0uwJZUigodGlNJUp
	BcVCsw+D39fnkGpt8ypK4U4oGaflumONH+PHpY41ZmhtpnRoa3XwMP/GLhwOyM9q
	ncWjH8VOXSZNSp5el81lh0LdWDagPfYhgJQL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X6KiuKte7KDVRbp06tvlSx7/+ZevHaV0
	QeoH5IWuVwnW7mse9hCO8VC0lFRAFzq7UMkMFSMiH0VfuYKDzY3wMkYO9AhvEDSv
	70Mr+BHCZILQ65EoRSBpU/bzQgti/YdrlXDC3EtpfLZTe/ewAfoN2nTHsWYViPDh
	39Ik8omVYNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75BC51B20E;
	Tue, 30 Apr 2013 20:54:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4514B1B20B;
	Tue, 30 Apr 2013 20:54:58 +0000 (UTC)
In-Reply-To: <1367342788-7795-8-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Tue, 30 Apr 2013 20:26:27 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37DEAF08-B1D8-11E2-8BC4-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223009>

Kevin Bracey <kevin@bracey.fi> writes:

> @@ -342,13 +342,13 @@ In the following, we will always refer to the same example history to
>  illustrate the differences between simplification settings.  We assume
>  that you are filtering for a file `foo` in this commit graph:
>  -----------------------------------------------------------------------
> +	  .-A---M---N---O---P---Q
> +	 /     /   /   /   /   /
> +	I     B   C   D   E   Y
> +	 \   /   /   /   /   /
> +	  `-------------'   X
>  -----------------------------------------------------------------------
> -The horizontal line of history A---P is taken to be the first parent of
> +The horizontal line of history A---Q is taken to be the first parent of
>  each merge.  The commits are:
>  
>  * `I` is the initial commit, in which `foo` exists with contents
> @@ -369,6 +369,10 @@ each merge.  The commits are:
>  * `E` changes `quux` to "xyzzy", and its merge `P` combines the
>    strings to "quux xyzzy".  `P` is TREESAME to `O`, but not to `E`.
>  
> +* `X` is an indpendent root commit that added a new file `side`, and `Y`
> +  modified it. `Y` is TREESAME to `X`. Its merge `Q` added `side` to `P`, and
> +  `Q` is TREESAME to `P`, but not to `Y`.
> +

OK, we say "filtering for a file `foo`" in the very beginning, so
there is an implied "with respect to `foo`" in all of these "A is
TREESAME to B", and the description in the new bullet point looks
correct.

> diff --git a/revision.c b/revision.c
> index 7535757..20c7058 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2119,6 +2119,22 @@ static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
>  	return marked;
>  }
>  
> +static int mark_treesame_root_parents(struct rev_info *revs, struct commit *commit)
> +{
> +	struct commit_list *p;
> +	int marked = 0;
> +
> +	for (p = commit->parents; p; p = p->next) {
> +		struct commit *parent = p->item;
> +		if (!parent->parents && (parent->object.flags & TREESAME)) {
> +			parent->object.flags |= TMP_MARK;
> +			marked++;
> +		}
> +	}
> +
> +	return marked;
> +}
> +
>  /*
>   * Awkward naming - this means one parent we are TREESAME to.
>   * cf mark_treesame_root_parents: root parents that are TREESAME (to an
> @@ -2284,10 +2300,18 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
>  	 *     /    /		o: a commit that touches the paths;
>  	 * ---o----'
>  	 *
> -	 * Detect and simplify this case.
> +	 * Further, a merge of an independent branch that doesn't
> +	 * touch the path will reduce to a treesame root parent:
> +	 *
> +	 *  ----o----X		X: the commit we are looking at;
> +	 *          /		o: a commit that touches the paths;
> +	 *         r		r: a root commit not touching the paths
> +	 *
> +	 * Detect and simplify both cases.
>  	 */
>  	if (1 < cnt) {
>  		int marked = mark_redundant_parents(revs, commit);
> +		marked += mark_treesame_root_parents(revs, commit);
>  		if (marked)
>  			marked -= leave_one_treesame_to_parent(revs, commit);
>  		if (marked)

The solution looks surprisingly simple ;-)

Thanks.

> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> index 4e55872..57ce239 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -110,7 +110,7 @@ check_result 'L K J I H G F E D C B A' --full-history
>  check_result 'K I H E C B A' --full-history -- file
>  check_result 'K I H E C B A' --full-history --topo-order -- file
>  check_result 'K I H E C B A' --full-history --date-order -- file
> -check_outcome failure 'I E C B A' --simplify-merges -- file
> +check_result 'I E C B A' --simplify-merges -- file
>  check_result 'I B A' -- file
>  check_result 'I B A' --topo-order -- file
>  check_result 'H' --first-parent -- another-file
