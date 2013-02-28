From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/5] Implement line-history search (git log -L)
Date: Thu, 28 Feb 2013 09:51:38 -0800
Message-ID: <7vbob4iaxh.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB7eU-0003ia-47
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 18:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759866Ab3B1Rvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 12:51:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759855Ab3B1Rvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 12:51:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F37DBB94;
	Thu, 28 Feb 2013 12:51:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HiyJmUs08U+huQW6Q57s6ME0z4E=; b=tZ/YyP
	rXuRJxVTscw8ShNP6js04kcfyr+ZlhU9Q37nJf6wo1IMVosjJTcVfGIfk73dCK+B
	Oq7JA5FyZoGpd9oAKqqw5u0o1eB2qbHxVEC/fadCzDf6VVGQVG16jE9qGcraKRPx
	TXxl3023tydbOUi9llF4NM2eZkBHDnjYuWBMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JsSMOsLPER+E8fxKIJZ0dFFfcO+p9lZ2
	lmMrBdsOivkxzMYLqtyy5HTe+D9DQTvkSUxG1Kbo4eep7Ptjg0W2bSwJLyYwPIkK
	b4UdzrxXwIC1xRgnC12oCRhuEHYR3ZAS2/P7q2oGg+i3IvXlXl0liqmy+0FY8eKP
	VvRugXTUhDc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32AB8BB93;
	Thu, 28 Feb 2013 12:51:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3F64BB85; Thu, 28 Feb 2013
 12:51:39 -0500 (EST)
In-Reply-To: <9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 28 Feb 2013 17:38:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8110B6DC-81CF-11E2-8AFA-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217246>

Thomas Rast <trast@student.ethz.ch> writes:

> @@ -138,6 +155,11 @@ Examples
>  	This makes sense only when following a strict policy of merging all
>  	topic branches when staying on a single integration branch.
>  
> +git log -L '/int main/',/^}/:main.c::
> +
> +	Shows how the function `main()` in the file 'main.c' evolved
> +	over time.

Perhaps have "^" before that "int"?

> diff --git a/line-log.c b/line-log.c
> index b167b00..789b7c4 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1,6 +1,442 @@
>  #include "git-compat-util.h"
> +#include "cache.h"
> +#include "tag.h"
> +#include "blob.h"
> +#include "tree.h"
> +#include "diff.h"
> +#include "commit.h"
> +#include "decorate.h"
> +#include "revision.h"
> +#include "xdiff-interface.h"
> +#include "strbuf.h"
> +#include "log-tree.h"
> +#include "graph.h"
>  #include "line-log.h"
>  
> +void range_set_grow (struct range_set *rs, size_t extra)

Lose the extra SP (everywhere in this file).

> +{
> +	ALLOC_GROW(rs->ranges, rs->nr + extra, rs->alloc);
> +}
> +
> +/* Either initialization would be fine */
> +#define RANGE_SET_INIT {0}
> +
> +void range_set_init (struct range_set *rs, size_t prealloc)
> +{
> +	rs->alloc = rs->nr = 0;
> +	rs->ranges = NULL;
> +	if (prealloc)
> +		range_set_grow(rs, prealloc);
> +}
> +
> +void range_set_release (struct range_set *rs)
> +{
> +	free(rs->ranges);
> +	rs->alloc = rs->nr = 0;
> +	rs->ranges = NULL;
> +}
> +
> +/* dst must be uninitialized! */
> +void range_set_copy (struct range_set *dst, struct range_set *src)
> +{
> +	range_set_init(dst, src->nr);
> +	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range_set));
> +	dst->nr = src->nr;
> +}
> +void range_set_move (struct range_set *dst, struct range_set *src)
> +{
> +	range_set_release(dst);
> +	dst->ranges = src->ranges;
> +	dst->nr = src->nr;
> +	dst->alloc = src->alloc;
> +	src->ranges = NULL;
> +	src->alloc = src->nr = 0;
> +}
> +
> +/* tack on a _new_ range _at the end_ */
> +void range_set_append (struct range_set *rs, long a, long b)
> +{
> +	assert(a <= b);
> +	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
> +	range_set_grow(rs, 1);
> +	rs->ranges[rs->nr].start = a;
> +	rs->ranges[rs->nr].end = b;
> +	rs->nr++;
> +}
> +
> +static int range_cmp (const void *_r, const void *_s)
> +{
> +	const struct range *r = _r;
> +	const struct range *s = _s;
> +
> +	/* this could be simply 'return r.start-s.start', but for the types */
> +	if (r->start == s->start)
> +		return 0;
> +	if (r->start < s->start)
> +		return -1;
> +	return 1;
> +}
> +
> +/*
> + * Helper: In-place pass of sorting and merging the ranges in the
> + * range set, to re-establish the invariants after another operation
> + *
> + * NEEDSWORK currently not needed
> + */
> +static void sort_and_merge_range_set (struct range_set *rs)
> +{
> +	int i;
> +	int o = 1; /* output cursor */
> +
> +	qsort(rs->ranges, rs->nr, sizeof(struct range), range_cmp);
> +
> +	for (i = 1; i < rs->nr; i++) {
> +		if (rs->ranges[i].start <= rs->ranges[o-1].end) {
> +			rs->ranges[o-1].end = rs->ranges[i].end;
> +		} else {
> +			rs->ranges[o].start = rs->ranges[i].start;
> +			rs->ranges[o].end = rs->ranges[i].end;
> +			o++;
> +		}
> +	}
> +	assert(o <= rs->nr);
> +	rs->nr = o;
> +}
> +
> +/*
> + * Union of range sets (i.e., sets of line numbers).  Used to merge
> + * them when searches meet at a common ancestor.
> + *
> + * This is also where the ranges are consolidated into canonical form:
> + * overlapping and adjacent ranges are merged, and empty ranges are
> + * removed.
> + */
> +static void range_set_union (struct range_set *out,
> +			     struct range_set *a, struct range_set *b)
> +{
> +	int i = 0, j = 0, o = 0;
> +	struct range *ra = a->ranges;
> +	struct range *rb = b->ranges;
> +	/* cannot make an alias of out->ranges: it may change during grow */
> +
> +	assert(out->nr == 0);
> +	while (i < a->nr || j < b->nr) {
> +		struct range *new;
> +		if (i < a->nr && j < b->nr) {
> +			if (ra[i].start < rb[j].start)
> +				new = &ra[i++];
> +			else if (ra[i].start > rb[j].start)
> +				new = &rb[j++];
> +			else if (ra[i].end < rb[j].end)
> +				new = &ra[i++];
> +			else
> +				new = &rb[j++];
> +		} else if (i < a->nr)      /* b exhausted */
> +			new = &ra[i++];
> +		else                       /* a exhausted */
> +			new = &rb[j++];
> +		if (new->start == new->end)
> +			; /* empty range */
> +		else if (!o || out->ranges[o-1].end < new->start) {
> +			range_set_grow(out, 1);
> +			out->ranges[o].start = new->start;
> +			out->ranges[o].end = new->end;
> +			o++;
> +		} else if (out->ranges[o-1].end < new->end) {
> +			out->ranges[o-1].end = new->end;
> +		}
> +	}
> +	out->nr = o;
> +}
> +
> +/*
> + * Difference of range sets (out = a \ b).  Pass the "interesting"
> + * ranges as 'a' and the target side of the diff as 'b': it removes
> + * the ranges for which the commit is responsible.
> + */
> +static void range_set_difference (struct range_set *out,
> +				  struct range_set *a, struct range_set *b)
> +{
> +	int i, j =  0;
> +	for (i = 0; i < a->nr; i++) {
> +		long start = a->ranges[i].start;
> +		long end = a->ranges[i].end;
> +		while (start < end) {
> +			while (j < b->nr && start >= b->ranges[j].end)
> +				/*
> +				 * a:         |-------
> +				 * b: ------|
> +				 */
> +				j++;
> +			if (j >= b->nr || end < b->ranges[j].start) {
> +				/*
> +				 * b exhausted, or
> +				 * a:  ----|
> +				 * b:         |----
> +				 */
> +				range_set_append(out, start, end);
> +				break;
> +			}
> +			if (start >= b->ranges[j].start) {
> +				/*
> +				 * a:     |--????
> +				 * b: |------|
> +				 */
> +				start = b->ranges[j].end;
> +			} else if (end > b->ranges[j].start) {
> +				/*
> +				 * a: |-----|
> +				 * b:    |--?????
> +				 */
> +				if (start < b->ranges[j].start)
> +					range_set_append(out, start, b->ranges[j].start);
> +				start = b->ranges[j].end;
> +			}
> +		}
> +	}
> +}
> +
> +static void diff_ranges_init (struct diff_ranges *diff)
> +{
> +	range_set_init(&diff->parent, 0);
> +	range_set_init(&diff->target, 0);
> +}
> +
> +static void diff_ranges_release (struct diff_ranges *diff)
> +{
> +	range_set_release(&diff->parent);
> +	range_set_release(&diff->target);
> +}
> +
> +void line_log_data_init(struct line_log_data *r)
> +{
> +	memset(r, 0, sizeof(struct line_log_data));
> +	range_set_init(&r->ranges, 0);
> +}
> +
> +static void line_log_data_clear(struct line_log_data *r)
> +{
> +	range_set_release(&r->ranges);
> +	if (r->pair)
> +		diff_free_filepair(r->pair);
> +}
> +
> +static void free_line_log_data(struct line_log_data *r)
> +{
> +	while (r) {
> +		struct line_log_data *next = r->next;
> +		line_log_data_clear(r);
> +		free(r);
> +		r = next;
> +	}
> +}
> +
> +static struct line_log_data *
> +search_line_log_data(struct line_log_data *list, const char *path,
> +		     struct line_log_data **insertion_point)
> +{
> +	struct line_log_data *p = list;
> +	if (insertion_point)
> +		*insertion_point = NULL;
> +	while (p) {
> +		int cmp = strcmp(p->spec->path, path);
> +		if (!cmp)
> +			return p;
> +		if (insertion_point && cmp < 0)
> +			*insertion_point = p;
> +		p = p->next;
> +	}
> +	return NULL;
> +}
> +
> +static void line_log_data_insert (struct line_log_data **list,
> +				  struct diff_filespec *spec,
> +				  long begin, long end)
> +{
> +	struct line_log_data *ip;
> +	struct line_log_data *p = search_line_log_data(*list, spec->path, &ip);
> +
> +	if (p) {
> +		range_set_append(&p->ranges, begin, end);
> +		sort_and_merge_range_set(&p->ranges);
> +		free_filespec(spec);
> +		return;
> +	}
> +
> +	p = xcalloc(1, sizeof(struct line_log_data));
> +	p->spec = spec;
> +	range_set_append(&p->ranges, begin, end);
> +	if (ip) {
> +		p->next = ip->next;
> +		ip->next = p;
> +	} else {
> +		p->next = *list;
> +		*list = p;
> +	}
> +}
> +
> +struct collect_diff_cbdata {
> +	struct diff_ranges *diff;
> +};
> +
> +static int collect_diff_cb (long start_a, long count_a,
> +			    long start_b, long count_b,
> +			    void *data)
> +{
> +	struct collect_diff_cbdata *d = data;
> +
> +	if (count_a >= 0)
> +		range_set_append(&d->diff->parent, start_a, start_a + count_a);
> +	if (count_b >= 0)
> +		range_set_append(&d->diff->target, start_b, start_b + count_b);
> +
> +	return 0;
> +}
> +
> +static void collect_diff (mmfile_t *parent, mmfile_t *target, struct diff_ranges *out)
> +{
> +	struct collect_diff_cbdata cbdata = {0};
> +	xpparam_t xpp;
> +	xdemitconf_t xecfg;
> +	xdemitcb_t ecb;
> +
> +	memset(&xpp, 0, sizeof(xpp));
> +	memset(&xecfg, 0, sizeof(xecfg));
> +	xecfg.ctxlen = xecfg.interhunkctxlen = 0;
> +
> +	cbdata.diff = out;
> +	xecfg.hunk_func = collect_diff_cb;
> +	memset(&ecb, 0, sizeof(ecb));
> +	ecb.priv = &cbdata;
> +	xdi_diff(parent, target, &xpp, &xecfg, &ecb);
> +}
> +
> +/*
> + * These are handy for debugging.  Removing them with #if 0 silences
> + * the "unused function" warning.
> + */
> +#if 0
> +static void dump_range_set (struct range_set *rs, const char *desc)
> +{
> +	int i;
> +	printf("range set %s (%d items):\n", desc, rs->nr);
> +	for (i = 0; i < rs->nr; i++)
> +		printf("\t[%ld,%ld]\n", rs->ranges[i].start, rs->ranges[i].end);
> +}
> +
> +static void dump_line_log_data (struct line_log_data *r)
> +{
> +	char buf[4096];
> +	while (r) {
> +		snprintf(buf, 4096, "file %s\n", r->spec->path);
> +		dump_range_set(&r->ranges, buf);
> +		r = r->next;
> +	}
> +}
> +
> +static void dump_diff_ranges (struct diff_ranges *diff, const char *desc)
> +{
> +	int i;
> +	assert(diff->parent.nr == diff->target.nr);
> +	printf("diff ranges %s (%d items):\n", desc, diff->parent.nr);
> +	printf("\tparent\ttarget\n");
> +	for (i = 0; i < diff->parent.nr; i++) {
> +		printf("\t[%ld,%ld]\t[%ld,%ld]\n",
> +		       diff->parent.ranges[i].start,
> +		       diff->parent.ranges[i].end,
> +		       diff->target.ranges[i].start,
> +		       diff->target.ranges[i].end);
> +	}
> +}
> +#endif
> +
> +
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
> +
> +/*
> + * Adjust the line counts in 'rs' to account for the lines
> + * added/removed in the diff.
> + */
> +static void range_set_shift_diff (struct range_set *out,
> +				  struct range_set *rs,
> +				  struct diff_ranges *diff)
> +{
> +	int i, j = 0;
> +	long offset = 0;
> +	struct range *src = rs->ranges;
> +	struct range *target = diff->target.ranges;
> +	struct range *parent = diff->parent.ranges;
> +
> +	for (i = 0; i < rs->nr; i++) {
> +		while (j < diff->target.nr && src[i].start >= target[j].start) {
> +			offset += (parent[j].end-parent[j].start)
> +				- (target[j].end-target[j].start);
> +			j++;
> +		}
> +		range_set_append(out, src[i].start+offset, src[i].end+offset);
> +	}
> +}
> +
> +/*
> + * Given a diff and the set of interesting ranges, map the ranges
> + * across the diff.  That is: observe that the target commit takes
> + * blame for all the + (target-side) ranges.  So for every pair of
> + * ranges in the diff that was touched, we remove the latter and add
> + * its parent side.
> + */
> +static void range_set_map_across_diff (struct range_set *out,
> +				       struct range_set *rs,
> +				       struct diff_ranges *diff,
> +				       struct diff_ranges **touched_out)
> +{
> +	struct diff_ranges *touched = xmalloc(sizeof(*touched));
> +	struct range_set tmp1 = RANGE_SET_INIT;
> +	struct range_set tmp2 = RANGE_SET_INIT;
> +
> +	diff_ranges_init(touched);
> +	diff_ranges_filter_touched(touched, diff, rs);
> +	range_set_difference(&tmp1, rs, &touched->target);
> +	range_set_shift_diff(&tmp2, &tmp1, diff);
> +	range_set_union(out, &tmp2, &touched->parent);
> +	range_set_release(&tmp1);
> +	range_set_release(&tmp2);
> +
> +	*touched_out = touched;
> +}
> +
>  /*
>   * Parse one item in the -L option
>   */
> @@ -18,7 +454,8 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>  	 * $ is a synonym for "the end of the file".
>  	 */
>  	if (spec[0] == '$') {
> -		*ret = lines;
> +		if (ret)
> +			*ret = lines;
>  		return spec + 1;
>  	}

This should have been part of the earlier patches, no?

> @@ -30,6 +467,8 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>  	if (begin != -1 && (spec[0] == '+' || spec[0] == '-')) {
>  		num = strtol(spec + 1, &term, 10);
>  		if (term != spec + 1) {
> +			if (!ret)
> +				return term;
>  			if (spec[0] == '-')
>  				num = 0 - num;
>  			if (0 < num)
> @@ -44,7 +483,8 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>  	}
>  	num = strtol(spec, &term, 10);
>  	if (term != spec) {
> -		*ret = num;
> +		if (ret)
> +			*ret = num;
>  		return term;
>  	}
>  	if (spec[0] != '/')
> @@ -58,6 +498,10 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>  	if (*term != '/')
>  		return spec;
>  
> +	/* in the scan-only case we are not interested in the regex */
> +	if (!ret)
> +		return term+1;
> +
>  	/* try [spec+1 .. term-1] as regexp */
>  	*term = 0;
>  	if (begin == -1)
> @@ -101,13 +545,763 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
>  		}
>  	}
>  
> -	if (*begin <= 0)
> -		*begin = 1;
> -	if (*end > lines)
> -		*end = lines;
> -
>  	if (*arg)
>  		return -1;
>  
>  	return 0;
>  }
> +
> +const char *skip_range_arg(const char *arg)
> +{
> +	arg = parse_loc(arg, NULL, NULL, 0, -1, 0);
> +
> +	if (*arg == ',')
> +		arg = parse_loc(arg+1, NULL, NULL, 0, 0, 0);
> +
> +	return arg;
> +}
> +
> +static struct commit *check_single_commit(struct rev_info *revs)
> +{
> +	struct object *commit = NULL;
> +	int found = -1;
> +	int i;
> +
> +	for (i = 0; i < revs->pending.nr; i++) {
> +		struct object *obj = revs->pending.objects[i].item;
> +		if (obj->flags & UNINTERESTING)
> +			continue;
> +		while (obj->type == OBJ_TAG)
> +			obj = deref_tag(obj, NULL, 0);
> +		if (obj->type != OBJ_COMMIT)
> +			die("Non commit %s?", revs->pending.objects[i].name);
> +		if (commit)
> +			die("More than one commit to dig from: %s and %s?",
> +			    revs->pending.objects[i].name,
> +			    revs->pending.objects[found].name);
> +		commit = obj;
> +		found = i;
> +	}
> +
> +	if (!commit)
> +		die("No commit specified?");
> +
> +	return (struct commit *) commit;
> +}
> +
> +static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
> +{
> +	unsigned mode;
> +	unsigned char sha1[20];
> +
> +	if (get_tree_entry(commit->object.sha1, spec->path,
> +			   sha1, &mode))
> +		die("There is no path %s in the commit", spec->path);
> +	fill_filespec(spec, sha1, 1, mode);
> +
> +	return;
> +}
> +
> +static void fill_line_ends(struct diff_filespec *spec, long *lines,
> +	unsigned long **line_ends)
> +{
> +	int num = 0, size = 50;
> +	long cur = 0;
> +	unsigned long *ends = NULL;
> +	char *data = NULL;
> +
> +	if (diff_populate_filespec(spec, 0))
> +		die("Cannot read blob %s", sha1_to_hex(spec->sha1));
> +
> +	ends = xmalloc(size * sizeof(*ends));
> +	ends[cur++] = 0;
> +	data = spec->data;
> +	while (num < spec->size) {
> +		if (data[num] == '\n' || num == spec->size - 1) {
> +			ALLOC_GROW(ends, (cur + 1), size);
> +			ends[cur++] = num;
> +		}
> +		num++;
> +	}
> +
> +	/* shrink the array to fit the elements */
> +	ends = xrealloc(ends, cur * sizeof(*ends));
> +	*lines = cur-1;
> +	*line_ends = ends;
> +}
> +
> +struct nth_line_cb {
> +	struct diff_filespec *spec;
> +	long lines;
> +	unsigned long *line_ends;
> +};
> +
> +static const char *nth_line(void *data, long line)
> +{
> +	struct nth_line_cb *d = data;
> +	assert(d && line <= d->lines);
> +	assert(d->spec && d->spec->data);
> +
> +	if (line == 0)
> +		return (char *)d->spec->data;
> +	else
> +		return (char *)d->spec->data + d->line_ends[line] + 1;
> +}
> +
> +static struct line_log_data *
> +parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
> +{
> +	long lines = 0;
> +	unsigned long *ends = NULL;
> +	struct nth_line_cb cb_data;
> +	struct string_list_item *item;
> +	struct line_log_data *ranges = NULL;
> +
> +	for_each_string_list_item(item, args) {
> +		const char *name_part, *range_part;
> +		const char *full_name;
> +		struct diff_filespec *spec;
> +		long begin = 0, end = 0;
> +
> +		name_part = skip_range_arg(item->string);
> +		if (!name_part || *name_part != ':')
> +			die("-L argument '%s' not of the form start,end:file",
> +			    item->string);
> +		range_part = xstrndup(item->string, name_part - item->string);
> +		name_part++;
> +
> +		full_name = prefix_path(prefix, prefix ? strlen(prefix) : 0,
> +					name_part);
> +
> +		spec = alloc_filespec(full_name);
> +		fill_blob_sha1(commit, spec);
> +		fill_line_ends(spec, &lines, &ends);
> +		cb_data.spec = spec;
> +		cb_data.lines = lines;
> +		cb_data.line_ends = ends;
> +
> +		if (parse_range_arg(range_part, nth_line, &cb_data,
> +				    lines, &begin, &end))
> +			die("malformed -L argument '%s'", range_part);
> +		if (begin < 1)
> +			begin = 1;
> +		if (end < 1)
> +			end = lines;
> +		begin--;
> +		if (lines < end || lines < begin)
> +			die("file %s has only %ld lines", name_part, lines);
> +		line_log_data_insert(&ranges, spec, begin, end);
> +
> +		free(ends);
> +		ends = NULL;
> +	}
> +
> +	return ranges;
> +}
> +
> +static struct line_log_data *line_log_data_copy_one(struct line_log_data *r)
> +{
> +	struct line_log_data *ret = xmalloc(sizeof(*ret));
> +
> +	assert(r);
> +	line_log_data_init(ret);
> +	range_set_copy(&ret->ranges, &r->ranges);
> +
> +	ret->spec = r->spec;
> +	assert(ret->spec);
> +	ret->spec->count++;
> +
> +	return ret;
> +}
> +
> +static struct line_log_data *
> +line_log_data_copy(struct line_log_data *r)
> +{
> +	struct line_log_data *ret = NULL;
> +	struct line_log_data *tmp = NULL, *prev = NULL;
> +
> +	assert(r);
> +	ret = tmp = prev = line_log_data_copy_one(r);
> +	r = r->next;
> +	while (r) {
> +		tmp = line_log_data_copy_one(r);
> +		prev->next = tmp;
> +		prev = tmp;
> +		r = r->next;
> +	}
> +
> +	return ret;
> +}
> +
> +/* merge two range sets across files */
> +static struct line_log_data *line_log_data_merge(struct line_log_data *a,
> +		struct line_log_data *b)
> +{
> +	struct line_log_data *head = NULL, **pp = &head;
> +
> +	while (a || b) {
> +		struct line_log_data *src;
> +		struct line_log_data *src2 = NULL;
> +		struct line_log_data *d;
> +		int cmp;
> +		if (!a)
> +			cmp = 1;
> +		else if (!b)
> +			cmp = -1;
> +		else
> +			cmp = strcmp(a->spec->path, b->spec->path);
> +		if (cmp < 0) {
> +			src = a;
> +			a = a->next;
> +		} else if (cmp == 0) {
> +			src = a;
> +			a = a->next;
> +			src2 = b;
> +			b = b->next;
> +		} else {
> +			src = b;
> +			b = b->next;
> +		}
> +		d = xmalloc(sizeof(struct line_log_data));
> +		line_log_data_init(d);
> +		d->spec = src->spec;
> +		d->spec->count++;
> +		*pp = d;
> +		pp = &d->next;
> +		if (src2)
> +			range_set_union(&d->ranges, &src->ranges, &src2->ranges);
> +		else
> +			range_set_copy(&d->ranges, &src->ranges);
> +	}
> +
> +	return head;
> +}
> +
> +static void add_line_range(struct rev_info *revs, struct commit *commit,
> +		struct line_log_data *range)
> +{
> +	struct line_log_data *old = NULL;
> +	struct line_log_data *new = NULL;
> +
> +	old = lookup_decoration(&revs->line_log_data, &commit->object);
> +	if (old && range) {
> +		new = line_log_data_merge(old, range);
> +		free_line_log_data(old);
> +	} else if (range)
> +		new = line_log_data_copy(range);
> +
> +	if (new)
> +		add_decoration(&revs->line_log_data, &commit->object, new);
> +}
> +
> +static void clear_commit_line_range(struct rev_info *revs, struct commit *commit)
> +{
> +	struct line_log_data *r;
> +	r = lookup_decoration(&revs->line_log_data, &commit->object);
> +	if (!r)
> +		return;
> +	free_line_log_data(r);
> +	add_decoration(&revs->line_log_data, &commit->object, NULL);
> +}
> +
> +static struct line_log_data *lookup_line_range(struct rev_info *revs,
> +		struct commit *commit)
> +{
> +	struct line_log_data *ret = NULL;
> +
> +	ret = lookup_decoration(&revs->line_log_data, &commit->object);
> +	return ret;
> +}
> +
> +void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args)
> +{
> +	struct commit *commit = NULL;
> +	struct line_log_data *range;
> +
> +	commit = check_single_commit(rev);
> +	range = parse_lines(commit, prefix, args);
> +	add_line_range(rev, commit, range);
> +
> +	if (!rev->diffopt.detect_rename) {
> +		int i, count = 0;
> +		struct line_log_data *r = range;
> +		const char **paths;
> +		while (r) {
> +			count++;
> +			r = r->next;
> +		}
> +		paths = xmalloc((count+1)*sizeof(char *));
> +		r = range;
> +		for (i = 0; i < count; i++) {
> +			paths[i] = xstrdup(r->spec->path);
> +			r = r->next;
> +		}
> +		paths[count] = NULL;
> +		init_pathspec(&rev->diffopt.pathspec, paths);
> +		free(paths);
> +	}
> +}
> +
> +static void load_tree_desc(struct tree_desc *desc, void **tree,
> +		const unsigned char *sha1)
> +{
> +	unsigned long size;
> +	*tree = read_object_with_reference(sha1, tree_type, &size, NULL);
> +	if (!tree)
> +		die("Unable to read tree (%s)", sha1_to_hex(sha1));
> +	init_tree_desc(desc, *tree, size);
> +}
> +
> +static int count_parents(struct commit *commit)
> +{
> +	struct commit_list *parents = commit->parents;
> +	int count = 0;
> +	while (parents) {
> +		count++;
> +		parents = parents->next;
> +	}
> +	return count;
> +}
> +
> +static void move_diff_queue(struct diff_queue_struct *dst,
> +			    struct diff_queue_struct *src)
> +{
> +	assert(src != dst);
> +	memcpy(dst, src, sizeof(struct diff_queue_struct));
> +	DIFF_QUEUE_CLEAR(src);
> +}
> +
> +static void queue_diffs(struct diff_options *opt,
> +			struct diff_queue_struct *queue,
> +			struct commit *commit, struct commit *parent)
> +{
> +	void *tree1 = NULL, *tree2 = NULL;
> +	struct tree_desc desc1, desc2;
> +
> +	assert(commit);
> +	load_tree_desc(&desc2, &tree2, commit->tree->object.sha1);
> +	if (parent)
> +		load_tree_desc(&desc1, &tree1, parent->tree->object.sha1);
> +	else
> +		init_tree_desc(&desc1, "", 0);
> +
> +	DIFF_QUEUE_CLEAR(&diff_queued_diff);
> +	diff_tree(&desc1, &desc2, "", opt);
> +	diffcore_std(opt);
> +	move_diff_queue(queue, &diff_queued_diff);
> +
> +	if (tree1)
> +		free(tree1);
> +	if (tree2)
> +		free(tree2);
> +}
> +
> +static char *get_nth_line(long line, unsigned long *ends, void *data)
> +{
> +	if (line == 0)
> +		return (char *)data;
> +	else
> +		return (char *)data + ends[line] + 1;
> +}
> +
> +static void print_line(const char *prefix, char first,
> +		       long line, unsigned long *ends, void *data,
> +		       const char *color, const char *reset)
> +{
> +	char *begin = get_nth_line(line, ends, data);
> +	char *end = get_nth_line(line+1, ends, data);
> +	int had_nl = 0;
> +
> +	if (end > begin && end[-1] == '\n') {
> +		end--;
> +		had_nl = 1;
> +	}
> +
> +	fputs(prefix, stdout);
> +	fputs(color, stdout);
> +	putchar(first);
> +	fwrite(begin, 1, end-begin, stdout);
> +	fputs(reset, stdout);
> +	putchar('\n');
> +	if (!had_nl)
> +		fputs("\\ No newline at end of file\n", stdout);
> +}
> +
> +static char *output_prefix(struct diff_options *opt)
> +{
> +	char *prefix = "";
> +
> +	if (opt->output_prefix) {
> +		struct strbuf *sb = opt->output_prefix(opt, opt->output_prefix_data);
> +		prefix = sb->buf;
> +	}
> +
> +	return prefix;
> +}
> +
> +static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
> +{
> +...

Yuck.

> +/*
> + * NEEDSWORK: manually building a diff here is not the Right
> + * Thing(tm).  log -L should be built into the diff pipeline.

I am not sure about this design, and do not necessarily agree that
wedging this to the diff pipeline is the right future direction.

I have a feeling that "log -L" should actually be built around
"blame".  You let blame to hit the first parent to take the blame,
and then turn around to show a single "diff-tree" between the child
and the parent with whatever other diff pipeline gizmo the user can
give you from the command line.  The blame also tells you what the
"interesting" line range were at the first parent commit you found,
so you can re-run the same thing with an updated range.

> +/*
> + * Unlike most other functions, this destructively operates on
> + * 'range'.
> + */
> +static int process_diff_filepair(struct rev_info *rev,
> +				 struct diff_filepair *pair,
> +				 struct line_log_data *range,
> +				 struct diff_ranges **diff_out)
> +{
> +	struct line_log_data *rg = range;
> +	struct range_set tmp;
> +	struct diff_ranges diff;
> +	mmfile_t file_parent, file_target;
> +
> +	assert(pair->two->path);
> +	while (rg) {
> +		assert(rg->spec->path);
> +		if (!strcmp(rg->spec->path, pair->two->path))
> +			break;
> +		rg = rg->next;
> +	}
> +
> +	if (!rg)
> +		return 0;
> +	if (rg->ranges.nr == 0)
> +		return 0;
> +
> +	assert(pair->two->sha1_valid);
> +	diff_populate_filespec(pair->two, 0);
> +	file_target.ptr = pair->two->data;
> +	file_target.size = pair->two->size;
> +
> +	if (pair->one->sha1_valid) {
> +		diff_populate_filespec(pair->one, 0);
> +		file_parent.ptr = pair->one->data;
> +		file_parent.size = pair->one->size;
> +	} else {
> +		file_parent.ptr = "";
> +		file_parent.size = 0;
> +	}
> +
> +	diff_ranges_init(&diff);
> +	collect_diff(&file_parent, &file_target, &diff);
> +
> +	/* NEEDSWORK should apply some heuristics to prevent mismatches */
> +	rg->spec->path = xstrdup(pair->one->path);
> +
> +	range_set_init(&tmp, 0);
> +	range_set_map_across_diff(&tmp, &rg->ranges, &diff, diff_out);
> +	range_set_release(&rg->ranges);
> +	range_set_move(&rg->ranges, &tmp);
> +
> +	diff_ranges_release(&diff);
> +
> +	return ((*diff_out)->parent.nr > 0);
> +}
> +
> +static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
> +{
> +	struct diff_filepair *new = xmalloc(sizeof(struct diff_filepair));
> +	new->one = pair->one;
> +	new->two = pair->two;
> +	new->one->count++;
> +	new->two->count++;
> +	return new;
> +}
> +
> +static void free_diffqueues(int n, struct diff_queue_struct *dq)
> +{
> +	int i, j;
> +	for (i = 0; i < n; i++)
> +		for (j = 0; j < dq[i].nr; j++)
> +			diff_free_filepair(dq[i].queue[j]);
> +	free(dq);
> +}
> +
> +static int process_all_files(struct line_log_data **range_out,
> +			     struct rev_info *rev,
> +			     struct diff_queue_struct *queue,
> +			     struct line_log_data *range)
> +{
> +	int i, changed = 0;
> +
> +	*range_out = line_log_data_copy(range);
> +
> +	for (i = 0; i < queue->nr; i++) {
> +		struct diff_ranges *pairdiff = NULL;
> +		if (process_diff_filepair(rev, queue->queue[i], *range_out, &pairdiff)) {
> +			struct line_log_data *rg = range;
> +			changed++;
> +			/* NEEDSWORK tramples over data structures not owned here */
> +			while (rg && strcmp(rg->spec->path, queue->queue[i]->two->path))
> +				rg = rg->next;
> +			assert(rg);
> +			rg->pair = diff_filepair_dup(queue->queue[i]);
> +			memcpy(&rg->diff, pairdiff, sizeof(struct diff_ranges));
> +		}
> +	}
> +
> +	return changed;
> +}
> +
> +int line_log_print(struct rev_info *rev, struct commit *commit)
> +{
> +       struct line_log_data *range = lookup_line_range(rev, commit);
> +
> +       show_log(rev);
> +       dump_diff_hacky(rev, range);
> +       return 1;
> +}
> +
> +static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *commit)
> +{
> +	struct commit *parent = NULL;
> +	struct diff_queue_struct queue;
> +	struct line_log_data *range = lookup_line_range(rev, commit);
> +	struct line_log_data *parent_range;
> +	int changed;
> +
> +	if (commit->parents)
> +		parent = commit->parents->item;
> +
> +	queue_diffs(&rev->diffopt, &queue, commit, parent);
> +	changed = process_all_files(&parent_range, rev, &queue, range);
> +	if (parent)
> +		add_line_range(rev, parent, parent_range);
> +	return changed;
> +}
> +
> +static int process_ranges_merge_commit(struct rev_info *rev, struct commit *commit)
> +{
> +	struct line_log_data *range = lookup_line_range(rev, commit);
> +	struct diff_queue_struct *diffqueues;
> +	struct line_log_data **cand;
> +	struct commit **parents;
> +	struct commit_list *p;
> +	int i;
> +	int nparents = count_parents(commit);
> +
> +	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
> +	cand = xmalloc(nparents * sizeof(*cand));
> +	parents = xmalloc(nparents * sizeof(*parents));
> +
> +	p = commit->parents;
> +	for (i = 0; i < nparents; i++) {
> +		parents[i] = p->item;
> +		p = p->next;
> +		queue_diffs(&rev->diffopt, &diffqueues[i], commit, parents[i]);
> +	}
> +
> +	for (i = 0; i < nparents; i++) {
> +		int changed;
> +		cand[i] = NULL;
> +		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
> +		if (!changed) {
> +			/*
> +			 * This parent can take all the blame, so we
> +			 * don't follow any other path in history
> +			 */
> +			add_line_range(rev, parents[i], cand[i]);
> +			clear_commit_line_range(rev, commit);
> +			commit->parents = xmalloc(sizeof(struct commit_list));
> +			commit->parents->item = parents[i];
> +			commit->parents->next = NULL;
> +			free(parents);
> +			free(cand);
> +			free_diffqueues(nparents, diffqueues);
> +			/* NEEDSWORK leaking like a sieve */

Indeed ;-)

> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 * No single parent took the blame.  We add the candidates
> +	 * from the above loop to the parents.
> +	 */
> +	for (i = 0; i < nparents; i++) {
> +		add_line_range(rev, parents[i], cand[i]);
> +	}
> +
> +	clear_commit_line_range(rev, commit);
> +	free(parents);
> +	free(cand);
> +	free_diffqueues(nparents, diffqueues);
> +	return 1;
> +
> +	/* NEEDSWORK evil merge detection stuff */
> +	/* NEEDSWORK leaking like a sieve */
> +}
> +
> +static int process_ranges_arbitrary_commit(struct rev_info *rev, struct commit *commit)
> +{
> +	int changed = 0;
> +
> +	if (lookup_line_range(rev, commit)) {
> +		if (!commit->parents || !commit->parents->next)
> +			changed = process_ranges_ordinary_commit(rev, commit);
> +		else
> +			changed = process_ranges_merge_commit(rev, commit);
> +	}

The code makes the decoration look-up for the same commit multiple
times in a single codeflow; perhaps this entry point should keep the
look-up result and pass it down to the callchain?

Overall, I like this better than the "log --follow" hack; as the
revision traversal is done without any pathspec when being "careful
and slow" (aka -M), you do not suffer from the "just use a singleton
pathspec globally regardless of what other history paths are being
traversed" limitation of "log --follow".

The patch series certainly is interesting.
