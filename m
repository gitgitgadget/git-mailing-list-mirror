Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8192C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiGRQu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiGRQuv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:50:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A7C2BB04
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:50:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDC8F1BDFB3;
        Mon, 18 Jul 2022 12:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iX/kighqZoRx
        G7i1r8WqucrGv9vWm+k1nhCLFMZNT4w=; b=dlEmeC5sL7ZqNabOMLiaRyBR/EoT
        QKXP13xQHcOslhK6zXCPRa6XrK8tOJkCD+dyexZS7lcCxny8DE0QubkT/U6gnjAS
        tpIoorDK3nm900rxz/MrumBIkLXwV05U9i/YBfjrKXq7dYLiCYCnKYzQElNSvVuP
        j79pm9Xuu+HAV3I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D70431BDFB2;
        Mon, 18 Jul 2022 12:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31BF81BDFB1;
        Mon, 18 Jul 2022 12:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Neeraj Singh <neerajsi@microsoft.com>,
        Han Xin <chiyutianyi@gmail.com>
Subject: Re: [PATCH v3] trace2: only include "fsync" events if we git_fsync()
References: <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>
        <patch-v3-1.1-979dea5956a-20220718T102747Z-avarab@gmail.com>
Date:   Mon, 18 Jul 2022 09:50:45 -0700
In-Reply-To: <patch-v3-1.1-979dea5956a-20220718T102747Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 18 Jul
 2022 12:31:52
        +0200")
Message-ID: <xmqq5yjus6u2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C50030B0-06B9-11ED-B0D5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As we're needing to indent the trace2_data_intmax() lines let's
> introduce helper variables to ensure that our resulting lines (which
> were already too) don't exceed the recommendations of the
> CodingGuidelines. Doing that requires either wrapping them twice, or
> introducing short throwaway variable names, let's do the latter.

Or a macro that can be used like

	log_trace_fsync_nonzero(writeout_only);
	log_trace_fsync_nonzero(hardware_flush);

something along the lines of

#define log_trace_fsync_nonzero(var) \
	if (count_fsync_ #var) \
		trace2_data_intmax("fsync", the_repository, \
			"fsync/" ##var, count_fsync_ #var)

using token pasting and token stringification ;-)

The macro itself I am not serious at all.  s/_if/_nonzero/ may be
worth pondering, though.

>    We now test how many "writeout" and "flush" sync events we emit,
>    rather than the (meaningless) previous behavior (see above)>

Makes sense.

Neeraj, Ack, as the author of 9a498767 (trace2: add stats for fsync
operations, 2022-03-30)?

Thanks all.
