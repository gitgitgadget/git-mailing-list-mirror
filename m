Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE381C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AEE20776
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FVWfKR/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437266AbgE1XIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:08:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62524 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbgE1XIq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:08:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88110CF1E9;
        Thu, 28 May 2020 19:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sUoDXJKxe2Stn5X1Vl3gty/mqMo=; b=FVWfKR
        /fCEF9t2nJQr4CPuUjHqMecAzyajLKyJFpcPPuSAuBNs3pXAd17xs+6qajgXZ3of
        IPQ/mAlddiDyXqNNRnp6kRLQ9A9SRcIVybOWTcmmoYC44Ool19Koxy/tO2yR6WkQ
        f/fsYqkO2mAJKXs3Uod/eT15J5lp+A7DjKSh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQl5M9VpXRZN1xSgIBeNrQ3nfXDfEESq
        74SVE6koAAF8MNAfryfY7uCzK32KgoJyeUfGo2fwbHg59sJQX0fdG60XrUEoOMs0
        +7hAVqYBwMm7Tr/zcT0ux24aQqwBIHayBOBiJfjJljG68L09yBQP5WNys1YFR2He
        j1/98e5xD2U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81A75CF1E8;
        Thu, 28 May 2020 19:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C68C7CF1E7;
        Thu, 28 May 2020 19:08:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: add new --date-format=raw-permissive format
References: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
        <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 16:08:41 -0700
In-Reply-To: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 28 May 2020
        20:40:37 +0000")
Message-ID: <xmqqpnan1wue.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CB19C88-A138-11EA-A261-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Provide a --date-format=raw-permissive format that will not error out on
> these otherwise invalid timezones so that such existing repositories can
> be imported.

So the idea is to just propagate whatever raw timestamp plus
timezone we read from the input stream, which most likely has been
copied from a (broken) raw commit object, to a rewritten commit?

Makes sense.  Will queue.

Thanks.
