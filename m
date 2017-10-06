Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74AC2036B
	for <e@80x24.org>; Fri,  6 Oct 2017 09:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdJFJpL (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 05:45:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51294 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750863AbdJFJpK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 05:45:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AACB9F87D;
        Fri,  6 Oct 2017 05:45:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j70k3Q9Zz0lGx2rTBWQjRLQ02VU=; b=hJBcgM
        HVlSIoAsfSWccswq1yy2oqcGncYGG6wpU+IHlNCD5mnZ4XOdv51GIOZ+hB7QXMNz
        xYKLfghNQwxbdVehdZekj87KrVlgoIRSROaCs0SAzOEKAWWFQbu2BXuj3/etgWHE
        DXIDBkj0C1u0O+JbmT5zZ26TYZwEhJXX2hHec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s+BLguy0rIVqzjjLFK4/X8fJe9smB0Nf
        hKG1XBKTNlx/GIaLLBFCFDPJZNM1ZYZc6XdovfdNfLaZGBAbPOyHYdjZBXoRgZgw
        HZSdCyGHR2Z79NHD3GnmthpOOU844jDM87Jtpay9EYJa2h/9M6yZZZP5FzpVbKJR
        8SP+TymNKtw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2208F9F87B;
        Fri,  6 Oct 2017 05:45:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F90D9F87A;
        Fri,  6 Oct 2017 05:45:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Krey <a.krey@gmx.de>, Git Users <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Regression in 'git branch -m'?
References: <20171005172552.GA11497@inner.h.apk.li>
        <20171005183303.f77dpkhs5ztxlmyv@sigill.intra.peff.net>
        <20171006073913.yavdbdd3p3y5vjhd@sigill.intra.peff.net>
        <20171006083719.jap56jucgmlsuvuo@sigill.intra.peff.net>
Date:   Fri, 06 Oct 2017 18:45:08 +0900
In-Reply-To: <20171006083719.jap56jucgmlsuvuo@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 6 Oct 2017 04:37:19 -0400")
Message-ID: <xmqqzi94vcd7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ABE6630-AA7B-11E7-863E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So this patch fixes the problem:
>
> diff --git a/refs.c b/refs.c
> index df075fcd06..2ba74720c8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1435,7 +1435,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  		if (refs_read_raw_ref(refs, refname,
>  				      sha1, &sb_refname, &read_flags)) {
>  			*flags |= read_flags;
> -			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
> +			if ((errno != ENOENT && errno != EISDIR) ||
> +			    (resolve_flags & RESOLVE_REF_READING))

Ooo, good find--is_missing_file_error() strikes back...

>  				return NULL;
>  			hashclr(sha1);
>  			if (*flags & REF_BAD_NAME)
>
> but seems to stimulate a test failure in t3308. I have a suspicion that
> I've just uncovered another bug, but I'll dig in that. In the meantime I
> wanted to post this update in case anybody else was looking into it.
>
> -Peff
