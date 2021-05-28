Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7336DC4707F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A5E613D1
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhE1DFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 23:05:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64274 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhE1DFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 23:05:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2554AD5E69;
        Thu, 27 May 2021 23:03:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=N+rS9/QRdtyE4C1pWqc60u4r0j/+LoIYbO/YkLp5NNw=; b=F064
        OlEd6Xg8nvv4zUqMkrYcXztt9LUFZkqDy3P0mb1QaFiW6jz2d/MXJdNhb1kAhHY3
        b1QJomYIxlmbafBRKvMcVv8xVWNDHx8P4RkLe7S/lhxdokiIN6WnqQDRUt/Qhdjw
        pxgoaJanZa53eJUUUi2T7nerBljCRn5wrwXw9ZY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15A7CD5E68;
        Thu, 27 May 2021 23:03:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 741C5D5E67;
        Thu, 27 May 2021 23:03:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
Date:   Fri, 28 May 2021 12:03:57 +0900
Message-ID: <xmqq1r9r8spu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58A72E3C-BF61-11EB-9BEE-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The raw data of blob, tree objects may contain '\0', but most of
> the logic in `ref-filter` depands on the output of the atom being
> a structured string (end with '\0').

Text, yes, string is also OK.  But structured?  Probably not.

    ... being text (specifically, no embedded NULs in it).

> E.g. `quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
> add the data to the buffer. The raw data of a tree object is
> `100644 one\0...`, only the `100644 one` will be added to the buffer,
> which is incorrect.
>
> Therefore, add a new member in `struct atom_value`: `s_size`, which
> can record raw object size, it can help us add raw object data to
> the buffer or compare two buffers which contain raw object data.

Other than the phrasing issue around "structured", all of the above
is a good description.

> Beyond, `--format=%(raw)` should not combine with `--python`, `--shell`,
> `--tcl`, `--perl` because if our binary raw data is passed to a variable
> in the host language, the host languages may cause escape errors.

OK.  I think at least --perl and possibly --python should be able to
express NULs in the "string" type we use from the host language, but
I am perfectly fine with the decision to leave it to later updates.

After all, the --<lang> feature to write scriptlets via --format and
execute them in the named language interpreter probably is not as
often used as it was originally designed for, so it might be that
nobody will ask for such "later updates".

> @@ -235,6 +235,20 @@ and `date` to extract the named component.  For email fields (`authoremail`,
>  without angle brackets, and `:localpart` to get the part before the `@` symbol
>  out of the trimmed email.
>  
> +The raw data in a object is `raw`, For commit and tag objects, `raw` contain
> +`header` and `contents` two parts, `header` is structured part of raw data, it
> +composed of "tree XXX", "parent YYY", etc lines in commits , or composed of
> +"object OOO", "type TTT", etc lines in tags; `contents` is unstructured "free
> +text" part of raw object data. For blob and tree objects, their raw data don't
> +have `header` and `contents` parts.
> +
> +raw:size::
> +	The raw data size of the object.
> +
> +Note that `--format=%(raw)` should not combine with `--python`, `--shell`, `--tcl`,

"should not combine" -> "cannot be used" would make it read more
naturally (ditto for the phrase used in the proposed log message).

> +`--perl` because if our binary raw data is passed to a variable in the host language,
> +the host languages may cause escape errors.
> +
>  The message in a commit or a tag object is `contents`, from which
>  `contents:<part>` can be used to extract various parts out of:
>  
> diff --git a/ref-filter.c b/ref-filter.c
> index 97116e12d7c4..c2abf5da7006 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -138,6 +138,9 @@ static struct used_atom {
>  			struct process_trailer_options trailer_opts;
>  			unsigned int nlines;
>  		} contents;
> +		struct {
> +			enum { RAW_BARE, RAW_LENGTH } option;
> +		} raw_data;
>  		struct {
>  			cmp_status cmp_status;
>  			const char *str;
> @@ -370,6 +373,18 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
>  	return 0;
>  }
>  
> +static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
> +				const char *arg, struct strbuf *err)
> +{
> +	if (!arg) {
> +		atom->u.raw_data.option = RAW_BARE;
> +	} else if (!strcmp(arg, "size"))
> +		atom->u.raw_data.option = RAW_LENGTH;
> +	else
> +		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
> +	return 0;
> +}
> +
>  static int oid_atom_parser(const struct ref_format *format, struct used_atom *atom,
>  			   const char *arg, struct strbuf *err)
>  {
> @@ -530,6 +545,7 @@ static struct {
>  	{ "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
>  	{ "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
>  	{ "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
> +	{ "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
>  	{ "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
>  	{ "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
>  	{ "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
> @@ -564,12 +580,15 @@ struct ref_formatting_state {
>  
>  struct atom_value {
>  	const char *s;
> +	size_t s_size;

OK, so everything used to be a C-string that cannot hold NULs in it,
but now it is a counted <ptr, len> string.  Good.

>  	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
>  		       struct strbuf *err);
>  	uintmax_t value; /* used for sorting when not FIELD_STR */
>  	struct used_atom *atom;
>  };
>  
> +#define ATOM_VALUE_S_SIZE_INIT (-1)
> +
>  /*
>   * Used to parse format string and sort specifiers
>   */
> @@ -588,6 +607,10 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  		return strbuf_addf_ret(err, -1, _("malformed field name: %.*s"),
>  				       (int)(ep-atom), atom);
>  
> +	if (format->quote_style && starts_with(sp, "raw"))
> +		return strbuf_addf_ret(err, -1, _("--format=%.*s should not combine with"
> +				"--python, --shell, --tcl, --perl"), (int)(ep-atom), atom);

Don't we want to allow "raw:size" that would be a plain text?
I am not sure if this check belongs here in the first place.
Shouldn't it be done in raw_atom_parser() instead?

Another idea is to teach a more generic rule to quote_formatting()
to detect NULs in v->s[0..v->s_size] at runtime and barf, i.e. a
plain-text blob object can be used with "--shell --format=%(raw)"
just fine.

> @@ -652,11 +675,14 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  	return at;
>  }
>  
> -static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
> +static void quote_formatting(struct strbuf *s, const char *str, size_t len, int quote_style)
>  {
>  	switch (quote_style) {
>  	case QUOTE_NONE:
> -		strbuf_addstr(s, str);
> +		if (len != ATOM_VALUE_S_SIZE_INIT)
> +			strbuf_add(s, str, len);
> +		else
> +			strbuf_addstr(s, str);

It probably is a good idea to invent a C preprocessor macro for a
named constant to be used when a structure is initialized, but it
would be easier to read if the rule is "len field is negative when
the value is a C-string", e.g.

		if (len < 0)

> @@ -683,9 +709,12 @@ static int append_atom(struct atom_value *v, struct ref_formatting_state *state,
>  	 * encountered.
>  	 */
>  	if (!state->stack->prev)
> -		quote_formatting(&state->stack->output, v->s, state->quote_style);
> +		quote_formatting(&state->stack->output, v->s, v->s_size, state->quote_style);
>  	else
> -		strbuf_addstr(&state->stack->output, v->s);
> +		if (v->s_size != ATOM_VALUE_S_SIZE_INIT)
> +			strbuf_add(&state->stack->output, v->s, v->s_size);
> +		else
> +			strbuf_addstr(&state->stack->output, v->s);
>  	return 0;
>  }
>  
> @@ -785,14 +814,16 @@ static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state
>  	return 0;
>  }
>  
> -static int is_empty(const char *s)
> +static int is_empty(struct strbuf *buf)
>  {
> -	while (*s != '\0') {
> -		if (!isspace(*s))
> -			return 0;
> +	const char *s = buf->buf;
> +	size_t cur_len = 0;
> +
> +	while ((cur_len != buf->len) && (isspace(*s) || *s == '\0')) {
>  		s++;
> +		cur_len++;
>  	}
> -	return 1;
> +	return cur_len == buf->len;
>  }

Assuming that we do want to treat NULs the same way as whitespaces,
the updated code works as intended, which is good.  But I have no
reason to support that design decision.  I do not have a strong
reason to support a design decision that goes the opposite way to
treat a NUL just like we treat an 'X', but at least I can understand
it (i.e. "because we have no reason to special case NUL any more
than 'X' when trying to see if a buffer is 'empty', we don't").
This code on the other hand must be supported with "because we need
to special case NUL for such and such reasons for the purpose of
determining if a buffer is 'empty', we treat them the same way as
whitespaces".

> @@ -800,6 +831,7 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
>  {
>  	struct ref_formatting_stack *cur = state->stack;
>  	struct if_then_else *if_then_else = NULL;
> +	size_t str_len = 0;
>  
>  	if (cur->at_end == if_then_else_handler)
>  		if_then_else = (struct if_then_else *)cur->at_end_data;
> @@ -810,18 +842,28 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
>  	if (if_then_else->else_atom_seen)
>  		return strbuf_addf_ret(err, -1, _("format: %%(then) atom used after %%(else)"));
>  	if_then_else->then_atom_seen = 1;
> +	if (if_then_else->str)
> +		str_len = strlen(if_then_else->str);
>  	/*
>  	 * If the 'equals' or 'notequals' attribute is used then
>  	 * perform the required comparison. If not, only non-empty
>  	 * strings satisfy the 'if' condition.
>  	 */
>  	if (if_then_else->cmp_status == COMPARE_EQUAL) {
> -		if (!strcmp(if_then_else->str, cur->output.buf))
> +		if (!if_then_else->str)
> +			BUG("when if_then_else->cmp_status == COMPARE_EQUAL,"
> +			    "if_then_else->str must not be null");

Can the change in this commit violate the invariant that
if_then_else->str cannot be NULL, which seems to have been the case
forever as we see an unchecked strcmp() done in the original?

If so, perhaps you can check the condition upfront, where you
compute str_len above, e.g.

	if (!if_then_else->str) {
		if (if_then_else->cmp_status == COMPARE_EQUAL ||
                    if_then_else->cmp_status == COMPARE_UNEQUAL)
			BUG(...);
	} else
		str_len = strlen(...);

If not, then I do not see the point of adding this (and later) check
with BUG to this code.

Or is the invariant that .str must not be NULL could have been
violated without this patch (i.e. the original was buggy in running
strcmp() on .str without checking)?  If so, please make it a separate
preliminary change to add such an assert.

> +		if (str_len == cur->output.len &&
> +		    !memcmp(if_then_else->str, cur->output.buf, cur->output.len))
>  			if_then_else->condition_satisfied = 1;
>  	} else if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
> -		if (strcmp(if_then_else->str, cur->output.buf))
> +		if (!if_then_else->str)
> +			BUG("when if_then_else->cmp_status == COMPARE_UNEQUAL,"
> +			    "if_then_else->str must not be null");



>  /* See grab_values */
> -static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
> +static void grab_raw_data(struct atom_value *val, int deref, void *buf, unsigned long buf_size, struct object *obj)
>  {
>  	int i;
>  	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
> @@ -1307,10 +1349,22 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>  			continue;
>  		if (deref)
>  			name++;
> -		if (strcmp(name, "body") &&
> -		    !starts_with(name, "subject") &&
> -		    !starts_with(name, "trailers") &&
> -		    !starts_with(name, "contents"))
> +
> +		if (starts_with(name, "raw")) {
> +			if (atom->u.raw_data.option == RAW_BARE) {
> +				v->s = xmemdupz(buf, buf_size);
> +				v->s_size = buf_size;
> +			} else if (atom->u.raw_data.option == RAW_LENGTH)
> +				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
> +			continue;
> +		}

I can understand that "raw[:<options>]" handling has been inserted
above the existing "from here on, we only deal with log message
components" check.  But

> +		if ((obj->type != OBJ_TAG &&
> +		     obj->type != OBJ_COMMIT) ||

I do not see why these new conditions are added.  The change is not
justified in the proposed log message, the original did not need
these conditions, and this does not concern the primary point of the
change, which is to start supporting %(raw[:<option>]) placeholder.

If it is needed as a bugfix (e.g. it may be that you consider "if a
blob has contents that looks very similar to 'git cat-file commit
HEAD', %(body) and friends parse these out, even though it is not a
commit" is a bug and the change to add these extra tests is meant as
a fix), that should be done as a preliminary change before adding
the support for a new atom.

> +		    (strcmp(name, "body") &&
> +		     !starts_with(name, "subject") &&
> +		     !starts_with(name, "trailers") &&
> +		     !starts_with(name, "contents")))
>  			continue;
>  		if (!subpos)
>  			find_subpos(buf,
> @@ -1374,25 +1428,30 @@ static void fill_missing_values(struct atom_value *val)
>   * pointed at by the ref itself; otherwise it is the object the
>   * ref (which is a tag) refers to.
>   */
> -static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
> +static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
>  {
> +	void *buf = data->content;
> +	unsigned long buf_size = data->size;
> +
>  	switch (obj->type) {
>  	case OBJ_TAG:
>  		grab_tag_values(val, deref, obj);
> -		grab_sub_body_contents(val, deref, buf);
> +		grab_raw_data(val, deref, buf, buf_size, obj);

It is very strange that a helper that is named to grab raw data can
still process pieces out of a structured data.  The original name is
still a far better match to what the function does, even after this
patch teaches it to also honor %(raw) placeholder.  It is still
about grabbing various "sub"-pieces out of "body contents", and the
sub-piece the %(raw) grabs just happens to be "the whole thing".

> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> +{
> +	size_t i;
> +	const char *s1 = (const char *)vs1;
> +	const char *s2 = (const char *)vs2;
> +
> +	for (i = 0; i < n; i++) {
> +		unsigned char u1 = s1[i];
> +		unsigned char u2 = s2[i];
> +		int U1 = toupper (u1);
> +		int U2 = toupper (u2);

Does toupper('\0') even have a defined meaning?

> +		int diff = (UCHAR_MAX <= INT_MAX ? U1 - U2
> +			: U1 < U2 ? -1 : U2 < U1);

Looks crazy to worry about uchar wider than int.  Such a system is
not even standard compliant, is it?

> +		if (diff)
> +			return diff;
> +	}
> +	return 0;
> +}


> @@ -2304,6 +2382,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  	int cmp_detached_head = 0;
>  	cmp_type cmp_type = used_atom[s->atom].type;
>  	struct strbuf err = STRBUF_INIT;
> +	size_t slen = 0;
>  
>  	if (get_ref_atom_value(a, s->atom, &va, &err))
>  		die("%s", err.buf);
> @@ -2317,10 +2396,32 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  	} else if (s->sort_flags & REF_SORTING_VERSION) {
>  		cmp = versioncmp(va->s, vb->s);
>  	} else if (cmp_type == FIELD_STR) {
> -		int (*cmp_fn)(const char *, const char *);
> -		cmp_fn = s->sort_flags & REF_SORTING_ICASE
> -			? strcasecmp : strcmp;
> -		cmp = cmp_fn(va->s, vb->s);

> +		if (va->s_size == ATOM_VALUE_S_SIZE_INIT &&
> +		    vb->s_size == ATOM_VALUE_S_SIZE_INIT) {
> +			int (*cmp_fn)(const char *, const char *);
> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
> +				? strcasecmp : strcmp;
> +			cmp = cmp_fn(va->s, vb->s);
> +		} else {
> +			int (*cmp_fn)(const void *, const void *, size_t);
> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
> +				? memcasecmp : memcmp;

Why not introduce two local temporary variables a_size and b_size
and initialize them upfront like so:

		a_size = va->s_size < 0 ? strlen(va->s) : va->s_size;
		b_size = vb->s_size < 0 ? strlen(vb->s) : vb->s_size;

Wouldn't that allow you to do without the complex "if both are
counted, do this, if A is counted but B is not, do that, ..."
cascade?

I can sort-of see the point of special casing "both are traditional
C strings" case (i.e. the "if" side of the "else" we are discussing
here) and using strcasecmp/strcmp instead of memcasecmp/memcmp, but
I do not see much point in having the if/elseif/else cascade inside
this "else" clause.

> +			if (va->s_size != ATOM_VALUE_S_SIZE_INIT &&
> +			    vb->s_size != ATOM_VALUE_S_SIZE_INIT) {
> +				cmp = cmp_fn(va->s, vb->s, va->s_size > vb->s_size ?
> +				       vb->s_size : va->s_size);
> +			} else if (va->s_size == ATOM_VALUE_S_SIZE_INIT) {
> +				slen = strlen(va->s);
> +				cmp = cmp_fn(va->s, vb->s, slen > vb->s_size ?
> +					     vb->s_size : slen);
> +			} else {
> +				slen = strlen(vb->s);
> +				cmp = cmp_fn(va->s, vb->s, slen > va->s_size ?
> +					     slen : va->s_size);
> +			}
> +			cmp = cmp ? cmp : va->s_size - vb->s_size;
> +		}
>  	} else {
>  		if (va->value < vb->value)
>  			cmp = -1;

Thanks.
