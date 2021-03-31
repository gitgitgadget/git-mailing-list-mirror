Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF84BC433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A346619CB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhCaAO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:14:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55183 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCaAOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 20:14:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9526812F053;
        Tue, 30 Mar 2021 20:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+f0yYXLQ6bmt
        tK0mTX3itEVRbmI=; b=w0NW4/FtHfSGCWpoKHToFj98rTazfdnZ2Cv3Fdc2PDFs
        b/RHTgsoake7RcgC0EColWLjZL8FRa5tNJSwo7+IOFvvrjHAXEUZUhaKBqb56Cqv
        1Z6+gTG+Evx/idQfV4QPU2I+dxwpvA6vDge2koSYD/J2Z5U+lpLpuvsyPFjBhbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ix7zMk
        znXWMQdVYVZTrqQeB+dEWYSaISlqNYOKMNDoSlcuFojJch3dPUiZkFKLAM8ZgPc8
        6Yg453tc7JJ8Xqy1cTWPp81Ga20dMbFEaH0Tr2fzmJlFl0VVeyxyGr9Wx3nbBcEo
        MkUnWp/niT5Ens+KIhgPbz30ufUi8tHq+n0VU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DB6A12F052;
        Tue, 30 Mar 2021 20:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CB4A212F050;
        Tue, 30 Mar 2021 20:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 22/22] pickaxe -G: don't special-case create/delete
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-23-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 17:14:28 -0700
In-Reply-To: <20210216115801.4773-23-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:58:01 +0100")
Message-ID: <xmqq1rbw9o2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0FB45B10-91B6-11EB-B07F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Instead of special-casing creations and deletions let's just generate
> a diff for them.
>
> This logic of not running a diff under -G if we don't have both sides
> dates back to the original implementation of -S in
> 52e9578985f ([PATCH] Introducing software archaeologist's tool
> "pickaxe"., 2005-05-21).
>
> In the case of -S we were not working with the xdiff interface and
> needed to do this, but when -G was implemented in f506b8e8b5f (git
> log/diff: add -G<regexp> that greps in the patch text, 2010-08-23)
> this logic was diligently copied over.

Nicely analized.  Yes, I agree that -G that special cases deletion
and creation is just being silly, mimicking what -S did without
thinking.  I can imagine that running grep over diff output in
normal case, and having to run grep over a single side in the edge
cases, would require unnecessary code duplication.

