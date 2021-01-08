Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F3AC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 23:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A720786
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 23:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbhAHXlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 18:41:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52267 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAHXlI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 18:41:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DEBE10CC66;
        Fri,  8 Jan 2021 18:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vx80te1Bk/e5o5jYTV1ZB58O9ak=; b=bWjRkK
        8ltiNkogbQYlVju7N7tGV4naG65o9OV5141EkcBAy/zLCv5sMEGl08e7UfaCrW+p
        QaPmTHjcRJGPzqbqbkVeszuv5vcHELRTSnhgAcmn+eIEDdu70dqF597Ug59qn/3W
        RnutJ6hLPjPmKe8Mi9/ps8wxeeKKyyg6walR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PCMJc4xd1rj3d5Y2XPCLCnZqJ4YOSewu
        pPNwCvyrvw5A8I/3fRfKPay5O+HWAEPPqJIvSnqtwz7tPmt7BcP3Wuqia7G4hko6
        uG8xPb2B0ndM1V1v35n8l//cEPPF2Sxa7r6CZuCXZtVPpLNA8GxKYry40m3fpwBb
        VQs40LYz1Ak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1709410CC65;
        Fri,  8 Jan 2021 18:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 185E310CC64;
        Fri,  8 Jan 2021 18:40:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/4] fetch: extract writing to FETCH_HEAD
References: <cover.1610027375.git.ps@pks.im> <cover.1610107599.git.ps@pks.im>
        <d80dbc5a9c9520621651541e418ee5216d164053.1610107599.git.ps@pks.im>
Date:   Fri, 08 Jan 2021 15:40:17 -0800
In-Reply-To: <d80dbc5a9c9520621651541e418ee5216d164053.1610107599.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 8 Jan 2021 13:11:14 +0100")
Message-ID: <xmqqmtxjgfq6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDE95C24-520A-11EB-9265-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +static int open_fetch_head(struct fetch_head *fetch_head)
> +{
> +	const char *filename = git_path_fetch_head(the_repository);
> +
> +	if (!write_fetch_head)
> +		return 0;
> +
> +	fetch_head->fp = fopen(filename, "a");
> +	if (!fetch_head->fp)
> +		return error_errno(_("cannot open %s"), filename);
> +
> +	return 0;
> +}

So the difference from the original, which used to have a writable
filehandle to /dev/null in the dry-run mode, is that fetch_head->fp
is left as-is (not even NULLed out).

> +static void append_fetch_head(struct fetch_head *fetch_head, const char *old_oid,

It is clear from the type these days but variable names like
"old_oid" hint the readers that they are not a hexadecimal object
name string but either an array of uchar[40] or a struct object_id;
perhaps "old_oid_hex" would be less misleading.

If the caller does have struct object_id, then it would be even
better to take it as-is as a parameter and use oid_to_hex_r() on it in
this function when it is given to fprintf().  [Nit #1]

> +			      const char *merge_status_marker, const char *note,
> +			      const char *url, size_t url_len)
> +{
> +	size_t i;
> +
> +	if (!write_fetch_head)
> +		return;

Presumably, this check is what makes sure that fetch_head->fp that
is left uninitialized will never gets used.

> +	fprintf(fetch_head->fp, "%s\t%s\t%s",
> +		old_oid, merge_status_marker, note);
> +	for (i = 0; i < url_len; ++i)
> +		if ('\n' == url[i])
> +			fputs("\\n", fetch_head->fp);
> +		else
> +			fputc(url[i], fetch_head->fp);
> +	fputc('\n', fetch_head->fp);
> +}

OK.  This is the "case FETCH_HEAD_NOT_FOR_MERGE" and "case
FETCH_HEAD_MERGE" parts in the original.

As an abstraction, it may be better to make the caller pass a
boolean "is this for merge?" and keep the knowledge of what exact
string is used for merge_status_marker to this function, instead of
letting the caller passing it as a parameter in the string form.
After all, we never allow anything other than an empty string or a
fixed "not-for-merge" string in that place in the file format.
[Nit #2]

> +static void commit_fetch_head(struct fetch_head *fetch_head)
> +{
> +	/* Nothing to commit yet. */
> +}
> +
> +static void close_fetch_head(struct fetch_head *fetch_head)
> +{
> +	if (!write_fetch_head)
> +		return;

So is this check a protection against uninitialized fetch_head->fp.
Both changes make sense.

> +	fclose(fetch_head->fp);
> +}

> @@ -909,22 +959,19 @@ N_("It took %.2f seconds to check forced updates. You can use\n"
>  static int store_updated_refs(const char *raw_url, const char *remote_name,
>  			      int connectivity_checked, struct ref *ref_map)
>  {
> -	FILE *fp;
> +	struct fetch_head fetch_head;

And that is why this variable is left uninitialised on stack and it
is OK.  An alternative design would be to initialize fetch_head.fp
to NULL, and return early with "if (!fetch_head->fp)" in the two
functions that take fetch_head struct.  That way, we have less
reliance on the global variable write_fetch_head.

>  	struct commit *commit;
>  	int url_len, i, rc = 0;
>  	struct strbuf note = STRBUF_INIT;
>  	const char *what, *kind;
>  	struct ref *rm;
>  	char *url;
> -	const char *filename = (!write_fetch_head
> -				? "/dev/null"
> -				: git_path_fetch_head(the_repository));
>  	int want_status;
>  	int summary_width = transport_summary_width(ref_map);
>  
> -	fp = fopen(filename, "a");
> -	if (!fp)
> -		return error_errno(_("cannot open %s"), filename);
> +	rc = open_fetch_head(&fetch_head);
> +	if (rc)
> +		return -1;

OK, we've already said "cannot open" in the open_fetch_head()
function, so we just return an error silently.

> @@ -1016,16 +1063,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				merge_status_marker = "not-for-merge";
>  				/* fall-through */
>  			case FETCH_HEAD_MERGE:
> -				fprintf(fp, "%s\t%s\t%s",
> -					oid_to_hex(&rm->old_oid),
> -					merge_status_marker,
> -					note.buf);
> -				for (i = 0; i < url_len; ++i)
> -					if ('\n' == url[i])
> -						fputs("\\n", fp);
> -					else
> -						fputc(url[i], fp);
> -				fputc('\n', fp);
> +				append_fetch_head(&fetch_head,
> +						  oid_to_hex(&rm->old_oid),
> +						  merge_status_marker,
> +						  note.buf, url, url_len);

Here, we can lose merge_status_marker variable from this caller, and
then this caller becomes:

		switch (rm->fetch_head_status) {
		case FETCH_HEAD_NOT_FOR_MERGE:
		case FETCH_HEAD_MERGE:
			append_fetch_head(&fetch_head, &rm->old_oid,
				rm->fetch_head_status == FETCH_HEAD_MERGE,
                                note.buf, url, url_len);

Note that I am passing "is this a ref to be merged?" boolean to keep
the exact string of "not-for-merge" in the callee.

> @@ -1060,6 +1101,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		}
>  	}
>  
> +	if (!rc)
> +		commit_fetch_head(&fetch_head);
> +
>  	if (rc & STORE_REF_ERROR_DF_CONFLICT)
>  		error(_("some local refs could not be updated; try running\n"
>  		      " 'git remote prune %s' to remove any old, conflicting "
> @@ -1077,7 +1121,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>   abort:
>  	strbuf_release(&note);
>  	free(url);
> -	fclose(fp);
> +	close_fetch_head(&fetch_head);
>  	return rc;
>  }

Other than the above two nits, this step looks good to me.

Thanks.
