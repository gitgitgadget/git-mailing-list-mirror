Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CC1203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbcGYT43 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 15:56:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752611AbcGYT42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 15:56:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B67BC2E7AA;
	Mon, 25 Jul 2016 15:56:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7utxM+SoHtgaESTAhiGd7DnEzTQ=; b=liR3bK
	XHm7Nj7zMgfzz1Oj32KnbNH2tc0XVq2jKgx3I8Fl64SFB/SMX6j2RcPyy15rdcUE
	ZfJXyAWtcX3SUu2CzqSGYuUve79J4YRAZs2q5mLaENdTeQyG/R6aMNhn182BJOkr
	KJD0OHEYcHUkCOgAQOK2K44X3K9sSC68R/LBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPXXZPoV4dJE+7g87Scu/+No89Hrt6eS
	nG1fKW/YA5oddWcpK6rDrOR7P1sq2yPtaqLlszRGHlz52Ughibczpu1Zfo0qbjog
	utSg6IXcAwERxM07u5lVNvNJ2ayTB4R3YqSqDA9L3XECzfRNMssXcQx7wCEQlz3/
	qA90pAca8oY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE6922E7A8;
	Mon, 25 Jul 2016 15:56:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 366B72E7A7;
	Mon, 25 Jul 2016 15:56:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
References: <20160725184938.GA12871@sigill.intra.peff.net>
	<20160725185010.GA12974@sigill.intra.peff.net>
Date:	Mon, 25 Jul 2016 12:56:23 -0700
In-Reply-To: <20160725185010.GA12974@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 25 Jul 2016 14:50:10 -0400")
Message-ID: <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEC9C358-52A1-11E6-9179-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When pack-objects collects the list of objects to pack
> (either from stdin, or via its internal rev-list), it
> filters each one through want_object_in_pack().
>
> This function loops through each existing packfile, looking
> for the object. When we find it, we mark the pack/offset
> combo for later use. However, we can't just return "yes, we
> want it" at that point. If --honor-pack-keep is in effect,
> we must keep looking to find it in _all_ packs, to make sure
> none of them has a .keep. Likewise, if --local is in effect,
> we must make sure it is not present in any local pack.

s/any local pack/any non-local pack/, no?

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a2f8cfd..55ef5a8 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -981,6 +981,8 @@ static int want_object_in_pack(const unsigned char *sha1,
>  				return 0;
>  			if (ignore_packed_keep && p->pack_local && p->pack_keep)
>  				return 0;
> +			if (!ignore_packed_keep && !local)
> +				break;
>  		}
>  	}

OK, so in this loop, we may return "false" (meaning, we do not want
to pack the object) if "local" (do not pack objects that appear in
non-local packs) or "ignore_packed_keep" (do not pack objects that
appear in locally kept packs) are in effect, but if neither of the
options is set, we know that one of the preconditions ("local" or
"ignore_packed_keep") for these two "reject by returning false" if
statements would never trigger for any pack on packed_git list, so
it is safe to break out and return the one that we have found.

If that is what is going on, I would have expected to see this early
break before these "we found that this is available in borrowed pack
and we are only packing local" and "we ignore objects in locally
kept packs" checks return false.

Or am I not following the logic in the loop correctly?
