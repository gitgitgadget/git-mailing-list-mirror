Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A6F1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 22:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbcHOWs7 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 18:48:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752316AbcHOWs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 18:48:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2F86352B1;
	Mon, 15 Aug 2016 18:48:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KbQ1m92WaQymJNoDkf77L5zMaKc=; b=RdfQxV
	XC0jZo1KZnZbKYkWu9ZAXRyoz1lhV/Ab4eeQQSNbNiVN12k9OOSt4aURAshssDTV
	ngyUU9QjLhAT103reZhb6K1LKqiyzxAf0KYyUyDjCui7fr7Dq8q6nwPFwqUSICyF
	zRN7G2+b+/F0h05b9kdIDeIDcSmP0KVT/XVFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i64L4Ew8xFOz/oG3AtoUk5stuPfWELKe
	7FjfJMspq6qoZjScvFmux9llNj30962Zo79Ce/+4eF5Pa6W2IbarypwG7g9Yu56x
	N62C5Lv+ayxL84KxjQOyujyAsrM9VQQmWDVcOxXpkn5P6pnhFJLukFMtELwk1uNI
	WtrDYnOm+nE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA5B5352AE;
	Mon, 15 Aug 2016 18:48:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AEFA352AA;
	Mon, 15 Aug 2016 18:48:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/3] receive-pack: allow a maximum input size to be specified
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
	<20160815195729.16826-4-chriscool@tuxfamily.org>
	<20160815204034.rrjn57wigxtjpgye@sigill.intra.peff.net>
Date:	Mon, 15 Aug 2016 15:48:55 -0700
In-Reply-To: <20160815204034.rrjn57wigxtjpgye@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 15 Aug 2016 16:40:34 -0400")
Message-ID: <xmqqr39pejhk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 733A69AE-633A-11E6-8608-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The simple fix is to call register_tempfile() in open_pack_file(), and
> just have index-pack clean up the file on its way out.
>
> But there are harder cases. For instance, imagine somebody pushes a
> 500MB file, and you have a pre-receive hook that says "too big; I won't
> accept this". And then they push in a loop, as before. You've accepted
> the incoming pack into the repository by the time the pre-receive runs.
> You can't just delete it, because you don't know if other simultaneous
> processes have started to depend on the objects.
>
> To solve that, I have patches that put incoming packfiles into a
> "quarantine" area, then run the connectivity check and pre-receive hooks
> with the quarantine accessible via GIT_ALTERNATE_OBJECT_DIRECTORIES. And
> then we either move the quarantine packs into the real repo, or blow
> away the tmpdir, depending on whether the hooks said the objects were
> OK.
>
> Those are patches I plan to share upstream but just haven't gotten
> around to yet.

I think these other patches can come later, independent from this
three-patch series resurrected from the archive, so I can take a
reroll of these once the integer-size issues you pointed out are
sorted out.
