From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/12] add the basic data structure for line level
 history
Date: Sun, 27 Jun 2010 11:23:15 -0700
Message-ID: <7v39w8gwrw.fsf@alter.siamese.dyndns.org>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
 <1277558857-23103-4-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 20:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSwVz-0005os-4f
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 20:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab0F0SX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 14:23:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0F0SX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 14:23:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54D36BF5E0;
	Sun, 27 Jun 2010 14:23:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Z5nIYr8UvSBtdHh0/02rDn47bhs=; b=EM3C1xcke2pKtoMH5EZ444a
	ZRdI2bvPp78SPsLdzCkCgy1wHoeLp5T3uNai8t2WvyAPH8tRbo2VBlCymiTrS66i
	MJoJY55pipgXDeYGHFzH2axidZCF32Slz16i3H8MLbx235GRv5AkI7kI9yzJ9tYt
	+n++CUDRxPL9NQz/ytz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Zd2qP8Lu7kTbRtwEoyfOBgJSPWPlVNP0cjb2WJ2Lm2LazW8DI
	EMWXNhH1yW2RH2hlclinRPi4Vg66c/AwMTIiGJVttFRDlzkebnY1/ceCUzYCR7s9
	FxpIQ3SRrPQNfTRr6guOE2gnoPsBpYN+ZldTIJ48BHUhZ0W9Vb1pga+vOo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 020D5BF5DE;
	Sun, 27 Jun 2010 14:23:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93C44BF5D7; Sun, 27 Jun
 2010 14:23:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11DB5B36-8219-11DF-B80E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149797>

Bo Yang <struggleyb.nku@gmail.com> writes:

> 'struct diff_line_range' is the main data structure to store
> the user interesting line range. There is one 'diff_line_range'
> for each file, and there are multiple 'struct range' in each
> 'diff_line_range'. In this way, we support multiple ranges.
>
> Within 'struct range', there are multiple 'struct print_range'
> which represent a diff chunk.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
> ...
> diff --git a/diffcore.h b/diffcore.h
> index 491bea0..06a6934 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -51,6 +52,8 @@ struct diff_filespec {
>  	int is_binary;
>  };
>  
> +#define FILESPEC_VALID(f) (f)->sha1_valid

The filespec itself is valid even when it refers to an entity in the
working tree. Drop this, as it is misleading, and you don't seem to use
this anywhere.

> +static void cleanup(struct diff_line_range *r)
> +{
> +	while (r) {
> +		struct diff_line_range *tmp = r->next;
> +		DIFF_LINE_RANGE_CLEAR(r);
> +		free(r);
> +		r = tmp;

Nit. s/tmp/next/;

> +static struct object *find_commit(struct rev_info *revs)
> +{
> +	struct object *commit = NULL;
> +	const char *name = NULL;
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
> +			    revs->pending.objects[i].name, name);
> +		commit = obj;
> +		name = revs->pending.objects[i].name;
> +	}
> +
> +	return commit;
> +}
> +

This function is misnamed, as it does a lot more than "find commit".  It
also enforces that you have at most one positive commit-ish on the command
line (or whatever populated revs->pending[] array), while making the
caller responsible for diagnosing (and dying if necessary) if there is no
commit-ish.

The sole caller of this doesn't seem to check if the returned value is
NULL.  If you make this die upon "more than one commit", probably you
should also make it die upon "no commit".

> +static void fill_blob_sha1(struct commit *commit, struct diff_line_range *r)
> +{
> +	unsigned mode;
> +	unsigned char sha1[20];
> +
> +	while (r) {
> +		if (get_tree_entry(commit->object.sha1, r->spec->path,
> +			sha1, &mode))
> +			goto error;
> +		fill_filespec(r->spec, sha1, mode);
> +		r = r->next;
> +	}
> +
> +	return ;

There is a stray SP before semicolon.  Drop it.

> +error:
> +	die("There is no path %s in the commit", r->spec->path);
> +}
> +
> +static void make_line_log_file(struct diff_filespec *spec, int *lines, int **line_ends)
> +{

I don't see anything like "log-file" in this function.

When we have the whole contents of a blob in a chunk of memory, we always
use "unsigned long" to keep the offsets into it, I think.  The type of
"line-ends" should be "unsigned long **" for consistency.  I don't offhand
recall how we count number of lines (i.e. type of "lines"), but I suspect
we count them in long.

> +	int num = 0, size = 50, cur = 0;
> +	int *ends = NULL;
> +	char *data = NULL;
> +
> +	if (diff_populate_filespec(spec, 0))
> +		die("Cannot read blob %s", sha1_to_hex(spec->sha1));
> +
> +	ends = xmalloc(size * sizeof(int));
> +	ends[cur++] = -1;
> +	data = spec->data;
> +	while (num < spec->size) {
> +		if (data[num] == '\n' || num == spec->size - 1) {
> +			if (cur >= size) {
> +				size = size * 2;
> +				ends = xrealloc(ends, size * sizeof(int));
> +			}
> +			ends[cur++] = num;
> +		}

ARRAY_GROW()???

> +		num ++;

There is a stray SP between the operand and unary operator.  Drop it.

> +/*
> + * copied from blame.c, indeed, we can even to use this to test

A bit of refactoring would certainly help, before this series graduates
the WIP/RFC stage.

> +static void parse_lines(struct commit *commit, struct diff_line_range *r)
> +{
> +	int i;
> +	struct range *rg = NULL;
> +	int lines = 0;
> +	int *ends = NULL;
> +
> +	while (r) {
> +		struct diff_filespec *spec = r->spec;
> +		int num = r->nr;
> +		assert(spec);
> +		fill_blob_sha1(commit, r);
> +		rg = r->ranges;
> +		r->ranges = NULL;
> +		r->nr = r->alloc = 0;
> +		make_line_log_file(spec, &lines, &ends);
> +		for (i = 0; i < num; i++) {
> +			parse_range(lines, ends, rg + i, spec);
> +			diff_line_range_insert(r, rg[i].arg, rg[i].start, rg[i].end);
> +		}
> +
> +		if (ends != NULL) {
> +			free(ends);
> +			ends = NULL;
> +		}

Under what condition can "ends" be NULL here?  You would have died inside
nth_line() when you called parse_range().

Besides, free(NULL) is perfectly Ok.

> +
> +		r = r->next;
> +		/* release the memory of old array */
> +		free(rg);

If you gave "rg" a more descriptive name, the readers would understand
without this comment.

> +/*
> + * Insert a new line range into a diff_line_range struct, and keep the
> + * r->ranges sorted by their starting line number.
> + */
> +struct range *diff_line_range_insert(struct diff_line_range *r, const char *arg,
> +				int start, int end)
> +{
> +	assert(r != NULL);
> +	assert(start <= end);
> +
> +	int i = 0;
> +	struct range *rs = r->ranges;
> +	int left_extend = 0, right_extend = 0;

We avoid decl-after-statement.

> diff --git a/revision.c b/revision.c
> index 7847921..3186e0e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1397,18 +1397,19 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	return 1;
>  }
>  
> -void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
> +int parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>  			const struct option *options,
>  			const char * const usagestr[])
>  {
>  	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
>  				    &ctx->cpidx, ctx->out);
>  	if (n <= 0) {
> -		error("unknown option `%s'", ctx->argv[0]);
> -		usage_with_options(usagestr, options);
> +		return -1;
>  	}
>  	ctx->argv += n;
>  	ctx->argc -= n;
> +
> +	return 0;
>  }

The function has existing callers and they expect it to fail with
usage_with_options(), never to return.  Doesn't this change break them?

This change is not described nor justified in the commit log message.

>  static int for_each_bad_bisect_ref(each_ref_fn fn, void *cb_data)
> @@ -1631,6 +1632,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	if (revs->combine_merges)
>  		revs->ignore_merges = 0;
>  	revs->diffopt.abbrev = revs->abbrev;
> +
> +	if (revs->line) {
> +		revs->limited = 1;
> +		revs->topo_order = 1;
> +	}
> +
>  	if (diff_setup_done(&revs->diffopt) < 0)
>  		die("diff_setup_done failed");
>  
> diff --git a/revision.h b/revision.h
> index 855464f..26c2ff5 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -14,6 +14,7 @@
>  #define CHILD_SHOWN	(1u<<6)
>  #define ADDED		(1u<<7)	/* Parents already parsed and added? */
>  #define SYMMETRIC_LEFT	(1u<<8)
> +#define RANGE_UPDATE	(1u<<9) /* for line level traverse */
>  #define ALL_REV_FLAGS	((1u<<9)-1)

It doesn't make sense to add a global flag here and keep ALL_REV_FLAGS the
same value.  Have you audited the existing code and made sure that they
either do use 1<<9 for their own or their uses of such a custom flag are
compatible with this?
