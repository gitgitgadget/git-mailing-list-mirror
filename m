Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7879C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 04:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20DE61362
	for <git@archiver.kernel.org>; Mon,  3 May 2021 04:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhECElz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 00:41:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55117 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhECEly (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 00:41:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BC17BB101;
        Mon,  3 May 2021 00:41:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CK+jen9rPP1GDUkGrktgqHGySul0x6CaCWRyd1
        dzfEA=; b=GnD/ZMYN6K/A/wxqYJ9AjcfcYFtBfwYipUXwusA4PO9gNGxQ5GiOaO
        0gNRD0K9U9+stDxKpJTW3hHbz9C6honngO2nL3VtOK99b+IYGj51l9HIk9kH+7Xw
        XxUrP/cYtUWJ7TELVMAMDeGG2SZYsjEBVqEoLJSCGy2KQoYYHKAsI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 833FDBB100;
        Mon,  3 May 2021 00:41:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D93BCBB0FE;
        Mon,  3 May 2021 00:41:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v4 4/5] fast-export: do not modify memory from
 get_commit_buffer
References: <20210423164118.693197-1-lukeshu@lukeshu.com>
        <20210430232537.1131641-1-lukeshu@lukeshu.com>
        <20210430232537.1131641-5-lukeshu@lukeshu.com>
Date:   Mon, 03 May 2021 13:41:00 +0900
In-Reply-To: <20210430232537.1131641-5-lukeshu@lukeshu.com> (Luke Shumaker's
        message of "Fri, 30 Apr 2021 17:25:36 -0600")
Message-ID: <xmqqa6pca0pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2C109CE-ABC9-11EB-BDB5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

> +static char *reencode_message(const char *in_msg,
> +			      const char *in_encoding, size_t in_encoding_len)
> +{
> +	static struct strbuf in_encoding_buf = STRBUF_INIT;
> +
> +	strbuf_reset(&in_encoding_buf);
> +	strbuf_add(&in_encoding_buf, in_encoding, in_encoding_len);
> +
> +	return reencode_string(in_msg, "UTF-8", in_encoding_buf.buf);
> +}

There is only a single caller of this, so making it caller's
responsibility to do the strbuf thing would allow us to make this
thread-safe quite easily (and at that point we might not even have
this helper function).

> +	committer = strstr(commit_buffer_cursor, "\ncommitter ");
>  	if (!committer)
>  		die("could not find committer in commit %s",
>  		    oid_to_hex(&commit->object.oid));
>  	committer++;
> -	committer_end = strchrnul(committer, '\n');
> -	message = strstr(committer_end, "\n\n");
> -	encoding = find_encoding(committer_end, message);
> +	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
> +
> +	/* find_commit_header() gets a `+ 1` because
> +	 * commit_buffer_cursor points at the trailing "\n" at the end
> +	 * of the previous line, but find_commit_header() wants a
> +	 * pointer to the beginning of the next line. */
> +	encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);

	/*
	 * Our multi-line comments have opening and closing
	 * slash-asterisk and asterisk-slash on their own
	 * lines.
	 */

What if strchrnul() returned a pointer to the terminating NUL
instead of the LF at the end of the line?  +1 will run past the end
of the buffer.

> +	if (encoding)
> +		commit_buffer_cursor = encoding + encoding_len;
> +
> +	message = strstr(commit_buffer_cursor, "\n\n");

Good.

> @@ -685,14 +693,15 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  	} else if (encoding) {
>  		switch(reencode_mode) {
>  		case REENCODE_YES:
> -			reencoded = reencode_string(message, "UTF-8", encoding);
> +			reencoded = reencode_message(message, encoding, encoding_len);
>  			break;

Here is where we can do the temporary strbuf to hold encoding[0,
encoding_len] and directly call reencode_string().

Other than that, this step looks good to me.

Thanks.
