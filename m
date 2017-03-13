Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DD7202C1
	for <e@80x24.org>; Mon, 13 Mar 2017 05:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbdCMF7Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 01:59:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55533 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751019AbdCMF7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 01:59:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEFD874E75;
        Mon, 13 Mar 2017 01:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tiamCj0qkgVbT2ZAFS1ykocV4g8=; b=KAjgIJ
        52Ntc1WlN3VLkGALoW/FCCyeQ7BugixifN3+E4EtRozyYAM7HHWqs3NcS/r4qk6p
        4V/rxN+n9HgVlkUFk3xo1/R5fQcEZiVcv5+zhHd4oJQnfps1DXR0jOnUxnbLoN3s
        tcB/+LRjvBkDtYsfAF/M02Nj/KQdteJVFzSGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VcdbcfGw3MxHZnz9E8l/MtFsJMskH+79
        4A84IzkULN0g8wvcek6jbdbDrfCMMCKEApVoFhs49BTRnsAKigr3Z5QyxvCXePdx
        6k/c05Eb51DPPo2GDB8/TP7AFNTy4NRq0C4+9it6zw3LsCS5Y9Sfla4DZQQ+ySfB
        vFXTxagsyy0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B829774E74;
        Mon, 13 Mar 2017 01:59:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1000174E73;
        Mon, 13 Mar 2017 01:59:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-walker: fix buffer underflow processing remote alternates
References: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net>
Date:   Sun, 12 Mar 2017 22:59:09 -0700
In-Reply-To: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 12 Mar 2017 08:38:54 -0400")
Message-ID: <xmqqfuihu382.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DB9D3D4-07B2-11E7-A370-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we parse a remote alternates (or http-alternates), we
> expect relative lines like:
>
>   ../../foo.git/objects
>
> which we convert into "$URL/../foo.git/" (and then use that
> as a base for fetching more objects).
>
> But if the remote feeds us nonsense like just:
>
>   ../
>
> we will try to blindly strip the last 7 characters, assuming
> they contain the string "objects". Since we don't _have_ 7
> characters at all, this results in feeding a small negative
> value to strbuf_add(), which converts it to a size_t,
> resulting in a big positive value. This should consistently
> fail (since we can't generally allocate the max size_t minus
> 7 bytes), so there shouldn't be any security implications.

OK.

> Let's fix this by using strbuf_strip_suffix() to drop the
> characters we want. As a bonus this lets us handle names
> that do not end in "objects" (all git repos do, but there is
> nothing to say that an alternate object store needs to be a
> git repo).

Hmph.

Isn't the reason why the function wants to strip "objects" at the
end because it then expects to be able to tack strings like
"objects/info/packs", etc. after the result of stripping, i.e.
$URL/../foo.git/, and get usable URLs to download other things?

I think it is very sensible to use strip_suffix() to notice that the
alternate does not end with "/objects", but I am not sure if it is a
good idea to proceed without stripping when it does not end with
"/objects".  Shouldn't we be ignoring (with warning, possibly) such
a remote alternate?

>  			}
> -			/* skip "objects\n" at end */
>  			if (okay) {
>  				struct strbuf target = STRBUF_INIT;
>  				strbuf_add(&target, base, serverlen);
> -				strbuf_add(&target, data + i, posn - i - 7);
> +				strbuf_add(&target, data + i, posn - i);
> +				strbuf_rtrim(&target);
> +				strbuf_strip_suffix(&target, "objects");
> +				strbuf_complete(&target, '/');
>  
>  				if (is_alternate_allowed(target.buf)) {
>  					warning("adding alternate object store: %s",
