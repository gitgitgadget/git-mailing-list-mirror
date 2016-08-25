Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196441F859
	for <e@80x24.org>; Thu, 25 Aug 2016 21:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbcHYVuQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 17:50:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59072 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754447AbcHYVuP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 17:50:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDC123774B;
        Thu, 25 Aug 2016 17:50:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r5ydNtWW6HKhy1NxAt+zpZYXHuA=; b=dZJX8C
        z9WEgsQTijGEbEd9EOuGrx+ZllhLyalIgJWHVVzj/VH8Dnj7NYkDiiDYkHcvvygQ
        KAvtnIh5giD47M1EY5/pKZEIaFLyBlhhQG4p1mq63HhhxnW7cXPyIBJvEiOLxiL9
        ue1CUZWd+8twvFQ4dJE6R34A561zdxSpNoEH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qu7k2Qtm576bGsFn15TuKXW+CLSEidKM
        p1Sc8bT77DGm0cvE4FxzXJHxTqSpL5UozT4Uy06JHEj75t7teLxYBvNFwWn+XjKd
        0B7AJa+f5CQ6prbkz0hDbtP8GJ7r07qIms6VUAmRzQfNTvjgXg+somfnmKjj8WRc
        UWbbkhQ34FY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D61E23774A;
        Thu, 25 Aug 2016 17:50:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44E2837748;
        Thu, 25 Aug 2016 17:50:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 05/13] pkt-line: add packet_write_gently()
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-6-larsxschneider@gmail.com>
Date:   Thu, 25 Aug 2016 14:50:11 -0700
In-Reply-To: <20160825110752.31581-6-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:44
        +0200")
Message-ID: <xmqq4m68ldrg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6E05DFC-6B0D-11E6-93DE-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> packet_write_fmt() has two shortcomings. First, it uses format_packet()
> which lets the caller only send string data via "%s". That means it
> cannot be used for arbitrary data that may contain NULs. Second, it will
> always die on error.

As you introduced _gently in 3/13, the latter is no longer a valid
excuse to add this function.  Just remove the sentence "Second, ...".

> Add packet_write_gently() which writes arbitrary data and returns `0`
> for success and `-1` for an error. This function is used by other
> pkt-line functions in a subsequent patch.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index cad26df..7e8a803 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -3,6 +3,7 @@
>  #include "run-command.h"
>  
>  char packet_buffer[LARGE_PACKET_MAX];
> +static char packet_write_buffer[LARGE_PACKET_MAX];
>  static const char *packet_trace_prefix = "git";
>  static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
>  static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);
> @@ -155,6 +156,17 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
>  	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
>  }
>  
> +int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +{
> +	if (size > sizeof(packet_write_buffer) - 4)
> +		return -1;
> +	packet_trace(buf, size, 1);
> +	memmove(packet_write_buffer + 4, buf, size);
> +	size += 4;
> +	set_packet_header(packet_write_buffer, size);

It may not matter all that much, but from code-reader's point of
view, when you know packet_write_buffer[] will contain things A and
B in this order, and when you have enough information to compute A
before stasrting to fill packet_write_buffer[], I would prefer to
see you actually fill the buffer in that natural order.

Do you anticipate future need of non-gently variant of this
function?  If so, perhaps a helper that takes a boolean "am I
working for the gently variant?" may help share more code.

> +	return (write_in_full(fd_out, packet_write_buffer, size) == size ? 0 : -1);
> +}
> +
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  {
>  	va_list args;
