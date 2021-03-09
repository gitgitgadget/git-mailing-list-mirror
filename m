Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C84C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 23:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D48650FD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 23:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCIXtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:49:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51692 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCIXsm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 18:48:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3010DACC51;
        Tue,  9 Mar 2021 18:48:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/cjXqwdtrPLFCswDAoPDAD7s4/U=; b=Y6Y3cm
        hJB9cCgXKayAn9PO+bL7xypQxcF2TheXSLPiKomALaZOHhUjuXFLKiRp2wWk0JUV
        F+AlzH2q/lYqgCroCElpw2xCG1LeyzXBwzixpyx5XP4huXzC3vzMeyWVkJqlAcqd
        H4INm7IJz6vanKUCIsG5u1JVSxjgTQucZ/xPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SN20I1vVstkLcEGsB6W0PceJoEZjkDiy
        iq2u5YRESuipbOLJuzgp4VULMP1u1Tr6yZriopsUnhDmdRZ19ln2Bo6/T12fO+6L
        QVLhYR0ebln++B1UyXjZNuV/pjqTKzrPNoGZd4+aGep3pJGKaz5/Fw7N9s6qG5Ec
        /iT7cO4r9bo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27DC5ACC50;
        Tue,  9 Mar 2021 18:48:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A98CDACC4F;
        Tue,  9 Mar 2021 18:48:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <311ea4a5cd71c5dd2407348ad4608d2f7dd77ce5.1615302157.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:48:40 -0800
In-Reply-To: <311ea4a5cd71c5dd2407348ad4608d2f7dd77ce5.1615302157.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Tue, 09 Mar 2021
        15:02:26 +0000")
Message-ID: <xmqqblbrzy5j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA455516-8131-11EB-80D9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * Write the header and the buffer in 2 parts so that we do not need
> +	 * to allocate a buffer or rely on a static buffer.  This avoids perf
> +	 * and multi-threading issues.
> +	 */

I understand "multi-threading issues" (i.e. let's not have too much
stuff on the stack), but what issue around "perf" are we worried
about?

Even though we eliminate memcpy() from the original buffer to our
temporary, this doubles the number of write(2) system calls used to
write out packetised data, by the way.  I do not know if this results
in measurable performance degradation, but hopefully we can fix it
locally if it turns out to be a real problem later.

> +	if (write_in_full(fd_out, header, 4) < 0 ||
> +	    write_in_full(fd_out, buf, size) < 0)
>  		return error(_("packet write failed"));
>  	return 0;
>  }
> @@ -244,20 +252,23 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
>  
>  int write_packetized_from_fd(int fd_in, int fd_out)
>  {
> -	static char buf[LARGE_PACKET_DATA_MAX];
> +	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
>  	int err = 0;
>  	ssize_t bytes_to_write;
>  
>  	while (!err) {
> -		bytes_to_write = xread(fd_in, buf, sizeof(buf));
> -		if (bytes_to_write < 0)
> +		bytes_to_write = xread(fd_in, buf, LARGE_PACKET_DATA_MAX);
> +		if (bytes_to_write < 0) {
> +			free(buf);
>  			return COPY_READ_ERROR;
> +		}
>  		if (bytes_to_write == 0)
>  			break;
>  		err = packet_write_gently(fd_out, buf, bytes_to_write);
>  	}
>  	if (!err)
>  		err = packet_flush_gently(fd_out);
> +	free(buf);
>  	return err;
>  }
