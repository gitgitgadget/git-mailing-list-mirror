From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/13] add the basic data structure for line level 
 history
Date: Mon, 12 Jul 2010 09:50:18 -0700
Message-ID: <7vr5j8bq5x.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-3-git-send-email-struggleyb.nku@gmail.com>
 <AANLkTim5m2vG3ZiveRcRIGLVszu9mFruTJ2B_6lsqkGH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 18:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYMD9-0007Ri-Mr
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 18:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab0GLQu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 12:50:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0GLQuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 12:50:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A764C4424;
	Mon, 12 Jul 2010 12:50:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=WKltR5kZnnw/eLJT27HK5ZLldmI=; b=K7FfCOE036ArwfK9MWLRAKk
	2c80HZ1Qgfaia/W5P4XKlsfNswdOtwnHedYWhjbTaC0u94EaItJ9Sd8Pj4gi8BQ2
	td4Xvr60OVmDQr3wkNE5h1PjO9E02u2ECtT3zGq2DX3ZCkiQycNSuqMhoyO6pu/4
	qCaox4eyDcPecB7JuuiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=o71ajiuUlHjoCdA/G/zmvsEr+d8iKN0Q5HkoesgUIvIzl42oM
	OMeYKJUQ9FaWMCE201aB4VzgTZp9e4Nd3HB7Go4OsN5FG7M3KtqEOe1JY25cYmW4
	PyHmgGmqIQyCNEa6yt13IE8oCWTW4tdMQ6F4Bv7Lo15GBpekDRDK0JIr1Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F62C4422;
	Mon, 12 Jul 2010 12:50:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6ACDC4421; Mon, 12 Jul
 2010 12:50:19 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 900B6326-8DD5-11DF-868C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150830>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Subject: [PATCH v3 revised 03/13] add the basic data structure for line level history
>
> 'struct diff_line_range' is the main data structure to store
> the user interesting line range. There is one 'diff_line_range'

-ECANTPARSE. Perhaps "to keep track of the line ranges the user is
interested in"?

Is it the end user, or the code, that is interested in the range recorded
in this structure?  If you are adjusting the line range while traversing
the history, then it is more of the latter; i.e. "the user originally
started digging from this range, but after examining the diff that affect
that range by this commit, we found that the range corresponds to this
widened/narrowed range in the history leading to the commit, so we will
update the range and use it from now on until we hit another commit that
affects this range".  In that case "to keep track of the line ranges we
are currently interested in" would be more appropriate than "the ranges
the user is interested in".

> for each file, and there are multiple 'struct range' in each
> 'diff_line_range'. In this way, we support multiple ranges.
>
> Within 'struct range', there are multiple 'struct print_range'
> which represent a diff chunk.

We call them "hunks" not "chunks", I think.

> diff --git a/diffcore.h b/diffcore.h
> index 491bea0..13d8e93 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -23,6 +23,7 @@
>  #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
>
>  struct userdiff_driver;
> +struct diff_options;

Why???

>  struct diff_filespec {
>  	unsigned char sha1[20];

> diff --git a/line.c b/line.c
> new file mode 100644
> index 0000000..2f82fd8
> --- /dev/null
> +++ b/line.c
> @@ -0,0 +1,456 @@
> ...
> +
> +static struct object *verify_commit(struct rev_info *revs)
> +{
> +	struct object *commit = NULL;
> +	const char *name = NULL;

Why not use "int found = -1" instead and point at the commit in the
pending.objects[] array you found with that variable?  Or use a variable
of the type of a pointer to an element in the pending.objects[] array,
initialized to NULL.

That way, you do not have to tell stupid compilers that name is set once
commit is set to avoid warnings, which is the only reason you initialize
name to NULL.

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
> +	if (commit == NULL)
> +		die("No commit specified?");
> +
> +	return commit;
> +}
> +
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
> +	return;
> +error:
> +	die("There is no path %s in the commit", r->spec->path);
> +}

These two look vaguely familiar...  Cut and paste without refactoring?

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
> +	ends[cur++] = -1;

Wasn't this an array of unsigned longs?

> +static const char *nth_line(struct diff_filespec *spec, int line,
> +		long lines, unsigned long *line_ends)
> +{
> +	assert(line < lines);
> +	assert(spec && spec->data);

Why aren't "line" and "lines" of the same type?

> +static void parse_range(long lines, unsigned long *line_ends,
> +		struct range *r, struct diff_filespec *spec)
> +{
> +	const char *term;
> +
> +	term = parse_loc(r->arg, spec, lines, line_ends, 1, &r->start);
> +	if (*term == ',') {
> +		term = parse_loc(term + 1, spec, lines, line_ends,
> +			r->start + 1, &r->end);
> +		if (*term) {
> +			die("-L parameter's argument should be <start>,<end>");
> +		}

Excess {} around a single statement.

> +struct range *diff_line_range_insert(struct diff_line_range *r, const
> char *arg,
> +				int start, int end)
> +{
> +	int i = 0;
> +	struct range *rs = r->ranges;
> +	int left_extend = 0, right_extend = 0;
> +
> +	assert(r != NULL);
> +	assert(start <= end);
> +
> +	if (r->nr == 0 || rs[r->nr - 1].end < start - 1) {
> +		DIFF_LINE_RANGE_GROW(r);
> +		rs = r->ranges;
> +		int num = r->nr - 1;

decl-after-statement

> ...
> +out:
> +	assert(r->nr != i);
> +	if (left_extend) {

Sounds more like a "merge" than "extend" to me...

> diff --git a/line.h b/line.h
> new file mode 100644
> index 0000000..a2f8545
> --- /dev/null
> +++ b/line.h
> @@ -0,0 +1,122 @@
> ...
> +#define PRINT_RANGE_INIT(r) \
> +	do { \
> +		(r)->line_added = 0; \
> +	} while(0);

	} while (0)

- No semicolon after a macro (the user will give it to us).
- A SP after "while".

Does this even have to be "do { ... } while (0)"???

> +
> +#define PRINT_PAIR_INIT(p) \
> +	do { \
> +		(p)->alloc = (p)->nr = 0; \
> +		(p)->ranges = NULL; \
> +	} while(0);
> +
> +#define PRINT_PAIR_GROW(p) \
> +	do { \
> +		(p)->nr ++; \

	(p)->nr++;

> +		ALLOC_GROW((p)->ranges, (p)->nr, (p)->alloc); \
> +	} while (0);
> +
> +#define PRINT_PAIR_CLEAR(p) \
> +	do { \
> +		(p)->alloc = (p)->nr = 0; \
> +		if ((p)->ranges) \
> +			free((p)->ranges); \
> +		(p)->ranges = NULL; \
> +	} while(0);
> +
> +struct range {
> +	const char *arg;	//The argument to specify this line range

No C++/C99 comments.

Do you need to keep track of this string representation once you have
parsed the user input and your main computation have started?

Isn't "range" too generic a term?   Unless you make this as a static
declaration only visible to functions where "range" can only mean "line
ranges" in their context, that is.

> +#define RANGE_INIT(r) \

Same comment for the name possibly being too generic.

> +extern struct range *diff_line_range_insert(struct diff_line_range
> *r, const char *arg,

Linewrapped?

> diff --git a/revision.c b/revision.c
> index 7e82efd..63f37ea 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1637,6 +1637,12 @@ int setup_revisions(int argc, const char
> **argv, struct rev_info *revs, struct s
>  	if (revs->combine_merges)
>  		revs->ignore_merges = 0;
>  	revs->diffopt.abbrev = revs->abbrev;
> +
> +	if (revs->line) {

"line" what?

> diff --git a/revision.h b/revision.h
> index 36fdf22..55836e0 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -14,7 +14,8 @@
>  #define CHILD_SHOWN	(1u<<6)
>  #define ADDED		(1u<<7)	/* Parents already parsed and added? */
>  #define SYMMETRIC_LEFT	(1u<<8)
> -#define ALL_REV_FLAGS	((1u<<9)-1)
> +#define RANGE_UPDATE	(1u<<9) /* for line level traverse */
> +#define ALL_REV_FLAGS	((1u<<10)-1)
>
>  #define DECORATE_SHORT_REFS	1
>  #define DECORATE_FULL_REFS	2
> @@ -68,7 +69,8 @@ struct rev_info {
>  			cherry_pick:1,
>  			bisect:1,
>  			ancestry_path:1,
> -			first_parent_only:1;
> +			first_parent_only:1,
> +			line:1;

Is this really a traversal flag that affects how the history is walked?

>  	/* Diff flags */
>  	unsigned int	diff:1,
> @@ -137,6 +139,8 @@ struct rev_info {
>  	/* commit counts */
>  	int count_left;
>  	int count_right;
> +	/* line-level intersting range */
> +	struct decoration line_range;

s/intersting//; or perhaps "line level range that we are chasing"

>  };
>
>  #define REV_TREE_SAME		0
> -- 
> 1.7.0.2.273.gc2413.dirty
