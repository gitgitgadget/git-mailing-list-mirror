Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77D82021E
	for <e@80x24.org>; Mon, 31 Oct 2016 22:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947746AbcJaWxs (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 18:53:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59827 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S947743AbcJaWxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 18:53:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DAF44B553;
        Mon, 31 Oct 2016 18:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t+yy8jZhJQWc+fjC/KmLJxCcyjA=; b=UgYTd4
        KsxjuKGj0UvESIuBpV70sDncbbt81UzMQvy6s1cx+IgD/zQm49tjgcj/ffCgob48
        tLjBqJyC0OcQkc9SZ3xA5D0+NIpcCx0rLQROog0o8LckIFkK+fCUeZOjrZt92tIK
        eMq9B4tSgyE+cAiYTb8smJ17/2qUtj8q1BVcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B/ZZRhIWElchTFEazssj6+MNLgH+Szk5
        NaSi60lXDkgVGr7UwEwOrzJEL5ZOq/2S6dJQVYjO8l3oMHkV6c3TcBIldlnGrBMR
        IMpH7XTqmh0qxwRh/XQDKZs7WPvTbiGm9R1EDGmnQd/u4mqEiMPtyfpWIxqtQ1ic
        qSD+Go6Ypjk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 648784B552;
        Mon, 31 Oct 2016 18:53:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0D6A4B546;
        Mon, 31 Oct 2016 18:53:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] trailer: have function to describe trailer layout
References: <cover.1477698917.git.jonathantanmy@google.com>
        <cover.1477698917.git.jonathantanmy@google.com>
        <d55ff281b88624cdbf5c21a56d817d8d17eff5c0.1477698917.git.jonathantanmy@google.com>
Date:   Mon, 31 Oct 2016 15:53:34 -0700
In-Reply-To: <d55ff281b88624cdbf5c21a56d817d8d17eff5c0.1477698917.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 28 Oct 2016 17:05:10 -0700")
Message-ID: <xmqqr36wqgep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAE8A19C-9FBC-11E6-9981-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  static char *separators = ":";
>  
> +static int configured = 0;

Avoid initializing a static to 0 or NULL; instead let .bss take care
of it.

>  static const char *token_from_item(struct arg_item *item, char *tok)
>  {
>  	if (item->conf.key)
> @@ -872,59 +885,43 @@ static int process_input_file(FILE *outfile,
>  			      const char *str,
>  			      struct list_head *head)
>  {
> -	int patch_start, trailer_start, trailer_end;
> +	struct trailer_info info;
>  	struct strbuf tok = STRBUF_INIT;
>  	struct strbuf val = STRBUF_INIT;
> -	struct trailer_item *last = NULL;
> -	struct strbuf *trailer, **trailer_lines, **ptr;
> +	int i;
>  
> -	patch_start = find_patch_start(str);
> -	trailer_end = find_trailer_end(str, patch_start);
> -	trailer_start = find_trailer_start(str, trailer_end);
> +	trailer_info_get(&info, str);

OK, it needs a reading of trailer_info_get() first to understand the
remainder of this function.  The function would grab these fields
into info, among doing other things.

>  	/* Print lines before the trailers as is */
> -	fwrite(str, 1, trailer_start, outfile);
> +	fwrite(str, 1, info.trailer_start - str, outfile);
>  
> -	if (!ends_with_blank_line(str, trailer_start))
> +	if (!info.blank_line_before_trailer)
>  		fprintf(outfile, "\n");

... and one of the "other things" include setting the
->blank_line_before_trailer field.  

> -	/* Parse trailer lines */
> -	trailer_lines = strbuf_split_buf(str + trailer_start, 
> -					 trailer_end - trailer_start,
> -					 '\n',
> -					 0);
> -	for (ptr = trailer_lines; *ptr; ptr++) {
> +	for (i = 0; i < info.trailer_nr; i++) {
>  		int separator_pos;
> -		trailer = *ptr;
> -		if (trailer->buf[0] == comment_line_char)
> +		char *trailer = info.trailers[i];
> +		if (trailer[0] == comment_line_char)
>  			continue;

And info.trailers[] is no longer an array of strbuf; it is an array
of "char *", which I alluded to during my review of [2/4].  Looking
good.

> -		if (last && isspace(trailer->buf[0])) {
> -			struct strbuf sb = STRBUF_INIT;
> -			strbuf_addf(&sb, "%s\n%s", last->value, trailer->buf);
> -			strbuf_strip_suffix(&sb, "\n");
> -			free(last->value);
> -			last->value = strbuf_detach(&sb, NULL);
> -			continue;
> -		}
> -		separator_pos = find_separator(trailer->buf, separators);
> +		separator_pos = find_separator(trailer, separators);

... presumably, the line-folding is already handled in
trailer_info_get(), so we do not need the "last" handling.

>  		if (separator_pos >= 1) {

... and it it is a "mail-header: looking" one, then add it one way.

> -			parse_trailer(&tok, &val, NULL, trailer->buf,
> -				      separator_pos);
> -			last = add_trailer_item(head,
> -						strbuf_detach(&tok, NULL),
> -						strbuf_detach(&val, NULL));
> +			parse_trailer(&tok, &val, NULL, trailer,
> +			              separator_pos);
> +			add_trailer_item(head,
> +					 strbuf_detach(&tok, NULL),
> +					 strbuf_detach(&val, NULL));
>  		} else {
> -			strbuf_addbuf(&val, trailer);
> +			strbuf_addstr(&val, trailer);

... otherwise add it another way.

>  			strbuf_strip_suffix(&val, "\n");
>  			add_trailer_item(head,
>  					 NULL,
>  					 strbuf_detach(&val, NULL));
> -			last = NULL;
>  		}
>  	}
> -	strbuf_list_free(trailer_lines);
>  
> -	return trailer_end;
> +	trailer_info_release(&info);
> +
> +	return info.trailer_end - str;
>  }

Nicely done.

> @@ -1004,3 +999,54 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
>  
>  	strbuf_release(&sb);
>  }
> +
> +void trailer_info_get(struct trailer_info *info, const char *str)
> +{
> +	int patch_start, trailer_end, trailer_start;
> +	struct strbuf **trailer_lines, **ptr;
> +	char **trailer_strings = NULL;
> +	size_t nr = 0, alloc = 0;
> +	char **last = NULL;
> +
> +	ensure_configured();
> +
> +	patch_start = find_patch_start(str);
> +	trailer_end = find_trailer_end(str, patch_start);
> +	trailer_start = find_trailer_start(str, trailer_end);
> +
> +	trailer_lines = strbuf_split_buf(str + trailer_start,
> +					 trailer_end - trailer_start,
> +					 '\n',
> +					 0);
> +	for (ptr = trailer_lines; *ptr; ptr++) {
> +		if (last && isspace((*ptr)->buf[0])) {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
> +			strbuf_addbuf(&sb, *ptr);
> +			*last = strbuf_detach(&sb, NULL);
> +			continue;
> +		}
> +		ALLOC_GROW(trailer_strings, nr + 1, alloc);
> +		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
> +		last = find_separator(trailer_strings[nr], separators) >= 1
> +			? &trailer_strings[nr]
> +			: NULL;
> +		nr++;
> +	}
> +	strbuf_list_free(trailer_lines);
> +
> +	info->blank_line_before_trailer = ends_with_blank_line(str,
> +							       trailer_start);
> +	info->trailer_start = str + trailer_start;
> +	info->trailer_end = str + trailer_end;
> +	info->trailers = trailer_strings;
> +	info->trailer_nr = nr;
> +}

OK, looking good.

