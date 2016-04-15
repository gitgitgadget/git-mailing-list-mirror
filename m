From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/21] bisect: use a bottom-up traversal to find relevant weights
Date: Fri, 15 Apr 2016 15:47:51 -0700
Message-ID: <xmqqtwj27alk.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-20-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:48:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCWt-00077K-9G
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcDOWrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:47:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751355AbcDOWry (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:47:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 341FD1373C;
	Fri, 15 Apr 2016 18:47:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c/odxeLrAfGRY0cN2SoGqa5ZEN8=; b=DRUvd/
	XejawYftSNoPUoNdlExJ9HAT3d3XsazDOS5mTqHb1zAeYOMmJL11d3bnoucMApNw
	+EQH+7qXZmhiioackojHe1UTk20KnT7TGy2OM+xhy728vla60dEsp9F4Nn9o4QpC
	GQV87VyGY60OGuzadCD7x9RGfvjHqhS9gHVlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WCf/hEa/kbLQxrCnakKpPm9EhAzTLXyl
	no4cumDWunUX/52ashjAWSSkEFWoEHHLTMgcwbbN4zQ8Fuzqe1503uvoWOToX18A
	wlSOWbfXdGfGdF83qftkLGUuy9kxonLFglEjBpxM4EyRA0ZR/mTmBRGS0G6/Wqoy
	HWqMkaX5bjo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CC321373B;
	Fri, 15 Apr 2016 18:47:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9338F13739;
	Fri, 15 Apr 2016 18:47:52 -0400 (EDT)
In-Reply-To: <1460294354-7031-20-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 163A2796-035C-11E6-B8C5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291687>

Stephan Beyer <s-beyer@gmx.net> writes:

> The idea is to reverse the DAG and perform a traversal
> starting on all sources of the reversed DAG.

Please clarify what you mean by "sources" here.  Those who read log
message in Git context would know that you mean the commit graph by
"DAG", and "reversed DAG" means "having reverse linkage that lets
you find children given a parent", so "DAG" does not need such a
clarification.

> We walk from the bottom commits, incrementing the weight while
> walking on a part of the graph that is single strand of pearls,
> or doing the "count the reachable ones the hard way" using
> compute_weight() when we hit a merge commit.

Makes sense.  So instead of "all sources", you can say "perform a
traversal starting from the bottom commits, going from parent to its
children".

> A traversal ends when the computed weight is falling or halfway.
> This way, commits with too high weight to be relevant are never
> visited (and their weights are never computed).

Yup, beautiful.

> diff --git a/bisect.c b/bisect.c
> index c6bad43..9487ba9 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -30,6 +30,9 @@ static unsigned marker;
>  struct node_data {
>  	int weight;
>  	unsigned marked;
> +	unsigned parents;
> +	unsigned visited : 1;
> +	struct commit_list *children;
>  };
>  
>  #define DEBUG_BISECT 0

> +static inline void commit_list_insert_unique(struct commit *item,
> +				      struct commit_list **list)
> +{
> +	if (!*list || item < (*list)->item) /* empty list or item will be first */
> +		commit_list_insert(item, list);
> +	else if (item != (*list)->item) { /* item will not be first or not inserted */
> +		struct commit_list *p = *list;
> +		for (; p->next && p->next->item < item; p = p->next);
> +		if (!p->next || item != p->next->item) /* not already inserted */
> +			commit_list_insert(item, &p->next);
> +	}
> +}

Hmmmmmmmmmmmmmmmmmmmmmmmmmmmm.

When you have two commits, struct commit *one, and struct commit
*two, is it safe to do a pointer comparison for ordering?

I know it would work in practice, but I am worried about language
lawyers (and possibly static analysis tools) barking at this code.
