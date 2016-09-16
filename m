Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFAA207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764885AbcIPTM4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 15:12:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1764214AbcIPTMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 15:12:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7ECD3FECF;
        Fri, 16 Sep 2016 15:12:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S2Dfp824N05JaPGjlhHUASFF3/U=; b=v5tO1k
        9wuabbKveeuhzIVX1Rn5jhxRLjpnnbx+IGT6uN7bjC9O2HP1zmQSfIusPqKiGl2p
        ZYZvtLtxdPMuWy6qDUPBKxFu5TWBAbVxsfaowJmLSxjwTh4ZXl++bGb4/5RxeeQz
        IFsfWouZLoDKnEW6RUVP3HtT/wIumrVjA/7Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xKI7BoW9lV3neteX3KglcpTwnCx61Kqb
        JBEjfyRqGAHPnSltuIYf0xqKVXvZm+47C8LYrBHghs6z0RvAEtzdB2zX83M8z8e6
        x2I/Dg9QN4K/7zeQJ30JMDh3qLW+r3tMjk0CIipXeYNrTogFIsF/rrwyb++tjGCG
        jCar4UWJVCc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DED9B3FECE;
        Fri, 16 Sep 2016 15:12:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CA893FECD;
        Fri, 16 Sep 2016 15:12:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/PATCH 1/3] mailinfo: refactor commit message processing
References: <cover.1474047135.git.jonathantanmy@google.com>
        <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
        <cover.1474047135.git.jonathantanmy@google.com>
        <7dbb4bc0659056211b27f0033c73f0d558efdb54.1474047135.git.jonathantanmy@google.com>
Date:   Fri, 16 Sep 2016 12:12:50 -0700
In-Reply-To: <7dbb4bc0659056211b27f0033c73f0d558efdb54.1474047135.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 16 Sep 2016 10:37:22 -0700")
Message-ID: <xmqqoa3nk6a5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90A1965A-7C41-11E6-AD0D-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Within the processing of the commit message, check for a scissors line
> or a patchbreak line first (before checking for in-body headers) so that
> a subsequent patch modifying the processing of in-body headers would not
> cause a scissors line or patchbreak line to be misidentified.
>
> If a line could be both an in-body header and a scissors line (for
> example, "From: -- >8 --"), this is considered a fatal error
> (previously, it would be interpreted as an in-body header).

The scissors line is designed to allow garbage other than scissors
and perforation marks to be on the same line, i.e.

        /*
         * The mark must be at least 8 bytes long (e.g. "-- >8 --").
         * Even though there can be arbitrary cruft on the same line
         * (e.g. "cut here"), in order to avoid misidentification, the
         * perforation must occupy more than a third of the visible
         * width of the line, and dashes and scissors must occupy more
         * than half of the perforation.
         */

Even though it is not likely for people to do so, it would probably
be nicer if we can treat

	From: -- >8 -- cut -- >8 -- >8 -- here -- >8 --

as a scissors line instead of making it a fatal error, by treating
that "From:" as just a random garbage.

But this is a minor point.  It is not worth to make it work like so
if the resulting code will become messier.

> The following enumeration shows that processing is the same except (as
> described above) the in-body header + scissors line case.
>
> o in-body header (check_header OK)
>   o passes UTF-8 conversion
>     o [described above] is scissors line
>     o [not possible] is patchbreak line
>     o [not possible] is blank line
>     o is none of the above - processed as header
>   o fails UTF-8 conversion - processed as header
> o not in-body header
>   o passes UTF-8 conversion
>     o is scissors line - processed as scissors
>     o is patchbreak line - processed as patchbreak
>     o is blank line - ignored if in header_stage
>     o is none of the above - log message
>   o fails UTF-8 conversion - input error
>
> As for the result left in "line" (after the invocation of
> handle_commit_msg), it is unused (by its caller, handle_filter, and by
> handle_filter's callers, handle_boundary and handle_body) unless this
> line is a patchbreak line, in which case handle_patch is subsequently
> called (in handle_filter) on "line". In this case, "line" must have
> passed UTF-8 conversion both before and after this patch, so the result
> is still the same overall.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  mailinfo.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 115 insertions(+), 30 deletions(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index e19abe3..23a56c2 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -340,23 +340,56 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
>  	return out;
>  }
>  
> -static int convert_to_utf8(struct mailinfo *mi,
> -			   struct strbuf *line, const char *charset)
> +/*
> + * Attempts to convert line into UTF-8, storing the result in line.
> + *
> + * This differs from convert_to_utf8 in that conversion non-success is not
> + * considered an error case - mi->input_error is not set, and no error message
> + * is printed.
> + *
> + * If the conversion is unnecessary, returns 0 and stores NULL in old_buf (if
> + * old_buf is not NULL).
> + *
> + * If the conversion is successful, returns 0 and stores the unconverted string
> + * in old_buf and old_len (if they are respectively not NULL).
> + *
> + * If the conversion is unsuccessful, returns -1.
> + */
> +static int try_convert_to_utf8(const struct mailinfo *mi, struct strbuf *line,
> +			       const char *charset, char **old_buf,
> +			       size_t *old_len)
>  {
> -	char *out;
> +	char *utf8;
>  
> -	if (!mi->metainfo_charset || !charset || !*charset)
> +	if (!mi->metainfo_charset || !charset || !*charset ||
> +	    same_encoding(mi->metainfo_charset, charset)) {
> +		if (old_buf)
> +			*old_buf = NULL;
>  		return 0;
> +	}
>  
> -	if (same_encoding(mi->metainfo_charset, charset))
> +	utf8 = reencode_string(line->buf, mi->metainfo_charset, charset);
> +	if (utf8) {
> +		char *temp = strbuf_detach(line, old_len);
> +		if (old_buf)
> +			*old_buf = temp;
> +		strbuf_attach(line, utf8, strlen(utf8), strlen(utf8));
>  		return 0;
> -	out = reencode_string(line->buf, mi->metainfo_charset, charset);
> -	if (!out) {
> +	}
> +	return -1;
> +}
> +
> +/*
> + * Converts line into UTF-8, setting mi->input_error to -1 upon failure.
> + */
> +static int convert_to_utf8(struct mailinfo *mi,
> +			   struct strbuf *line, const char *charset)
> +{
> +	if (try_convert_to_utf8(mi, line, charset, NULL, NULL)) {
>  		mi->input_error = -1;
>  		return error("cannot convert from %s to %s",
>  			     charset, mi->metainfo_charset);
>  	}
> -	strbuf_attach(line, out, strlen(out), strlen(out));
>  	return 0;
>  }

Please split this part into its own patch.  IIUC, it moves the meat
of convert_to_utf8() to a more silent try_convert_to_utf8() and then
makes the former a thin wrapper of the latter.  Which by itself is a
good change but does not have anything to do with "fix handling of
the in-body headers", other than that the main fix wants to have
such a more silent helper for its own use.


> @@ -515,6 +548,13 @@ static int check_header(struct mailinfo *mi,
>  	return ret;
>  }
>  
> +static int check_header_raw(struct mailinfo *mi,
> +			    char *buf, size_t len,
> +			    struct strbuf *hdr_data[], int overwrite) {
> +	const struct strbuf sb = {0, len, buf};
> +	return check_header(mi, &sb, hdr_data, overwrite);
> +}

IIUC, this is a helper for callers that do not have a strbuf but
instead have <buf, len> pair to perform the same check_header() the
callers that have strbuf can do.

As check_header() uses the strbuf as a read-only entity, wrapping
the <buf, len> pair in a temporary strbuf like this is safe.

The incoming <buf> should conceptually be "const char *", but it's
OK.

If check_header() didn't call any helper function that gets passed
&sb as a strbuf, or if convertiong the helper function to take a
<buf, len> pair instead, I would actually suggest refactoring this
the other way around, though.  That is, move the implementation of
check_header() to this function, updating its reference to line->buf
and line->len to reference to <buf> and <len>, and then make
check_header() a thin wrapper that does

        check_header(mi, const struct strbuf *line,
                     struct strbuf *hdr_data[], int overwrite)
        {
                return check_header_raw(mi, line->buf, line->len,
                                        hdr_data, overwrite);
        }

I didn't check how involved to update cmp_header() to take <buf,len>
pair.  If it does not look too bad, then I think I would prefer to
do it that way, and as before, make that conversion a separate
preparatory patch.

> @@ -623,32 +663,48 @@ static int is_scissors_line(const struct strbuf *line)
>  		gap * 2 < perforation);
>  }
>  
> -static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
> +static int resembles_rfc2822_header(const struct strbuf *line)
>  {
> -	assert(!mi->filter_stage);
> +	char *c;
>  
> -	if (mi->header_stage) {
> -		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
> +	if (!isalpha(line->buf[0]))
> +		return 0;
> +
> +	for (c = line->buf + 1; *c != 0; c++) {
> +		if (*c == ':')
> +			return 1;
> +		else if (*c != '-' && !isalpha(*c))
>  			return 0;
>  	}
> +	return 0;
> +}

Is this helper supposed to handle any rfc2822 looking header, or
only the ones we expect to see as in-body header?


> -	if (mi->use_inbody_headers && mi->header_stage) {
> -		mi->header_stage = check_header(mi, line, mi->s_hdr_data, 0);
> -		if (mi->header_stage)
> -			return 0;
> -	} else
> -		/* Only trim the first (blank) line of the commit message
> -		 * when ignoring in-body headers.
> -		 */
> -		mi->header_stage = 0;
> +static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
> +{
> +	int ret = 0;
> +	int utf8_result;
> +	char *old_buf;
> +	size_t old_len;
> +
> +	assert(!mi->filter_stage);
>  
> -	/* normalize the log message to UTF-8. */
> -	if (convert_to_utf8(mi, line, mi->charset.buf))
> -		return 0; /* mi->input_error already set */
> +	/*
> +	 * Obtain UTF8 for scissors line and patchbreak checks, but retain the
> +	 * undecoded line in case we need to process it as an in-body header.
> +	 */
> +	utf8_result = try_convert_to_utf8(mi, line, mi->charset.buf, &old_buf,
> +					  &old_len);

Just a minor style suggestion.  As <old_buf, old_len> come in a
pair, fold the line before them, so that the readers can easily
see the association between them.  I.e.

        utf8_result = try_convert_to_utf8(mi, line, mi->charset.buf,
                                          &old_buf, &old_len);


> -	if (mi->use_scissors && is_scissors_line(line)) {
> +	if (!utf8_result && mi->use_scissors && is_scissors_line(line)) {
>  		int i;
>  
> +		if (resembles_rfc2822_header(line))
> +			/*
> +			 * Explicitly reject scissor lines that resemble a RFC
> +			 * 2822 header, to avoid being prone to error.
> +			 */
> +			die("scissors line resembles RFC 2822 header");
> +

I guess "disambiguate to favor scissors" is not that difficult ;-)

>  		strbuf_setlen(&mi->log_message, 0);
>  		mi->header_stage = 1;
>  
> @@ -661,18 +717,47 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>  				strbuf_release(mi->s_hdr_data[i]);
>  			mi->s_hdr_data[i] = NULL;
>  		}
> -		return 0;
> +		goto handle_commit_msg_out;
>  	}
> -
> -	if (patchbreak(line)) {
> +	if (!utf8_result && patchbreak(line)) {
>  		if (mi->message_id)
>  			strbuf_addf(&mi->log_message,
>  				    "Message-Id: %s\n", mi->message_id);
> -		return 1;
> +		ret = 1;
> +		goto handle_commit_msg_out;
>  	}
>  
> +	if (mi->header_stage) {
> +		char *buf = old_buf ? old_buf : line->buf;
> +		if (buf[0] == 0 || (buf[0] == '\n' && buf[1] == 0))
> +			goto handle_commit_msg_out;
> +	}
> +
> +	if (mi->use_inbody_headers && mi->header_stage) {
> +		char *buf = old_buf ? old_buf : line->buf;
> +		size_t len = old_buf ? old_len : line->len;
> +		mi->header_stage = check_header_raw(mi, buf, len,
> +						    mi->s_hdr_data, 0);

Just a minor comment, but I guess check_header_raw() refactoring is
not strictly needed after all, as this callsite can wrap <buf,len>
into a temporary strbuf.

Unlike the real header that is read in read_one_header_line() inside
a loop to implement line folding before check_header() is called, we
call check_header() before possibly-foldable header lines is fully
assembled into one header.  Probably it comes in later patches, I
guess.

It is not immediately obvious to me how this step helps further work
done by later patches in the series until I read them, but so far
what this patch did looks understandable to me ;-)

Thanks.


> +		if (mi->header_stage)
> +			goto handle_commit_msg_out;
> +	} else
> +		/* Only trim the first (blank) line of the commit message
> +		 * when ignoring in-body headers.
> +		 */
> +		mi->header_stage = 0;
> +
> +	/* If adding as a log message, conversion to UTF-8 is required. */
> +	if (utf8_result) {
> +		mi->input_error = -1;
> +		error("cannot convert from %s to %s",
> +		      mi->charset.buf, mi->metainfo_charset);
> +		goto handle_commit_msg_out;
> +	}
>  	strbuf_addbuf(&mi->log_message, line);
> -	return 0;
> +
> +handle_commit_msg_out:
> +	free(old_buf);
> +	return ret;
>  }
>  
>  static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
