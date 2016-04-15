From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/21] bisect: get rid of recursion in count_distance()
Date: Fri, 15 Apr 2016 14:31:10 -0700
Message-ID: <xmqq4mb2a7a9.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-11-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:31:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBKg-0006b8-5C
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbcDOVbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:31:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750956AbcDOVbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:31:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E977013F18;
	Fri, 15 Apr 2016 17:31:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQV110bDAIuvOguPUveu2ek/hlI=; b=bdoDgA
	nPiavbYVchA78Ylp42b85tVLbzMJmPP7wouW+X4WysPf1+eXT/bpR+ZEp2HjBqt9
	9kJSzuYLZVmY1P467srchEa2Ddssz7xNRFjeuef08yhMwGJSEGxXyYMe1Q7ztODm
	pZvc5PGbhTz+yDwPYcHc1p6vXsJpMQGty8n1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M/KiENUwu36MEWTcSeqLILd0vKqV6nPa
	j5K1QqiG6uiavn6JXT/+SmaAfbM+d+YE7Wzmrv/sic9XTKiOrrqdt1BxvP2Gliw0
	ULLhfUSR7h2cFCIxbWe1GnlxK3qkVkAR9tVleinsP69ZinUZcVlrZoVMTSbdoAD2
	SE2GPOaAMt0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0E7F13F17;
	Fri, 15 Apr 2016 17:31:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5387413F16;
	Fri, 15 Apr 2016 17:31:11 -0400 (EDT)
In-Reply-To: <1460294354-7031-11-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FA99A52-0351-11E6-A23E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291669>

Stephan Beyer <s-beyer@gmx.net> writes:

> Large repositories with a huge amount of merge commits in the
> bisection process could lead to stack overflows in git bisect.
> In order to prevent this, this commit uses an *iterative* version
> for counting the number of ancestors of a commit.

Yay!

> -/*
> - * This is a truly stupid algorithm, but it's only
> - * used for bisection, and we just don't care enough.
> - *
> - * We care just barely enough to avoid recursing for
> - * non-merge entries.
> - */
>  static int count_distance(struct commit_list *entry)
>  {
>  	int nr = 0;
> +	struct commit_list *todo = NULL;
> +	commit_list_append(entry->item, &todo);
>  
> -	while (entry) {
> -		struct commit *commit = entry->item;
> -		struct commit_list *p;
> +	while (todo) {
> +		struct commit *commit = pop_commit(&todo);
>  
> -		if (commit->object.flags & (UNINTERESTING | COUNTED))
> -			break;
> -		if (!(commit->object.flags & TREESAME))
> -			nr++;
> -		commit->object.flags |= COUNTED;
> -		p = commit->parents;
> -		entry = p;
> -		if (p) {
> -			p = p->next;
> -			while (p) {
> -				nr += count_distance(p);
> -				p = p->next;
> +		if (!(commit->object.flags & (UNINTERESTING | COUNTED))) {
> +			struct commit_list *p;
> +			if (!(commit->object.flags & TREESAME))
> +				nr++;
> +			commit->object.flags |= COUNTED;
> +
> +			for (p = commit->parents; p; p = p->next) {
> +				commit_list_insert(p->item, &todo);
>  			}
>  		}
>  	}
> @@ -287,7 +277,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  	 * can reach.  So we do not have to run the expensive
>  	 * count_distance() for single strand of pearls.
>  	 *
> -	 * However, if you have more than one parents, you cannot
> +	 * However, if you have more than one parent, you cannot

Thanks.  This grammo is mine, back in 1c4fea3a (git-rev-list
--bisect: optimization, 2007-03-21)

> @@ -296,17 +286,16 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  	 * way, and then fill the blanks using cheaper algorithm.
>  	 */
>  	for (p = list; p; p = p->next) {
> -		if (p->item->object.flags & UNINTERESTING)
> -			continue;
> -		if (weight(p) != -2)
> -			continue;
> -		weight_set(p, count_distance(p));
> -		clear_distance(list);
> +		if (!(p->item->object.flags & UNINTERESTING)
> +		 && (weight(p) == -2)) {
> +			weight_set(p, count_distance(p));
> +			clear_distance(list);
>  
> -		/* Does it happen to be at exactly half-way? */
> -		if (!find_all && halfway(p, nr))
> -			return p;
> -		counted++;
> +			/* Does it happen to be at exactly half-way? */
> +			if (!find_all && halfway(p, nr))
> +				return p;
> +			counted++;
> +		}
>  	}

I can buy collapsing two if() statements into one, but I'd prefer to
see us keep the structure:

	loop () {
                if (... || ...)
                        continue;
                quite a
                many
                operations
                here
	}

>  
>  	show_list("bisection 2 count_distance", counted, nr, list);
