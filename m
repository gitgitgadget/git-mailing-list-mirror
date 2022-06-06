Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F97C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiFFRoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFFRoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:44:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CF3207DE
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:44:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6836211AD84;
        Mon,  6 Jun 2022 13:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6YER/gkzWbnm
        4tsVu7pLIjgZWZPiv84V+A0Z28D5UFw=; b=AQpbzyjTYcgddZ5F3CYk6ZcGAZT+
        3AzqMWQWAPdjKQUN0qxMXx0GQJxPvc1SeundArw9FBSGiaKip2Y7qhXTE4OcSt6o
        2Agaulyr7tZLX2fJb4QV6WRHsuB14T8cRWNAnzZfpazO9sIpyLtnKcgfbyWWRauA
        8Ao3DGMC2kOB26M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EA5C11AD82;
        Mon,  6 Jun 2022 13:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C007C11AD81;
        Mon,  6 Jun 2022 13:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
        <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
        <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
        <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
        <220604.868rqcwfnw.gmgdl@evledraar.gmail.com>
        <xmqq7d5tag3s.fsf@gitster.g>
        <220606.864k0xwuyl.gmgdl@evledraar.gmail.com>
Date:   Mon, 06 Jun 2022 10:44:17 -0700
In-Reply-To: <220606.864k0xwuyl.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 06 Jun 2022 19:38:07 +0200")
Message-ID: <xmqqh74x8z66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4A809970-E5C0-11EC-8FC4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yes, but I think in this case most of these are either 100% legitimate
> issues, or things where we'd like to e.g. add a BUG() assertion anyway,
> e.g. in the diff parsing case.

Where does that "BUG() assertion anyway" comes from?  What are we
protecting against?

I do not think such a BUG() added only for placating -fanalyzer
falls into "legitimate" category at all.

