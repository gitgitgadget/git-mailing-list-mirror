Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014BA203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 21:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbcGYVwc (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 17:52:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752984AbcGYVw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 17:52:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53DE03007A;
	Mon, 25 Jul 2016 17:52:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PCKYQc6j3sgWVHPt4HWjd0rHr4g=; b=LG5EfM
	TauWEYqJa0eZ5SfBRw+E7osq8fJFXS4pRtR9XdMMLuGM6tJxetyKgc8+D0mpnnMd
	fbU+2MEVELGhYOqhejXe4i0YjUg924gTxTUcwhT3GRESL4bgkYvHc/F3XylA/MjJ
	+FH6VnsRwYErQhPMgiFMtx53yJrb2wobYLQos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cvgvtZDk4VwWBQYn91L5Iqu4ZydD+AvH
	8XSpLOWUjn5513cv+VubVro9humufB3lfIq3wv4PpKZ9RriTk9SEkklIzLtIPsyD
	jWP+L2hMPXfk5g4BIAeG6eb8cEaTX4ph3o2dB1uobNDXF9wW8N2xtNdZg490IvtV
	wF+T86hiwSc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49A1F30078;
	Mon, 25 Jul 2016 17:52:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3ADB30077;
	Mon, 25 Jul 2016 17:52:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
References: <20160725184938.GA12871@sigill.intra.peff.net>
	<20160725185010.GA12974@sigill.intra.peff.net>
	<xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
	<20160725214113.GA13589@sigill.intra.peff.net>
Date:	Mon, 25 Jul 2016 14:52:24 -0700
In-Reply-To: <20160725214113.GA13589@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 25 Jul 2016 17:41:13 -0400")
Message-ID: <xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 138A0A84-52B2-11E6-A4BA-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   if (!*found_pack) {
>     ... first find! fill in found pack, etc ...
>   }
>   if (exclude)
> 	return 1;
>   if (incremental)
> 	return 0;
>   if (!ignore_packed_keep && !local)
> 	break; /* effectively return 1, but I think the break is more clear */
>   if (local && !p->pack_local)
> 	return 0;
>   if (ignore_packed_keep && p->pack_local && p->pack_keep)
> 	return 0;
>
> which just bumps it up. I don't think there is a way to make it more
> elegant, e.g., by only checking ignore_packed_keep once, because we have
> to distinguish between each condition being set independently, or the
> case where neither is set.
>
> So I stuck the new check at the end, because to me logically it was "can
> we break out of the loop instead of looking at p->next". But I agree it
> would be equivalent to place it before the related checks, and I don't
> mind doing that if you think it's more readable.

I do not mind too much about having to check two bools twice.  But
given that the reason why I was confused was because I didn't see
why we need to pass the two "return 0" conditions at least once
before we decide that we do not need the "return 0" thing at all,
and started constructing a case where this might break by writing
"Suppose you have two packs, one remote and one local in packed_git
list in this order, and ..." before I realized that the new "early
break" can be hoisted up like the above, I definitely feel that "we
found one, and we aren't conditionally pretending that this thing
does not need to be packed at all, so return early and say we want
to pack it" is easier to understand before the two existing "if"
statements.

Thanks.
