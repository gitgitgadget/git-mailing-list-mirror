Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A8DC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B850864F58
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhBDSR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:17:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54268 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbhBDSRK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:17:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1ECBA8262;
        Thu,  4 Feb 2021 13:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WQcesLaDj0Yo
        I9RGOHtW55VdKFQ=; b=Pi3QJrAGyflUWt3xJTchLjUGjafjPH/86Ht9R8frlp5w
        UsR5xRDu49+FvjL4mebdiOvI6mZnCTlZfrHFa8/d3c8Yzfe0bawfiylZKd/QyP9U
        0Xh4DBVHMrm5JRzjMt6xUcQthWjoUbYEzKG6hKCST6z4NFq/3X50qCQrE2SXig8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xGndlq
        Xls4GwCFXI/slkoe4QxhdGWrZXfora95oC7Vb1q1H3FLjmvlltnbPa2FVDp1Jm5z
        YT3iIxJe0YB8WI4VfgPKEv5MI9wE+zlelcDyxkXf5LrpdjAduJ6Dikm4UEfeGUa0
        ZAvaO8mlmROqglvAXFIZGK2SJZ32LoisTIsmM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 999A2A8261;
        Thu,  4 Feb 2021 13:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B150A8260;
        Thu,  4 Feb 2021 13:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 24/25] xdiff-interface: support early exit in xdiff_outf()
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210203032811.14979-25-avarab@gmail.com>
Date:   Thu, 04 Feb 2021 10:16:26 -0800
In-Reply-To: <20210203032811.14979-25-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 3 Feb 2021 04:28:10 +0100")
Message-ID: <xmqqzh0j7l6t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18B2C952-6715-11EB-AF09-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Bridge the gap between the preceding "xdiff-interface: allow early
> return from xdiff_emit_{line,hunk}_fn" change and the public
> interface. This change was split off from the rest as it wasn't a
> purely mechanical addition of "return 0".
>
> Here we want to be able to abort early, but do so in a way that
> doesn't skip the appropriate strbuf_reset() invocations.

Nice.

> The use of -1 as a return value in the xdiff codebase for early
> return, as we'll see more of in subsequent commits.

This is a non-sentence without a verb. =20

I started reading the sentence and expected to see "The use of -1,
as opposed to something else, is because of thess deep reasons"
explained, but perhaps you forgot to conclude the sentence with such
an explanation?

