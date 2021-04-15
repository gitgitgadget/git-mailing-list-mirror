Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D1DC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE097610F7
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhDOV76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:59:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60138 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbhDOV75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 17:59:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A203DC82E7;
        Thu, 15 Apr 2021 17:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4JPiOaid+Zgyv/bF6qT4AK7VIMw=; b=wWjjo3
        1b3Uv9Y6H2bX26u0fyCkKEkN/QfWw9J8J5pqoZ7GWyBgrHfCVL4LU2WgRP1QgHN8
        Kjk6chBPVVQhSmkms17vrUwJCmhTgnywh2Y7oKqthUkawLW2AlpnRekgVo7rE+uG
        hkOgitRluxoekyZxdNUzROohHfgrzTYmZv2QU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gyFaQ7utgiHn/T0SB/DZnsjLWQ7U+AAd
        Cg+lLRMFSkEzP+W/YBeMojTww+JX6F3L3Z7gFMTkDOwW+Fx4Z25GSvwA3Hv474k9
        Zm8/6yFwL2aUbTOY7k059Ii/ajHKPGFHrbnHlwpvNTxcuOq0Q8qXQ8kt07Y7B6fT
        Snfbzhmizi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 993DEC82E6;
        Thu, 15 Apr 2021 17:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 129ADC82E5;
        Thu, 15 Apr 2021 17:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH v2] pkt-line: do not report packet write errors twice
References: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
        <d477a069eed1cfa10ebe68991caed6c2b0ebb43b.1618522570.git.matheus.bernardino@usp.br>
Date:   Thu, 15 Apr 2021 14:59:32 -0700
In-Reply-To: <d477a069eed1cfa10ebe68991caed6c2b0ebb43b.1618522570.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Thu, 15 Apr 2021 18:57:52 -0300")
Message-ID: <xmqqtuo7nr97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC458CE0-9E35-11EB-8AB3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> On write() errors, packet_write() dies with the same error message that
> is already printed by its callee, packet_write_gently(). This produces
> an unnecessarily verbose and repetitive output:
>
> error: packet write failed
> fatal: packet write failed: <strerror() message>
>
> In addition to that, packet_write_gently() does not always fulfill its
> caller expectation that errno will be properly set before a non-zero
> return. In particular, that is not the case for a "data exceeds max
> packet size" error. So, in this case, packet_write() will call
> die_errno() and print an strerror(errno) message that might be totally
> unrelated to the actual error.
>
> Fix both those issues by turning packet_write() and
> packet_write_gently() into wrappers to a common lower level function
> that doesn't print the error message, but instead returns it on a buffer
> for the caller to die() or error() as appropriate.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  pkt-line.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)

Nicely done.  Thanks, will queue.

>
> diff --git a/pkt-line.c b/pkt-line.c
> index 0194137528..98304ce374 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -194,13 +194,16 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
>  	return status;
>  }
>  
> -static int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +static int do_packet_write(const int fd_out, const char *buf, size_t size,
> +			   struct strbuf *err)
>  {
>  	char header[4];
>  	size_t packet_size;
>  
> -	if (size > LARGE_PACKET_DATA_MAX)
> -		return error(_("packet write failed - data exceeds max packet size"));
> +	if (size > LARGE_PACKET_DATA_MAX) {
> +		strbuf_addstr(err, _("packet write failed - data exceeds max packet size"));
> +		return -1;
> +	}
>  
>  	packet_trace(buf, size, 1);
>  	packet_size = size + 4;
> @@ -215,15 +218,29 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
>  	 */
>  
>  	if (write_in_full(fd_out, header, 4) < 0 ||
> -	    write_in_full(fd_out, buf, size) < 0)
> -		return error(_("packet write failed"));
> +	    write_in_full(fd_out, buf, size) < 0) {
> +		strbuf_addf(err, _("packet write failed: %s"), strerror(errno));
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +{
> +	struct strbuf err = STRBUF_INIT;
> +	if (do_packet_write(fd_out, buf, size, &err)) {
> +		error("%s", err.buf);
> +		strbuf_release(&err);
> +		return -1;
> +	}
>  	return 0;
>  }
>  
>  void packet_write(int fd_out, const char *buf, size_t size)
>  {
> -	if (packet_write_gently(fd_out, buf, size))
> -		die_errno(_("packet write failed"));
> +	struct strbuf err = STRBUF_INIT;
> +	if (do_packet_write(fd_out, buf, size, &err))
> +		die("%s", err.buf);
>  }
>  
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
