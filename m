Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6ADE20372
	for <e@80x24.org>; Tue, 10 Oct 2017 01:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbdJJBeF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 21:34:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51528 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754707AbdJJBeE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 21:34:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01965A9A58;
        Mon,  9 Oct 2017 21:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DqHRXWDn2yMXfhQcZxvfnBZIUDA=; b=Q6jMH4
        N3Qodk1PNolsfdZMozQuDcB/o+y6Al5QJt7uz2WEs7fMC5lZzy3AH3OF30QhGASe
        VYPPbHgoYm6LctSbj8jbZqC3Qat5pQ5/GOO3AwyAd6mMy0p+N8mqoD5+f8JOzeC1
        X67XJw8h+VnUc8KVzexhM2dTyRTRq+qRgr2yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=exgoJQEdp83BSKyfahnG4cbu+A80Sm7b
        Ggw5waxJHlb7vNiyBtqmg88AS38m5QDr8k9LUzAxWItqYgQS0kOtVzlLnG4uKYD8
        Mbrvp0k47wFuQdDa56x/eF3s2TlVRXE8TeF8T8zy0VC+K3+yRaGzdGkTdjv/IMom
        i7DU8m7jNeY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED570A9A57;
        Mon,  9 Oct 2017 21:34:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A202A9A55;
        Mon,  9 Oct 2017 21:34:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] sha1_loose_object_info: handle errors from unpack_sha1_rest
References: <20171005055952.t5ef7hyolyevoj3d@sigill.intra.peff.net>
        <xmqqr2ugykl2.fsf@gitster.mtv.corp.google.com>
        <20171006043008.2s6pg4aurwledf3s@sigill.intra.peff.net>
        <20171006043847.hja2yjlvatckgy4d@sigill.intra.peff.net>
Date:   Tue, 10 Oct 2017 10:34:01 +0900
In-Reply-To: <20171006043847.hja2yjlvatckgy4d@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 6 Oct 2017 00:38:47 -0400")
Message-ID: <xmqq376rrdkm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 193328D0-AD5B-11E7-8F1A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, there are only two callers left these days. One of them leaks,
> and the other immediately closes the zstream. So something like:
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 09ad64ce55..cea003d182 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -978,10 +978,10 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
>  		while (status == Z_OK)
>  			status = git_inflate(stream, Z_FINISH);
>  	}
> -	if (status == Z_STREAM_END && !stream->avail_in) {
> -		git_inflate_end(stream);
> +	git_inflate_end(stream);
> +
> +	if (status == Z_STREAM_END && !stream->avail_in)
>  		return buf;
> -	}
>  
>  	if (status < 0)
>  		error("corrupt loose object '%s'", sha1_to_hex(sha1));
> @@ -2107,7 +2107,6 @@ int read_loose_object(const char *path,
>  		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_sha1);
>  		if (!*contents) {
>  			error("unable to unpack contents of %s", path);
> -			git_inflate_end(&stream);
>  			goto out;
>  		}
>  		if (check_sha1_signature(expected_sha1, *contents,
>
> seems reasonable. Doing it that (with my other patch on top) splits the
> leak-fix and the not-yet-a-bug-but-confusing-error-return problems into
> two separate patches.
>
> I dunno. There aren't that many callers of unpack_sha1_rest(), so it may
> not matter that much, but while we're here...

Yeah, I agree that it is a reasonable thing to do.
