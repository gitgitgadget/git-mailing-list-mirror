Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4711F955
	for <e@80x24.org>; Fri, 29 Jul 2016 15:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbcG2PC5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 11:02:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751697AbcG2PCz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 11:02:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EC2931091;
	Fri, 29 Jul 2016 11:02:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0T6UcrkTYrV0eGu42u4IfIf3HE=; b=EeAEDC
	X7SH32lgFn+1BB/CwWYtOz99N8CqzIcSaFvaqqq7qJ+vS0fAcECR9kVw6roysz2l
	6pZsW3ptfyRJFlPceBK3yaUVqg6Lsn/1q/DfGL+rp3SP/w70HFR++SlQQ5s9SMMM
	qDy3y6ARwaOg7M8pnNzOlzpEG8bcACv4+AkMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtj212UrqMLNyfeZjClMl214quikMKX/
	tupo5eJ0bNGrlBMDBu/ctymQkJEDCF1iJeCcFK1GLcee/H2c4L1UvjhtqJV4XJ0T
	ehCTFuCRxDDb4Fuj0veRGDz9wGkN/pnpTFauokl7WD5x8NqumkcEwA/CRxrXAvMq
	c4a64zEpMI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 277EF31090;
	Fri, 29 Jul 2016 11:02:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A59B43108E;
	Fri, 29 Jul 2016 11:02:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/7] pack-objects: use mru list when iterating over packs
References: <20160729040422.GA19678@sigill.intra.peff.net>
	<20160729041524.GG22408@sigill.intra.peff.net>
	<20160729054536.GA27343@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 08:02:51 -0700
In-Reply-To: <20160729054536.GA27343@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 01:45:37 -0400")
Message-ID: <xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 868B77A0-559D-11E6-B72A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 29, 2016 at 12:15:24AM -0400, Jeff King wrote:
>
> But because this series switches the order of pack-lookup between
> objects, it is possible for us to find a `B` which is a delta against
> `A` in one pack, and then another copy of `A` which is a delta against
> another copy of `B` from another pack. We add both of the deltas to our
> packing list, but at write time when we try to write out all of the
> bases for `A`, we realize that whoops, we are recursing infinitely.
>
> As it turns out, Git actually handles this pretty well! Upon noticing
> the recursion, it breaks the delta chain and writes out one of the
> objects as a full base. This is due to Junio's f63c79d (pack-object:
> tolerate broken packs that have duplicated objects, 2011-11-16), though
> I think we later decided that duplicated objects were simply insane.
>
> So one option is to simply silence the warning, because the resulting
> pack is perfectly fine.

Thanks for a great analysis.

My gut feeling is that keeping the warning is preferred if possible,
because f63c79db (pack-object: tolerate broken packs that have
duplicated objects, 2011-11-16) was made as the last ditch effort to
warn about the presence of the problem in the delta-base selection
code without harming the users.

> So it's possible that the resulting pack
> is not as small as it could be (i.e., we break the chain with a base
> object, but it's possible if we looked that we could have broken the
> chain by making a delta against an existing base object). So I wonder if
> it's possible to detect this case earlier, during the "can we reuse this
> delta" bits of check_object().

I'd let the issue simmer in my mind a bit for now, as I do not
think of a neat trick offhand.
