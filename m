From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 5/5] Implement line-history search (git log -L)
Date: Thu, 07 Jun 2012 10:42:47 -0700
Message-ID: <7vhaunhvc8.fsf@alter.siamese.dyndns.org>
References: <cover.1339063659.git.trast@student.ethz.ch>
 <61a797a048c43d64352ef86a1b224f017e7161ae.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:43:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScgkI-0003dT-91
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547Ab2FGRnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:43:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755020Ab2FGRmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:42:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE0E8F22;
	Thu,  7 Jun 2012 13:42:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j9NtkQ7deE4tMNxCnYASpf2IuIw=; b=NZDqhw
	If18ifeNqqGn+pHu12C0cE1vmeiTaKgfy4vlolmHLAnl1YWCS9lU+uiaWDq/Am/H
	ZV7ZUWUbYMfWOCV8ISQn/R+4+rQTys+HxxoJx88jlfvV1Z3ggOX2EX5Oh5s66LXI
	7B8vm1rAdLqtTuKX98tb5+DS/uErYzMiLJ1Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orFpO6tF7iD77wUpjABt8Qi5DpJskGeZ
	XNNKotWf5ojup8p3QlPpbvbQD/a1bYRiSrBilJg3YL9tFKxFI4WgXpsOwBdp07Y7
	4yrhPGxOrZb3AW05BzES6ACAMNUYlkf6mFBXm4u7eNvutABkfrPLAri7UU66fsTB
	dMn+tnHrdGo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B8D8F21;
	Thu,  7 Jun 2012 13:42:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB9828F1D; Thu,  7 Jun 2012
 13:42:48 -0400 (EDT)
In-Reply-To: <61a797a048c43d64352ef86a1b224f017e7161ae.1339063659.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 7 Jun 2012 12:23:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32BE3BC2-B0C8-11E1-95D1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199424>

Thomas Rast <trast@student.ethz.ch> writes:

> This is a rewrite of much of Bo's work, mainly in an effort to split
> it into smaller, easier to understand routines.

You mentioned "splitting" in the cover letter, but it does seem to
need a bit more work.

> diff --git a/builtin/log.c b/builtin/log.c
> index 906dca4..4a0d5da 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -38,6 +39,12 @@
> ...
> +static int log_line_range_callback(const struct option *option, const char *arg, int unset)
> +{
> +	struct line_opt_callback_data *data = option->value;
> +	struct line_log_data *r;
> +	const char *name_start, *range_arg, *full_path;
> ...
> +	ALLOC_GROW(r->args, r->arg_nr+1, r->arg_alloc);
> +	r->args[r->arg_nr++] = range_arg;

Assignment discards qualifiers from pointer target type; this
pointer does not have to be "const char *" perhaps?

> @@ -94,15 +135,23 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  {
>  	struct userformat_want w;
>  	int quiet = 0, source = 0;
> +	static struct line_opt_callback_data line_cb = {0};
> +	static int full_line_diff;

Variable unused.

> diff --git a/line.c b/line.c
> index a7f33ed..d837bb3 100644
> --- a/line.c
> +++ b/line.c
> @@ -1,6 +1,459 @@
> ...
> +static void diff_ranges_release (struct diff_ranges *diff)
> +{
> +	range_set_release(&diff->parent);
> +	range_set_release(&diff->target);
> +}

Unused.

> +static struct line_log_data *
> +search_line_log_data(struct line_log_data *list, const char *path)
> +{
> +	return search_line_log_data_1(list, path, NULL);
> +}

Unused.

> +static void line_log_data_sort (struct line_log_data *list)
> +{
> +	struct line_log_data *p = list;
> +	while (p) {
> +		sort_and_merge_range_set(&p->ranges);
> +		p = p->next;
> +	}
> +}

Unused.

> +static int ranges_overlap (struct range *a, struct range *b)
> +{
> +	return !(a->end <= b->start || b->end <= a->start);
> +}
> +
> +/*
> + * Given a diff and the set of interesting ranges, determine all hunks
> + * of the diff which touch (overlap) at least one of the interesting
> + * ranges in the target.
> + */
> +static void diff_ranges_filter_touched (struct diff_ranges *out,
> +					struct diff_ranges *diff,
> +					struct range_set *rs)
> +{
> +	int i, j = 0;
> +
> +	assert(out->target.nr == 0);
> +
> +	for (i = 0; i < diff->target.nr; i++) {
> +		while (diff->target.ranges[i].start > rs->ranges[j].end) {
> +			j++;
> +			if (j == rs->nr)
> +				return;
> +		}
> +		if (ranges_overlap(&diff->target.ranges[i], &rs->ranges[j])) {
> +			range_set_append(&out->parent,
> +					 diff->parent.ranges[i].start,
> +					 diff->parent.ranges[i].end);
> +			range_set_append(&out->target,
> +					 diff->target.ranges[i].start,
> +					 diff->target.ranges[i].end);
> +		}
> +	}
> +}

Shouldn't the ranges be merged, not just appended?

> diff --git a/log-tree.c b/log-tree.c
> index c894930..3fb025d 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -809,6 +809,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  	log.parent = NULL;
>  	opt->loginfo = &log;
>  
> +	if (opt->line_level_traverse)
> +		return line_log_print(opt, commit);
> +

#include "line.h" is missing from the beginning of this file.

> diff --git a/revision.h b/revision.h
> index 6d09550..01902cf 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -92,7 +92,8 @@ struct rev_info {
>  			cherry_mark:1,
>  			bisect:1,
>  			ancestry_path:1,
> -			first_parent_only:1;
> +			first_parent_only:1,
> +			line_level_traverse:1;
>  
>  	/* Diff flags */
>  	unsigned int	diff:1,
> @@ -168,6 +169,9 @@ struct rev_info {
>  	int count_left;
>  	int count_right;
>  	int count_same;
> +
> +	/* line level range that we are chasing */
> +	struct decoration line_log_data;

Good use of decoration.

>  };
>  
>  #define REV_TREE_SAME		0
