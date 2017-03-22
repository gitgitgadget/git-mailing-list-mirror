Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A438E2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbdCVUVk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 16:21:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58567 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753380AbdCVUVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 16:21:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CD8C7BD27;
        Wed, 22 Mar 2017 16:21:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G46femCeBPzO24VZ8F5ETCNgucg=; b=fLPXWk
        FsYPv73Qal2BO6P0dElSI6FlR3LY818IJAWFdVPXF0oVlScHxUDWEGg8VrTpmTWj
        0I3xl8lMSgL9CYNS+f6OS94oF5d1M8/U4B24x9SkIXjHXWpKh5I87GeqKYsNVWP2
        QOA4TYwhLn/52iTF5C+6wYLbkrweiGXLuqQz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mXAUX92OXyy/2jukeHeOdAwX6SVIxlOy
        mbdeMKkV1KZr8OnUiqUJmr1y3VVYFWPJw6LH28dc/sdJ3ywHWD3Got6QAonT4tdM
        tQEC4O6WNvvsHnamNgqNlznufNmSaZUe6GecqsER3IvU+lzW7ZnzJOOBLkNRcRer
        MuMm6h+jC2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 534FD7BD26;
        Wed, 22 Mar 2017 16:21:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB1547BD25;
        Wed, 22 Mar 2017 16:21:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v1 1/3] pkt-line: add packet_write_list_gently()
References: <20170322165220.5660-1-benpeart@microsoft.com>
        <20170322165220.5660-2-benpeart@microsoft.com>
Date:   Wed, 22 Mar 2017 13:21:20 -0700
In-Reply-To: <20170322165220.5660-2-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 22 Mar 2017 12:52:18 -0400")
Message-ID: <xmqqefxpjc5b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D57ECA0-0F3D-11E7-9C17-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Add packet_write_list_gently() which writes multiple lines in a single
> call and then calls packet_flush_gently(). This is used later in this
> patch series.

I can see how it would be convenient to have a function like this.
I'd name it without _gently(), though.  We call something _gently()
when we initially only have a function that dies hard on error and
later want to have a variant that returns an error for the caller to
handle.  You are starting without a dying variant (which is probably
a preferable way to structure the API).

Also I am hesitant to take a function that does not take any "list"
type argument and yet calls itself "write_list".  IOW, I'd expect
something like these

	write_list(int fd, const char **lines);
	write_list(int fd, struct string_list *lines);

given that name, and not "varargs, each of which is a line".  I am
tempted to suggest

	packet_writel(int fd, const char *line, ...);

noticing similarity with execl(), but perhaps others may be able to
come up with better names.

> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  pkt-line.c | 19 +++++++++++++++++++
>  pkt-line.h |  1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index d4b6bfe076..fccdac1352 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
>  	return status;
>  }
>  
> +int packet_write_list_gently(int fd, const char *line, ...)
> +{
> +	va_list args;
> +	int err;
> +	va_start(args, line);
> +	for (;;) {
> +		if (!line)
> +			break;
> +		if (strlen(line) > LARGE_PACKET_DATA_MAX)
> +			return -1;
> +		err = packet_write_fmt_gently(fd, "%s\n", line);
> +		if (err)
> +			return err;
> +		line = va_arg(args, const char*);
> +	}
> +	va_end(args);
> +	return packet_flush_gently(fd);
> +}
> +
>  static int packet_write_gently(const int fd_out, const char *buf, size_t size)
>  {
>  	static char packet_write_buffer[LARGE_PACKET_MAX];
> diff --git a/pkt-line.h b/pkt-line.h
> index 18eac64830..3674d04509 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  int packet_flush_gently(int fd);
>  int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int packet_write_list_gently(int fd, const char *line, ...);
>  int write_packetized_from_fd(int fd_in, int fd_out);
>  int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
