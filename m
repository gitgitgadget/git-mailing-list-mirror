Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5517C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6064E22
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbhBDSX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:23:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57566 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbhBDSXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:23:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0804A82CF;
        Thu,  4 Feb 2021 13:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=/r/9nZveBO8xoDd6Pzf3jV/B/
        Ns=; b=xq03a6hj9oItmqja9RZzY/eit3+auhSWAQKRQXLTp8E6a/RTMAOIA5RnA
        xggkY/u/vxmOEmZ99P+fvZXZg2EkE73kXcK8i64Z6SA8MVZ9ufZUoX4HJCMZO9ev
        ShSWgYZkUQWSqrY0BshGsLjaF5019/p0JDksYfP3iMEjcTylQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=QABfw2ojN/gJfWekklX
        F14myCmynpCRzoLaS0l1BqBJ6AkJAKE54t/MpmpVKjoIImNhY5OemWRHk3HV9VIt
        bhS4He8FvTcrRX8pa/xZnGcVPX/NnS2Rear7N1usRLsiQxmMFExSHER8HXnc5KkH
        H8o04RZ0veKVB9tbrCA8jFaY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D94F2A82CE;
        Thu,  4 Feb 2021 13:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B220A82CD;
        Thu,  4 Feb 2021 13:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 21/25] pickaxe: use PCREv2 for -G and -S
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210203032811.14979-22-avarab@gmail.com>
Date:   Thu, 04 Feb 2021 10:22:35 -0800
Message-ID: <xmqqpn1f7kwk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4CC4170-6715-11EB-9D49-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Follow-up b65abcafc7a (grep: use PCRE v2 for optimized fixed-string
> search, 2019-07-01) and remove the use of kwset in the pickaxe code
> for fixed-string search, in favor of optimistically using PCRE v2.
>
> This does mean that the semantics of the -G option subtly change,
> before it's an ERE, whereas now it'll be a PCRE if we're compiled with
> PCRE. Since PCRE is almost entirely a strict superset of ERE syntax I
> think this is OK.

Since Git is no longer a tool shared among 100 developers who are at
least acquaintances, there will be people who are bothered by the
differences, and such a change deserves a backward-compatibility
warning in the release notes, at least.

Recently, I discovered that I've been building my personal copy of
Git without LIBPCRE support at all for a long time.  It is possible
I've never built with LIBPCRE.  This series may give me incentive to
start using "git grep -P" ;-)

Thanks.
