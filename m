From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: use true parents for diff even when rewriting
Date: Tue, 23 Jul 2013 12:55:39 -0700
Message-ID: <7vob9t6og4.fsf@alter.siamese.dyndns.org>
References: <20130722090854.GA22222@pengutronix.de>
	<a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 23 21:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1igX-0003D8-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 21:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933931Ab3GWTzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 15:55:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933829Ab3GWTzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 15:55:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C4AB335FB;
	Tue, 23 Jul 2013 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GDa4BrVkv92ADj2IiSmXl2OnLKA=; b=q8QXmY
	l9b9slxPPYLcZWde7r4kfY9N+BFU6Io50P9tZ3/FZhq2Ei/LiLh2lV7ISmFSgeWX
	ljTmIFP3NfE3P3Roczw3yv1pU7ohZN3S0lTAD4X8/txbnsOc2HNWGT5pi8Hf0/ZE
	X5R40lhsmMVfafrMLCXc5A/dyu7CTsvtWcfgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W6Qg1Ha8AAYN1jikUuDAiE6jFZzg9yMX
	ShbS6kuQmA3ltSw0ZXpVu7YFFi0hkr7s6MBkodGhb3yafiPOHUjifZMhr1TarfCe
	xbST90TxXBcIFy8zGY2VJLoNMqcx4+KVy+NR0soZVt6k4Se6DxCFx3iHFw2cGcOd
	rztGr5oUuTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3BDD335FA;
	Tue, 23 Jul 2013 19:55:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C9BC335F8;
	Tue, 23 Jul 2013 19:55:41 +0000 (UTC)
In-Reply-To: <a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Mon, 22 Jul 2013 23:22:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA884C2E-F3D1-11E2-9F96-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231055>

Thomas Rast <trast@inf.ethz.ch> writes:

> +define_commit_slab(saved_parents, struct commit_list *);
> +struct saved_parents saved_parents_slab;
> +static int saved_parents_initialized;
> +
> +void save_parents(struct commit *commit)
> +{
> +	struct commit_list **pp;
> +
> +	if (!saved_parents_initialized) {
> +		init_saved_parents(&saved_parents_slab);
> +		saved_parents_initialized = 1;
> +	}
> +
> +	pp = saved_parents_at(&saved_parents_slab, commit);
> +	assert(*pp == NULL);
> +	*pp = copy_commit_list(commit->parents);
> +}
> +
> +struct commit_list *get_saved_parents(struct commit *commit)

Use "const struct commit *" here, as combine-diff.c has a const pointer.

> +{
> +	if (!saved_parents_initialized)
> +		return commit->parents;
> +
> +	return *saved_parents_at(&saved_parents_slab, commit);
> +}

clear_commit_slab() is not used, failing -Wunused -Werror compilation.

> diff --git a/revision.h b/revision.h
> index 95859ba..0717518 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -273,4 +273,19 @@ enum rewrite_result {
>  
>  extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
>  	rewrite_parent_fn_t rewrite_parent);
> +
> +/*
> + * Save a copy of the parent list, and return the saved copy.  This is
> + * used by the log machinery to retrieve the original parents when
> + * commit->parents has been modified by history simpification.
> + *
> + * You may only call save_parents() once per commit (this is checked
> + * for non-root commits).
> + *
> + * get_original_parents() will transparently return commit->parents if
> + * history simplification is off.
> + */
> +extern void save_parents(struct commit *commit);
> +extern struct commit_list *get_original_parents(struct commit *commit);
> +

s/_original/_saved/ here, and "const struct commit *".

By the way, when the only single parameter is a named type, you can
safely omit the name of the parameter from the declaration without
losing clarity.

>  #endif
> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> index 57ce239..fde5e71 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -127,4 +127,10 @@ test_expect_success 'full history simplification without parent' '
>  	}
>  '
>  
> +test_expect_success '--full-diff is not affected by --parents' '
> +	git log -p --pretty="%H" --full-diff -- file >expected &&
> +	git log -p --pretty="%H" --full-diff --parents -- file >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
