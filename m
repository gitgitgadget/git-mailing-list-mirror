Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD32C43217
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 23:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiBQXzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 18:55:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBQXzb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 18:55:31 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD050465
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 15:55:12 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98578111C1F;
        Thu, 17 Feb 2022 18:55:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oLjWMxiKmjwxgFxko7J+YVugX56A1U/tUhgfKa
        Fc9hs=; b=XLILwccKCWq1CcKptbM91Yf9ILKIcFzGVsOGc+8xQX+4qEzGQ7/amF
        NWTGl0BKlm0KlBNRpz7WwVkSlkbTRffJsRyu6P7oIqp4iJYosTVo9D65HUspmWcJ
        80AxH3FKYpRRjedNVqc3bcnPnIn8HgucrKZ+g3PHbb3sI64md5oD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EF89111C1D;
        Thu, 17 Feb 2022 18:55:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE206111C1A;
        Thu, 17 Feb 2022 18:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 4/7] reftable: avoid writing empty keys at the block
 layer
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <ba036ee8543b2dc28ac046eb0c8c0aef9e751c80.1645106124.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 15:55:09 -0800
In-Reply-To: <ba036ee8543b2dc28ac046eb0c8c0aef9e751c80.1645106124.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 17 Feb 2022
        13:55:21 +0000")
Message-ID: <xmqqee4159r6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AC608D8-904D-11EC-AF93-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -105,8 +106,14 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
>  	int is_restart = 0;
>  	struct strbuf key = STRBUF_INIT;
>  	int n = 0;
> +	int err = -1;
>  
>  	reftable_record_key(rec, &key);
> +	if (!key.len) {
> +		err = REFTABLE_API_ERROR;
> +		goto done;
> +	}

OK; we get an API_ERROR when trying to write a bad one.  And ...

> @@ -332,6 +334,9 @@ int block_iter_next(struct block_iter *it, struct reftable_record *rec)
>  	if (n < 0)
>  		return -1;
>  
> +	if (!key.len)
> +		return REFTABLE_FORMAT_ERROR;

... we get a FORMAT_ERROR when the data we try to read is bad
(i.e. not our fault).  OK.

> @@ -358,6 +363,8 @@ int block_reader_first_key(struct block_reader *br, struct strbuf *key)
>  	int n = reftable_decode_key(key, &extra, empty, in);
>  	if (n < 0)
>  		return n;
> +	if (!key->len)
> +		return -1;

It is curious that this gets a different error out of the same
sequence, i.e. decode-key did not return an error but the length of
the key happens to be 0, not FORMAT_ERROR.

> diff --git a/reftable/writer.c b/reftable/writer.c
> index 944c2329ab5..d54215a50dc 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -240,14 +240,13 @@ static int writer_add_record(struct reftable_writer *w,
>  
>  	writer_reinit_block_writer(w, reftable_record_type(rec));
>  	err = block_writer_add(w->block_writer, rec);
> -	if (err < 0) {
> +	if (err == -1) {
>  		/* we are writing into memory, so an error can only mean it
>  		 * doesn't fit. */
>  		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
>  		goto done;
>  	}
>  
> -	err = 0;

Is this "doesn't fit" related to "we catch 0-length keys", or an
unrelated fix was included in this step by "rebase -i" mistake?

