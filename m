From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] bisect: use commit instead of commit list as arguments when appropriate
Date: Thu, 25 Feb 2016 19:10:55 -0800
Message-ID: <xmqqmvqokvy8.fsf@gitster.mtv.corp.google.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-9-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 04:11:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ8o4-0004bE-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 04:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbcBZDK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 22:10:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752727AbcBZDK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 22:10:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B3BE45D05;
	Thu, 25 Feb 2016 22:10:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oq2tqGra+pBrP6LDa/kPtTEsq5A=; b=NbTtCl
	D/fOF0IxilhxNl/3w3SfQBHQ/Wn4f+31iD8Pw55nw0bHR4vJHQrfeqxm3YYTQATA
	0LBFNLmcJDzngSRo5jU+W/PsI2o1tYM0N7JEdkOW3ErSNP/qyecl8ddpMggkJBiR
	25X32hYw3u6851HItiBvpxQPCwknEmC6Xg4do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dp2FyntJpqNzggnRMBKitAh8prc+pEC1
	Gz8XJEaJY9Ass2C0laKshf4EVh+cL17/yKvAf8dxAexnYFxvTiNTYUnki6ONBtL5
	io3NJQPO21PXVMj8O6hIlF1O9RRqBK+TJH1u+Se8E5e976u9ei5h/lbUZ5NGQ2Ks
	t7r2ZYpKn0o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9185145D04;
	Thu, 25 Feb 2016 22:10:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 14AC445D03;
	Thu, 25 Feb 2016 22:10:57 -0500 (EST)
In-Reply-To: <1456452282-10325-9-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Fri, 26 Feb 2016 03:04:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8DDBB172-DC36-11E5-AA11-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287536>

Stephan Beyer <s-beyer@gmx.net> writes:

> It makes no sense that the argument for count_distance() and
> halfway() is a commit list when only its first commit is relevant.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> This is just some kind of minor code cleanup.
> The typical "while at it", you know it, I guess.

If you are doing while-at-it, please rename the variable to commit
or something.  "entry" refers to one element in the list, but the
entity the updated code works on is no longer that.

>
>  bisect.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 6df13b0..76f2445 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -38,11 +38,11 @@ static inline struct node_data *node_data(struct commit *elem)
>  	return (struct node_data *)elem->util;
>  }
>  
> -static int count_distance(struct commit_list *entry)
> +static int count_distance(struct commit *entry)
>  {
>  	int nr = 0;
>  	struct commit_list *todo = NULL;
> -	commit_list_append(entry->item, &todo);
> +	commit_list_append(entry, &todo);
>  	marker++;
>  
>  	while (todo) {
> @@ -77,18 +77,18 @@ static int count_interesting_parents(struct commit *commit)
>  	return count;
>  }
>  
> -static inline int halfway(struct commit_list *p, int nr)
> +static inline int halfway(struct commit *commit, int nr)
>  {
>  	/*
>  	 * Don't short-cut something we are not going to return!
>  	 */
> -	if (p->item->object.flags & TREESAME)
> +	if (commit->object.flags & TREESAME)
>  		return 0;
>  	/*
>  	 * 2 and 3 are halfway of 5.
>  	 * 3 is halfway of 6 but 2 and 4 are not.
>  	 */
> -	switch (2 * node_data(p->item)->weight - nr) {
> +	switch (2 * node_data(commit)->weight - nr) {
>  	case -1: case 0: case 1:
>  		return 1;
>  	default:
> @@ -280,10 +280,10 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  	for (p = list; p; p = p->next) {
>  		if (!(p->item->object.flags & UNINTERESTING)
>  		 && (node_data(p->item)->weight == -2)) {
> -			node_data(p->item)->weight = count_distance(p);
> +			node_data(p->item)->weight = count_distance(p->item);
>  
>  			/* Does it happen to be at exactly half-way? */
> -			if (!find_all && halfway(p, nr))
> +			if (!find_all && halfway(p->item, nr))
>  				return p;
>  			counted++;
>  		}
> @@ -321,7 +321,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			}
>  
>  			/* Does it happen to be at exactly half-way? */
> -			if (!find_all && halfway(p, nr))
> +			if (!find_all && halfway(p->item, nr))
>  				return p;
>  		}
>  	}
