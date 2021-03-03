Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D07C43619
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6760564EBA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355396AbhCDAXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57634 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378751AbhCCTxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 14:53:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD893BD54A;
        Wed,  3 Mar 2021 14:53:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NhgNub5tD5y2aiyo8d8qd71W310=; b=ubRdCc
        TDsprkjPkM2JbEsEBmefHNfQeN2vRfEUXIF2duo/9Q5II2Abcor0jGeQRQc2Ujkx
        cissdIj0nnjt32VcqL/A8sUG7ZiQ4gGW7By0og5zLsn+RBu7MLqwTiRWXKhfj2Q9
        q/OH1T4k3edzdNg96i+FdLMGhShkzE9CwrXT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g245PlYuJrAbKnwRjkx7yW/YQqXGYBxa
        LXSm6GsfDMo+26qim0AG+U3v+tvdRlVfkZlQ5sRmRwdBtb1DcZwvpzQIwmn+VYJW
        XPVHDaLF1bnYDBqsONYtrWQ+JAsvjmDAZOmLhEIi/zRl0yxcDEiW12Srr43xk3JK
        UmrngYhVPdQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4FE1BD549;
        Wed,  3 Mar 2021 14:53:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15D76BD548;
        Wed,  3 Mar 2021 14:53:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 03/12] pkt-line: (optionally) libify the packet readers
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <e05467def4e158a5f1cfa3aafffdb5c77097859a.1613598529.git.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 11:53:06 -0800
In-Reply-To: <e05467def4e158a5f1cfa3aafffdb5c77097859a.1613598529.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 17 Feb 2021
        21:48:39 +0000")
Message-ID: <xmqqwnuohv4t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12E8AF8C-7C5A-11EB-BA08-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -313,6 +316,8 @@ static int get_packet_data(int fd, char **src_buf, 
>  		if (options & PACKET_READ_GENTLE_ON_EOF)
>  			return -1;
>  
> +		if (options & PACKET_READ_NEVER_DIE)
> +			return error(_("the remote end hung up unexpectedly"));
>  		die(_("the remote end hung up unexpectedly"));
>  	}

This hunk treats READ_NEVER_DIE as a less quiet version of
GENTRL_ON_EOF, i.e. the new flag allows to continue even after the
"hung up unexpectedly" condition that usually causes the process to
die..

> @@ -355,12 +363,19 @@ enum packet_read_status packet_read_with_status(i
> ...
> -	if ((unsigned)len >= size)
> +	if ((unsigned)len >= size) {
> +		if (options & PACKET_READ_NEVER_DIE)
> +			return error(_("protocol error: bad line length %d"),
> +				     len);
>  		die(_("protocol error: bad line length %d"), len);
> +	}
>  
>  	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
>  		*pktlen = -1;

In the post-context of this hunk, there is this code:

	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
	    starts_with(buffer, "ERR "))
		die(_("remote error: %s"), buffer + 4);

	*pktlen = len;
	return PACKET_READ_NORMAL;

But here, there is no way to override the DIE_ON_ERR with
READ_NEVER_DIE.

The asymmetry is somewhat annoying (i.e. if "if you do not want to
die upon ERR, don't pass DIE_ON_ERR" could be a valid suggestion to
the callers, then "if you do not want to die upon an unexpected
hung-up, pass GENTLE_ON_EOF" would equally be valid suggestion),
but I'll let it pass.

> diff --git a/pkt-line.h b/pkt-line.h
> index a7149429ac35..2e472efaf2c5 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -75,10 +75,14 @@ int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
>   *
>   * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
>   * ERR packet.
> + *
> + * With `PACKET_READ_NEVER_DIE`, no errors are allowed to trigger die() (except
> + * an ERR packet, when `PACKET_READ_DIE_ON_ERR_PACKET` is in effect).
>   */
>  #define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
>  #define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
>  #define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
> +#define PACKET_READ_NEVER_DIE         (1u<<3)
>  int packet_read(int fd, char **src_buffer, size_t *src_len, char
>  		*buffer, unsigned size, int options);
