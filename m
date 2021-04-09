Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E17C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175DE61165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhDIEtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:49:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56310 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhDIEti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:49:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 22A4A119B4E;
        Fri,  9 Apr 2021 00:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ktC2zGMMHck6lZdJgMgUXWG4oHo=; b=UTpIQX
        lDJRQsdZsteIYFo7tSHPSNV87bHt+6pYT1ACtcy4Mwki/pOhyULkEfvGzsMRsQI7
        X9wd7HYOAAMfAd1Sikppycc2zeBbKuH1z55CVC9fJ/vxLlIRybPkkrskrDxamV8E
        1PXICtD2T+pzMm/2mZefCydaLtRm63icfs35s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rWnjJYRys4OX89Sjsby6o2QSVZTgdd9J
        S3vDzrF1CykFE26Wsc6SYqWQZsj3n2UtBDWrXRrYgDRKciSoGlpmJi59nrdRGVKP
        N2L3EpRiu3HLmcYGWbPdTmEVRfmvWRZNGTODtiGPF4mgpHke/7SCLr7ZsHLynIO7
        tuoDBukHkkU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C1F9119B4D;
        Fri,  9 Apr 2021 00:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15D28119B4B;
        Fri,  9 Apr 2021 00:49:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] fetch-pack: buffer object-format with other args
References: <cover.1617929278.git.jonathantanmy@google.com>
        <86e4ce0e8d9665b1c5a2b30173be4afffe0a0abd.1617929278.git.jonathantanmy@google.com>
Date:   Thu, 08 Apr 2021 21:49:12 -0700
In-Reply-To: <86e4ce0e8d9665b1c5a2b30173be4afffe0a0abd.1617929278.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 8 Apr 2021 18:09:58 -0700")
Message-ID: <xmqqy2dsnjuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EECDD47C-98EE-11EB-A111-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In send_fetch_request(), "object-format" is written directly to the file
> descriptor, as opposed to the other arguments, which are buffered.
> Buffer "object-format" as well. "object-format" must be buffered; in
> particular, it must appear after "command=fetch" in the request.
>
> This divergence was introduced in 4b831208bb ("fetch-pack: parse and
> advertise the object-format capability", 2020-05-27), perhaps as an
> oversight (the surrounding code at the point of this commit has already
> been using a request buffer.)

Good find.  Did this actually resulted in a data corruption and that
was how you discovered it?



>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6e68276aa3..2318ebe680 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1251,7 +1251,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>  			die(_("mismatched algorithms: client %s; server %s"),
>  			    the_hash_algo->name, hash_name);
> -		packet_write_fmt(fd_out, "object-format=%s", the_hash_algo->name);
> +		packet_buf_write(&req_buf, "object-format=%s", the_hash_algo->name);
>  	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
>  		die(_("the server does not support algorithm '%s'"),
>  		    the_hash_algo->name);
