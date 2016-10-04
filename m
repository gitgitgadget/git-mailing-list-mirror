Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B811E20986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbcJDTeE (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:34:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60015 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752815AbcJDTeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:34:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88E3E42AC9;
        Tue,  4 Oct 2016 15:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2wkS1Sv6U4l+asbgIuvOnifIlNU=; b=hm6rTi
        OmrgdZgcCzqiOrdmDY+ztYjdgHG5UpK5TC2rIIT+JhYlIezMhjHkrP1zAIvzoJzP
        yHvxw3j9DQwBvkSfeXZQLDCi5c8ktQ7cSVBPKk63epTXp1h7JnRqi4aGUwWHFLhU
        UbHLDGjO45/1r2H07o1i5g/n6WgQws5wzdTIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlNUIBpAZJm637I1oYjPvmoJ7MAFqmpQ
        wGOa/8cxrv5OBQGdLDaKwjzVfmCsjp2kEU3KD1Ap4AbH4MjzfvgX72Y4HglUEDGN
        dpsIw8dM3iRJ6j0O6ZpUczTUaCL82YObhRb+iBv20W0BKgAbaILUCxS9ZfAff3Zy
        CQ5ymCax4RA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E69042AC8;
        Tue,  4 Oct 2016 15:34:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BD4A42AC4;
        Tue,  4 Oct 2016 15:34:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 09/14] pkt-line: add packet_write_gently()
References: <20161004125947.67104-1-larsxschneider@gmail.com>
        <20161004125947.67104-10-larsxschneider@gmail.com>
Date:   Tue, 04 Oct 2016 12:33:59 -0700
In-Reply-To: <20161004125947.67104-10-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Tue, 4 Oct 2016 14:59:42
        +0200")
Message-ID: <xmqqd1jfucwo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80AE8704-8A69-11E6-8552-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> packet_write_fmt_gently() uses format_packet() which lets the caller
> only send string data via "%s". That means it cannot be used for
> arbitrary data that may contain NULs.
>
> Add packet_write_gently() which writes arbitrary data and does not die
> in case of an error. The function is used by other pkt-line functions in
> a subsequent patch.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  pkt-line.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 286eb09..3fd4dc0 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -171,6 +171,22 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
>  	return status;
>  }
>  
> +static int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +{
> +	static char packet_write_buffer[LARGE_PACKET_MAX];
> +	const size_t packet_size = size + 4;
> +
> +	if (packet_size > sizeof(packet_write_buffer))
> +		return error("packet write failed - data exceeds max packet size");

Hmph, in the previous round, this used to be "is the size larger
than sizeof(..) - 4?", which avoided integer overflow issue rather
nicely and more idiomatic.  If size is near the size_t's max,
packet_size may wrap around to become very small, and we won't hit
this error, will we?

> +	packet_trace(buf, size, 1);
> +	set_packet_header(packet_write_buffer, packet_size);
> +	memcpy(packet_write_buffer + 4, buf, size);
> +	if (write_in_full(fd_out, packet_write_buffer, packet_size) == packet_size)
> +		return 0;
> +	return error("packet write failed");
> +}
> +
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  {
>  	va_list args;
