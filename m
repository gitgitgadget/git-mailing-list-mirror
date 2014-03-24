From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/19] tree-diff: remove special-case diff-emitting code for empty-tree cases
Date: Mon, 24 Mar 2014 14:18:10 -0700
Message-ID: <xmqqior3pa7h.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<dad40b2cf785e5951c105cac936d86a7bc6db8a3.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:18:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCGC-0003tp-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbaCXVSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:18:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbaCXVSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:18:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BCB077A35;
	Mon, 24 Mar 2014 17:18:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OTXUDP7HvslJz06lBLxuRiRGdBQ=; b=haFvTV
	3zbnXYm3SvIXTY2XcNi0P5AgYYFPoRfmuZC41BZBAi2UHulbuGzsOSRwuPcHpKxu
	fIfvRnfSRqpW6Cjy2AfwwQmahhXJFeGiAm3qjC7UH682Y99sO6ot9LWVY9ePAI8X
	Pu1/iSRz7FI0igJob70OQyYDz2Ij7v/bmC5fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yh2VVeDRyzAmyX0zlTKRtc56AD5w0vN3
	ncoC0pzoaCP3K1m5yR6IDzG51OqnCzeJbzOUhePjrGIOnAdK8ot/hCUKsi4OwxVN
	B4ri/hbzXO9rrPveWa42B1vDLhhQBtPmSPW+eO1WD3UT0RvY8kFuOp2H8ld/WAXS
	mTWeL3iFNfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2266E77A34;
	Mon, 24 Mar 2014 17:18:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6858D77A31;
	Mon, 24 Mar 2014 17:18:13 -0400 (EDT)
In-Reply-To: <dad40b2cf785e5951c105cac936d86a7bc6db8a3.1393257006.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 24 Feb 2014 20:21:44 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CEEE9016-B399-11E3-B67A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244870>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> via teaching tree_entry_pathcmp() how to compare empty tree descriptors:

Drop this line, as you explain the "pretend empty compares bigger
than anything else" idea later anyway?  This early part of the
proposed log message made me hiccup while reading it.

> While walking trees, we iterate their entries from lowest to highest in
> sort order, so empty tree means all entries were already went over.
>
> If we artificially assign +infinity value to such tree "entry", it will
> go after all usual entries, and through the usual driver loop we will be
> taking the same actions, which were hand-coded for special cases, i.e.
>
>     t1 empty, t2 non-empty
>         pathcmp(+∞, t2) -> +1
>         show_path(/*t1=*/NULL, t2);     /* = t1 > t2 case in main loop */
>
>     t1 non-empty, t2-empty
>         pathcmp(t1, +∞) -> -1
>         show_path(t1, /*t2=*/NULL);     /* = t1 < t2 case in main loop */

Sounds good.  I would have phrased a bit differently, though:

    When we have T1 and T2, we return a sign that tells the caller
    to indicate the "earlier" one to be emitted, and by returning
    the sign that causes the non-empty side to be emitted, we will
    automatically cause the entries from the remaining side to be
    emitted, without attempting to touch the empty side at all.  We
    can teach tree_entry_pathcmp() to pretend that an empty tree has
    an element that sorts after anything else to achieve this.

without saying "infinity".

> Right now we never go to when compared tree descriptors are infinity,...

Sorry, but I cannot parse this.

> as
> this condition is checked in the loop beginning as finishing criteria,

What condition and which loop?  The loop that immediately surrounds
the callsite of tree_entry_pathcmp() is the infinite "for (;;) {" loop,
and after it prepares t1 and t2 by skipping paths outside pathspec,
we check if both are empty (i.e. we ran out).  Is that the condition
you are referring to?

> but will do in the future, when there will be several parents iterated
> simultaneously, and some pair of them would run to the end.
>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> ( re-posting without change )
>
>  tree-diff.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/tree-diff.c b/tree-diff.c
> index cf96ad7..2fd6d0e 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -12,12 +12,19 @@
>   *
>   * NOTE files and directories *always* compare differently, even when having
>   *      the same name - thanks to base_name_compare().
> + *
> + * NOTE empty (=invalid) descriptor(s) take part in comparison as +infty.

The basic idea is very sane.  It is a nice (and obvious---once you
are told about the trick) and clean restructuring of the code.

>   */
>  static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
>  {
>  	struct name_entry *e1, *e2;
>  	int cmp;
>  
> +	if (!t1->size)
> +		return t2->size ? +1 /* +∞ > c */  : 0 /* +∞ = +∞ */;
> +	else if (!t2->size)
> +		return -1;	/* c < +∞ */

Where do these "c" come from?  I somehow feel that these comments
are making it harder to understand what is going on.

>  	e1 = &t1->entry;
>  	e2 = &t2->entry;
>  	cmp = base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
> @@ -151,18 +158,8 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
>  			skip_uninteresting(t1, &base, opt);
>  			skip_uninteresting(t2, &base, opt);
>  		}
> -		if (!t1->size) {
> -			if (!t2->size)
> -				break;
> -			show_path(&base, opt, /*t1=*/NULL, t2);
> -			update_tree_entry(t2);
> -			continue;
> -		}
> -		if (!t2->size) {
> -			show_path(&base, opt, t1, /*t2=*/NULL);
> -			update_tree_entry(t1);
> -			continue;
> -		}
> +		if (!t1->size && !t2->size)
> +			break;
>  
>  		cmp = tree_entry_pathcmp(t1, t2);
