Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A60DC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhLIV5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:57:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55503 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbhLIV4y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 16:56:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55A731684D6;
        Thu,  9 Dec 2021 16:53:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZviwfFULQ9+Rv3gi733SIIpDxbTYWHErXCAGm6
        vhgqc=; b=BDrksSk1JuN8Gcd3Uwpsedhz7o2VoE+XO6CIbPtUfhUC0jg+ZDasBk
        mb7RNq+zIgvX2SqUM93Ue7apD5hcRgi3QrUR4v5BR61Did1JqPX8VAxVlAVVZtuR
        PF+4L2osEaPMLtLRCpNe4SRPIG9Gf2sW2a1tDDh57nIqN9YCMX78Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E2B71684D5;
        Thu,  9 Dec 2021 16:53:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94D5E1684D4;
        Thu,  9 Dec 2021 16:53:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC] fetch: update refs in a single transaction
References: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
Date:   Thu, 09 Dec 2021 13:53:14 -0800
In-Reply-To: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 7 Dec 2021 15:24:21 +0100")
Message-ID: <xmqqzgp9o379.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A31234C-593A-11EC-A00E-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> instead of creating one slice per updated ref. While this inefficiency
> can be easily mitigated by using the `--atomic` flag, this flag cannot
> be used in contexts where we want partial-update semantics.

Interesting and puzzling.  In today's code, we use a single
transaction when "atomic" is asked for, so that we can open a
transaction, prepare bunch of ref updates, and say "commit" to
commit all of them and let the ref_transaction layer to make the
whole thing all-or-none.  If we now use a single transaction for two
refs update that do not have to be atomic, it is surprising (from
the diffstat) that we can do so without changing anything in the
ref_transaction layer.  Doesn't the caller at least need to say
"this transaction is best-effort 'partial-update' (whatever it
means)" vs "this transaction is all-or-none"?  And doesn't the
ref_transaction layer now need to implement the 'partial-update'
thing?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fetch.c | 78 ++++++++++++++++---------------------------------
>  1 file changed, 25 insertions(+), 53 deletions(-)

