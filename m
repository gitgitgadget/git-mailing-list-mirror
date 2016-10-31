Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F532021E
	for <e@80x24.org>; Mon, 31 Oct 2016 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946945AbcJaVKJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 17:10:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61719 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935253AbcJaVKI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 17:10:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 466AB4A29E;
        Mon, 31 Oct 2016 17:10:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=vvx6XIQL/pwrTjDYZ6gb3KKrQ0Q=; b=vXZrwhe/sW9emlBeNFKY
        XGLRZFWGwppu1QZNYdr32P73dWZ6oXkTRghswBI6nS5y6EDsASfghzvyJWkY11jk
        aXjy0SN//6hbeHy49i33yFXe12eWNTIVqD12To5wIBEM1uvdKOptQcagVnsd1vud
        gsWdZpOd8CkmREaAUGN5Zwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=L8qEPrjEWcZZFrwMkpYe8X4bpW4J0gugO95LOnI7i8G7Pb
        T1EzNSAjfHoIm3Pv59yEHGT8AjnWX2T7yJBmZoxjWPYu54f6JlcsajIbSsKssz1G
        VF08vCJqORGILS5YQAt68OjljI1bdUKGOC4OstbeOepzCHHMuv8KVr5IxY1ws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F0C14A297;
        Mon, 31 Oct 2016 17:10:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B0324A290;
        Mon, 31 Oct 2016 17:10:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] trailer: avoid unnecessary splitting on lines
References: <cover.1477698917.git.jonathantanmy@google.com>
        <cover.1477698917.git.jonathantanmy@google.com>
        <db609e13740415ac4e5e357493661347b0f681f7.1477698917.git.jonathantanmy@google.com>
Date:   Mon, 31 Oct 2016 14:10:05 -0700
Message-ID: <xmqqoa20rzrm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 660188E8-9FAE-11E6-AE07-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/trailer.c b/trailer.c
> index 6d8375b..d4d9e10 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -102,12 +102,12 @@ static int same_trailer(struct trailer_item *a, struct arg_item *b)
>  	return same_token(a, b) && same_value(a, b);
>  }
>  
> -static inline int contains_only_spaces(const char *str)
> +static inline int is_blank_line(const char *str)
>  {
>  	const char *s = str;
> -	while (*s && isspace(*s))
> +	while (*s && *s != '\n' && isspace(*s))
>  		s++;
> -	return !*s;
> +	return !*s || *s == '\n';
>  }

This used to be fed a single line and did not have to worry about
stopping at the end of a line, but now it does have to, and does so
correctly.  OK.

And the updated function name certainly reflects the fact that this
is (now) about a line-oriented processing better, and this renaming
makes sense.

> @@ -566,13 +566,18 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
>  }
>  
>  /*
> - * Return the location of the first separator in line, or -1 if there is no
> - * separator.
> + * Return the location of the first separator in the given line, or -1 if there
> + * is no separator.
> + *
> + * The interests parameter must contain the acceptable separators and may
> + * contain '\n'. If interests contains '\n', the input line is considered to
> + * end at the first newline encountered. Otherwise, the input line is
> + * considered to end at its null terminator.
>   */

The name of that terminating byte is NUL, not NULL.  

> -static int find_separator(const char *line, const char *separators)
> +static int find_separator(const char *line, const char *interests)
>  {
> -	int loc = strcspn(line, separators);
> -	if (!line[loc])
> +	int loc = strcspn(line, interests);
> +	if (!line[loc] || line[loc] == '\n')
>  		return -1;
>  	return loc;
>  }

I am not sure interests is a better name than separators.  If the
original used "interests", I do not think it is worth renaming it to
"separators", and I doubt that the renaming of the parameter in this
patch is an improvement.


> @@ -688,51 +693,71 @@ static void process_command_line_args(struct list_head *arg_head,
> -static struct strbuf **read_input_file(const char *file)
> +static void read_input_file(struct strbuf *sb, const char *file)
>  {
> -	struct strbuf **lines;
> -	struct strbuf sb = STRBUF_INIT;
> -
>  	if (file) {
> -		if (strbuf_read_file(&sb, file, 0) < 0)
> +		if (strbuf_read_file(sb, file, 0) < 0)
>  			die_errno(_("could not read input file '%s'"), file);
>  	} else {
> -		if (strbuf_read(&sb, fileno(stdin), 0) < 0)
> +		if (strbuf_read(sb, fileno(stdin), 0) < 0)
>  			die_errno(_("could not read from stdin"));
>  	}
> +}

The original used to return an array of strbufs but we now just read
into a single strbuf.  The caller may need to do more, or perhaps
the early split into array of strbufs was mostly wasteful use of
more flexible data structure.  We'll find out when we read what
happens to the data read here.

> +static const char *next_line(const char *str)
> +{
> +	const char *nl = strchrnul(str, '\n');
> +	return nl + !!*nl;
> +}

"next_line()" gives a pointer to either the beginning of the next
line, or points at the NUL that terminates the whole buffer.  OK.

> +/*
> + * Return the position of the start of the last line. If len is 0, return -1.
> + */
> +static int last_line(const char *buf, size_t len)
> +{
> +	int i;
> +	if (len == 0)
> +		return -1;
> +	if (len == 1)
> +		return 0;
> +	/*
> +	 * Skip the last character (in addition to the null terminator),
> +	 * because if the last character is a newline, it is considered as part
> +	 * of the last line anyway.
> +	 */
> +	i = len - 2;

... and if the last character is not a newline, the line is an
incomplete last line.  OK.

> -	return lines;
> +	for (; i >= 0; i--) {
> +		if (buf[i] == '\n')
> +			return i + 1;
> +	}
> +	return 0;
>  }

OK.

>  /*
> - * Return the (0 based) index of the start of the patch or the line
> - * count if there is no patch in the message.
> + * Return the position of the start of the patch or the length of str if there
> + * is no patch in the message.
>   */
> -static int find_patch_start(struct strbuf **lines, int count)
> +static int find_patch_start(const char *str)
>  {
> -	int i;
> +	const char *s;
>  
> -	/* Get the start of the patch part if any */
> -	for (i = 0; i < count; i++) {
> -		if (starts_with(lines[i]->buf, "---"))
> -			return i;
> +	for (s = str; *s; s = next_line(s)) {
> +		if (starts_with(s, "---"))
> +			return s - str;
>  	}
>  
> -	return count;
> +	return s - str;
>  }

The original assumed that the input was first split into an array of
strbufs and found the index that begins with a line "---".  We have
a flat buffer of input, and find a line that begins with "---".  The
returned value is different (i.e. used to be line-number, now it is
the byte offset).  OK.

>  /*
> - * Return the (0 based) index of the first trailer line or count if
> - * there are no trailers. Trailers are searched only in the lines from
> - * index (count - 1) down to index 0.
> + * Return the position of the first trailer line or len if there are no
> + * trailers.
>   */

OK, the idea is the same as the above; it used to be line-based, but
now it is counted in byte-offset.

> -static int find_trailer_start(struct strbuf **lines, int count)
> +static int find_trailer_start(const char *buf, size_t len)
>  {
> -	int start, end_of_title, only_spaces = 1;
> +	const char *s;
> +	int title_end, l, only_spaces = 1;

between end-of-title and title-end, I have slight preference for the
former over the latter, but just like separators vs interests, this
rename is probably more distracting than is worth.

>  	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
>  	/*
>  	 * Number of possible continuation lines encountered. This will be
> @@ -742,15 +767,18 @@ static int find_trailer_start(struct strbuf **lines, int count)
>  	 * are to be considered non-trailers).
>  	 */
>  	int possible_continuation_lines = 0;
> +	int ret;
> +
> +	char *sep_nl = xstrfmt("%s\n", separators);
>  
>  	/* The first paragraph is the title and cannot be trailers */
> -	for (start = 0; start < count; start++) {
> -		if (lines[start]->buf[0] == comment_line_char)
> +	for (s = buf; s < buf + len; s = next_line(s)) {
> +		if (s[0] == comment_line_char)
>  			continue;
> -		if (contains_only_spaces(lines[start]->buf))
> +		if (is_blank_line(s))
>  			break;
>  	}
> -	end_of_title = start;
> +	title_end = s - buf;

OK, we skipped to find the first blank line.  The original had an
array of strbufs to iterate over and didn't have to look for LF but
now we do, but it is just the matter of calling next_line() that is
simple enough.

> @@ -758,30 +786,33 @@ static int find_trailer_start(struct strbuf **lines, int count)
>  	 * trailers, or (ii) contains at least one Git-generated trailer and
>  	 * consists of at least 25% trailers.
>  	 */
> -	for (start = count - 1; start >= end_of_title; start--) {
> +	for (l = last_line(buf, len); l >= title_end; l = last_line(buf, l)) {

The iteration is conceptually the same.  We used to iterate from the
last line in the input down to the first blank line that ends the
title paragraph.  We do the same but now we are byte-offset based,
so we start from last_line() of the entire buffer, and go back
one-line-at-a-time by calling last_line(buf, l).  OK.

> +		const char *bol = buf + l;
>  		const char **p;
>  		int separator_pos;
>  
> -		if (lines[start]->buf[0] == comment_line_char) {
> +		if (bol[0] == comment_line_char) {
>  			non_trailer_lines += possible_continuation_lines;
>  			possible_continuation_lines = 0;
>  			continue;
>  		}
> -		if (contains_only_spaces(lines[start]->buf)) {
> +		if (is_blank_line(bol)) {
>  			if (only_spaces)
>  				continue;
>  			non_trailer_lines += possible_continuation_lines;
>  			if (recognized_prefix &&
>  			    trailer_lines * 3 >= non_trailer_lines)
> -				return start + 1;
> -			if (trailer_lines && !non_trailer_lines)
> -				return start + 1;
> -			return count;
> +				ret = next_line(bol) - buf;

The original called the line we are looking at as "start"; the
corresponding byte-offset is "l", and "bol" is the pointer to the
beginning of the current line.  Returning next_line(bol)-buf is
equivalent to returning "start + 1" in the original.  OK.

> +			else if (trailer_lines && !non_trailer_lines)
> +				ret = next_line(bol) - buf;

Ditto.

> +			else
> +				ret = len;

Ditto.

> +			goto cleanup;

We are no longer "return"ing directly from this part of the code,
and instead saving the return value in "ret" and jumping there where
the real "return" is.  We need cleanup because we have an extra
allocation of separator + LF thing up above.

> ...

The changes to the remainder of this function shows that the
original lines[] were accessed read-only and it only used
lines[]->buf without lines[]->len, which is a strong indication that
an array of strbuf was an overkill.  

The rewrite looks to be a logical equivalent, which is good.

> @@ -817,88 +848,73 @@ static int find_trailer_start(struct strbuf **lines, int count)
> ...
> -/* Get the index of the end of the trailers */
> -static int find_trailer_end(struct strbuf **lines, int patch_start)
> +/* Return the position of the end of the trailers. */
> +static int find_trailer_end(const char *buf, size_t len)
>  {
> -	struct strbuf sb = STRBUF_INIT;
> -	int i, ignore_bytes;
> -
> -	for (i = 0; i < patch_start; i++)
> -		strbuf_addbuf(&sb, lines[i]);
> -	ignore_bytes = ignore_non_trailer(sb.buf, sb.len);
> -	strbuf_release(&sb);
> -	for (i = patch_start - 1; i >= 0 && ignore_bytes > 0; i--)
> -		ignore_bytes -= lines[i]->len;
> -
> -	return i + 1;

That indeed was grossly wasteful.  Things split into lines[] are
concatenated back only to call a single helper function that reports
a byte offset, and then lines[]->len is counted separately to find
the line that the byte offset falls in.  

> +	return len - ignore_non_trailer(buf, len);

Using the byte-offset based data structure throughout the code makes
it a lot simpler.  Good.

>  }
>  
> -static int has_blank_line_before(struct strbuf **lines, int start)
> +static int ends_with_blank_line(const char *buf, size_t len)
>  {
> -	for (;start >= 0; start--) {
> -		if (lines[start]->buf[0] == comment_line_char)
> -			continue;
> -		return contains_only_spaces(lines[start]->buf);
> -	}
> -	return 0;
> -}
> -
> -static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end)
> -{
> -	int i;
> -	for (i = start; lines[i] && i < end; i++)
> -		fprintf(outfile, "%s", lines[i]->buf);
> +	int ll = last_line(buf, len);
> +	if (ll < 0)
> +		return 0;
> +	return is_blank_line(buf + ll);
>  }

Two helpers "has-blank-line-before" and "print-lines" are gone.
Let's see how updated code does things without them.

>  static int process_input_file(FILE *outfile,
> -			      struct strbuf **lines,
> +			      const char *str,
>  			      struct list_head *head)
>  {
> -	int count = 0;
> -	int patch_start, trailer_start, trailer_end, i;
> +	int patch_start, trailer_start, trailer_end;
>  	struct strbuf tok = STRBUF_INIT;
>  	struct strbuf val = STRBUF_INIT;
>  	struct trailer_item *last = NULL;
> +	struct strbuf *trailer, **trailer_lines, **ptr;
>  
> -	/* Get the line count */
> -	while (lines[count])
> -		count++;
> -
> -	patch_start = find_patch_start(lines, count);
> -	trailer_end = find_trailer_end(lines, patch_start);
> -	trailer_start = find_trailer_start(lines, trailer_end);
> +	patch_start = find_patch_start(str);
> +	trailer_end = find_trailer_end(str, patch_start);
> +	trailer_start = find_trailer_start(str, trailer_end);
>  
>  	/* Print lines before the trailers as is */
> -	print_lines(outfile, lines, 0, trailer_start);
> +	fwrite(str, 1, trailer_start, outfile);

Ah, of course, if you don't split into an array of strbuf then you
do not need a helper that iterates over the array and prints.

> -	if (!has_blank_line_before(lines, trailer_start - 1))
> +	if (!ends_with_blank_line(str, trailer_start))
>  		fprintf(outfile, "\n");

Then if the part before the trailer doesn't end with a blank, we
force a blank.  

This is not a new issue, but this makes me wonder what happens when
there is no trailer to emit after this.  Do we end up with an extra
blank line?

>  	/* Parse trailer lines */
> -	for (i = trailer_start; i < trailer_end; i++) {
> +	trailer_lines = strbuf_split_buf(str + trailer_start, 
> +					 trailer_end - trailer_start,
> +					 '\n',
> +					 0);

We want each line NUL terminated while going over the trailer part
line-by-line so that it is easy to do _addf(&buf, "%s").  Use of
strbuf_split_buf() to split them into an array of strbufs is close
to the way the original did it, so that is why it is done here.

OK.  If we had a helper function that would split into an array of
"const char *"s, I suspect it would have worked equally well.  In
the loop, we only look at ->buf of the strbuf instances and do not
take advantage of the fact that the length of each line is known.
But that is better left as a further clean-up to the future.

Thanks.  This step looks like a regression-free rewrite.


