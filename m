Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F76C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiEPQKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiEPQKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 12:10:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705E26E3
        for <git@vger.kernel.org>; Mon, 16 May 2022 09:10:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04B3212D32B;
        Mon, 16 May 2022 12:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wv5B/ErL8nStEJMnAFSwV11RiJu/8ciwck+vTy
        2euFI=; b=xlQbcZe7ck+feolO2LytvaFo/mM1SVuTAuG3NgyIQQV5JH91uAueoR
        8fG3TPnNhYYLxVtcwFx/6H8UHj8KiKyKuP9IdIozr1qzRe73xkwf8XLuPBmZjYuk
        8Ey+smzwtVUz/F0zmx8QFDVLczvdWWucx2ScUzKNu5IEULgTeLLco=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE7C512D32A;
        Mon, 16 May 2022 12:10:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5555112D329;
        Mon, 16 May 2022 12:10:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: make unexpected peek result non-fatal
References: <20220516110221.3490982-1-jonathantanmy@google.com>
Date:   Mon, 16 May 2022 09:10:40 -0700
In-Reply-To: <20220516110221.3490982-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 16 May 2022 04:02:20 -0700")
Message-ID: <xmqqr14t4fwf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB92D068-D532-11EC-B9B9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When a Git server responds to a fetch request, it may send optional
> sections before the packfile section. To handle this, the Git client
> calls packet_reader_peek() (see process_section_header()) in order to
> see what's next without consuming the line.
>
> However, as implemented, Git errors out whenever what's peeked is not an
> ordinary line. This is not only unexpected (here, we only need to know
> whether the upcoming line is the section header we want) but causes
> errors to include the name of a section header that is irrelevant to the
> cause of the error. For example, at $DAYJOB, we have seen "fatal: error
> reading section header 'shallow-info'" error messages when none of the
> repositories involved are shallow.
>
> Therefore, fix this so that the peek returns 1 if the upcoming line is
> the wanted section header and nothing else. Because of this change,
> reader->line may now be NULL later in the function, so update the error
> message printing code accordingly.

[not a suggestion to change anything; just making sure I got the
above correct]

We used to die unless READ_NORMAL was returned, so the code after
packet_reader_peek() can rely on reader->line to be populated.  Now
that code must handle cases where an earlier _peek() gave something
other than READ_NORMAL and in such an error case reader->line points
at NULL.  So any code that assumed reader->line was populated needs
to be updated.

Makes sense.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 4e1e88eea0..6d0d271259 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1370,17 +1370,20 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  static int process_section_header(struct packet_reader *reader,
>  				  const char *section, int peek)
>  {
> -	int ret;
> -
> -	if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
> -		die(_("error reading section header '%s'"), section);
> +	int ret = 0;
>  
> -	ret = !strcmp(reader->line, section);
> +	if (packet_reader_peek(reader) == PACKET_READ_NORMAL &&
> +	    !strcmp(reader->line, section))
> +		ret = 1;
>  
>  	if (!peek) {
> -		if (!ret)
> -			die(_("expected '%s', received '%s'"),
> -			    section, reader->line);
> +		if (!ret) {
> +			if (reader->line)
> +				die(_("expected '%s', received '%s'"),
> +				    section, reader->line);
> +			else
> +				die(_("expected '%s'"), section);
> +		}
>  		packet_reader_read(reader);
>  	}
