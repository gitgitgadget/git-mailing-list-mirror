Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D06CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 22:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjISWjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjISWjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 18:39:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B0EBA
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:39:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B62D719D1D8;
        Tue, 19 Sep 2023 18:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=uMzQ4omc8T0RKXzf8DiWs0uUsoJwSrubgDaEuv
        d6zp8=; b=q4SQxkYZkmHj0KCjtfK4m7h6Rd7p8j0vhaxfIXuetS5uNGrWRhveXN
        erStZSHJQXoxQNtJIHjQesPFMIglVE6vzlfk/atIwFxsEGvshaJEMSMNn6CkMA5F
        6VFRnu/yoslfgIYZM+0jVLKwD4d8+7ZGDN4NReokU/9KtdWj67rxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE6C819D1D7;
        Tue, 19 Sep 2023 18:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17D3319D1D6;
        Tue, 19 Sep 2023 18:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] pkt-line: do not chomp EOL for sideband progress info
In-Reply-To: <20230919071956.14015-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Tue, 19 Sep 2023 15:19:56 +0800")
References: <20230919071956.14015-1-worldhello.net@gmail.com>
Date:   Tue, 19 Sep 2023 15:38:55 -0700
Message-ID: <xmqqled1eqkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51BE97BA-573D-11EE-B766-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Who knows packet_reader interface well?  Jonathan?

Thanks.


> In the protocol negotiation stage, we need to turn on the flag
> "PACKET_READ_CHOMP_NEWLINE" to chomp EOL for each packet line from
> client or server. But when receiving data and progress information
> using sideband, we will turn off the flag "PACKET_READ_CHOMP_NEWLINE"
> to prevent mangling EOLs from data and progress information.
>
> When both the server and the client support "sideband-all" capability,
> we have a dilemma that EOLs in negotiation packets should be trimmed,
> but EOLs in progress infomation should be leaved as is.
>
> Move the logic of chomping EOLs from "packet_read_with_status()" to
> "packet_reader_read()" can resolve this dilemma.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  pkt-line.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index af83a19f4d..d6d08b6aa6 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -597,12 +597,18 @@ void packet_reader_init(struct packet_reader *reader, int fd,
>  enum packet_read_status packet_reader_read(struct packet_reader *reader)
>  {
>  	struct strbuf scratch = STRBUF_INIT;
> +	int options = reader->options;
>  
>  	if (reader->line_peeked) {
>  		reader->line_peeked = 0;
>  		return reader->status;
>  	}
>  
> +	/* Do not chomp newlines for sideband progress and error messages */
> +	if (reader->use_sideband && options & PACKET_READ_CHOMP_NEWLINE) {
> +		options &= ~PACKET_READ_CHOMP_NEWLINE;
> +	}
> +
>  	/*
>  	 * Consume all progress packets until a primary payload packet is
>  	 * received
> @@ -615,7 +621,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
>  							 reader->buffer,
>  							 reader->buffer_size,
>  							 &reader->pktlen,
> -							 reader->options);
> +							 options);
>  		if (!reader->use_sideband)
>  			break;
>  		if (demultiplex_sideband(reader->me, reader->status,
> @@ -624,12 +630,19 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
>  			break;
>  	}
>  
> -	if (reader->status == PACKET_READ_NORMAL)
> +	if (reader->status == PACKET_READ_NORMAL) {
>  		/* Skip the sideband designator if sideband is used */
>  		reader->line = reader->use_sideband ?
>  			reader->buffer + 1 : reader->buffer;
> -	else
> +
> +		if ((reader->options & PACKET_READ_CHOMP_NEWLINE) &&
> +		    reader->buffer[reader->pktlen - 1] == '\n') {
> +			reader->buffer[reader->pktlen - 1] = 0;
> +			reader->pktlen--;
> +		}
> +	} else {
>  		reader->line = NULL;
> +	}
>  
>  	return reader->status;
>  }
