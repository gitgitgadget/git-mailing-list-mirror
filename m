From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/21] bisect: prepare for different algorithms based on find_all
Date: Fri, 15 Apr 2016 15:36:06 -0700
Message-ID: <xmqqy48e7b55.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-19-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:36:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCLX-0000jd-0c
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbcDOWgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:36:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbcDOWgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:36:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7507C13675;
	Fri, 15 Apr 2016 18:36:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5nC3tdq3QfL9ORcKwdE1Ia9F6ks=; b=aZHum/
	joC4G3WpNn6RUfZz/QPW4NtRy3w2rqPGosdUL1XMQbxbHHg248TiF6kHDlCA232F
	w3IOVDNQrAlcoYT/xqWW5HqEcFGk4/lmAsZFqggzkqz1xxZnfoy8d1a7fHvETks6
	UQJCtARvIEYljkl4meqs69ptpD0XejAlLJpf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H6GAs46+ATz9+vL9I4Qq6SYscFFbehz0
	Ao4ry9DccatLoOJaHfjb0VmA6AUq1t87PC6Ez7CzIhFObtIx+Rl/qt+p3hiGXtrq
	rBYtHcu3kZmT0TEW3XTkHN/4s4ZuFuxFVB43ac1/+9xvBRtkwqW4+iovKHxd6plv
	IPKVQoVbNaw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B79713674;
	Fri, 15 Apr 2016 18:36:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF61913673;
	Fri, 15 Apr 2016 18:36:07 -0400 (EDT)
In-Reply-To: <1460294354-7031-19-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7214FA7A-035A-11E6-AECD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291684>

Stephan Beyer <s-beyer@gmx.net> writes:

> This is a preparation commit with copy-and-paste involved.
> The function do_find_bisection() is changed and copied to
> two almost similar functions compute_all_weights() and
> compute_relevant_weights().
>
> The function compute_relevant_weights() stops when a
> "halfway" commit is found.
>
> To keep the code clean, the halfway commit is not returned
> and has to be found by best_bisection() afterwards.
> This results in a singular additional O(#commits)-time
> overhead but this will be outweighed by the following
> changes to compute_relevant_weights().
>
> It is necessary to keep compute_all_weights() for the
> "git rev-list --bisect-all" command. All other bisect-related
> commands will use compute_relevant_weights().
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  bisect.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 97 insertions(+), 19 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index a254f28..c6bad43 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -179,6 +179,7 @@ static struct commit_list *best_bisection(struct commit_list *list)
>  		}
>  	}
>  
> +	best->next = NULL;
>  	return best;
>  }

At this point of this patch it is unclear how this change is
relevant.  I'll read on without complaining but with puzzlement.

> @@ -245,9 +246,8 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list)
>   * unknown.  After running compute_weight() first, they will get zero
>   * or positive distance.
>   */
> -static struct commit_list *do_find_bisection(struct commit_list *list,
> -					     struct node_data *weights,
> -					     int find_all)
> +static void compute_all_weights(struct commit_list *list,
> +				struct node_data *weights)
>  {
>  	int n, counted;
>  	struct commit_list *p;
> @@ -301,10 +301,88 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		if (!(p->item->object.flags & UNINTERESTING)
>  		 && (node_data(p->item)->weight == -2)) {
>  			compute_weight(p->item);
> +			counted++;
> +		}
> +	}
> +
> +	show_list("bisection 2 compute_weight", counted, list);
> +
> +	while (counted < total) {
> +		for (p = list; p; p = p->next) {
> +			struct commit_list *q;
> +			unsigned flags = p->item->object.flags;
> +
> +			if (0 <= node_data(p->item)->weight)
> +				continue;
> +			for (q = p->item->parents; q; q = q->next) {
> +				if (q->item->object.flags & UNINTERESTING)
> +					continue;
> +				if (0 <= node_data(q->item)->weight)
> +					break;
> +			}
> +			if (!q)
> +				continue;
> +
> +			/*
> +			 * weight for p is unknown but q is known.
> +			 * add one for p itself if p is to be counted,
> +			 * otherwise inherit it from q directly.
> +			 */

This is not a new problem, but "q" in the comment should be
"q->item"; my bad.

> +			node_data(p->item)->weight = node_data(q->item)->weight;
> +			if (!(flags & TREESAME)) {
> +				node_data(p->item)->weight++;
> +				counted++;
> +				show_list("bisection 2 count one",
> +					  counted, list);
> +			}

This is not a new problem, and I do admit that I wrote the original
at 1daa09d9 (make the previous optimization work also on
path-limited rev-list --bisect, 2007-03-23), but this makes me
wonder why counted++ is not done for p that is treesame.

 ... goes and looks ...

Ahh, the original while loop was counting upto "nr", which is
different from total.  When the traversal is pathspec limited, I
counted in the original (and probably in 'master' branch before your
series) the number of tree-changing commits in 'nr' which can be
smaller than 'total'.  That is why skipping counted++ on a treesame
commit was the correct thing to do.

Is it possible that you did not test --bisect-all with pathspec?  I
have a suspicion that the above loop would not terminate because of
this change.  If that is the case, either "make total global and get
rid of nr" needs to be fixed, or (probably better) move counted++
out of this if statement.  At this point, counted indicates "how
many commits out of 'total' we have computed weight for?", so the
latter would make more sense to me, even though either is OK.

The "priming the well" step for the "no interesting parent--set
weight to either 0 or 1" also needs to adjust counted++, I suspect.

> +		}
> +	}
> +	show_list("bisection 2 counted all", counted, list);
> +}
> +
> +/* At the moment this is basically the same as compute_all_weights()
> + * but with a halfway shortcut */

/*
 * We write our multi-line comments like this.
 * The first and last lines have only asterisk
 * and slash.
 */

> +static void compute_relevant_weights(struct commit_list *list,
> +				     struct node_data *weights)
> +{
> +	int n, counted;
> +	struct commit_list *p;
> +
> +	counted = 0;
> +
> +	for (n = 0, p = list; p; p = p->next) {
> +		struct commit *commit = p->item;
> +		unsigned flags = commit->object.flags;
> +
> +		commit->util = &weights[n++];
> +		switch (count_interesting_parents(commit)) {
> +		case 0:
> +			if (!(flags & TREESAME)) {
> +				node_data(commit)->weight = 1;
> +				counted++;
> +				show_list("bisection 2 count one",
> +					  counted, list);
> +			}
> +			break;
> +		case 1:
> +			node_data(commit)->weight = -1;
> +			break;
> +		default:
> +			node_data(commit)->weight = -2;
> +			break;
> +		}
> +	}
> +
> +	show_list("bisection 2 initialize", counted, list);
> +
> +	for (p = list; p; p = p->next) {
> +		if (!(p->item->object.flags & UNINTERESTING)
> +		 && (node_data(p->item)->weight == -2)) {
> +			compute_weight(p->item);
>  
>  			/* Does it happen to be at exactly half-way? */
> -			if (!find_all && halfway(p->item))
> -				return p;
> +			if (halfway(p->item))
> +				return;

It is somewhat curious why this, after finding the desired commit as
p->item, does not return it.  If it is already known that we have
half-way one, can't we return it immediately (and when we fall
through without finding exactly the half-way one, we signal the
caller that it needs best_bisection() among the list by returning a
NULL or something?

But probably that is optimizing it prematurely.  I dunno.

>  			counted++;
>  		}
>  	}
> @@ -341,17 +419,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			}
>  
>  			/* Does it happen to be at exactly half-way? */
> -			if (!find_all && halfway(p->item))
> -				return p;
> +			if (halfway(p->item))
> +				return;
>  		}
>  	}
> -
>  	show_list("bisection 2 counted all", counted, list);
> -
> -	if (!find_all)
> -		return best_bisection(list);
> -	else
> -		return best_bisection_sorted(list);
>  }
>  
>  struct commit_list *find_bisection(struct commit_list *list,
> @@ -365,6 +437,9 @@ struct commit_list *find_bisection(struct commit_list *list,
>  	total = 0;
>  	marker = 0;
>  
> +	if (!list)
> +		return NULL;
> +
>  	show_list("bisection 2 entry", 0, list);
>  
>  	/*
> @@ -391,13 +466,16 @@ struct commit_list *find_bisection(struct commit_list *list,
>  	*all = total;
>  	weights = (struct node_data *)xcalloc(on_list, sizeof(*weights));
>  
> -	/* Do the real work of finding bisection commit. */
> -	best = do_find_bisection(list, weights, find_all);
> -	if (best) {
> -		if (!find_all)
> -			best->next = NULL;
> -		*reaches = node_data(best->item)->weight;
> +	if (find_all) {
> +		compute_all_weights(list, weights);
> +		best = best_bisection_sorted(list);
> +	} else {
> +		compute_relevant_weights(list, weights);
> +		best = best_bisection(list);
>  	}
> +	assert(best);
> +	*reaches = node_data(best->item)->weight;
> +
>  	free(weights);
>  
>  	return best;
